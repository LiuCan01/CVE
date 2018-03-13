#! /bin/bash

if test $# -ne 3; then
  echo "Parameter not right"
  echo "Usage: $0 <cvelist dir> <last time> <score threshold> e.g. $0  /home/lc/work/escore_source/cvelist 2017-12-25 8.0"
  exit 1
fi

REPO_DIR=$1
LAST_TIME=$2
SCORE_THRESHOLD=$3

WORKDIR=`mktemp -d`
CURRENT_DIR=`pwd`

cd $REPO_DIR

#clean and update the repo 
git clean -d -x -f -q
git checkout -f -q
git pull -f > /dev/null

COMMIT_ID=`git log --date=short | grep  -m 1 -B 3 'Date:   '$LAST_TIME| grep commit |awk '{print $2}'`

git reset  -q  --soft $COMMIT_ID 

git status| grep CVE-|awk '{print $NF}' |while read line ; 
do  
	[ `cat $line| grep 'CVSS 3.0 Base Score'| wc -l` -gt 0 ] && echo $line >> $WORKDIR/cve_score_list 
done

while read line;
do
    SCORE_NUM=`/usr/bin/python $CURRENT_DIR/get-severity.py $REPO_DIR/$line`
    if [ `echo " $SCORE_NUM > $SCORE_THRESHOLD"|bc` -eq 1 ];then
        #echo $SCORE_NUM
        echo $line >> $WORKDIR/cve_list
        /usr/bin/python $CURRENT_DIR/convert-json.py $REPO_DIR/$line >> $WORKDIR/report $SCORE_NUM
    fi
done < $WORKDIR/cve_score_list


cp $WORKDIR/cve_list $CURRENT_DIR
cp $WORKDIR/report $CURRENT_DIR
rm $WORKDIR -fr
