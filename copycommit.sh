#!/bin/bash
cd /home/foaj/Development/Learning/expense-control
commit=$(git status | grep 'app/' | grep -v 'deleted' | sed 's/modified://')
if [ ! -d /home/foaj/fabiocommit ]; then
mkdir /home/foaj/fabiocommit
fi
for path in $commit
do
   echo $path
   cp $path /home/foaj/fabiocommit
done
touch '/home/foaj/fabiocommit/gitstatus.txt'
git status > '/home/foaj/fabiocommit/gitstatus.txt'
cd ~ && zip -r fabiocommit.zip fabiocommit
rm -rf ~/fabiocommit


