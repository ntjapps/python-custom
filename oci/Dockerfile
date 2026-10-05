FROM python:3-slim

ARG ORACLE_VERSION=21.23.0.0.0
ARG ORACLE_SIMPLE_VERSION=2123000
ARG ORACLE_ZIP_DIR=instantclient_21_23
# Instant Client 21 has no Linux arm64 build; arm64 images get 19.x, the
# newest line Oracle ships for aarch64. /usr/oracle/instantclient points at
# whichever one was installed.
ARG ORACLE_ARM64_VERSION=19.32.0.0.0
ARG ORACLE_ARM64_SIMPLE_VERSION=1932000
ARG ORACLE_ARM64_ZIP_DIR=instantclient_19_32
ARG TARGETARCH

# Update, install dependencies, download and install Oracle Instant Client in one RUN
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl unzip libaio-dev && \
    mkdir -p /usr/oracle && \
    case "${TARGETARCH:-amd64}" in \
        arm64) ic_arch=arm64; ic_ver=${ORACLE_ARM64_VERSION}; ic_simple=${ORACLE_ARM64_SIMPLE_VERSION}; ic_dir=${ORACLE_ARM64_ZIP_DIR} ;; \
        *) ic_arch=x64; ic_ver=${ORACLE_VERSION}; ic_simple=${ORACLE_SIMPLE_VERSION}; ic_dir=${ORACLE_ZIP_DIR} ;; \
    esac && \
    curl -fsSL "https://download.oracle.com/otn_software/linux/instantclient/${ic_simple}/instantclient-basic-linux.${ic_arch}-${ic_ver}dbru.zip" -o /usr/oracle/oic.zip && \
    curl -fsSL "https://download.oracle.com/otn_software/linux/instantclient/${ic_simple}/instantclient-sdk-linux.${ic_arch}-${ic_ver}dbru.zip" -o /usr/oracle/sdk.zip && \
    cd /usr/oracle && \
    unzip -qo oic.zip && \
    unzip -qo sdk.zip && \
    ln -sfn /usr/oracle/${ic_dir} /usr/oracle/instantclient && \
    rm -f oic.zip sdk.zip && \
    echo /usr/oracle/instantclient > /etc/ld.so.conf.d/oracle-instantclient.conf && \
    # Debian 13 ships only libaio.so.1t64; Instant Client links against libaio.so.1.
    for aio in /usr/lib/*/libaio.so.1t64; do \
        [ -e "$(dirname "$aio")/libaio.so.1" ] || ln -s "$aio" "$(dirname "$aio")/libaio.so.1"; \
    done && \
    ldconfig && \
    ! ldd /usr/oracle/instantclient/libclntsh.so | grep 'not found' && \
    apt-get purge -y --auto-remove curl unzip && \
    rm -rf /var/lib/apt/lists/*
