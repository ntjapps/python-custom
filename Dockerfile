# Base pinned by digest (multi-arch index): `docker buildx imagetools inspect python:3-slim`, copy the top-level "Digest:".
# Dependabot (docker, target dev) opens a PR when the digest moves.
FROM python:3-slim@sha256:65a65fc7b30b06cb6df4930fd4650697cb23f4c2698ab81fc87e4b031bc36928

# Update and install dependencies
RUN apt-get update && apt-get install -y curl && apt-get upgrade -y && \
    apt-get autoclean -y
