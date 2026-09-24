#!/usr/bin/env bash

set -euo pipefail
shopt -s nullglob

root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
usage="Usage: install.sh --claude|--codex|--check"
task_template="${root}/templates/task.md"

claude_release="${root}/releases/claude"
claude_skills=(guide redesign task quick reduce ship debugging ast-grep)
claude_user_only=(redesign task quick reduce ship)
claude_assets=("skills/guide/assets/task.md")
claude_block_start='<!-- oh-my-guide:claude-default:start -->'
claude_block_end='<!-- oh-my-guide:claude-default:end -->'

codex_skill_name="oh-my-guide"
codex_owned=(
    "SKILL.md"
    "references/core.md"
    "references/guide.md"
    "references/task.md"
    "assets/task.md"
    "scripts/ship-project.sh"
)
codex_block_start='<!-- oh-my-guide:codex-default:start -->'
codex_block_end='<!-- oh-my-guide:codex-default:end -->'

fail()
{
    printf 'ERROR: %s\n' "$1" >&2
    exit 1
}

claude_owned()
{
    local name
    for name in "${claude_skills[@]}"; do
        printf '%s\n' "skills/${name}/SKILL.md"
    done
    printf '%s\n' "${claude_assets[@]}"
}

check_bootstrap()
{
    local file="$1"
    local start="$2"
    local end="$3"

    [[ -f "${file}" ]] || fail "Missing default Guide bootstrap: ${file}"
    ! grep -Fqx -- "${start}" "${file}" || fail "Bootstrap must not contain installer markers: ${file}"
    ! grep -Fqx -- "${end}" "${file}" || fail "Bootstrap must not contain installer markers: ${file}"
}

check_claude_sources()
{
    local name file expected actual
    local skill_dirs=("${claude_release}"/skills/*/)

    [[ "${#skill_dirs[@]}" -eq "${#claude_skills[@]}" ]] || fail "Expected ${#claude_skills[@]} Claude Code Skills."
    for name in "${claude_skills[@]}"; do
        file="${claude_release}/skills/${name}/SKILL.md"
        [[ -f "${file}" ]] || fail "Missing Claude Code Skill: ${name}"
        grep -Fqx -- "name: ${name}" "${file}" || fail "Invalid Claude Code Skill name: ${name}"
        grep -Fq -- 'description:' "${file}" || fail "Missing Claude Code Skill description: ${name}"
    done
    for name in "${claude_user_only[@]}"; do
        grep -Fqx -- 'disable-model-invocation: true' "${claude_release}/skills/${name}/SKILL.md" || \
            fail "Claude Code Skill must be user-only: ${name}"
    done

    expected="$( { claude_owned; printf '%s\n' "default-guide.md"; } | LC_ALL=C sort)"
    actual="$(cd -- "${claude_release}" && find . -type f | sed 's|^\./||' | LC_ALL=C sort)"
    [[ "${expected}" == "${actual}" ]] || fail "Claude Code release files differ from the owned file list."
    cmp -s -- "${task_template}" "${claude_release}/skills/guide/assets/task.md" || \
        fail "Claude Code task template differs from templates/task.md."
    check_bootstrap "${claude_release}/default-guide.md" "${claude_block_start}" "${claude_block_end}"
}

check_codex_sources()
{
    local relative file
    local codex_skill_files=("${root}"/releases/codex/skills/*/SKILL.md)
    local skill_root="${root}/releases/codex/skills/${codex_skill_name}"

    [[ "${#codex_skill_files[@]}" -eq 1 ]] || fail "Expected one Codex Skill."
    for relative in "${codex_owned[@]}"; do
        [[ -f "${skill_root}/${relative}" ]] || fail "Missing Codex Skill file: ${relative}"
    done
    [[ "$(cd -- "${skill_root}" && find . -type f | wc -l)" -eq "${#codex_owned[@]}" ]] || \
        fail "Codex Skill files differ from the owned file list."
    file="${skill_root}/SKILL.md"
    grep -Fqx -- "name: ${codex_skill_name}" "${file}" || fail "Invalid Codex Skill name."
    grep -Fq -- 'description:' "${file}" || fail "Missing Codex Skill description."
    [[ -x "${skill_root}/scripts/ship-project.sh" ]] || fail "Codex Ship helper must be executable."
    cmp -s -- "${task_template}" "${skill_root}/assets/task.md" || fail "Codex task template differs from templates/task.md."
    check_bootstrap "${root}/releases/codex/default-guide.md" "${codex_block_start}" "${codex_block_end}"
    grep -Fq -- 'Do not ask the user to enter' "${root}/releases/codex/default-guide.md" || \
        fail "Invalid Codex default Guide bootstrap."
    [[ ! -e "${root}/releases/codex/agents" ]] || fail "Codex release must not define Agents."
    [[ ! -e "${root}/releases/codex/.codex-plugin" ]] || fail "Codex release must not define a plugin."
}

