#!/usr/bin/env bash

# Check the exit status and report an error message
# Usage: checkError $? "custom message"
checkError() {
  [ "${1}" -ne 0 ] && echo "### ${2} See output above. Exit code: ${1}" && printStack && exit "${1}"
  return 0
}

# Prints a stack trace with an optional header
# shellcheck disable=SC2120
function printStack() {
    echo "${1:-Stack trace}"

    local depth
    depth=${#FUNCNAME[@]}

    for ((i=1; i<depth; i++)); do
        local function="${FUNCNAME[$i]}"
        local line="${BASH_LINENO[$((i-1))]}"
        local file="${BASH_SOURCE[$((i-1))]}"
        echo " $function(), $file, line $line"
    done
}

getPlatform() {
    if [[ "${OSTYPE}" == "darwin"* ]]; then
        echo "darwin"
    elif [[ "${OSTYPE}" == "linux-"* ]]; then
        echo "linux"
    else
        echo "unknown"
    fi
}

# Wait for a tool to report a zero exit status indicating success. Will stop after {delay}
# seconds.
# Usage: waitFor minikube 15
waitFor() {
    local cmd=${1:?}
    local delay=${2:-15}
    local reenter=${3}

    if [ -z "${reenter}" ]; then
        SECONDS=0
    fi
    if [ "${SECONDS}" -gt "${delay}" ]; then
        echo "${cmd} did not report success after ${delay}"
        exit 1
    fi

    case ${cmd} in
        minikube)
            if ! minikube status > /dev/null
            then
                waitFor "${cmd}" "${delay}" 1
            fi
        ;;
    *)
        echo "Unable to check the status of ${cmd}"
        ;;
    esac
}