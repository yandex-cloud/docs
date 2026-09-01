---
title: How to suspend and reactivate a service account
description: Follow this guide to suspend and reactivate a service account.
---

# Suspending and reactivating a service account

To [suspend](#suspend) or [reactivate](#reactivate) a service account, you must have the `editor` role for the service account or at least the `{{ roles-iam-sa-admin }}` [role](../../security/index.md#iam-serviceAccounts-admin) for the parent [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).

## Suspending a service account {#suspend}

Suspend a [service account](../../concepts/users/service-accounts.md) to pause its activity in {{ yandex-cloud }}. All its roles are retained, but become inactive until you restore the account.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the command for suspending a service account:

      ```bash
      yc iam service-account suspend --help
      ```

  1. Get a list of service accounts in the default folder:

      ```bash
      yc iam service-account list
      ```

      Result:

      ```text
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2******** | my-robot         |                               |
      | aje9sda1ufvq******** | account_name     | account_description           |
      +----------------------+------------------+-------------------------------+
      ```

  1. Suspend the service account by specifying its name or ID:

      ```bash
      yc iam service-account suspend <account_name_or_ID>
      ```

      Here is an example:

      ```bash
      yc iam service-account suspend my-robot
      ```

- API {#api}

  To suspend a service account, use the [suspend](../../api-ref/ServiceAccount/suspend.md) REST API method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Suspend](../../api-ref/grpc/ServiceAccount/suspend.md) gRPC API call.

{% endlist %}

## Reactivating a service account {#reactivate}

To restore [service account](../../concepts/users/service-accounts.md) activity in {{ yandex-cloud }}, reactivate it.

If the account was suspended due to expired lifetime (`--expires-at`), [set](update.md#update-expires-at) a new lifetime for the [service account](../../concepts/users/service-accounts.md#sa-suspend) or run the `reactivate` command as described below.

{% note warning %}

The `reactivate` command will reactivate the account, but it does not affect the `expires-at` setting. You account will be suspended again unless you [update](update.md#update-expires-at) its lifetime.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the service account reactivation command:

      ```bash
      yc iam service-account reactivate --help
      ```

  1. Get a list of service accounts in the default folder:

      ```bash
      yc iam service-account list
      ```

      Result:

      ```text
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2******** | my-robot         |                               |
      | aje9sda1ufvq******** | account_name     | account_description           |
      +----------------------+------------------+-------------------------------+
      ```

  1. Reactivate the service account by specifying its name or ID:

      ```bash
      yc iam service-account reactivate <account_name_or_ID>
      ```

      Here is an example:

      ```bash
      yc iam service-account reactivate my-robot
      ```

- API {#api}

  To reactivate a service account, use the [reactivate](../../api-ref/ServiceAccount/reactivate.md) REST API method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Reactivate](../../api-ref/grpc/ServiceAccount/reactivate.md) gRPC API call.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../../concepts/users/service-accounts.md)
* [{#T}](create.md)
* [{#T}](update.md)
* [{#T}](delete.md)
