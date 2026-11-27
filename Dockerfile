# Base pinned by digest (multi-arch index): `docker buildx imagetools inspect python:3-slim`, copy the top-level "Digest:".
# Dependabot (docker, target dev) opens a PR when the digest moves.
FROM python:3-slim@sha256:63bb298d2b7b88f176f51b5189f54ce6535c997682ea70885d2132f5d473a8a5

# Update and install dependencies
RUN apt-get update && apt-get install -y curl && apt-get upgrade -y && \
    apt-get autoclean -y
