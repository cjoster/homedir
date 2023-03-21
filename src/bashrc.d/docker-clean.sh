alias docker-clean='docker rmi $(docker images -a | grep ^\<none\> | awk "{print \$3}")'
