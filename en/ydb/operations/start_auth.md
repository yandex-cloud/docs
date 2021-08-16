---
title: Access management in Yandex Database
description: "Access control in the service for creating and managing databases Yandex Database. To allow access to the resources of the YDB service (databases and their users), assign the user the necessary roles from the list below."
---

# Access management in {{ ydb-name }}

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. If a user doesn't have any roles assigned, almost all operations are forbidden.

To allow access to {{ ydb-short-name }} resources (databases and their users), assign users the relevant roles from the list below. For now, a role can only be assigned for a parent resource (folder or cloud), and roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles {#roles}

The list below shows all roles that are considered when verifying access rights in the {{ ydb-short-name }} service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### {{ roles-viewer }}

Users with the `{{ roles-viewer }}` role can view information about resources. For example, they can view a list of hosts or get information about a database cluster.

### {{ roles-editor }}

Users with the `{{ roles-editor }}` role can manage any resource, including creating a database cluster and creating or deleting cluster hosts.

The `{{ roles-editor }}` role also includes all `{{ roles-viewer }}` role permissions.

### {{ roles-admin }}

Users with the `{{ roles-admin }}` role can manage resource access rights, including allowing other users to create database clusters and to view information about them.

The `{{ roles-admin }}` role also includes all `{{ roles-editor }}` role permissions.

