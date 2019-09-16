# {{ iam-full-name }}

{% include notitle [iam-def](../../_includes/iam-def.md) %}

With {{ iam-short-name }}, you can:

* [Grant access to resources](#access).
* [Manage accounts in Yandex.Cloud](#accounts).
* [Manage authorization keys](#keys).
* [Log in to Yandex.Cloud](#auth).

## Access {#access}

To grant a user access to a resource, you assign them [roles](access-control/roles.md) for the resource. Each role consists of a set of permissions that describe operations that can be performed with the resource.

Before performing an operation with a certain resource (such as creating a VM), Yandex.Cloud sends a request to the IAM service to check whether this operation is allowed. {{ iam-short-name }} compares the list of required permissions to the list of permissions granted to the user performing this operation. If some of the permissions are missing, the operation is not allowed and Yandex.Cloud returns an error. For more information, see [{#T}](access-control/index.md).

## Accounts {#accounts}

Users performing operations with resources are identified via [Yandex.Passport accounts](#passport) and [service accounts](#sa).

{% note info %}

Billing accounts aren't used for managing resources in Yandex.Cloud and aren't part of {{ iam-short-name }}. For more information, see [{#T}](../../billing/concepts/billing-account.md) in the billing documentation.

{% endnote %}

### Yandex.Passport accounts {#passport}

_A Yandex.Passport account_ is your Yandex or [Yandex.Connect]({{ link-yandex-connect }}) account. You need a Yandex.Passport account to manage resources from the [management console]({{ link-console-main }}).

### Service accounts {#sa}

{% include [sa-def](../_includes_service/sa-def.md) %}

By using service accounts you can flexibly configure access rights to resources for programs you have written. For more information, see [{#T}](users/service-accounts.md).

## Authorization keys {#keys}

There are three different kinds of authorization keys in Yandex.Cloud:

* [API keys](authorization/api-key.md): Used instead of IAM tokens for simplified authorization.
* [Authorized keys](authorization/key.md): Used to obtain IAM tokens for service accounts.
* [Static access keys](authorization/access-key.md) — Used in services with AWS-compatible APIs.

These keys are currently only used for service accounts.

## Authorization {#auth}

The user has to pass authorization so that {{ iam-short-name }} can check the user's rights. Authorization is performed in different ways, depending on the type of account and the interface used. For more information, see [{#T}](authorization/index.md).

