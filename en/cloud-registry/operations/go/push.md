---
title: Pushing a Go module to a {{ cloud-registry-full-name }} registry
description: Follow this guide to push a Go module to a registry in {{ cloud-registry-full-name }}.
---

# Pulling a Go module to the registry

Before pushing, prepare a ZIP archive of your Go module. For more information, see [{#T}](create.md).

1. {% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}
1. Push the [Go module](../../concepts/artifacts/go.md) using a PUT HTTP request:

    ```bash
    curl \
      --request PUT \
      --user "$REGISTRY_USERNAME:$REGISTRY_PASSWORD" \
      --header "X-Checksum-SHA256: <file_hash>" \
      --upload-file <local_path_to_ZIP_file> \
      https://registry.yandexcloud.net/go/<registry_ID>/<module_name>/<module_version>/<file_name_in_registry>
    ```

    Where:

    * `--request`: Method.
    * `--user`: Authentication data.
    * `--header`: API request header. This is an optional setting.

        In the `X-Checksum-SHA256` header, you can specify the hash of the file you are pushing to check the file’s integrity after it is pushed. You can generate the hash, e.g., using this command:

        ```bash
        openssl dgst -sha256 <file_path> | awk '{print $2}'
        ```

    * `--upload-file`: Local path to the ZIP file. 
    * The request URL contains the registry URL, the Go module name and version, and the file name in the registry. For example:

        ```bash
        https://registry.yandexcloud.net/go/cn15fqbr806r********/mymodule/1.0.0/mymodule-v1.0.0.zip
        ```

    {% note warning %}

    In the URL, provide the Go module version without the `v` prefix; e.g., for version `v1.0.0`, specify `1.0.0`.

    {% endnote %}

    {% note warning %}

    When publishing a Go module, do not prefix its name with `registry.yandexcloud.net/go/<registry_ID>/`. If your Go module's major version is greater than 1, omit the `/vN` suffix as well; e.g., for a `registry.yandexcloud.net/go/<registry_ID>/sample/module/v4` Go module, use `sample/module` as its name.

    {% endnote %}
