---
title: Examples of working with PyPI registries
description: Step-by-step examples of creating, configuring, and using PyPI registries in {{ cloud-registry-name }}.
---

# Examples of working with PyPI registries

This section provides step-by-step examples for different types of PyPI registries.

## Creating and using registries {#registry-examples}

### Local registry {#local}

1. Create a registry:

    ```bash
    yc cloud-registry registry create \
      --name my-pypi-local \
      --registry-kind pypi \
      --registry-type local \
      --description "Local PyPI registry"
    ```

    Result:

    ```text
    id: e5o6a2blpkb6********
    name: my-pypi-local
    kind: PYPI
    type: LOCAL
    ```

1. Create a package:

    ```bash
    mkdir -p my_package/my_package
    cd my_package
    ```

    Create a file named `my_package/__init__.py`:

    ```python
    def hello():
        return "Hello from my package!"
    ```

    Create a `pyproject.toml`:

    ```toml
    [build-system]
    requires = ["setuptools"]

    [project]
    name = "my_package"
    version = "0.0.1"
    authors = [{ name="Example Author", email="author@example.com" }]
    description = "A small example package"
    readme = "README.md"
    requires-python = ">=3.9"
    classifiers = [
        "Programming Language :: Python :: 3",
        "Operating System :: OS Independent",
    ]
    ```

    Create a `README.md`:

    ```markdown
    # My Package
    This is an example of a Python package.
    ```

1. [Set up](installation.md) authentication:

    Create a `~/.pypirc`:

    ```text
    [distutils]
    index-servers = cloud-registry

    [cloud-registry]
    repository = https://registry.yandexcloud.net/pypi/e5o6a2b********/legacy/
    username = iam
    password = <IAM_token>
    ```

1. Build and publish the package:

    ```bash
    python3 -m venv my-venv && source my-venv/bin/activate
    python3 -m pip install build twine
    python3 -m build
    python3 -m twine upload --repository cloud-registry dist/*
    ```

1. Install a package:

    ```bash
    pip install my_package \
      --index-url https://iam:$(yc iam create-token)@registry.yandexcloud.net/pypi/e5o6a2blpkb6********/simple/ \
      --no-cache
    ```

    Check:

    ```python
    python3 -c "from my_package import hello; print(hello())"
    # Hello from my package!
    ```

### Remote registry {#remote}

1. Create a registry:

    ```bash
    yc cloud-registry registry create \
      --name my-pypi-remote \
      --registry-kind pypi \
      --registry-type remote \
      --description "Remote PyPI proxy" \
      --properties source=@pypi
    ```

    Result:

    ```text
    id: e5o7b3cmqlc7********
    name: my-pypi-remote
    kind: PYPI
    type: REMOTE
    ```

1. Install the package (first time):

    When first installed, the package is uploaded from the public PyPI and stored in the cache:

    ```bash
    pip install pytest==9.0.1 \
      --index-url https://iam:$(yc iam create-token)@registry.yandexcloud.net/pypi/e5o7b3cmqlc7********/simple/ \
      --no-cache
    ```

1. Install the package (once more):

    When reinstalling, the package is uploaded from the cache:

    ```bash
    pip install pytest==9.0.1 \
      --index-url https://iam:$(yc iam create-token)@registry.yandexcloud.net/pypi/e5o7b3cmqlc7********/simple/ \
      --no-cache
    ```

1. Install another package:

    ```bash
    pip install requests==2.31.0 \
      --index-url https://iam:$(yc iam create-token)@registry.yandexcloud.net/pypi/e5o7b3cmqlc7********/simple/ \
      --no-cache
    ```

{% note info %}

All installed packages are cached in the registry. On next installation they will be uploaded from the cache.

{% endnote %}

### Virtual registry {#virtual}

1. Create a registry:

    Merge the local (`cn1mfr50********`) and remote (`cn1ihsdl********`) registries:

    ```bash
    yc cloud-registry registry create \
      --name my-pypi-virtual \
      --description "Virtual registry" \
      --registry-kind pypi \
      --registry-type virtual \
      --properties "readOnly=false,deploymentRegistryId=cn1mfr50********,registryIds=cn1mfr50********;cn1ihsdl********"
    ```

    Result:

    ```text
    id: e5o9d5eosne9********
    name: my-pypi-virtual
    kind: PYPI
    type: VIRTUAL
    ```

1. Install the internal package:

    The virtual registry first searches the local registry:

    ```bash
    pip install my_package \
      --index-url https://iam:$(yc iam create-token)@registry.yandexcloud.net/pypi/e5o9d5eosne9********/simple/ \
      --no-cache
    ```

1. Install the public package:

    If the package is not found in the local registry, searches the remote one:

    ```bash
    pip install pytest==9.0.1 \
      --index-url https://iam:$(yc iam create-token)@registry.yandexcloud.net/pypi/e5o9d5eosne9********/simple/ \
      --no-cache
    ```

1. Install multiple packages:

    ```bash
    pip install my_package pytest==9.0.1 requests==2.31.0 \
      --index-url https://iam:$(yc iam create-token)@registry.yandexcloud.net/pypi/e5o9d5eosne9********/simple/ \
      --no-cache
    ```

#### See also {#see-also}

* [{#T}](create.md)
* [{#T}](push.md)
* [{#T}](pull.md)
* [{#T}](../../concepts/lifecycle-policy.md)
* [{#T}](../../tutorials/lifecycle-policy-examples.md)
