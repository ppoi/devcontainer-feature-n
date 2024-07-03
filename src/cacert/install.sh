#!/bin/bash

set -e

CANAME=${CANAME:-$(date +%s)}

echo "install CA certification named ${CANAME}"

CERT_DATA=""
if [ ! -z "${CERT}" ]; then
  echo "use inline certification"
  CERT_DATA=$(echo "-----BEGIN CERTIFICATE-----\n${CERT}\n-----END CERTIFICATE-----")
elif [ ! -z "${CERT_URL}" ]; then
  echo "certification url: ${CERT_URL}"
  CERT_DATA=$(curl -kL ${CERT_URL})
fi

if [ -z "${CERT_DATA}" ]; then
  echo "Missing CA cert source."
  exit 1
fi

echo "install CA cert: ${CANAME}"
echo "${CERT_DATA}" | tee "/usr/local/share/ca-certificates/${CANAME}.crt"
update-ca-certificates

if [ "${JVM}" = "true" ] && which keytool > /dev/null; then
  echo "install CA cert into JVM default keystore."
  keytool -cacerts -import -alias ${CANAME} -storepass "${JVM_KEYSTORE_PASS:-"changeit"}" -f "/usr/local/share/ca-certificates/${CANAME}.crt"
fi

echo "Done!"