# What is this repository?

This is python image with Oracle Instantclient installed for oracle support

# Releases and tags

- No version tags for routine releases; do not create `v*` tags here. An image is published by dispatching `docker-build.yaml` on the default branch `latest` (`gh workflow run docker-build.yaml --ref latest`), only when the owner asks. Every workflow is manual-only because CI costs money.
- The image tag derives from the dispatched ref: `latest` comes from branch `latest`, any other branch publishes under its own branch name, so publish from `latest` only.

# LICENSE

License can be read in [LICENSE](https://github.com/ntjapps/python-custom/blob/latest/LICENSE)

# UPDATE

28 Sep 2026
