---
title: "{{ iam-full-name }} overview"
description: "The {{ iam-name }} (IAM) service controls access to resources and lets you configure access rights. You determine who should have rights to a certain resource and what these rights are, while {{ iam-short-name }} grants access according to the assigned rights."
---

# {{ iam-full-name }} overview

{% include notitle [iam-def](../../_includes/iam-def.md) %}

With {{ iam-short-name }}, you can:

* [Grant access to resources](#access).
* [Manage accounts in {{ yandex-cloud }}](#accounts).
* [Manage authorization keys](#keys).
* [Logging in to {{ yandex-cloud }}](#auth).


## Resource access {#access}

To grant a user access to a resource, you assign them [roles](access-control/roles.md) for the resource. Each role consists of a set of permissions that describe operations that can be performed with the resource.

Before performing an operation with a certain resource (for example, creating a VM), {{ yandex-cloud }} sends a request to the IAM service to check whether this operation is allowed. {{ iam-short-name }} compares the list of required permissions to the list of permissions granted to the user who is performing this operation. If some of the permissions are missing, the operation is not allowed and {{ yandex-cloud }} returns an error. For more information, see [{#T}](access-control/index.md).


## Accounts in {{ yandex-cloud }} {#accounts}

To identify users performing operations with resources, use [Yandex accounts](#passport), [service accounts](#sa), or [federated accounts](#saml-federation).


{% note info %}

Billing accounts aren't used for managing resources in {{ yandex-cloud }} and aren't part of {{ iam-short-name }}. For more information, see [{#T}](../../billing/concepts/billing-account.md) in the documentation.

{% endnote %}


### Yandex account {#passport}

_Yandex account_: Your [Yandex](https://yandex.ru/support/passport/index.html) or [Yandex 360](https://360.yandex.ru/) account.

{% note info %}

{% include [yandex-account-2fa-warning.md](../../_includes/iam/yandex-account-2fa-warning.md) %}

{% endnote %}

### Service accounts {#sa}

{% include [sa-def](../_includes_service/sa-def.md) %}

By using service accounts you can flexibly configure access rights to resources for programs you wrote. For more information, see [{#T}](users/service-accounts.md).

### Federated accounts {#saml-federation}

A _federated account_ is a user account from an identity federation, like Active Directory.

{% include [about-saml-federations](../../_includes/iam/about-saml-federations.md) %}

For more information, see [{#T}](../../organization/add-federation.md).

## Authorization keys {#keys}

There are three different kinds of authorization keys in {{ yandex-cloud }}:

* [API keys](authorization/api-key.md): Used instead of IAM tokens for simplified authorization.
* [Authorized keys](authorization/key.md): Used to obtain IAM tokens for service accounts.
* [Static access keys](authorization/access-key.md): Used in services with AWS-compatible APIs.

These keys are currently only used for service accounts.

## Authorization {#auth}

The user must pass authentication so that {{ iam-short-name }} can authorize them (i.e., check whether the user has rights). Authentication is performed in different ways, depending on the type of account and the interface used. For more information, see [{#T}](authorization/index.md).
