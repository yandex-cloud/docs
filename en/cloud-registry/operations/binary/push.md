---
title: Pushing a binary artifact to a {{ cloud-registry-full-name }} registry
description: Follow this guide to push a binary artifact to a registry in {{ cloud-registry-full-name }}.
---

# Pushing a binary artifact to a registry

1. {% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}
1. To push a [binary artifact](../../concepts/art-binary.md), use a POST [HTTP](https://{{ lang }}.wikipedia.org/wiki/HTTP) request:

    ```bash
    curl \
      --request PUT \
      --user "$REGISTRY_USERNAME:$REGISTRY_PASSWORD" \
      --header "X-Checksum-SHA256: <file_hash>" \
      --upload-file <local_path_to_file> \
      https://{{ cloud-registry }}/binaries/<registry_ID>/<artifact_name>/<artifact_version>/<file_name_in_registry>
    ```

    Where:

    * `--request`: Method.
    * `--user`: Authentication data.
    * `--header`: API request header. This is an optional setting.

        In the `X-Checksum-SHA256` header, you can specify the hash of the file you are pushing to check the file’s integrity after it is pushed. You can generate the hash, e.g., using this command:

        ```bash
        openssl dgst -sha256 <file_path> | awk '{print $2}'
        ```

    * `--upload-file`: Local path to the file to upload. Maximum size: 100 MB.
    * The request URL contains the registry URL, the artifact name and version, as well as the file name in the registry. Here is an example:

        ```bash
        https://{{ cloud-registry }}/binaries/cn15fqbr806r********/sample-package/3.5.4/agent-installer.sh
        ```