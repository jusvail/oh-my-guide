#!/usr/bin/env bash

set -euo pipefail
shopt -s nullglob

root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
agents=(guide scout task)
commands=(guide redesign task quick ship clean)
skills=(debugging browser computer-use git ast-grep)

fail()
{
    printf 'ERROR: %s\n' "$1" >&2
    exit 1
}

check_sources()
{
    local name file term match
    local agent_files=("${root}"/.opencode/agents/*.md)
    local command_files=("${root}"/.opencode/commands/*.md)
    local skill_files=("${root}"/.opencode/skills/*/SKILL.md)

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

    [[ -f "${root}/preferences/core.md" ]] || fail "Missing core preferences."
    [[ -f "${root}/releases/opencode/profiles/recommended/opencode.json" ]] || fail "Missing recommended profile."
    [[ -f "${root}/scripts/ship-project.sh" ]] || fail "Missing ship helper."
    [[ -f "${root}/templates/task.md" ]] || fail "Missing task template."
    [[ -f "${root}/templates/instructions/README.md" ]] || fail "Missing instruction template."
    grep -Fqx -- '.tmp/' "${root}/.gitignore" || fail "Project scratch directory must be ignored."

    for term in "vec""tori" "r""tk"; do
        match="$(grep -Ril --exclude-dir=.git --exclude-dir=.tasks -- "${term}" \
            "${root}/.opencode" "${root}/preferences" "${root}/releases" "${root}/scripts" \
            "${root}/templates" "${root}/README.md" "${root}/AGENTS.md" || true)"
        [[ -z "${match}" ]] || fail "Found prohibited package-specific content: ${match}"
    done

    for term in "/""tmp" "/""var/"; do
        match="$(grep -RIl -- "${term}" "${root}/.opencode" "${root}/preferences" \
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

check_sources

mode="install"
case "${1:-}" in
    "") [[ "$#" -eq 0 ]] || fail "Usage: install.sh [--check|--takeover]" ;;
    --check) [[ "$#" -eq 1 ]] || fail "Usage: install.sh [--check|--takeover]"; mode="check" ;;
    --takeover) [[ "$#" -eq 1 ]] || fail "Usage: install.sh [--check|--takeover]"; mode="takeover" ;;
    *) fail "Usage: install.sh [--check|--takeover]" ;;
esac

if [[ "${mode}" == "check" ]]; then
    printf 'Package is valid: %s Agents, %s commands, and %s Skills.\n' \
        "${#agents[@]}" "${#commands[@]}" "${#skills[@]}"
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
