#!/bin/sh
openssl pkcs12 -info -in <tenant-name>.console.ves.volterra.io.api-creds.p12 -out private_key.key -nodes -nocerts
openssl pkcs12 -info -in <tenant-name>.console.ves.volterra.io.api-creds.p12 -out certificate.cert -nokeys
