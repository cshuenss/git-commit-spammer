#! /usr/bin/bash

read -p "Commits: " commit_count

file="committed_file"
for (( i=0; i <= $commit_count; ++i ))
do
	if [ -f $file ]; then
		rm $file	
		
	else
		touch $file
		git add $file
	fi
	git commit -m "commit $i"
done
