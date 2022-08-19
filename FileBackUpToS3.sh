#!/bin/bash

nextdate=$(date -d '+1 day' '+%Y-%m-%d')
todaydate=$(date +%Y-%m-%d)
find webdata -type f -newermt $todaydate ! -newermt $nextdate > filelist.txt
data=$(<filelist.txt)
for file in $data
do
    echo ${file}
    zip -r $todaydate.zip ${file}

done
aws s3 mv $todaydate.zip s3://mountpoint811/
rm filelist.txt
