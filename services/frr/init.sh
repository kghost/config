#! /bin/sh

TUN_LOCAL_ADDRESS=$(ip -4 addr show hole | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
TUN_PEER_ADDRESS=$(ip -4 addr show hole | grep -oP '(?<=peer\s)\d+(\.\d+){3}')

echo Using TUN address $TUN_LOCAL_ADDRESS peer $TUN_PEER_ADDRESS

echo Enable frr ospfd

sed -i 's/^ospfd=no$/ospfd=yes/g' /etc/frr/daemons

echo Restarting frr

systemctl restart frr.service

echo Configure ospfd

sudo vtysh << EOF
configure terminal
router ospf
 ospf router-id ${TUN_LOCAL_ADDRESS}
 network 172.31.0.0/16 area 0.0.0.0
 default-information originate metric 20
end
write
EOF

echo Done
