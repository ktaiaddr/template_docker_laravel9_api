#!/bin/bash

DIR=$(cd $(dirname $0);pwd -P)

read -p '開発ホスト名を入力してください（例：local.xxxxx.siteengine.co.jp）： ' HOSTNAME

if [ -z "$HOSTNAME" ]; then
  echo ホスト名を入力してください
  exit
fi

SSL_FILES_DIR=${DIR}/ssl
mkdir ${SSL_FILES_DIR}

KEYFILE=${SSL_FILES_DIR}/ssl.key
CSRFILE=${SSL_FILES_DIR}/ssl.csr
SANFILE=${SSL_FILES_DIR}/san.txt
CRTFILE=${SSL_FILES_DIR}/ssl.crt

SUBJECT="/C=JP/ST=Tokyo/L=LOCAL/O=LOCAL inc./OU=LOCAL/CN=${HOSTNAME}"

openssl genrsa -out ${KEYFILE} 2048

openssl req -new -sha256 -key ${KEYFILE} -out ${CSRFILE} -subj "${SUBJECT}"

openssl req -noout -text -in ${CSRFILE}

echo "subjectAltName = DNS:${HOSTNAME}" >  ${SANFILE}

openssl x509 -req -sha256 -days 3650 -signkey ${KEYFILE} -in ${CSRFILE} -out ${CRTFILE} -extfile ${SANFILE}
