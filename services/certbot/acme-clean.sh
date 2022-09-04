#!/bin/bash

if [ -z "$CERTBOT_DOMAIN" ]
then
	echo "EMPTY DOMAIN"
	exit -1
fi

BASEDIR=$(dirname "$0")
SERVER=ns.kghost.info

DOMAIN=$(expr match "$CERTBOT_DOMAIN" '[^.]*\.\(.*\)')
HOST=$(expr match "$CERTBOT_DOMAIN" '\([^.]*\)\..*')
ACME="_acme-challenge"

/usr/bin/nsupdate -k "${BASEDIR}/dyn_update" << EOM
server ${SERVER}
zone dyn.${DOMAIN}
update delete ${ACME}.${HOST}.dyn.${DOMAIN} TXT
send
EOM
