---
title: Access management in {{ resmgr-full-name }}
description: Access management in {{ resmgr-full-name }}, a service for organizing {{ yandex-cloud }} resources into folders. This section describes the resources for which you can assign a role, the roles this service has, and the roles required for specific actions.
---

# Access management in {{ resmgr-name }}

In this section, you will learn about:
* [Resources you can assign a role for](#resources).
* [Roles this service has](#roles-list).
* [Roles required](#required-roles) for specific actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

{% include [roles-assign](../../_includes/iam/roles-assign.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Roles this service has {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

{% include [resource-manager](../../_mermaid/roles/resource-manager.md) %}

### Service roles {#service-roles}

#### resource-manager.auditor {#resource-manager-auditor}

{% include [resourcemanager-auditor](../../_roles/resource-manager/auditor.md) %}

#### resource-manager.viewer {#resource-manager-viewer}

{% include [resourcemanager-viewer](../../_roles/resource-manager/viewer.md) %}

#### resource-manager.editor {#resource-manager-editor}

{% include [resourcemanager-editor](../../_roles/resource-manager/editor.md) %}

#### resource-manager.admin {#resource-manager-admin}

{% include [resourcemanager-admin](../../_roles/resource-manager/admin.md) %}

#### resource-manager.clouds.member {#resource-manager-clouds-member}

{% include [resourcemanager-clouds-member](../../_roles/resource-manager/clouds/member.md) %}

#### resource-manager.clouds.owner {#resource-manager-clouds-owner}

{% include [resourcemanager-clouds-owner](../../_roles/resource-manager/clouds/owner.md) %}


### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Required roles {#required-roles}

The table below lists the roles required for specific actions. You can always assign a role with more permissions, e.g., `editor` instead of `viewer`.

Action | Methods | Required roles
----- | ----- | -----
**Viewing data** | |
Viewing resource details | `get`, `list` | `viewer` for this resource
Viewing information about a folder or cloud | `get`, `list` | `resource-manager.viewer` for the folder or cloud
View metadata about a folder or cloud | `get`, `list` | `resource-manager.auditor` for the folder or cloud
**Managing resources** | |
[Creating a cloud](../operations/cloud/create.md) | | To create your first cloud, no roles are required. You only need to authenticate (a user is automatically assigned the `resource-manager.clouds.owner` role in the created organization). Later, you will need the `resource-manager.editor` or `editor` role for the organization.
[Updating a cloud](../operations/cloud/update.md) | `update` | `editor` or `resource-manager.editor` for the cloud
[Deleting a cloud](../operations/cloud/delete.md) | `delete` | `resource-manager.clouds.owner` for the cloud
[Create a folder in the cloud](../operations/folder/create.md) | `create` | `editor` or `resource-manager.editor` for the cloud
[Updating a folder](../operations/folder/update.md) | `update` | `editor` or `resource-manager.editor` for the folder
[Deleting a folder](../operations/folder/delete.md) | `delete` | `editor` or `resource-manager.editor` for the folder
**Managing resource access** | |
Invite a new user to an organization | | `{{ roles-organization-admin }}` |
[Making a new user the owner of the cloud](../operations/cloud/set-access-bindings.md) | `setAccessBindings`, `updateAccessBindings` | `resource-manager.clouds.owner` for this cloud
View roles granted for a resource | `listAccessBindings` | `viewer` for this resource
View roles granted for the folder or cloud | `listAccessBindings` | `resource-manager.viewer` for the folder or cloud
[Assign a role](../../iam/operations/roles/grant.md) and [revoke a role](../../iam/operations/roles/revoke.md) for the folder or cloud | `setAccessBindings`, `updateAccessBindings` | `admin` or `resource-manager.admin` for the folder or cloud

#### What's next {#what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
