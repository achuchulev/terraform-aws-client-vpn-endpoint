#!/usr/bin/env bash

[ -f $1/client-config.ovpn ] && { 
    sed -i "" "s/cvpn-endpoint/random.cvpn-endpoint/g" client-config.ovpn
} && {
    cat<<EOF >> client-config.ovpn
cert $1/$2/client1.$3.crt
key $1/$2/client1.$3.key
EOF
}
