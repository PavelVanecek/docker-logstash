#!/bin/bash

# Fail fast, including pipelines
set -e -o pipefail

# Set LOGSTASH_TRACE to enable debugging
[[ $LOGSTASH_TRACE ]] && set -x

LF_SSL_DIR='/opt/ssl'

# The default logstash-forwarder keys are insecure. Please do not
# use them in production.
#
LF_SSL_CERT_KEY_URL=${LF_SSL_CERT_KEY_URL:-"https://gist.githubusercontent.com/pblittle/8994708/raw/insecure-logstash-forwarder.key"}
LF_SSL_CERT_URL=${LF_SSL_CERT_URL:-"https://gist.githubusercontent.com/pblittle/8994726/raw/insecure-logstash-forwarder.crt"}

LF_SSL_CERT_KEY_FILE="${LF_SSL_DIR}/logstash-forwarder.key"
LF_SSL_CERT_FILE="${LF_SSL_DIR}/logstash-forwarder.crt"

forwarder_create_ssl_dir() {
    mkdir -p "$LF_SSL_DIR"
}

forwarder_download_cert() {
    wget "$LF_SSL_CERT_URL" -O "$LF_SSL_CERT_FILE"
}

forwarder_download_key() {
    wget "$LF_SSL_CERT_KEY_URL" -O "$LF_SSL_CERT_KEY_FILE"
}
