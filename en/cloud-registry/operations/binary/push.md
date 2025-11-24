---
title: Pushing a binary artifact to a {{ cloud-registry-full-name }} registry
description: Follow this guide to push a binary artifact to a registry in {{ cloud-registry-full-name }}.
---

# Pushing a binary artifact to a registry

To push a [binary artifact](../../concepts/art-binary.md), use a POST [HTTP](https://{{ lang }}.wikipedia.org/wiki/HTTP) request. When sending the request, use authentication with an [IAM token](../../../iam/concepts/authorization/iam-token.md). The maximum size of the file to push is 100 MB.

Request example:

```bash
curl \
  --request PUT \
  --user "iam:<IAM_token>" \
  --header "X-Checksum-SHA256: <file_hash>" \
  --upload-file <local_path_to_file> \
  https://{{ cloud-registry }}/binaries/<registry_ID>/<artifact_name>/<artifact_version>/<file_name_in_registry>
```

Where:

* In the `--user` authentication parameter, specify the `iam` username and the [IAM token](../../../iam/concepts/authorization/iam-token.md) value.
* In the `X-Checksum-SHA256` header, you can specify the hash of the file you are pushing to check the file’s integrity after it is pushed. This is an optional header.

    You can generate the hash, e.g., using this command:
    
    ```bash
    openssl dgst -sha256 <file_path> | awk '{print $2}'
    ```
* In the `--upload-file` parameter, specify the local path to the file being pushed.
* The request URL contains the registry URL, the artifact name and version, as well as the file name in the registry. Here is an example:

    ```bash
    https://{{ cloud-registry }}/binaries/cn15fqbr806r********/sample-package/3.5.4/agent-installer.sh
    ```