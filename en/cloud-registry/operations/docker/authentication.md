---
title: Authentication in {{ cloud-registry-full-name }}
description: Follow this guide to authenticate for the required interface.
---

# Authentication in {{ cloud-registry-name }}

Before you start using {{ cloud-registry-name }}, you need to [configure Docker](installation.md) and get authenticated to use the appropriate interface:
* In the **management console**, the minimum required [role](../../../iam/concepts/access-control/roles.md) for a [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) is `viewer`.
* In the **Docker CLI** or **{{ managed-k8s-full-name }}**, the minimum required role for a [registry](../../concepts/registry.md) is `cloud-registry.artifacts.puller`.

Assign the required role to the {{ yandex-cloud }} user. Read about [authentication methods](#method) and choose the appropriate one.

For more information about roles, see [{#T}](../../security/index.md).

## Authentication methods {#method}

You can authenticate:

* [As a user](#user):
  * Using an OAuth token (with a 12-month lifetime).
  * Using an IAM token (with a {{ iam-token-lifetime }} lifetime or less).


## Authenticating as a user {#user}

{% list tabs group=registry_auth %}

- Using an OAuth token {#oauth-token}

  {% note info %}

  {% include [oauth-token-lifetime](../../../_includes/oauth-token-lifetime.md) %}

  {% endnote %}

  1. If you do not have Docker yet, [install it](installation.md).
  1. If you do not have an OAuth token yet, get one by following [this link]({{ link-cloud-oauth }}).
  1. Run the following command:

     ```bash
     echo <OAuth_token>|docker login \
       --username oauth \
       --password-stdin \
      {{ cloud-registry }}
     ```

      Where:
      * `<OAuth_token>`: Body of the previously obtained OAuth token.
      * `--username`: Token type. `oauth` means that an OAuth token is used for authentication.
      * `{{ cloud-registry }}`: The endpoint that Docker will access when working with the image registry. If it not specified, the request will be sent to [Docker Hub](https://hub.docker.com) as the default service.

- Using an IAM token {#iam-token}

  {% note info %}

  {% include [iam-token-note](../../../_includes/iam/iam-token-note.md) %}

  {% endnote %}

  1. If you do not have Docker yet, [install it](installation.md).
  1. Get an [IAM token](../../../iam/operations/iam-token/create.md).
  1. Run the following command:

      ```bash
      echo <IAM_token>|docker login \
        --username iam \
        --password-stdin \
        {{ cloud-registry }}
      ```

      Where:
      * `<OAuth>`: Body of the previously obtained IAM token.
      * `--username`: Token type. `iam` means that an IAM token is used for authentication.
      * `{{ cloud-registry }}`: The endpoint that Docker will access when working with the image registry. If it not specified, the request will be sent to [Docker Hub](https://hub.docker.com) as the default service.

{% endlist %}

When running the command, you may get this error message: `docker login is not supported with yc credential helper`. In such a case, disable the Docker credential helper.

