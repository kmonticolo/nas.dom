#http://www.funtoo.org/Traffic_Control
# priorities packets for wrt54

# cat ~/.ssh/id_rsa.pub | ssh 192.168.1.1  'mkdir ~/.ssh; cat - >> ~/.ssh/authorized_keys'
# scp prio_ack.sh 192.168.1.1:
# ssh 192.168.1.1 'sh prio_ack.sh'
# ssh 192.168.1.1 'iptables -L -t mangle -nv'


iptables -t mangle -N ack
iptables -t mangle -A ack -m tos ! --tos Normal-Service -j RETURN
iptables -t mangle -A ack -p tcp -m length --length 0:128 -j TOS --set-tos Minimize-Delay
iptables -t mangle -A ack -p tcp -m length --length 128: -j TOS --set-tos Maximize-Throughput
iptables -t mangle -A ack -j RETURN
 
iptables -t mangle -A POSTROUTING -p tcp -m tcp --tcp-flags SYN,RST,ACK ACK -j ack
