---
title: Pushing a Debian package to a {{ cloud-registry-full-name }}
description: Follow this guide to push a Debian package to a registry in {{ cloud-registry-full-name }}.
---

# Pushing a Debian package to a registry

This guide describes how to push a [Debian package](../../concepts/artifacts/debian.md) to a [local registry](../../concepts/registry.md#local-registry).

To push a Debian package to a registry, you need the `cloud-registry.artifacts.pusher` [role](../../security/index.md#cloud-registry-artifacts-pusher) or higher.

{% list tabs group=debian_tools %}

- cURL {#curl} 

    1. {% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}

    1. Run this HTTP request to push your package:

        ```bash
        curl \
          --url-query "dist=<distribution>" \
          --url-query "comp=<component>" \
          --user "${REGISTRY_USERNAME}:${REGISTRY_PASSWORD}" \
          --upload-file "<package>.deb" \
          "https://{{ cloud-registry }}/debian/<registry_ID>"
        ```

- dput {#dput}

  [dput](https://packages.debian.org/stable/dput) (Debian package upload tool) is a utility for pushing packages to Debian repositories.

  1. {% include [auth-env](../../../_includes/cloud-registry/auth-env.md) %}

  1. Add the following registry configuration to the `/etc/dput.cf` file:

      ```ini
      [ycr]
      fqdn = {{ cloud-registry }}
      incoming = /debian/<registry_ID>/upload/
      login = <login>
      method = https
      allow_unsigned_uploads = 1
      ```

      Where:
      * `<registry_ID>`: Your registry ID.
      * `login`: Authentication method, `iam` or `api_key`.

  1. Upload the package:

      ```bash
      dput ycr <package>.changes
      ```

      Where `<package>.changes` is the package change file generated during the compilation.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](installation.md)
* [{#T}](pull.md)
