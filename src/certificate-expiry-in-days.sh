#!/bin/bash

# is openssl installed ?
command -v openssl >/dev/null 2>&1 || { echo >&2 "openssl is required to run this script. Aborting."; exit 1; }

# are 2 parameters supplied ?
# parameter 1 = host
# parameter 2 = port
if (( $# == 2))
then
  expirationDate=$(echo | openssl s_client -connect $1:$2 2>/dev/null | openssl x509 -noout -dates | tail -n 1 | cut -d'=' -f 2)
  expirationEpochSeconds=$(date -d "$expirationDate" +%s)
  nowEpochSeconds=$(date +%s)
  secondsToExpire=$((expirationEpochSeconds-nowEpochSeconds))
  daysToExpire=$((secondsToExpire/86400))
  echo $daysToExpire
else
  echo "This script tests the expiry of SSL certificates in days"
  echo "--------------------------------------------------------"
  echo "Usage 'certificate-expiry-in-days [host] [port]"
fi



