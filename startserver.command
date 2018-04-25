#!/bin/bash
cd $(dirname $0)/pptc
rm -v foobar.*
php -S 0.0.0.0:1234 &
#./apache.sh $PWD 1234 &
php testwebsock.php &
sleep 3
echo "Adresse: $(ifconfig|grep inet|grep -v "127.0.0.1"|grep -v "::1"|grep -v "inet6"|awk '{ print $2 }'):1234"
while true
do
sleep 999
done

