#!/bin/bash

if [ $# -eq 0 ]; then
    echo '네임스페이스를 입력하세요'
    exit 1
fi

workdir='external-storage/nfs-client/deploy/'
sed -i "s/namespace: /namespace: $1/g" ${workdir}rbac.yaml ${workdir}deployment.yaml
