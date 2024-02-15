---
title: "{{ iam-full-name }} overview"
description: "The {{ iam-name }} (IAM) service controls access to resources and enables you to configure access rights. You determine who should have rights to a certain resource and what these rights are, while {{ iam-short-name }} grants access according to the assigned rights."
---

# {{ iam-full-name }} overview

{% include notitle [iam-def](../../_includes/iam-def.md) %}

With {{ iam-short-name }}, you can:

* [Grant access to resources](#access).
* [Manage accounts in {{ yandex-cloud }}](#accounts).
* [Manage authentication keys](#keys).
* [Log in to {{ yandex-cloud }}](#auth).

## Resource access {#access}

To grant a user access to a resource, you assign them [roles](access-control/roles.md) for the resource. Each role consists of a set of permissions that describe operations that can be performed with the resource.

Before performing an operation with a resource, such as creating a VM, {{ yandex-cloud }} sends a request to the IAM service to check whether this operation is allowed. {{ iam-short-name }} compares the list of required permissions to the list of permissions granted to the user who is performing this operation. If any of the permissions are missing, the operation is not allowed and {{ yandex-cloud }} returns an error. For more information, see [{#T}](access-control/index.md).

## Accounts in {{ yandex-cloud }} {#accounts}

To identify users performing operations with resources, {{ yandex-cloud }} allows using various account types. For more information, see [{#T}](users/accounts.md).

## Authentication keys {#keys}

There are three types of keys used for authentication in {{ yandex-cloud }}:

* [API keys](authorization/api-key.md): Used instead of IAM tokens for simplified authorization.
* [Authorized keys](authorization/key.md): Used to obtain IAM tokens for service accounts.
* [Static access keys](authorization/access-key.md): Used in services with AWS-compatible APIs.

These keys are currently only used for service accounts.

## Authorization {#auth}

The user must pass authentication so that {{ iam-short-name }} can authorize them (i.e., check whether the user has rights). Authentication is performed in different ways, depending on the type of account and the interface used. For more information, see [{#T}](authorization/index.md).
