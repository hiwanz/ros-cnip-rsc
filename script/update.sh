#!/bin/bash
status_code=$(curl -s -o /dev/null -w "%{http_code}" "https://raw.githubusercontent.com/17mon/china_ip_list/master/china_ip_list.txt")

if [ $status_code -ne 200 ]; then
    echo "无法访问文件，进程结束"
    exit 1
fi
curl -s https://raw.githubusercontent.com/17mon/china_ip_list/master/china_ip_list.txt |sed -e 's/^/add address=/g' -e 's/$/ list=CNIP/g'|sed -e $'1i\\\n/ip firewall address-list' -e $'1i\\\nremove [/ip firewall address-list find list=CNIP]' -e $'1i\\\nadd address=10.0.0.0/8 list=CNIP comment=private-network' -e $'1i\\\nadd address=172.16.0.0/12 list=CNIP comment=private-network' -e $'1i\\\nadd address=192.168.0.0/16 list=CNIP comment=private-network'>cnip.rsc