check_sources()
{
    local term match
    local scanned=("${root}/releases" "${root}/scripts" "${root}/templates" "${root}/README.md" "${root}/AGENTS.md")

    check_claude_sources
    check_codex_sources

    [[ -f "${task_template}" ]] || fail "Missing task template."
    [[ -f "${root}/templates/instructions/README.md" ]] || fail "Missing instruction template."
    grep -Fqx -- '.tmp/' "${root}/.gitignore" || fail "Project scratch directory must be ignored."

    for term in "vec""tori" "r""tk"; do
        match="$(grep -Ril -- "${term}" "${scanned[@]}" || true)"
        [[ -z "${match}" ]] || fail "Found prohibited package-specific content: ${match}"
    done

    for term in "/""tmp" "/""var/"; do
        match="$(grep -RIl -- "${term}" "${scanned[@]}" || true)"
        [[ -z "${match}" ]] || fail "Found an absolute system scratch path: ${match}"
    done
}

copy_file()
{
    local source="$1"
    local destination="$2"
    mkdir -p -- "$(dirname -- "${destination}")"
    cp -- "${source}" "${destination}"
}

safe_relative_path()
{
    [[ -n "$1" && "$1" != /* && "$1" != *".."* && "$1" != *"//"* ]]
}

safe_claude_owned_path()
{
    safe_relative_path "$1" || return 1
    [[ "$1" == skills/?*/?* ]]
}

