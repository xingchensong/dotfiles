#!/usr/bin/env bash

echo "# [$(whoami)@$(hostname):$(pwd)]"
echo "# [$(date +%Y-%m-%d\ %T)] [PID: $$] Running: $0 $@"
set -e -o pipefail -u

docker build -t micr.cloud.mioffice.cn/base_model/touchnet:1.0.1 .

echo "# [$(date +%Y-%m-%d\ %T)] [PID: $$] Finished: $0 $@"
exit 0
