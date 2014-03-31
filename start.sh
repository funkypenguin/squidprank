# Permit ip forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

# Setup iptables for interception
iptables -t nat -A PREROUTING -i eth1 -p tcp --dport 80 -j REDIRECT --to-ports 3129 
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE 

# This is a bit dirty, but it clears the vagrant default gw(s), and updates gateway to whatever's on eth1 via DHCP, so that we can arpspoof
route del default
route del default
dhclient eth1

# Arpspoof the default gw
GATEWAY=`ip -4 route list 0/0 | cut -d ' ' -f 3`
# /usr/bin/screen -S arpspoof -d -m /usr/sbin/arpspoof -i eth1 $GATEWAY

# echo Done. Run "screen -S arpspoof" to see the arpspoof output
