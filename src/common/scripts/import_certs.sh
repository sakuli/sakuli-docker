#!/usr/bin/env bash

### Script installs root.cert.pem to certificate trust store of applications using NSS

if [ -z ${SAKULI_TRUSTED_CA_DIR+x} ]; then
    echo "NO CERTIFICATES PATH FOR IMPORT SET, SKIPPING"
else
    for cert in $SAKULI_TRUSTED_CA_DIR/*.{cer,crt,pem}; do
        certfile=$(basename $cert)
        certname="${certfile%%.*}"

        if [ -f $cert ]; then
            echo "IMPORTING ${certfile}"

            ###
            ### For cert8 (legacy - DBM)
            ###
            for certDB in $(find ~/ -name "cert8.db"); do
                echo "Installing certificate to ${certDB}"
                certdir=$(dirname ${certDB})
                certutil -A -n "${certname}" -t "TCu,Cu,Tu" -i ${cert} -d dbm:${certdir}
            done

            ###
            ### For cert9 (SQL)
            ###
            for certDB in $(find ~/ -name "cert9.db"); do
                echo "Installing certificate to ${certDB}"
                certdir=$(dirname ${certDB})
                certutil -A -n "${certname}" -t "TCu,Cu,Tu" -i ${cert} -d sql:${certdir}
            done
        fi
    done
fi
