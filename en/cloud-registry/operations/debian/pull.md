---
title: Pulling a Debian package from a {{ cloud-registry-full-name }}
description: Follow this guide to pull a Debian package from a {{ cloud-registry-name }}.
---

# Pulling a Debian package from a registry

Follow this guide to install a [Debian package](../../concepts/artifacts/debian.md) from a {{ cloud-registry-full-name }} using the [`APT` package manager](https://en.wikipedia.org/wiki/APT_(software)) (Advanced Package Tool).

To pull a Debian package, you need the `cloud-registry.artifacts.puller` [role](../../security/index.md#cloud-registry-artifacts-puller) or higher.

Before you begin, [configure `APT`](installation.md) to work with the registry.

## Installing from a local registry {#local-registry}

A [local registry](../../concepts/registry.md#local-registry) contains packages created and published within your organization.

1. Update the list of packages:

    ```bash
    apt-get update
    ```

1. Install a package:

    ```bash
    apt-get install <package_name>
    ```

    Where `<package_name>` is the name of the package to install.

## Installing from a remote registry {#remote-registry}

A [remote registry](../../concepts/registry.md#remote-registry) acts as a proxy for external Debian repositories. Remote registries cache packages locally after the first request.

Caching is only supported for registries that implement one of the following package storage formats:

* Standard format: `/pool/<component>/<letter>/<package_name>/...deb`. This format is used in repositories such as `archive.ubuntu.com` and `deb.debian.org`.
* {{ cloud-registry-name }} format.

{% note info %}

Remote registries do not support the [Flat Repository Format](https://wiki.debian.org/DebianRepository/Format#Flat_Repository_Format).

{% endnote %}

1. Update the list of packages:

    ```bash
    apt-get update
    ```

1. Install a package:

    ```bash
    apt-get install <package_name>
    ```

    Where `<package_name>` is the name of the package being installed from an external repository.

    Upon the first request, the package will be pulled from the external repository and stored in the cache. During subsequent installations, the package will be loaded from the cache.

#### Useful links {#see-also}

* [{#T}](installation.md)
* [{#T}](push.md)
