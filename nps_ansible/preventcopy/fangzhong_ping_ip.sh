#!/bash/bin
name=fangzhong_ip.txt
for ip in `cat ${name}|awk '{print $2}'`
do
	ping -c 1 ${ip} >>/dev/null
	if [ $? -ne 0 ];then
	grep ${ip} ./${name} >>fangzhong_butong.txt
	else
	grep ${ip} ./${name} >>fangzhong_tong.txt
	fi
done
