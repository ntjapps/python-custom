# Base pinned by digest (multi-arch index): `docker buildx imagetools inspect python:3-slim`, copy the top-level "Digest:".
# Dependabot (docker, target dev) opens a PR when the digest moves.
FROM python:3-slim@sha256:65a65fc7b30b06cb6df4930fd4650697cb23f4c2698ab81fc87e4b031bc36928

ARG ORACLE_VERSION=21.23.0.0.0
ARG ORACLE_SIMPLE_VERSION=2123000
ARG ORACLE_ZIP_DIR=instantclient_21_23
# Instant Client 21 has no Linux arm64 build; arm64 images get 19.x, the
# newest line Oracle ships for aarch64. /usr/oracle/instantclient points at
# whichever one was installed.
ARG ORACLE_ARM64_VERSION=19.32.0.0.0
ARG ORACLE_ARM64_SIMPLE_VERSION=1932000
ARG ORACLE_ARM64_ZIP_DIR=instantclient_19_32
# SHA-256 of the four zips above (computed from the files download.oracle.com served on 2026-11-12, i.e. trust on first download:
# compare with Oracle's download page when bumping). The build fails on a mismatch. Bump a version and its two hashes together, per arch.
ARG ORACLE_BASIC_SHA256=68a6ccd7ca6fbfb4d2914bd6531a8599fdb75841b8d47df5256bfef40d020820
ARG ORACLE_SDK_SHA256=784241faffe2bd8dee1c045a1b2032535f44a5e0a819ec6a50417939fe0a7780
ARG ORACLE_ARM64_BASIC_SHA256=d5b413822c6cb1a9bb5cfe83ee2a138c39e9b7a931fb9887f5c82fc67ca859ad
ARG ORACLE_ARM64_SDK_SHA256=be3b37817943102cb051fad80f5dc821821cf1616ffd0983c2ded81621c760d3
ARG TARGETARCH

# Update, install dependencies, download and install Oracle Instant Client in one RUN
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl unzip libaio-dev && \
    mkdir -p /usr/oracle && \
    case "${TARGETARCH:-amd64}" in \
        arm64) ic_arch=arm64; ic_ver=${ORACLE_ARM64_VERSION}; ic_simple=${ORACLE_ARM64_SIMPLE_VERSION}; ic_dir=${ORACLE_ARM64_ZIP_DIR}; ic_basic_sha=${ORACLE_ARM64_BASIC_SHA256}; ic_sdk_sha=${ORACLE_ARM64_SDK_SHA256} ;; \
        *) ic_arch=x64; ic_ver=${ORACLE_VERSION}; ic_simple=${ORACLE_SIMPLE_VERSION}; ic_dir=${ORACLE_ZIP_DIR}; ic_basic_sha=${ORACLE_BASIC_SHA256}; ic_sdk_sha=${ORACLE_SDK_SHA256} ;; \
    esac && \
    curl -fsSL "https://download.oracle.com/otn_software/linux/instantclient/${ic_simple}/instantclient-basic-linux.${ic_arch}-${ic_ver}dbru.zip" -o /usr/oracle/oic.zip && \
    curl -fsSL "https://download.oracle.com/otn_software/linux/instantclient/${ic_simple}/instantclient-sdk-linux.${ic_arch}-${ic_ver}dbru.zip" -o /usr/oracle/sdk.zip && \
    echo "${ic_basic_sha}  /usr/oracle/oic.zip" | sha256sum -c - && \
    echo "${ic_sdk_sha}  /usr/oracle/sdk.zip" | sha256sum -c - && \
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
