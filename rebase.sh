#!/bin/bash
should_push=0

helpfunc() {
  echo "Help:

  ====================  Valid flags  ====================
  -fp          Push to origin w/ --force-with-lease flag
  -h           Displays this help dialog
  "
}

while getopts ":fp :h" opt; do
  case $opt in
    fp)
      $should_push=1
      ;;
    h)
	  helpfunc
	  exit 1
	  ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

current_branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
git checkout master 
git pull origin master
git checkout $current_branch
git rebase master

if [[ $should_push -eq 1 ]]; then
  if git diff | grep -qE '^<<<<<|>>>>>'; then
    echo "Saw a conflict marker in $(git rev-parse HEAD)" >&2
    exit 1
  else
    git push --force-with-lease origin $current_branch
  fi
fi
