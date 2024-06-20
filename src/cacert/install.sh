#!/bin/bash

set -e

CANAME=${CANAME:-$(date +%s)}

CERT_DATA=""
if [ ! -z "${CERT}" ]; then
  CERT_DATA=${CERT}
elif [ ! -z "${CERT_URL}" ]; then
  CERT_DATA=$(curl -kL ${CERT_URL})
fi

if [ -z "${CERT_DATA}" ]; then
  echo "Missing CA cert source."
  exit 1
fi

echo "install CA cert: ${CANAME}"
echo ${CERT_DATA} | sudo tee "/usr/local/share/ca-certificates/${CANAME}.crt"
sudo update-ca-certificates

if [ "${JVM}" -eq "true" && (which keytool) ]; then
  echo "install CA cert into JVM default keystore."
  sudo keytool -cacerts -import -alias ${CANAME} -storepass "${JVM_KEYSTORE_PASS:-"changeit"}" -f "/usr/local/share/ca-certificates/${CANAME}.crt"
fi

echo "Done!"