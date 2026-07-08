---
title: Pulling a Go module from a {{ cloud-registry-name }}
description: Follow this guide to pull a Go module from a {{ cloud-registry-name }}.
---

# Pulling a Go module from a {{ cloud-registry-name }}

To pull a [Go module](../../concepts/artifacts/go.md), you need the `cloud-registry.artifacts.puller` [role](../../security/index.md#cloud-registry-artifacts-puller) or higher.

You can pull Go modules using the standard `go` command: your {{ cloud-registry-name }} operates as a Go proxy and implements [Module Proxy Protocol](https://go.dev/ref/mod#goproxy-protocol).

## Environment setup {#setup}

1. Specify the registry as a proxy for Go modules and disable checksum verification via the public [Go checksum database](https://sum.golang.org/) for Go modules within your registry:

    ```bash
    export GOPROXY=https://registry.yandexcloud.net/go/<registry_ID>,https://proxy.golang.org,direct
    export GONOSUMDB=registry.yandexcloud.net/*
    ```

    Where:

    * `GOPROXY`: Comma-separated list of Go proxies. The `go` command searches for a Go module in every source, one by one:
        * `https://registry.yandexcloud.net/go/<registry_ID>`: Your {{ cloud-registry-name }}.
        * `https://proxy.golang.org`: Public Go proxy for modules from public repositories.
        * `direct`: Direct access to a VCS repository, e.g., GitHub, if the Go module was not found in any of the proxies.
    * `GONOSUMDB`: Path templates of Go modules to skip checksum verification for.

1. Provide the registry authentication credentials. The `go` command only supports basic authentication, so we recommend providing the credentials via the `~/.netrc` file.

    {% list tabs group=registry_auth %}

    - IAM token {#iam-token}

        Add the following line to the `~/.netrc` file:

        ```text
        machine registry.yandexcloud.net login iam password <IAM_token>
        ```

    - API key {#api-key}

        Add the following line to the `~/.netrc` file:

        ```text
        machine registry.yandexcloud.net login api_key password <API_key>
        ```

    {% endlist %}

    {% note info %}

    Read access to the `~/.netrc` file must be restricted to its owner. Set the access permissions:

    ```bash
    chmod 600 ~/.netrc
    ```

    {% endnote %}

## Adding a Go module to a project {#add-module}

1. Navigate to the Go project root where the `go.mod` file resides.

1. Add the required version of the Go module:

    ```bash
    go get registry.yandexcloud.net/go/<registry_ID>/<module_name>@<version>
    ```

    For example:

    ```bash
    go get registry.yandexcloud.net/go/e5o6a2blpkb6********/mymodule@v1.0.0
    ```

    This command will pull the Go module to the local cache and add a corresponding record to `go.mod` and `go.sum`:

    ```text
    go: added registry.yandexcloud.net/go/e5o6a2blpkb6********/mymodule v1.0.0
    ```

1. Optionally, if the Go module is already used in your code via the `import` directive, synchronize `go.mod` and `go.sum`:

    ```bash
    go mod tidy
    ```

1. Optionally, pull all project dependencies to the local cache without executing a build:

    ```bash
    go mod download
    ```

#### Useful links {#see-also}

* [{#T}](push.md)
* [{#T}](create.md)
