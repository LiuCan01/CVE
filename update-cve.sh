#! /bin/bash

REPO_DIR=$1
LAST_TIME=$2
WORKDIR=`mktemp -d`
CURRENT_DIR=`pwd`

cd $REPO_DIR

#clean and update the repo 
git clean -d -x -f -q
git checkout -f -q
git pull -f > /dev/null

COMMIT_ID=`git log --date=short | grep  -m 1 -B 3 'Date:   '$LAST_TIME| grep commit |awk '{print $2}'`

git reset  -q  --soft $COMMIT_ID 

#modified cve list
git status| grep CVE-|awk '{print $NF}' |while read line ; 
do  
	[ `cat $line| grep 'CVSS 3.0 Base Score'| wc -l` -gt 0 ] && echo $line >> $WORKDIR/cve_score_list 
done


cp $WORKDIR/cve_score_list $CURRENT_DIR
rm $WORKDIR -fr