safe_codex_owned_path()
{
    safe_relative_path "$1" || return 1
    case "$1" in
        SKILL.md|references/*|assets/*|scripts/*) return 0 ;;
        *) return 1 ;;
    esac
}

marker_count()
{
    local file="$1"
    local marker="$2"

    grep -Fxc -- "${marker}" "${file}" 2>/dev/null || true
}

validate_instruction_file()
{
    local file="$1"
    local start="$2"
    local end="$3"
    local starts ends first

    [[ -e "${file}" ]] || return 0
    [[ -f "${file}" ]] || fail "Instruction path is not a file: ${file}"
    [[ ! -L "${file}" ]] || fail "Refusing to replace an instruction symlink: ${file}"

    starts="$(marker_count "${file}" "${start}")"
    ends="$(marker_count "${file}" "${end}")"
    [[ "${starts}" -eq "${ends}" ]] || fail "Malformed oh-my-guide block in ${file}"
    [[ "${starts}" -le 1 ]] || fail "Duplicate oh-my-guide blocks in ${file}"

    if [[ "${starts}" -eq 1 ]]; then
        first=""
        IFS= read -r first < "${file}" || [[ -n "${first}" ]]
        [[ "${first}" == "${start}" ]] || fail "Managed oh-my-guide block is not at the start of ${file}"
    fi
}

strip_instruction_block()
{
    local file="$1"
    local start="$2"
    local end="$3"
    local line found tmp

    [[ -e "${file}" ]] || return 0
    [[ "$(marker_count "${file}" "${start}")" -eq 1 ]] || return 0

    tmp="${file}.oh-my-guide.$$"
    cp -p -- "${file}" "${tmp}"
    : > "${tmp}"
    exec 3< "${file}"
    IFS= read -r line <&3 || fail "Cannot read managed block from ${file}"
    found="false"
    while IFS= read -r line <&3 || [[ -n "${line}" ]]; do
        if [[ "${line}" == "${end}" ]]; then
            found="true"
            break
        fi
    done
    [[ "${found}" == "true" ]] || fail "Cannot find managed block end in ${file}"
    cat <&3 > "${tmp}"
    exec 3<&-
    mv -- "${tmp}" "${file}"
}

prepend_instruction_block()
{
    local file="$1"
    local start="$2"
    local end="$3"
    local source="$4"
    local tmp="${file}.oh-my-guide.$$"

    cp -p -- "${file}" "${tmp}"
    {
        printf '%s\n' "${start}"
        cat "${source}"
        printf '%s\n' "${end}"
        cat "${file}"
    } > "${tmp}"
    mv -- "${tmp}" "${file}"
}

write_manifest()
{
    local manifest="$1"
    shift
    local tmp="${manifest}.tmp.$$"

    printf '%s\n' "$@" > "${tmp}"
    mv -- "${tmp}" "${manifest}"
}

install_claude()
{
    local claude_dir manifest instructions relative owned_path name dir destination
    local owned=() previous=()

    claude_dir="${OH_MY_GUIDE_CLAUDE_DIR:-${CLAUDE_CONFIG_DIR:-${HOME}/.claude}}"
    [[ -n "${claude_dir}" && "${claude_dir}" != "/" ]] || fail "Unsafe Claude Code configuration root."
    manifest="${claude_dir}/.oh-my-guide-manifest"
    instructions="${claude_dir}/CLAUDE.md"
    mapfile -t owned < <(claude_owned)

    validate_instruction_file "${instructions}" "${claude_block_start}" "${claude_block_end}"
    if [[ -f "${manifest}" ]]; then
        while IFS= read -r owned_path; do
            [[ -n "${owned_path}" ]] || continue
            safe_claude_owned_path "${owned_path}" || fail "Unsafe path in existing Claude Code manifest: ${owned_path}"
            previous+=("${owned_path}")
        done < "${manifest}"
    fi

    for name in "${claude_skills[@]}"; do
        dir="${claude_dir}/skills/${name}"
        [[ ! -L "${dir}" ]] || fail "Refusing to replace a Claude Code Skill symlink: ${dir}"
        [[ ! -e "${dir}" ]] || [[ " ${previous[*]} " == *" skills/${name}/"* ]] || \
            fail "Refusing to replace a Claude Code Skill that oh-my-guide does not own: ${dir}"
    done

    mkdir -p -- "${claude_dir}/skills"
    for owned_path in "${previous[@]}"; do
        rm -f -- "${claude_dir}/${owned_path}"
        dir="$(dirname -- "${owned_path}")"
        while [[ "${dir}" == skills/?* ]]; do
            rmdir -- "${claude_dir}/${dir}" 2>/dev/null || break
            dir="$(dirname -- "${dir}")"
        done
    done

    for relative in "${owned[@]}"; do
        destination="${claude_dir}/${relative}"
        [[ ! -L "${destination}" && ! -L "$(dirname -- "${destination}")" ]] || \
            fail "Refusing to write through a Claude Code Skill symlink: ${destination}"
        copy_file "${claude_release}/${relative}" "${destination}"
    done
    write_manifest "${manifest}" "${owned[@]}"

    strip_instruction_block "${instructions}" "${claude_block_start}" "${claude_block_end}"
    [[ -e "${instructions}" ]] || : > "${instructions}"
    prepend_instruction_block "${instructions}" "${claude_block_start}" "${claude_block_end}" \
        "${claude_release}/default-guide.md"

    printf 'Installed %s Claude Code Skills into %s and activated default Guide in %s.\n' \
        "${#claude_skills[@]}" "${claude_dir}/skills" "${instructions}"
}

install_codex()
{
    local skills_root codex_dir skill_target manifest relative owned_path destination
    local agents_file override_file active_file

    skills_root="${OH_MY_GUIDE_CODEX_SKILLS_DIR:-${HOME}/.agents/skills}"
    codex_dir="${OH_MY_GUIDE_CODEX_DIR:-${CODEX_HOME:-${HOME}/.codex}}"
    [[ -n "${skills_root}" && "${skills_root}" != "/" ]] || fail "Unsafe Codex Skills root."
    [[ -n "${codex_dir}" && "${codex_dir}" != "/" ]] || fail "Unsafe Codex configuration root."

    skill_target="${skills_root}/${codex_skill_name}"
    manifest="${skill_target}/.oh-my-guide-manifest"
    agents_file="${codex_dir}/AGENTS.md"
    override_file="${codex_dir}/AGENTS.override.md"

    validate_instruction_file "${agents_file}" "${codex_block_start}" "${codex_block_end}"
    validate_instruction_file "${override_file}" "${codex_block_start}" "${codex_block_end}"
    [[ ! -L "${skill_target}" ]] || fail "Refusing to replace a Codex Skill symlink: ${skill_target}"
    for relative in references assets scripts; do
        [[ ! -L "${skill_target}/${relative}" ]] || \
            fail "Refusing to write through a Codex Skill symlink: ${skill_target}/${relative}"
    done

    mkdir -p -- "${skills_root}" "${codex_dir}"
    if [[ -f "${manifest}" ]]; then
        while IFS= read -r owned_path; do
            [[ -n "${owned_path}" ]] || continue
            safe_codex_owned_path "${owned_path}" || fail "Unsafe path in existing Codex manifest: ${owned_path}"
            rm -f -- "${skill_target}/${owned_path}"
        done < "${manifest}"
    fi

    for relative in "${codex_owned[@]}"; do
        destination="${skill_target}/${relative}"
        [[ ! -L "${destination}" ]] || fail "Refusing to replace a Codex Skill file symlink: ${destination}"
        copy_file "${root}/releases/codex/skills/${codex_skill_name}/${relative}" "${destination}"
    done
    chmod +x "${skill_target}/scripts/ship-project.sh"
    write_manifest "${manifest}" "${codex_owned[@]}"

    strip_instruction_block "${agents_file}" "${codex_block_start}" "${codex_block_end}"
    strip_instruction_block "${override_file}" "${codex_block_start}" "${codex_block_end}"
    if [[ -e "${override_file}" ]]; then
        active_file="${override_file}"
    else
        active_file="${agents_file}"
        [[ -e "${active_file}" ]] || : > "${active_file}"
    fi
    prepend_instruction_block "${active_file}" "${codex_block_start}" "${codex_block_end}" \
        "${root}/releases/codex/default-guide.md"

    printf 'Installed Codex Skill %s into %s and activated default Guide in %s.\n' \
        "${codex_skill_name}" "${skill_target}" "${active_file}"
}

[[ "$#" -eq 1 ]] || fail "${usage}"
check_sources

case "$1" in
    --check)
        printf 'Package is valid: %s Claude Code Skills and one Codex Skill.\n' "${#claude_skills[@]}"
        ;;
    --claude) install_claude ;;
    --codex) install_codex ;;
    *) fail "${usage}" ;;
esac
