#!/bash/bin
num=$1
for ip in `cat ${num}_ok.txt`
do
echo -e "${ip}  ansible_ssh_user=\"Administrator\" ansible_ssh_pass=\"NPS#2018\" ansible_ssh_port=5985 ansible_connection=\"winrm\" ansible_winrm_server_cert_validation=ignore" >>${num}_ansible.txt
done
