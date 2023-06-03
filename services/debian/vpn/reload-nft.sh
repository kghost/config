#! /usr/bin/bash

ip ro add default via 172.30.12.1 table 20
ip ru add from all fwmark 0x20 iif lo pref 10000 table 20

nft delete table inet proute

nft -f "$(dirname -- ${BASH_SOURCE[0]})/nft-policy-route"
nft -f "$(dirname -- ${BASH_SOURCE[0]})/nft-fill-v4vpn"

nft list table inet proute
