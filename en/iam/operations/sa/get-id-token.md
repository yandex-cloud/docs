---
title: How to create a service account ID token
description: Follow this guide to create an ID token for authenticating a service account in an external system with OIDC authentication support.
---

# Getting a service account ID token

To use {{ iam-full-name }} for authentication in an external system with [OIDC](https://openid.net/specs/openid-connect-core-1_0.html) authentication support, you need to get an [ID token](../../concepts/authorization/id-token.md). You can only get an ID token for a [service account](../../concepts/users/service-accounts.md).

To get an ID token:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the command for creating an ID token:

      ```bash
      yc iam create-id-token --help
      ```
  1. Get the ID of the service account to use for authentication in the external system:

      ```bash
      yc iam service-account list
      ```

      Result:

      ```
      +----------------------+--------------+--------+---------------------+-----------------------+
      |          ID          |     NAME     | LABELS |     CREATED AT      | LAST AUTHENTICATED AT |
      +----------------------+--------------+--------+---------------------+-----------------------+
      | ajeg2b2et02f******** | my-robot     |        | 2024-09-08 18:59:45 | 2025-02-18 10:10:00   |
      | ajegtlf2q28a******** | account-name |        | 2023-06-27 16:18:18 | 2025-02-18 10:20:00   |
      +----------------------+--------------+--------+---------------------+-----------------------+
      ```
  1. Get an ID token for the service account:

      ```
      yc iam create-id-token \
        --subject-id <service_account_ID> \
        --audience <resource>
      ```

      Where:

      * `--subject-id`: [ID](./get-id.md) of the service account to create an ID token for.
      * `--audience`: Target resource for the token. This is an optional parameter. If left unspecified, this value defaults to the service account ID specified in the `subject-id` parameter.

      In response, the command will output the [body](../../concepts/authorization/id-token.md#token-format) of the created service account ID token to the standard output stream (`STDOUT`).

{% endlist %}