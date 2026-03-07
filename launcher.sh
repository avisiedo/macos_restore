#!/bin/bash
PRODUCT="$1"

check_product() {
    local product="$1"
    [ "${product}" != "" ] || {
        printf "error:product is empty\n"
        exit 1
    }
}

check_python3() {
    which "python3" &>/dev/null || {
        printf "error:python3 is not found in the environment\n"
        exit 1
    }
}

clone_repo() {
    [ -e .git ] || {
        git clone 'https://github.com/little-engineer-2025/macos_restore.git'
        cd macos_restore
    }
}

main() {
    check_product "$1"
    check_python3
    clone_repo
    [ -e .venv ] || {
        python3 -m venv .venv
    }
    source .venv/bin/activate
    python3 -m pip install -U pip
    python3 -m pip install -r requirements.txt
    exec python3 ./macos_restore/__main__.py "$@"
}

main "$@"
