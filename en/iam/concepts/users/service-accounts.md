---
title: Service accounts
description: A service account is an account that can be used by a program to manage resources in {{ yandex-cloud }}.
---

# Service accounts

{% include [sa-def](../../_includes_service/sa-def.md) %}

## What are service accounts used for {#sa-usage}

By using service accounts you can flexibly configure access rights to resources for programs you wrote.

> For example, let's assume you have an app for tracking VM statuses. This app only needs to have the view permissions (the [viewer](../../roles-reference.md#viewer) role); however, it runs under your name and you have the right to delete VMs.
>
> To prevent your app from accidentally deleting a VM, create a service account and grant it view-only access.

{% include [sa-uniq-name](../../../_includes/iam/sa-uniq-name.md) %}

## How service accounts differ from other accounts {#sa-difference}

* Currently, you cannot use service accounts to log in to the [management console]({{ link-console-main }}). We assume that programs, rather than users, perform operations on behalf of service accounts.
* The service account is a resource. You can [assign](../../operations/sa/set-access-bindings.md) and [revoke](../../operations/roles/revoke.md) users' roles for a service account. For example, you can allow other people to use this service account to access {{ yandex-cloud }}. To assign a role for a service account, you need the `iam.serviceAccounts.admin` role.
* You can create [keys](#sa-key) for the service account to [authenticate in {{ yandex-cloud }}](../authorization/index.md#sa) via the API, CLI, or other tools. Those keys are deleted when you delete the service account.
* You can link your service account to [virtual machines](../../../compute/operations/vm-connect/auth-inside-vm.md) and [functions](../../../functions/operations/function-sa.md) that you run your program from.

   This makes it easier to scale applications running on {{ yandex-cloud }}:
   * You do not need to edit the program code to make it run on a new VM or function. The IAM authentication token is already available from inside.
   * To enable or disable operations in {{ yandex-cloud }} for all running program instances, you can assign or revoke roles for a single service account.

## Service account keys {#sa-key}

The following keys are used for service account authentication in {{ yandex-cloud }}:

* [Authorized keys](../authorization/key.md): Keys used to [get an IAM token](../../operations/iam-token/create-for-sa.md).
* [API keys](../authorization/api-key.md): Keys used in some services for simplified authentication instead of IAM tokens.
* [Static access keys](../authorization/access-key.md): Keys used in services with AWS-compatible APIs.

Generated keys belong to the service account and permissions to manage them are inherited from the service account. For example, if you have the `viewer` role in the service account, you can view the list of keys that belong to this account, but you cannot delete them or create new keys.

{% include [key-has-last-used-data](../../../_includes/iam/key-has-last-used-data.md) %}

#### See also {#see-also}

- [{#T}](../../quickstart-sa.md)
- [Authorization as a service account](../authorization/index.md#sa)
