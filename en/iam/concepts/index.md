---
title: Overview of {{ iam-full-name }}
description: 'The {{ iam-full-name }} (IAM) service controls access to resources and provides functionality for configuring access rights. You determine who has what rights to the resource, and {{ iam-short-name }} grants access according to the assigned rights.'
---

# Overview of {{ iam-full-name }}

{% include notitle [iam-def](../../_includes/iam-def.md) %}

With {{ iam-short-name }}, you can:

* [Grant access to resources](#access).
* [Manage accounts in {{ yandex-cloud }}](#accounts).
* [Manage authorization keys](#keys).
* [Log in to {{ yandex-cloud }}](#auth).

## Resource access {#access}

To grant a user access to a resource, you assign them [roles](access-control/roles.md) for the resource. Each role consists of a set of permissions that describe operations that can be performed with the resource.

Before performing an operation with a certain resource (such as creating a VM), {{ yandex-cloud }} sends a request to the IAM service to check whether this operation is allowed. {{ iam-short-name }} compares the list of required permissions to the list of permissions granted to the user performing this operation. If some of the permissions are missing, the operation is not allowed and {{ yandex-cloud }} returns an error. For more information, see [{#T}](access-control/index.md).

## Accounts in {{ yandex-cloud }} {#accounts}

To identify users performing operations with resources, use [{% if product == "yandex-cloud" %}Yandex{% endif %}{% if product == "cloud-il" %}Google{% endif %} accounts](#passport), [service accounts](#sa), or [federated accounts](#saml-federation).

{% if product == "yandex-cloud" %}

{% note info %}

Billing accounts aren't used for managing resources in {{ yandex-cloud }} and aren't part of {{ iam-short-name }}. For more information, see [{#T}](../../billing/concepts/billing-account.md) in the billing documentation.

{% endnote %}

{% endif %}

### {% if product == "yandex-cloud" %}Yandex{% endif %}{% if product == "cloud-il" %}Google{% endif %} account {#passport}

{% if product == "yandex-cloud" %}

_Yandex accounts_ are your accounts in Yandex.Passport or [Yandex 360](https://360.yandex.com/?ncrnd=673).

{% endif %}

{% if product == "cloud-il" %}

_Google accounts_ are your accounts in [Google Accounts](https://accounts.google.com).

{% endif %}

{% note info %}

{% include [yandex-account-2fa-warning.md](../../_includes/iam/yandex-account-2fa-warning.md) %}

{% endnote %}

### Service accounts {#sa}

{% include [sa-def](../_includes_service/sa-def.md) %}

By using service accounts you can flexibly configure access rights to resources for programs you wrote. For more information, see [{#T}](users/service-accounts.md).

### Federated account {#saml-federation}

_A federated account_ is a user account from an identity federation, like Active Directory.

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

