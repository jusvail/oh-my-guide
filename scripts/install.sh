#!/usr/bin/env bash

set -euo pipefail
shopt -s nullglob

root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
agents=(guide scout task)
commands=(guide redesign task quick ship clean)
skills=(debugging browser git ast-grep)
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

check_sources()
{
    local name file relative term match
    local agent_files=("${root}"/.opencode/agents/*.md)
    local command_files=("${root}"/.opencode/commands/*.md)
    local skill_files=("${root}"/.opencode/skills/*/SKILL.md)
    local codex_skill_files=("${root}"/releases/codex/skills/*/SKILL.md)
    local codex_reference_files=("${root}"/releases/codex/skills/oh-my-guide/references/*.md)
    local codex_asset_files=("${root}"/releases/codex/skills/oh-my-guide/assets/*.md)
    local codex_script_files=("${root}"/releases/codex/skills/oh-my-guide/scripts/*.sh)

    [[ "${#agent_files[@]}" -eq "${#agents[@]}" ]] || fail "Expected ${#agents[@]} Agent files."
    [[ "${#command_files[@]}" -eq "${#commands[@]}" ]] || fail "Expected ${#commands[@]} command files."
    [[ "${#skill_files[@]}" -eq "${#skills[@]}" ]] || fail "Expected ${#skills[@]} Skill files."

    for name in "${agents[@]}"; do
        file="${root}/.opencode/agents/${name}.md"
        [[ -f "${file}" ]] || fail "Missing Agent: ${name}"
        grep -Fq -- 'description:' "${file}" || fail "Missing Agent description: ${name}"
    done

    for name in "${commands[@]}"; do
        file="${root}/.opencode/commands/${name}.md"
        [[ -f "${file}" ]] || fail "Missing command: ${name}"
        grep -Fq -- 'description:' "${file}" || fail "Missing command description: ${name}"
    done

    for name in "${skills[@]}"; do
        file="${root}/.opencode/skills/${name}/SKILL.md"
        [[ -f "${file}" ]] || fail "Missing Skill: ${name}"
        grep -Fqx -- "name: ${name}" "${file}" || fail "Invalid Skill name: ${name}"
        grep -Fq -- 'description:' "${file}" || fail "Missing Skill description: ${name}"
    done

    [[ "${#codex_skill_files[@]}" -eq 1 ]] || fail "Expected one Codex Skill."
    [[ "${#codex_reference_files[@]}" -eq 3 ]] || fail "Expected three Codex Skill references."
    [[ "${#codex_asset_files[@]}" -eq 1 ]] || fail "Expected one Codex Skill asset."
    [[ "${#codex_script_files[@]}" -eq 1 ]] || fail "Expected one Codex Skill script."
    file="${root}/releases/codex/skills/${codex_skill_name}/SKILL.md"
    grep -Fqx -- "name: ${codex_skill_name}" "${file}" || fail "Invalid Codex Skill name."
    grep -Fq -- 'description:' "${file}" || fail "Missing Codex Skill description."
    for relative in "${codex_owned[@]}"; do
        [[ -f "${root}/releases/codex/skills/${codex_skill_name}/${relative}" ]] || \
            fail "Missing Codex Skill file: ${relative}"
    done
    [[ -x "${root}/releases/codex/skills/${codex_skill_name}/scripts/ship-project.sh" ]] || \
        fail "Codex Ship helper must be executable."
    [[ -f "${root}/releases/codex/default-guide.md" ]] || fail "Missing Codex default Guide bootstrap."
    grep -Fq -- 'Do not ask the user to enter' "${root}/releases/codex/default-guide.md" || \
        fail "Invalid Codex default Guide bootstrap."
    grep -Fq -- 'Superpowers' "${root}/releases/codex/default-guide.md" || \
        fail "Missing Codex Superpowers boundary."
    [[ ! -e "${root}/releases/codex/agents" ]] || fail "Codex release must not define Agents."
    [[ ! -e "${root}/releases/codex/.codex-plugin" ]] || fail "Codex release must not define a plugin."
    ! grep -Fqx -- "${codex_block_start}" "${root}/releases/codex/default-guide.md" || \
        fail "Codex bootstrap must not contain installer markers."
    ! grep -Fqx -- "${codex_block_end}" "${root}/releases/codex/default-guide.md" || \
        fail "Codex bootstrap must not contain installer markers."

    [[ -f "${root}/preferences/core.md" ]] || fail "Missing core preferences."
    [[ -f "${root}/releases/opencode/profiles/recommended/opencode.json" ]] || fail "Missing recommended profile."
    [[ -f "${root}/scripts/ship-project.sh" ]] || fail "Missing ship helper."
    [[ -f "${root}/templates/task.md" ]] || fail "Missing task template."
    [[ -f "${root}/templates/instructions/README.md" ]] || fail "Missing instruction template."
    grep -Fqx -- '.tmp/' "${root}/.gitignore" || fail "Project scratch directory must be ignored."

    for term in "vec""tori" "r""tk"; do
        match="$(grep -Ril --exclude-dir=.git --exclude-dir=.tasks -- "${term}" \
            "${root}/.opencode/agents" "${root}/.opencode/commands" "${root}/.opencode/skills" \
            "${root}/preferences" "${root}/releases" "${root}/scripts" \
            "${root}/templates" "${root}/README.md" "${root}/AGENTS.md" || true)"
        [[ -z "${match}" ]] || fail "Found prohibited package-specific content: ${match}"
    done

    for term in "/""tmp" "/""var/"; do
        match="$(grep -RIl -- "${term}" "${root}/.opencode/agents" "${root}/.opencode/commands" \
            "${root}/.opencode/skills" "${root}/preferences" \
            "${root}/releases" "${root}/scripts" "${root}/templates" "${root}/README.md" \
            "${root}/AGENTS.md" || true)"
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

safe_owned_path()
{
    case "$1" in
        agents/*.md|commands/*.md|skills/*/SKILL.md|preferences/core.md|scripts/ship-project.sh) return 0 ;;
        *) return 1 ;;
    esac
}

