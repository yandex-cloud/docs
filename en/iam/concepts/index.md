---
title: '{{ iam-full-name }} overview'
description: '{{ iam-name }} (IAM) controls access to resources and offers functions for access permission setup. You decide who gets what permissions for a resource, and {{ iam-short-name }} provides access according to the permissions you assign.'
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

Before performing an operation with a resource (e.g., creating a VM), {{ yandex-cloud }} requests IAM to check whether this operation is allowed. {{ iam-short-name }} compares the list of required permissions against the list of permissions held by the user performing the operation. If the user lacks any of the permissions, the operation is not allowed and {{ yandex-cloud }} returns an error. For more information, see [{#T}](access-control/index.md).

## Accounts in {{ yandex-cloud }} {#accounts}

To identify users performing operations with resources, {{ yandex-cloud }} allows using various account types. For more information, see [{#T}](users/accounts.md).

## Authentication keys {#keys}

There are three types of keys used for authentication in {{ yandex-cloud }}:

* [API keys](authorization/api-key.md): Used for simplified authentication instead of IAM tokens.
* [Authorized keys](authorization/key.md): Used to obtain IAM tokens for service accounts.
* [Static access keys](authorization/access-key.md): Used for authentication in services with an AWS-compatible API.

These keys are currently only used for service accounts.

## Authentication {#auth}

For {{ iam-short-name }} to be able to authorize the user (i.e., check if the user has the required permissions), the user must get authenticated. Authentication is performed in different ways, depending on the type of account and the interface used. For more information, see [{#T}](authorization/index.md).
