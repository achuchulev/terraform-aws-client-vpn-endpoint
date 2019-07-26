#!/usr/bin/env bash

[ -d ./easy-rsa/$2 ] && { 
    sed -i "" "s/cvpn-endpoint/random.cvpn-endpoint/g" client-config.ovpn 
}

cat<<EOF >> client-config.ovpn

cert $1/easy-rsa/$2/client1.$3.crt
key $1/easy-rsa/$2/client1.$3.key

EOF