safe_codex_owned_path()
{
    [[ "$1" != /* && "$1" != *".."* && "$1" != *"//"* ]] || return 1
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
    local starts ends first

    [[ -e "${file}" ]] || return 0
    [[ -f "${file}" ]] || fail "Codex instruction path is not a file: ${file}"
    [[ ! -L "${file}" ]] || fail "Refusing to replace a Codex instruction symlink: ${file}"

    starts="$(marker_count "${file}" "${codex_block_start}")"
    ends="$(marker_count "${file}" "${codex_block_end}")"
    [[ "${starts}" -eq "${ends}" ]] || fail "Malformed oh-my-guide block in ${file}"
    [[ "${starts}" -le 1 ]] || fail "Duplicate oh-my-guide blocks in ${file}"

    if [[ "${starts}" -eq 1 ]]; then
        first=""
        IFS= read -r first < "${file}" || [[ -n "${first}" ]]
        [[ "${first}" == "${codex_block_start}" ]] || \
            fail "Managed oh-my-guide block is not at the start of ${file}"
    fi
}

strip_instruction_block()
{
    local file="$1"
    local starts line found tmp

    [[ -e "${file}" ]] || return 0
    starts="$(marker_count "${file}" "${codex_block_start}")"
    [[ "${starts}" -eq 1 ]] || return 0

    tmp="${file}.oh-my-guide.$$"
    cp -p -- "${file}" "${tmp}"
    : > "${tmp}"
    exec 3< "${file}"
    IFS= read -r line <&3 || fail "Cannot read managed block from ${file}"
    found="false"
    while IFS= read -r line <&3 || [[ -n "${line}" ]]; do
        if [[ "${line}" == "${codex_block_end}" ]]; then
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
    local tmp="${file}.oh-my-guide.$$"

    cp -p -- "${file}" "${tmp}"
    {
        printf '%s\n' "${codex_block_start}"
        cat "${root}/releases/codex/default-guide.md"
        printf '%s\n' "${codex_block_end}"
        cat "${file}"
    } > "${tmp}"
    mv -- "${tmp}" "${file}"
}

install_codex()
{
    local skills_root codex_dir skill_target manifest manifest_tmp relative owned_path destination
    local agents_file override_file active_file

    skills_root="${OH_MY_GUIDE_CODEX_SKILLS_DIR:-${HOME}/.agents/skills}"
    codex_dir="${OH_MY_GUIDE_CODEX_DIR:-${CODEX_HOME:-${HOME}/.codex}}"
    [[ -n "${skills_root}" && "${skills_root}" != "/" ]] || fail "Unsafe Codex Skills root."
    [[ -n "${codex_dir}" && "${codex_dir}" != "/" ]] || fail "Unsafe Codex configuration root."

    skill_target="${skills_root}/${codex_skill_name}"
    manifest="${skill_target}/.oh-my-guide-manifest"
    agents_file="${codex_dir}/AGENTS.md"
    override_file="${codex_dir}/AGENTS.override.md"

    validate_instruction_file "${agents_file}"
    validate_instruction_file "${override_file}"
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

    manifest_tmp="${manifest}.tmp.$$"
    for relative in "${codex_owned[@]}"; do
        printf '%s\n' "${relative}"
    done > "${manifest_tmp}"
    mv -- "${manifest_tmp}" "${manifest}"

    strip_instruction_block "${agents_file}"
    strip_instruction_block "${override_file}"
    if [[ -e "${override_file}" ]]; then
        active_file="${override_file}"
    else
        active_file="${agents_file}"
        [[ -e "${active_file}" ]] || : > "${active_file}"
    fi
    prepend_instruction_block "${active_file}"

    printf 'Installed Codex Skill %s into %s and activated default Guide in %s.\n' \
        "${codex_skill_name}" "${skill_target}" "${active_file}"
}

check_sources

mode="install"
case "${1:-}" in
    "") [[ "$#" -eq 0 ]] || fail "Usage: install.sh [--check|--takeover|--codex]" ;;
    --check) [[ "$#" -eq 1 ]] || fail "Usage: install.sh [--check|--takeover|--codex]"; mode="check" ;;
    --takeover) [[ "$#" -eq 1 ]] || fail "Usage: install.sh [--check|--takeover|--codex]"; mode="takeover" ;;
    --codex) [[ "$#" -eq 1 ]] || fail "Usage: install.sh [--check|--takeover|--codex]"; mode="codex" ;;
    *) fail "Usage: install.sh [--check|--takeover|--codex]" ;;
esac

if [[ "${mode}" == "check" ]]; then
    printf 'Package is valid: %s OpenCode Agents, %s commands, %s Skills, and one Codex Skill.\n' \
        "${#agents[@]}" "${#commands[@]}" "${#skills[@]}"
    exit 0
fi

if [[ "${mode}" == "codex" ]]; then
    install_codex
    exit 0
fi

target="${OH_MY_GUIDE_OPENCODE_DIR:-${HOME}/.config/opencode}"
manifest="${target}/.oh-my-guide-manifest"
owned=()

for name in "${agents[@]}"; do
    owned+=("agents/${name}.md")
done
for name in "${commands[@]}"; do
    owned+=("commands/${name}.md")
done
for name in "${skills[@]}"; do
    owned+=("skills/${name}/SKILL.md")
done
owned+=("preferences/core.md" "scripts/ship-project.sh")

if [[ "${mode}" == "takeover" ]]; then
    rm -rf -- "${target}/agents" "${target}/agent" "${target}/commands" "${target}/command" "${target}/skills"
elif [[ -f "${manifest}" ]]; then
    while IFS= read -r relative; do
        [[ -n "${relative}" ]] || continue
        safe_owned_path "${relative}" || fail "Unsafe path in existing manifest: ${relative}"
        rm -f -- "${target}/${relative}"
    done < "${manifest}"
fi

for name in "${agents[@]}"; do
    copy_file "${root}/.opencode/agents/${name}.md" "${target}/agents/${name}.md"
done
for name in "${commands[@]}"; do
    copy_file "${root}/.opencode/commands/${name}.md" "${target}/commands/${name}.md"
done
for name in "${skills[@]}"; do
    copy_file "${root}/.opencode/skills/${name}/SKILL.md" "${target}/skills/${name}/SKILL.md"
done
copy_file "${root}/preferences/core.md" "${target}/preferences/core.md"
copy_file "${root}/scripts/ship-project.sh" "${target}/scripts/ship-project.sh"
chmod +x "${target}/scripts/ship-project.sh"

mkdir -p -- "${target}"
manifest_tmp="${manifest}.tmp.$$"
for relative in "${owned[@]}"; do
    printf '%s\n' "${relative}"
done > "${manifest_tmp}"
mv -- "${manifest_tmp}" "${manifest}"

if [[ "${mode}" == "takeover" ]]; then
    copy_file "${root}/releases/opencode/profiles/recommended/opencode.json" "${target}/opencode.json"
fi

printf 'Installed %s Agents, %s commands, and %s Skills into %s (%s mode).\n' \
    "${#agents[@]}" "${#commands[@]}" "${#skills[@]}" "${target}" "${mode}"
