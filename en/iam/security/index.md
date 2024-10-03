---
title: Access management in {{ iam-full-name }} ({{ iam-short-name }})
description: Accesses in {{ iam-full-name }} ({{ iam-short-name }}), a service for identity and access management. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action.
---

# Access management in {{ iam-name }}

In this section, you will learn:
* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#choosing-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have the `iam.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Which roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/iam/security/service-roles-hierarchy.svg)

### Service roles {#service-roles}

#### iam.serviceAccounts.user {#iam-serviceAccounts-user}

{% include [iam.serviceAccounts.user](../../_roles/iam/serviceAccounts/user.md) %}

#### iam.serviceAccounts.admin {#iam-serviceAccounts-admin}

{% include [iam.serviceAccounts.admin](../../_roles/iam/serviceAccounts/admin.md) %}

For some services, you need a service account to perform operations, such as in [{{ ig-name }}](../../compute/concepts/instance-groups/index.md) or [{{ managed-k8s-name }}]({{ link-cloud-services }}/managed-kubernetes). If you specified a service account in the request, {{ iam-short-name }} will check whether you have permissions to use this account.

#### iam.serviceAccounts.accessKeyAdmin {#iam-serviceAccounts-accessKeyAdmin}

{% include [iam.serviceAccounts.accessKeyAdmin](../../_roles/iam/serviceAccounts/accessKeyAdmin.md) %}

#### iam.serviceAccounts.apiKeyAdmin {#iam-serviceAccounts-apiKeyAdmin}

{% include [iam.serviceAccounts.apiKeyAdmin](../../_roles/iam/serviceAccounts/apiKeyAdmin.md) %}

#### iam.serviceAccounts.authorizedKeyAdmin {#iam-serviceAccounts-authorizedKeyAdmin}

{% include [iam.serviceAccounts.authorizedKeyAdmin](../../_roles/iam/serviceAccounts/authorizedKeyAdmin.md) %}

#### iam.serviceAccounts.keyAdmin {#iam-serviceAccounts-keyAdmin}

{% include [iam.serviceAccounts.keyAdmin](../../_roles/iam/serviceAccounts/keyAdmin.md) %}

#### iam.serviceAccounts.tokenCreator {#iam-serviceAccounts-tokenCreator}

{% include [iam.serviceAccounts.tokenCreator](../../_roles/iam/serviceAccounts/tokenCreator.md) %}

#### iam.auditor {#iam-auditor}

{% include [iam.auditor](../../_roles/iam/auditor.md) %}

#### iam.viewer {#iam-viewer}

{% include [iam.viewer](../../_roles/iam/viewer.md) %}

#### iam.editor {#iam-editor}

{% include [iam.editor](../../_roles/iam/editor.md) %}

#### iam.admin {#iam-admin}

{% include [iam.admin](../../_roles/iam/admin.md) %}


### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles required to perform a particular action. You can always assign a role offering more permissions than the one specified. For example, you can assign the `editor` role instead of `viewer`.

| Action | Methods | Required roles |
----- | ----- | -----
| **View data** | |
| [Get an IAM token](../operations/iam-token/create.md) | `create` | no roles needed, only authentication |
| [View user data](../operations/users/get.md) | `get`, `getByLogin` | no roles needed, only authentication |
| [View service account data](../operations/sa/get-id.md) | `get`, `list`, `listOperations` | `iam.serviceAccounts.user` or `viewer` for the service account |
| View information about a folder or cloud | `get`, `list` | `iam.auditor` for the folder or cloud |
| View information about any resource | `get`, `list` | `viewer` for this resource |
| **Manage resources** | |
| [Create](../operations/sa/create.md) service accounts in the folder | `create` | `iam.serviceAccounts.admin` for the folder |
| [Update](../operations/sa/update.md) and [delete](../operations/sa/delete.md) service accounts | `update`, `delete` | `editor` for the service account |
| Create and delete keys for a service account | `create`, `delete` | `iam.serviceAccounts.accessKeyAdmin`, `iam.serviceAccounts.apiKeyAdmin`, `iam.serviceAccounts.authorizedKeyAdmin`, and `iam.serviceAccounts.keyAdmin`<br/> for the service account |
| **Manage resource access** | |
| [Add a new user to the cloud](../operations/users/create.md) | `setAccessBindings` | `admin` for the cloud |
| [Make a new user the owner of the cloud](../operations/roles/grant.md) | `setAccessBindings`, `updateAccessBindings` | `resource-manager.clouds.owner` for the cloud |
| [Grant a role](../operations/roles/grant.md), [revoke a role](../operations/roles/revoke.md), and view roles granted for the resource | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` for the resource |
| Getting an IAM token for a service account | `create` | `iam.serviceAccounts.tokenCreator` for the service account |

#### What's next {#what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
