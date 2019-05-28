# Service accounts

[!INCLUDE [sa-def](../../_includes_service/sa-def.md)]

## What are service accounts used for?

By using service accounts you can flexibly configure access rights to resources for programs you have written.

> For example, you have a program for tracking VM statuses. This program only needs to have view rights (the [viewer](../access-control/roles.md#viewer) role), but the program runs under your name and you have rights to delete VMs.
>
> To prevent your program from accidentally deleting a VM, create a service account and grant it view-only access.

A service account is a resource. You can assign and revoke users' roles for a service account so that these users can manually create authorization keys.

Service accounts should be used when performing operations as a normal user is either inconvenient or unsafe.

## Service account keys

The following keys are used for service account authentication in Yandex.Cloud:

* [Authorized keys](../authorization/key.md) — keys used to [get an IAM token](../../operations/iam-token/create-for-sa.md).
* [API keys](../authorization/api-key.md) — keys used in some services for simplified authentication instead of IAM tokens.
* [Static access keys](../authorization/access-key.md) — keys used in services with AWS-compatible APIs.

Generated keys belong to the service account and permissions to manage them are inherited from the service account. For example, if you have the `viewer` role in the service account, you can view the list of keys that belong to this account, but you cannot delete them or create new keys.

#### See also

- [Authorization on behalf of a service account](../authorization/index.md#sa)

