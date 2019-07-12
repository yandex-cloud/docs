# Yandex Identity and Access Management

{% include notitle [iam-def](../../_includes/iam-def.md) %}

With IAM, you can:

* [Grant access to resources](#access).
* [Manage accounts in Yandex.Cloud](#accounts).
* [Log in to Yandex.Cloud](#auth).

## Access {#access}

To grant a user access to a resource, you assign them [roles](access-control/roles.md) for the resource. Each role consists of a set of permissions that describe operations that can be performed with the resource.

Before performing an operation with a certain resource (for example, creating a VM), Yandex.Cloud sends a request to the IAM service to check whether this operation is allowed. IAM compares the list of required permissions to the list of permissions granted to the user who is performing this operation. If some of the permissions are missing, the operation is not allowed and Yandex.Cloud returns an error. For more information, see the section [#T](access-control/index.md).

## Accounts {#accounts}

Users who are performing operations with resources are identified via [Yandex.Passport accounts](#passport) and [service accounts](#sa).

{% note info %}

Billing accounts are not used for resource management in Yandex.Cloud and do not pertain to the IAM service. For more information, see the section [#T](../../billing/concepts/billing-account.md) in the billing documentation.

{% endnote %}

### Yandex.Passport account {#passport}

_A Yandex.Passport account_ is your Yandex or [Yandex.Connect](https://connect.yandex.com) account. You need a Yandex.Passport account for managing resources via the [management console](https://console.cloud.yandex.com/).

### Service account {#sa}

{% include [sa-def](../_includes_service/sa-def.md) %}

By using service accounts you can flexibly configure access rights to resources for programs you have written. For more information, see [#T](users/service-accounts.md).

## Authorization {#auth}

The user has to go through authorization so that IAM can check the user's rights. Authorization is performed in different ways, depending on the type of account and the interface used. For more information, see the section [#T](authorization/index.md).

