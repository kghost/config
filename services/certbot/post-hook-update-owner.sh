#!/bin/bash

if [ -z "$RENEWED_LINEAGE" ]
then
	RENEWED_LINEAGE="/etc/letsencrypt/live/$(hostname -f)"
	echo Using dir "$RENEWED_LINEAGE"
fi

chgrp --changes certbot "${RENEWED_LINEAGE}/privkey.pem"
chmod --changes g+r "${RENEWED_LINEAGE}/privkey.pem"
