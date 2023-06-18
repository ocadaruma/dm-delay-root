#!/bin/bash

set -eu

if [ $# -ne 1 ]; then
    echo "Usage: $0 <lima-instance>"
    exit 1
fi

lima_instance="$1"

ssh_port=$(limactl show-ssh "$lima_instance" | perl -nle '/Port=([0-9]+)/ && print $1')
ssh_priv_key="$HOME/.lima/_config/user"

# write ssh inventory file as heredoc
cat <<EOF > hosts
[$lima_instance]
localhost ansible_port=$ssh_port ansible_ssh_private_key_file=$ssh_priv_key
EOF
