---
title: Impersonation in {{ iam-full-name }}
description: In this article, you will learn about impersonation in {{ iam-full-name }} and how to use it when managing {{ yandex-cloud }} resources.
---

# Impersonation

_Impersonation_ is when a user performs actions with [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud) resources under a [service account](../users/service-accounts.md) with appropriate [access permissions](../access-control/roles.md). Impersonation is mostly [used](../../operations/sa/impersonate-sa.md) to temporarily expand user permissions without generating [static credentials](../authorization/index.md) for the user.

For example, impersonation can help you out when the user has no permissions to view a [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder), but needs to for a short while. The administrator may then [assign](../../operations/sa/impersonate-sa.md) the viewer role for the folder to the service account and the special `iam.serviceAccounts.tokenCreator` [role](../../security/index.md#iam-serviceAccounts-tokenCreator) to the user. This will allow the user to view the folder's resources under the service account or get the service account's [IAM token](../authorization/iam-token.md). However, the user will not be able to edit permissions or delete the service account.

The administrator can revoke the `iam.serviceAccounts.tokenCreator` role from the user whenever needed. The user will then lose the ability to view the folder under the service account.

#### See also {#see-also}

* [{#T}](../../operations/sa/impersonate-sa.md)