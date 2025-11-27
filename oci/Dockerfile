FROM python:3-slim

ARG ORACLE_VERSION=21.13.0.0.0
ARG ORACLE_SIMPLE_VERSION=2113000
ARG ORACLE_ZIP_DIR=instantclient_21_13

# Update, install dependencies, download and install Oracle Instant Client in one RUN
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl unzip libaio-dev && \
    mkdir -p /usr/oracle && \
    curl -fsSL "https://download.oracle.com/otn_software/linux/instantclient/${ORACLE_SIMPLE_VERSION}/instantclient-basic-linux.x64-${ORACLE_VERSION}dbru.zip" -o /usr/oracle/oic.zip && \
    curl -fsSL "https://download.oracle.com/otn_software/linux/instantclient/${ORACLE_SIMPLE_VERSION}/instantclient-sdk-linux.x64-${ORACLE_VERSION}dbru.zip" -o /usr/oracle/sdk.zip && \
    cd /usr/oracle && \
    unzip -q oic.zip && \
    unzip -q sdk.zip && \
    rm -f oic.zip sdk.zip && \
    echo /usr/oracle/${ORACLE_ZIP_DIR} > /etc/ld.so.conf.d/oracle-instantclient.conf && \
    ldconfig && \
    apt-get purge -y --auto-remove curl unzip && \
    rm -rf /var/lib/apt/lists/*
