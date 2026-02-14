#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MODEL_PATH="${SCRIPT_DIR}/models/models--happyme531--SenseVoiceSmall-RKNN2/snapshots/2b134bc175c5bc16ec315613d183eb34b0748043"
export PYTHONPATH="${SCRIPT_DIR}/lib/rknnlite_wrapper:${SCRIPT_DIR}/lib:${MODEL_PATH}:$PYTHONPATH"
cd "${SCRIPT_DIR}"
exec /root/rkllama-env/bin/python3 sensevoice_server.py
