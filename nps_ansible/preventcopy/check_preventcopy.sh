#!/bash/bin
while true
do
for i in {1,2,3,3bei,4,5,6,8,9,13,14,21,zhishi,gf,apm}
do
result=`ps aux|grep -v grep|grep "ansible ${i}"|wc -l`
if [ $result -eq 0 ];then
	sh /root/ansible_playbooks/preventcopy/preventcopy_start.sh ${i} &
fi
done
sleep 30
done
