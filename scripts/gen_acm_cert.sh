#!/usr/bin/env bash

git clone https://github.com/OpenVPN/easy-rsa.git
cd easy-rsa/easyrsa3
./easyrsa init-pki
export EASYRSA_BATCH=1
./easyrsa build-ca nopass
./easyrsa build-server-full server nopass
./easyrsa build-client-full client1.$2 nopass
mkdir ../../$1
mv pki/ca.crt ../../$1/
mv pki/issued/server.crt ../../$1/
mv pki/private/server.key ../../$1/
mv pki/issued/client1.$2.crt ../../$1/
mv pki/private/client1.$2.key ../../$1/
