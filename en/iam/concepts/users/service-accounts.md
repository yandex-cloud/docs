# Service accounts

{% include [sa-def](../../_includes_service/sa-def.md) %}

## What are service accounts used for {#sa-usage}

By using service accounts you can flexibly configure access rights to resources for programs you wrote.

> For example, you have an app for tracking VM statuses. This program only needs to have the right to view (the [viewer](../access-control/roles.md#viewer) role), but the program runs under your name and you have the right to delete VMs.
>
> To prevent your program from accidentally deleting a VM, create a service account and grant it view-only access.

{% include [sa-uniq-name](../../../_includes/iam/sa-uniq-name.md) %}

## How service accounts differ from other accounts {#sa-difference}

* Currently, you can't use service accounts to log in the [management console]({{ link-console-main }}). We assume that programs, rather than users, perform operations on behalf of service accounts.
* The service account is a resource. You can [assign](../../operations/sa/set-access-bindings.md) and [revoke](../../operations/roles/revoke.md) users roles for a service account. For example, you can allow other people to use this service account to access {{ yandex-cloud }}.
* You can create [keys](#sa-key) for the service account to [authenticate in {{ yandex-cloud }}](../authorization/index.md#sa) via the API, CLI, or other tools. Those keys are deleted when you delete the service account.
* You can link your service account to [virtual machines](../../../compute/operations/vm-connect/auth-inside-vm.md){% if product == "yandex-cloud" %} and [functions](../../../functions/operations/function-sa.md){% endif %} that you run your program from.

   This makes it easier to scale applications running on {{ yandex-cloud }}:
   * You don't need to edit the program code to make it run on a new VM or function. The IAM authentication token is already available from inside.
   * To enable or disable operations in {{ yandex-cloud }} for all running program instances, you can assign or revoke roles for a single service account.

## Service account keys {#sa-key}

The following keys are used for service account authentication in {{ yandex-cloud }}:

* [Authorized keys](../authorization/key.md) — keys used to [get an IAM token](../../operations/iam-token/create-for-sa.md).
* [API keys](../authorization/api-key.md) — keys used in some services for simplified authentication instead of IAM tokens.
* [Static access keys](../authorization/access-key.md) — keys used in services with AWS-compatible APIs.

Generated keys belong to the service account and permissions to manage them are inherited from the service account. For example, if you have the `viewer` role in the service account, you can view the list of keys that belong to this account, but you cannot delete them or create new keys.

#### See also {#see-also}

- [{#T}](../../quickstart-sa.md)
- [Authorization on behalf of a service account](../authorization/index.md#sa)
