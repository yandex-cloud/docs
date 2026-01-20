---
title: Pulling a binary artifact from a {{ cloud-registry-full-name }}
description: Follow this guide to pull a binary artifact from a {{ cloud-registry-full-name }}.
---

# Pulling a binary artifact from a registry

1. {% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}
1. To pull a [binary artifact](../../concepts/art-binary.md), use a GET [HTTP](https://{{ lang }}.wikipedia.org/wiki/HTTP) request:

    ```bash
    curl \
      --request GET \
      --user "$REGISTRY_USERNAME:$REGISTRY_PASSWORD" \
      --location \
      --output <local_path_to_file> \
      https://{{ cloud-registry }}/binaries/<registry_ID>/<artifact_name>/<artifact_version>
    ```

    Where:

    * `--request`: Method.
    * `--user`: Authentication data.
    * `--output`: Local path and name of the file to pull the artifact to.
    * The request URL contains the registry URL as well as the artifact name and version. Here is an example:

        ```bash
        https://{{ cloud-registry }}/binaries/cn15fqbr806r********/sample-package/3.5.4
        ```