#!/bash/bin
name=$1
for ip in `cat ${name}_ip.txt`
do
	ping -c 1 ${ip} >>/dev/null
	if [ $? -eq 0 ];then
	echo ${ip}  >>${name}_ok.txt
	else
	echo ${ip}  >>${name}_no.txt
	fi
done
