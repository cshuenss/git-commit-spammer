#! /usr/bin/bash

if [[ $# -eq 0 ]] ; then
	echo 'Usage: $0 <directory>'
	exit 1
fi

cd $1 || exit 1

read -p "Commits: " commit_count

file="committed_file"
for (( i=1; i <= $commit_count; ++i ))
do
	if [ -f $file ]; then
		rm $file
		git add $file
		
	else
		touch $file
		git add $file
	fi
	git commit -m "commit $i"
done
