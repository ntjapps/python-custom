FROM python:3-slim

ARG ORACLE_VERSION=21.23.0.0.0
ARG ORACLE_SIMPLE_VERSION=2123000
ARG ORACLE_ZIP_DIR=instantclient_21_23

# Update, install dependencies, download and install Oracle Instant Client in one RUN
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl unzip libaio-dev && \
    mkdir -p /usr/oracle && \
    curl -fsSL "https://download.oracle.com/otn_software/linux/instantclient/${ORACLE_SIMPLE_VERSION}/instantclient-basic-linux.x64-${ORACLE_VERSION}dbru.zip" -o /usr/oracle/oic.zip && \
    curl -fsSL "https://download.oracle.com/otn_software/linux/instantclient/${ORACLE_SIMPLE_VERSION}/instantclient-sdk-linux.x64-${ORACLE_VERSION}dbru.zip" -o /usr/oracle/sdk.zip && \
    cd /usr/oracle && \
    unzip -qo oic.zip && \
    unzip -qo sdk.zip && \
    rm -f oic.zip sdk.zip && \
    echo /usr/oracle/${ORACLE_ZIP_DIR} > /etc/ld.so.conf.d/oracle-instantclient.conf && \
    # Debian 13 ships only libaio.so.1t64; Instant Client links against libaio.so.1.
    for aio in /usr/lib/*/libaio.so.1t64; do \
        [ -e "$(dirname "$aio")/libaio.so.1" ] || ln -s "$aio" "$(dirname "$aio")/libaio.so.1"; \
    done && \
    ldconfig && \
    ! ldd /usr/oracle/${ORACLE_ZIP_DIR}/libclntsh.so | grep 'not found' && \
    apt-get purge -y --auto-remove curl unzip && \
    rm -rf /var/lib/apt/lists/*
