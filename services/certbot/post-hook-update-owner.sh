#!/bin/bash

if [ -z "$RENEWED_LINEAGE" ]
then
	RENEWED_LINEAGE="/etc/letsencrypt/live/$(hostname -f)/privkey.pem"
	echo Using file "$RENEWED_LINEAGE"
fi

USER=root

chown --dereference "${USER}" "${RENEWED_LINEAGE}/privkey.pem"
