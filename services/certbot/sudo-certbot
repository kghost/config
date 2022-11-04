#! /bin/sh

BASEDIR=$(realpath $(dirname "$0"))
CERTBOT_DIR=/etc/letsencrypt

groupadd -g 28401 certbot

mkdir --verbose -p ${CERTBOT_DIR}
chgrp --changes certbot ${CERTBOT_DIR}
chmod --changes g+srx ${CERTBOT_DIR}

mkdir -p ${CERTBOT_DIR}/live ${CERTBOT_DIR}/archive
chgrp --changes certbot ${CERTBOT_DIR}/live ${CERTBOT_DIR}/archive
chmod --changes g+srx ${CERTBOT_DIR}/live ${CERTBOT_DIR}/archive

for i in ${CERTBOT_DIR}/live/* ${CERTBOT_DIR}/archive/* ; do
    if [ -d $i ] ; then
        chgrp --changes certbot ${i}
        chmod --changes g+srx ${i}

        for j in $i/* ; do
            chgrp --changes certbot ${j}
            chmod --changes g+r ${j}
        done
    fi
done

certbot certonly --config ${BASEDIR}/cli.ini --manual --preferred-challenge=dns --manual-auth-hook="${BASEDIR}/acme-nsupdate.sh" --manual-cleanup-hook="${BASEDIR}/acme-clean.sh" --post-hook="${BASEDIR}/post-hook-update-owner.sh" --domain $(hostname -f)
