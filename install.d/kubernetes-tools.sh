#!/bin/bash
# shellcheck disable=2174

# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
# NOTE this downloads the latest stable version of the tools.

set -euo pipefail

LANG=C
umask 0022

if [ $EUID -ne 0 ]; then
echo -e "$ERROR This script must be run as root!" 1>&2
    exit 1
fi

trap cleanup EXIT

cleanup() {
    rm -f kubectl-convert kubectl-convert.sha256
}

apt-get update
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg

# Will download `v1.31.1` or similar.
RELEASE=$(curl -L -s https://dl.k8s.io/release/stable.txt)
# Just need `v1.31` here.
MAJOR_MINOR_VERSION=$(echo "$RELEASE" | awk -F. '{print $1"."$2}')

mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL "https://pkgs.k8s.io/core:/stable:/$MAJOR_MINOR_VERSION/deb/Release.key" \
    | gpg --dearmor -o /usr/share/keyrings/kubernetes-apt-keyring.gpg && \
    chmod 644 /usr/share/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /" \
    | tee /etc/apt/sources.list.d/kubernetes.list && \
    chmod 644 /etc/apt/sources.list.d/kubernetes.list

apt-get update

apt-get install -y \
    kubeadm \
    kubectl \
    kubelet

apt-mark hold \
    kubeadm \
    kubectl \
    kubelet

systemctl enable --now kubelet

# The following is already in `$HOME/.bash_vendor`:
#if type _init_completion &> /dev/null
#then
#    source <(kubectl completion bash)
#    alias k="kubectl"
#    complete -o default -F __start_kubectl k
#fi

# kubectl convert
curl -LO "https://dl.k8s.io/release/$RELEASE/bin/linux/amd64/kubectl-convert"
curl -LO "https://dl.k8s.io/release/$RELEASE/bin/linux/amd64/kubectl-convert.sha256"
if ! echo "$(cat kubectl-convert.sha256) kubectl-convert" | sha256sum --check
then
    # We won't log anything to stdout here as the preceding check will have done it for us.
    exit 1
else
    install -o root -g root -m 0755 kubectl-convert /usr/local/bin/kubectl-convert
    echo -e "$SUCCESS Run the following command to complete the setup: \`. $HOME/.bashrc\`"
fi

