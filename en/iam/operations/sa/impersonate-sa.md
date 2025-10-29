---
title: How to use impersonation in {{ iam-full-name }}
description: Follow this guide to perform operations on {{ yandex-cloud }} resources under a service account using impersonation.
---

# Using impersonation

[Impersonation](../../concepts/access-control/impersonation.md) enables a user to perform actions under a [service account](../../concepts/users/service-accounts.md) using the `--impersonate-service-account-id` parameter in the [{{ yandex-cloud }} CLI](../../../cli/index.yaml) command.

{% note info %}

To use impersonation:
* The service account must have [permissions](../../roles-reference.md) required to perform the actions with {{ yandex-cloud }} resources.
* The user must have the `iam.serviceAccounts.tokenCreator` [role](../../security/index.md#iam-serviceAccounts-tokenCreator) for the service account or the folder containing it.

{% endnote %}

To perform an operation under a service account:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. [Find out](./get-id.md) the ID of the service account you want to assign the role to. To find out the ID, get a list of available service accounts (in the administrator's profile):

      ```bash
      yc iam service-account list
      ```

      Result:

      ```
      +----------------------+----------+--------+---------------------+-----------------------+
      |          ID          |   NAME   | LABELS |     CREATED AT      | LAST AUTHENTICATED AT |
      +----------------------+----------+--------+---------------------+-----------------------+
      | ajebqtreob2d******** | test-sa  |        | 2024-09-08 18:59:45 | 2025-09-04 07:10:00   |
      | aje6o61dvog2******** | my-robot |        | 2023-06-27 16:18:18 | 2025-10-10 18:00:00   |
      +----------------------+----------+--------+---------------------+-----------------------+
      ```

  1. Assign the `test-sa` service account the `viewer` role for `my-folder`. Put `serviceAccount` for subject type, and the service account's ID for value (in the administrator's profile):

      ```
      yc resource-manager folder add-access-binding my-folder \
        --role viewer \
        --subject serviceAccount:<service_account_ID>
      ```

  1. [Get](../users/get.md) the user's ID and assign the `iam.serviceAccounts.tokenCreator` role for the `test-sa` service account (in the administrator's profile):

      ```
      yc iam service-account add-access-binding test-sa \
        --role iam.serviceAccounts.tokenCreator \
        --subject userAccount:<user_ID>
      ```

  1. The user can run a command under the `test-sa` service account using the `--impersonate-service-account-id` parameter.

      For example, the user can get a list of VMs in `my-folder`:

      ```
      yc compute instance list \
        --folder-name my-folder \
        --impersonate-service-account-id <service_account_ID>
      ```

      The user can also get an [IAM token](../../concepts/authorization/iam-token.md) of the `test-sa` service account for short-term access:

      ```
      yc iam create-token \
        --impersonate-service-account-id <service_account_ID>
      ```

      The token will [expire](../../concepts/authorization/iam-token.md#lifetime) automatically.

  1. If the user no longer needs this permission, revoke the role from the service account (in the administrator's profile):

      ```
      yc resource-manager folder remove-access-binding my-folder \
        --role viewer \
        --subject serviceAccount:<service_account_ID>
      ```
  1. Revoke the `iam.serviceAccounts.tokenCreator` role from the user you granted service account permissions to:

      ```
      yc iam service-account remove-access-binding test-sa \
        --role iam.serviceAccounts.tokenCreator \
        --subject userAccount:<user_ID>
      ```

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/access-control/impersonation.md)