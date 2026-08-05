---
title: Debian artifact in {{ cloud-registry-full-name }}
description: A Debian artifact is a package which contains compiled software, metadata, dependencies, and other resources. Debian packages are used to distribute software on Debian and Ubuntu-based systems.
---

# Debian artifact

A _Debian artifact_ is a `*.deb` package file containing compiled software, metadata, dependencies, and other resources for [Debian](https://{{ lang }}.wikipedia.org/wiki/Debian) and [Ubuntu](https://{{ lang }}.wikipedia.org/wiki/Ubuntu)-based systems.

## Package format {#package-format}

[DEB](https://en.wikipedia.org/wiki/Deb_(file_format)) is a package format used in Debian-based systems. A DEB package is an archive containing:

* Compiled executables and libraries.
* Package metadata (name, version, description, dependencies).
* Installation and deletion scripts.
* Configuration files.

Debian artifacts are used to distribute software you can install and manage using the [APT](https://en.wikipedia.org/wiki/APT_(software)) (Advanced Package Tool) and [dpkg](https://{{ lang }}.wikipedia.org/wiki/Dpkg) package managers.

## Metadata signing {#metadata-signing}

{{ cloud-registry-name }} supports signing Debian registry metadata with a GPG key. The signature allows clients to verify the authenticity of packages before the installation.

When creating a registry with a metadata signature:

* The secret part of the GPG key is stored in [{{ lockbox-full-name }}](../../../lockbox/).
* {{ cloud-registry-name }} automatically signs registry metadata on every update.
* Clients use the public part of the GPG key to verify the signature.

For more information on signature settings, see [{#T}](../../operations/debian/installation.md#prepare-gpg-key).

#### Useful links {#see-also}

* [Supported artifact types](./index.md#artifacts)
* [{#T}](../../operations/debian/installation.md)
* [{#T}](../../operations/debian/push.md)
* [{#T}](../../operations/debian/pull.md)
