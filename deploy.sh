#!/bin/bash
host=""
if [ $1 == "test" ]
then
  host="hera-test"
elif [ $1 == "online" ]
then
  host="hera-test-online"
elif [ $1 == "prod" ]
then
  host="hera-s1"
fi
echo "host is ${host}"
cur_date="`date +%Y%m%d%H%m%s`" 
tar zcvf $cur_date.tar.gz dist
scp $cur_date.tar.gz ubuntu@${host}:~/
ssh ubuntu@${host} "tar zxvf ${cur_date}.tar.gz"
ssh ubuntu@${host} "if [ -d heraConsole.bak ]; then rm -rf heraConsole.bak heraConsole.bak; fi"
ssh ubuntu@${host} "if [ -d heraConsole ]; then mv heraConsole heraConsole.bak; fi"
ssh ubuntu@${host} "mv dist heraConsole"
ssh ubuntu@${host} "rm ${cur_date}.tar.gz"
rm ${cur_date}.tar.gz
