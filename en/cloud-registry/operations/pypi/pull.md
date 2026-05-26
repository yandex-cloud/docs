---
title: Pulling a Python package from a {{ cloud-registry-name }}
description: Follow this guide to pull a Python package from a {{ cloud-registry-name }}.
---

# Pulling a Python package from a {{ cloud-registry-name }}

To pull a [Python package](../../concepts/artifacts/python.md), you need the `cloud-registry.artifacts.puller` [role](../../security/index.md#cloud-registry-artifacts-puller) or higher.

{% list tabs group=python_tools %}

- pip {#pip}

  1. Set authentication variables:
     
     ```bash
     export IAM_TOKEN="<IAM_token>"
     export LOCAL_REG_ID="<registry_ID>"   
     export REMOTE_REG_ID="<remote_registry_ID>"  
     export VIRTUAL_REG_ID="<virtual_registry_ID>"
     ```  
  
  1. Pull a Python package from a [registry](../../concepts/registry.md):

      ```bash
      pip install <package_name> \
        --index-url https://iam:$IAM_TOKEN@{{ cloud-registry }}/pypi/$LOCAL_REG_ID/simple/
      ```

      Where:
      * `$IAM_TOKEN`: IAM token being used for authentication.
      * `<registry_ID>`: Your registry ID.
      * `<package_name>`: Name of the package being installed.

      Result:

      ```text
      Collecting my_package
        Downloading https://{{ cloud-registry }}/pypi/e5o6a2blpkb6********/simple/my-package/my_package-0.0.1-py3-none-any.whl (4.5 kB)
      Installing collected packages: my_package
      Successfully installed my_package-0.0.1
      ```

  1. Make sure the package was installed:

      ```bash
      python3 -m pip list | grep my_package
      ```

      Result:

      ```text
      my_package    0.0.1
      ```

- Poetry {#poetry}

  1. Set authentication variables:
     
     ```bash
     export IAM_TOKEN="<IAM_token>"
     export LOCAL_REG_ID="<registry_ID>"   
     export REMOTE_REG_ID="<remote_registry_ID>"  
     export VIRTUAL_REG_ID="<virtual_registry_ID>"
     ``` 

  1. Add the package source:

      ```bash
      poetry config http-basic.cloud-registry iam $IAM_TOKEN
      poetry init  # Press Enter for all questions
      poetry source add cloud-registry https://iam:$IAM_TOKEN@{{ cloud-registry }}/pypi/$LOCAL_REG_ID/simple/
      ```

  1. Download a package:

      ```bash
      poetry add <package_name> --source cloud-registry
      ```

      Result:

      ```text
      Using version ^0.0.1 for my_package

      Updating dependencies
      Resolving dependencies... (0.1s)

      Package operations: 1 install, 0 updates, 0 removals

        - Installing my_package (0.0.1)

      Writing lock file
      ```

- uv {#uv}

  1. Set authentication variables:

     ```bash
     export IAM_TOKEN="<IAM_token>"
     export LOCAL_REG_ID="<registry_ID>"   
     export REMOTE_REG_ID="<remote_registry_ID>"  
     export VIRTUAL_REG_ID="<virtual_registry_ID>"
     ``` 

  1. Download a package:

      ```bash
      uv pip install <package_name> \
        --index-url https://iam:$IAM_TOKEN@{{ cloud-registry }}/pypi/$LOCAL_REG_ID/simple/ 
      ```

      Result:

      ```text
      Resolved 1 package in 0.5s
      Downloaded 1 package in 0.2s
      Installed 1 package in 0.1s
       + my_package==0.0.1
      ```

{% endlist %}

## Installation from different registry types {#registry-types}

### Local registry {#local-registry}

A [local registry](../../concepts/registry.md#local-registry) contains packages created and published within your organization.

1. {% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}

1. Install a package from a local registry:

    {% list tabs group=registry_auth %}

    - IAM token {#iam-token}

      ```bash
      pip install <package_name> \
        --index-url https://$REGISTRY_USERNAME:$REGISTRY_PASSWORD@{{ cloud-registry }}/pypi/<registry_ID>/simple/ \
        --no-cache
      ```

      Where:

      * `<registry_ID>`: Your local registry ID.
      * `<package_name>`: Name of the package being installed.

    - API key {#api-key}

      ```bash
      pip install <package_name> \
        --index-url https://$REGISTRY_USERNAME:$REGISTRY_PASSWORD@{{ cloud-registry }}/pypi/<registry_ID>/simple/ \
        --no-cache
      ```

      Where:

      * `<registry_ID>`: Your local registry ID.
      * `<package_name>`: Name of the package being installed.

    {% endlist %}

Example:

```bash
pip install <package_name> \
  --index-url https://iam:$(yc iam create-token)@{{ cloud-registry }}/pypi/e5o6a2blpkb6********/simple/
```

### Remote registry {#remote-registry}

A [remote registry](../../concepts/registry.md#remote-registry) acts as a proxy for public repositories such as [PyPI](https://pypi.org/). Remote registries cache packages locally after the first request.

1. {% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}

1. Install a package from a remote registry:

    {% list tabs group=registry_auth %}

    - IAM token {#iam-token}

      ```bash
      pip install <package_name> \
        --index-url https://$REGISTRY_USERNAME:$REGISTRY_PASSWORD@{{ cloud-registry }}/pypi/<registry_ID>/simple/ \
        --no-cache
      ```

      Where:

      * `<registry_ID>`: Your remote registry's ID.
      * `<package_name>`: Name of the package being installed from the public PyPI.

    - API key {#api-key}

      ```bash
      pip install <package_name> \
        --index-url https://$REGISTRY_USERNAME:$REGISTRY_PASSWORD@{{ cloud-registry }}/pypi/<registry_ID>/simple/ \
        --no-cache
      ```

      Where:

      * `<registry_ID>`: Your remote registry's ID.
      * `<package_name>`: Name of the package being installed from the public PyPI.

    {% endlist %}

Example:

```bash
pip install pytest==9.0.1 \
  --index-url https://iam:$(yc iam create-token)@{{ cloud-registry }}/pypi/e5o6a2blpkb6********/simple/
```

Upon the first request, the package will be uploaded from the public PyPI and stored in the cache. During subsequent installations, the package will be loaded from the cache.

### Virtual registry {#virtual-registry}

A [virtual registry](../../concepts/registry.md#virtual-registry) combines several local and remote registries under a single name, providing a single entry point for searching and installing packages.

1. {% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}

1. Install a package from a virtual registry:

    {% list tabs group=registry_auth %}

    - IAM token {#iam-token}

      ```bash
      pip install <package_name> \
        --index-url https://$REGISTRY_USERNAME:$REGISTRY_PASSWORD@{{ cloud-registry }}/pypi/<registry_ID>/simple/ \
        --no-cache
      ```

      Where:

      * `<registry_ID>`: Your virtual registry's ID.
      * `<package_name>`: Name of the package being installed.

    - API key {#api-key}

      ```bash
      pip install <package_name> \
        --index-url https://$REGISTRY_USERNAME:$REGISTRY_PASSWORD@{{ cloud-registry }}/pypi/<registry_ID>/simple/ \
        --no-cache
      ```

      Where:

      * `<registry_ID>`: Your virtual registry's ID.
      * `<package_name>`: Name of the package being installed.

    {% endlist %}

Example:

```bash
pip install <package_name> \
  --index-url https://iam:$(yc iam create-token)@{{ cloud-registry }}/pypi/e5o6a2blpkb6********/simple/
```

The virtual registry automatically searches for the package in all connected local and remote registries according to their priority order.

## Installing packages with dependencies from different sources {#mixed-sources}

If you need to install a package from your own registry while its dependencies come from the public PyPI, use the `--extra-index-url` parameter:

```bash
pip install <package_name> \
  --index-url https://iam:$(yc iam create-token)@{{ cloud-registry }}/pypi/<registry_ID>/simple/ \
  --extra-index-url https://pypi.org/simple/ 
```

Where:
* `--index-url`: Primary package source (your registry).
* `--extra-index-url`: Additional source for dependencies (public PyPI).

#### See also {#see-also}

* [{#T}](installation.md)
* [{#T}](push.md)
* [{#T}](examples.md)
