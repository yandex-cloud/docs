---
title: System groups
description: In this tutorial, you will learn about system groups and their types.
---

# System groups

A _system group_ is a group of users (subjects) to which you can assign [roles](./roles.md). In {{ yandex-cloud }}, there are three types of system groups: `All users in organization X`, `All users in federation N`, and `All users in userpool P`. These groups allow you to grant access to your resources for a specific user group, but only for the operations that are allowed by the assigned role. System groups do not include [service accounts](../users/service-accounts.md).

System groups are dynamic: any new user added to an organization, federation, or pool automatically inherits all the permissions assigned to that organization, federation, or pool. When a user is removed from an organization, federation, or pool, such permissions are automatically revoked.

It is unsafe to assign roles with extensive permissions, such as `editor` or `admin`, to system groups.

### All users in organization X {#allOrganizationUsers}

`All users in organization X` includes all [organization](../../../organization/quickstart.md) `X` users.

### All users in federation N {#allFederationUsers}

`All users in federation N` includes all [identity federation](../../../organization/concepts/add-federation.md) `N` users.

### All users in userpool P {#allUserpoolUsers}

`All users in userpool P` includes all [local users](../../../iam/concepts/users/accounts.md#local) of the `P` [user pool](../../../organization/concepts/user-pools.md) the group belongs to.

## Use cases {#examples}

* [{#T}](../../../tutorials/security/integration-adfs.md)
* [{#T}](../../../tutorials/security/integration-azure.md)
