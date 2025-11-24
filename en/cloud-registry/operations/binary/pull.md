---
title: Pulling a binary artifact from a {{ cloud-registry-full-name }}
description: Follow this guide to pull a binary artifact from a {{ cloud-registry-full-name }}.
---

# Pulling a binary artifact from a registry

To pull a [binary artifact](../../concepts/art-binary.md), use a GET HTTP request. When sending the request, use authentication with an [IAM token](../../../iam/concepts/authorization/iam-token.md).

Request example:

```bash
curl \
  --request GET \
  --user "iam:<IAM_token>" \
  --location \
  --output <local_path_to_file> \
  https://{{ cloud-registry }}/binaries/<registry_ID>/<artifact_name>/<artifact_version>
```

Where:

* In the `--user` authentication parameter, specify the `iam` username and the [IAM token](../../../iam/concepts/authorization/iam-token.md) value.
* In the `--output` parameter, specify the local path and name of the file to pull the artifact to.
* The request URL contains the registry URL as well as the artifact name and version. Here is an example:

    ```bash
    https://{{ cloud-registry }}/binaries/cn15fqbr806r********/sample-package/3.5.4
    ```