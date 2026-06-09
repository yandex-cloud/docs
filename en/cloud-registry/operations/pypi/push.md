---
title: Pushing a Python package to a registry in {{ cloud-registry-name }}
description: This guide describes how to push a Python package to a registry in {{ cloud-registry-name }}.
---

# Pushing a Python package to a local registry in {{ cloud-registry-name }}

This guide describes how to push a [Python package](../../concepts/artifacts/python.md) to a [local registry](../../concepts/registry.md#local-registry).

To push a Python package to a registry, you need the `cloud-registry.artifacts.pusher` [role](../../security/index.md#cloud-registry-artifacts-pusher) or higher.

{% list tabs group=python_tools %}

- pip + twine {#pip-twine}

  1. If you do not have a built package yet, [create](create.md) one.

  1. Upload the package: 
      
      ```bash
      export LOCAL_REG_ID="<registry_ID>"
      export IAM_TOKEN="<IAM_token>"

      twine upload \
      --repository-url "https://registry.yandexcloud.net/pypi/$LOCAL_REG_ID/legacy/" \
      --username iam \
      --password "$IAM_TOKEN" \
      dist/*
      ```

      Or [configure](installation.md) authentication using a `~/.pypirc` file:

      ```ini
      [distutils]
      index-servers = cloud-registry

      [cloud-registry]
      repository = https://{{ cloud-registry }}/pypi/<registry_ID>/legacy/
      username = iam
      password = <IAM_token>
      ```

      Where:
      * `<registry_ID>`: Your local registry ID.
      * `username`: Token type, `iam` or `api_key`.
      * `password`: Token value.

      ```bash
      python3 -m twine upload --repository cloud-registry dist/*
      ```
      
      Result:

      ```text
      Uploading distributions to https://{{ cloud-registry }}/pypi/e5o6a2blpkb6********/legacy/
      Uploading my_package-0.0.1-py3-none-any.whl
      100% ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 4.5/4.5 kB • 00:00 • ?
      Uploading my_package-0.0.1.tar.gz
      100% ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 3.8/3.8 kB • 00:00 • ?
      ```

- Poetry {#poetry}

  1. If you do not have a built package yet, [create](create.md) one.

  1. Set up a repository for publishing:

      ```bash
      poetry config repositories.cloud-registry https://{{ cloud-registry }}/pypi/<registry_ID>/legacy/
      ```

  1. Set up authentication:

      ```bash
      poetry config http-basic.cloud-registry iam "$(yc iam create-token)"
      ```

      Where:

        * `iam`: Token type. Instead of `iam`, you can use `api_key`.
        * `<registry_ID>`: Your local registry ID.

  1. Upload the package into the registry:

      ```bash
      poetry publish -r cloud-registry
      ```

      Result:

      ```text
      Publishing my_package (0.0.1) to cloud-registry
       - Uploading my_package-0.0.1-py3-none-any.whl 100%
       - Uploading my_package-0.0.1.tar.gz 100%
      ```

- uv {#uv}

  1. If you do not have a built package yet, [create](create.md) one.

  1. Upload the package: 
      
      ```bash
      export LOCAL_REG_ID="<registry_ID>"
      export IAM_TOKEN="<IAM_token>"

      uv publish \
        --publish-url "https://registry.yandexcloud.net/pypi/$LOCAL_REG_ID/legacy/" \
        --username iam \
        --password "$IAM_TOKEN" \
        dist/*
      ```

      Or create a file named `uv.toml` in the project root:

      ```toml
      [publish]
      url = "https://{{ cloud-registry }}/pypi/<registry_ID>/legacy/"
      username = "iam"
      password = "<IAM_token>"
      ```

      Where:
      * `<registry_ID>`: Your local registry ID.
      * `username`: Token type, `iam` or `api_key`.
      * `password`: Token value.

      ```bash
      uv publish
      ```

      Result:

      ```text
      Uploading my_package-0.0.1-py3-none-any.whl (4.5 KB)
      Uploading my_package-0.0.1.tar.gz (3.8 KB)
      ```

{% endlist %}

#### See also {#see-also}

* [{#T}](create.md)
* [{#T}](pull.md)
* [{#T}](examples.md)
