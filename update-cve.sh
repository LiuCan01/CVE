#! /bin/bash

REPO_DIR=$1
LAST_TIME=$2
WORKDIR=`mktemp -d`
CURRENT_DIR=`pwd`

cd $REPO_DIR
git clean -d -x -f
git checkout *
git pull

COMMIT_ID=`git log --date=short | grep  -m 1 -B 3 'Date:   '$LAST_TIME| grep commit |awk '{print $2}'`

git reset $COMMIT_ID

#modified cve list
git status| grep CVE-| grep modified |awk '{print $3}' |while read line ; do  [ `cat $line| grep 'CVSS 3.0 Base Score'| wc -l` -gt 0 ] && echo $line >> $WORKDIR/cve_score_list ; done

#new cve list
#git status| grep CVE-| grep -v modified |awk '{print $2}' |while read line ; do  [ `cat $line| grep 'CVSS 3.0 Base Score'| wc -l` -gt 0 ] && echo $line >> $WORKDIR/cve_score_list ; done

cp $WORKDIR/cve_score_list $CURRENT_DIR
rm $WORKDIR -fr
