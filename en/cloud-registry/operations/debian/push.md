---
title: Pushing a Debian package to a {{ cloud-registry-full-name }} registry
description: Follow this guide to push a Debian package to a registry in {{ cloud-registry-full-name }}.
---

# Pushing a Debian package to a registry

This guide describes how to push a [Debian package](../../concepts/artifacts/debian.md) to a [local registry](../../concepts/registry.md#local-registry).

To push a Debian package to the registry, you need the `cloud-registry.artifacts.pusher` [role](../../security/index.md#cloud-registry-artifacts-pusher) or higher.

{% list tabs group=debian_tools %}

- cURL {#curl} 

    1. {% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}

    1. Push the project using an HTTP request:

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

      {% list tabs %}

      - IAM token

          ```ini
          [ycr]
          fqdn = {{ cloud-registry }}
          incoming = /debian/<registry_ID>/upload/
          login = iam
          method = https
          allow_unsigned_uploads = 1
          ```

      - API key

          ```ini
          [ycr]
          fqdn = {{ cloud-registry }}
          incoming = /debian/<registry_ID>/upload/
          login = api_key
          method = https
          allow_unsigned_uploads = 1
          ```

      {% endlist %}

  1. Upload the package:

      ```bash
      dput ycr <package>.changes
      ```

      Where `<package>.changes` is the package changes file generated during the build.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](installation.md)
* [{#T}](pull.md)
