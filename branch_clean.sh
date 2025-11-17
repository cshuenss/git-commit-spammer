#!/bin/zsh

cd "$1"
CURRENT_BRANCH="$(git branch --show-current)"
echo "${CURRENT_BRANCH}"
git checkout master >/dev/null 2>&1
if [ $? -ne 0 ]; then 
    echo "Failed to checkout to master. Check that there are no changes on the working branch."
    exit 1 
fi

echo "Delete branches:\n"

DEL_BRANCHES="$(git branch --merged master | grep -v '\*\|master|main')"
ALL_BRANCHES="$(git branch -l)"
echo "${DEL_BRANCHES}"

echo "\nKeep branches:\n"

# ALL_BRANCHES is a superset of DEL_BRANCHES, so any lines that do not appear once only appear in ALL_BRANCHES
sort <(echo "${DEL_BRANCHES}") <(echo "${ALL_BRANCHES}") | uniq -u

read "?Proceed? [Y/n] "
if [[ ${REPLY} =~ ^[Yy]$ ]] then
    echo "${DEL_BRANCHES}" | xargs --no-run-if-empty git branch -d
    echo "Deleted branches"
else
    echo "Aborting"
fi

git checkout "${CURRENT_BRANCH}" >/dev/null 2&>1
