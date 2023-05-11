alias podman-clean='podman rmi $(podman images -a | grep ^\<none\> | awk "{print \$3}")'
