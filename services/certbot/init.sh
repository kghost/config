#! /bin/sh

BASEDIR=$(dirname "$0")

certbot certonly --config ${BASEDIR}/cli.ini --manual --preferred-challenge=dns --manual-auth-hook="${BASEDIR}/acme-nsupdate.sh" --manual-cleanup-hook="${BASEDIR}/acme-clean.sh" --post-hook="${BASEDIR}/post-hook-update-owner.sh" --domain $(hostname -f)
