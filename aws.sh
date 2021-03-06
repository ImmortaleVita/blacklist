#!/bin/bash
# Updates the aptly repository on aws.helmrock.com and pushes it to github

VERSION="1.0"
host=${1}
pkg=${2}
tag=${3}

ssh -tt ${host} <<-EOF
	aptly repo add blacklist .
	aptly snapshot create blacklist-${tag} from repo blacklist
	aptly publish switch stretch blacklist-${tag}
	cd /home/ubuntu/debian-repo
	git add --all
	git commit -am"Package repository release ${tag}"
	git tag "${pkg}package"
	git push origin master
	git push --tags
	exit
EOF
