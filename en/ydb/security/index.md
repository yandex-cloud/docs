---
title: "Managing access in Yandex Managed Service for YDB"
description: "Access management in the {{ ydb-full-name }} database creation and management service. To allow access to {{ ydb-short-name }} resources (databases and their users), assign appropriate roles from the list to the user."
sourcePath: overlay/security/start_auth.md
---

# Access management in {{ ydb-name }}

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. If a user doesn't have any roles assigned, almost all operations are forbidden.

To allow access to {{ ydb-short-name }} resources (databases and their users), assign users the relevant roles from the list below. Currently, a role can only be assigned to a parent resource (folder or cloud). Roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles {#roles}

The list below shows all roles that are considered when verifying access rights in the {{ ydb-name }} service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### ydb.viewer

A user with the `{{ roles-ydb-viewer }}` role can perform the following actions:
* Establish DB connections.
* View a list of schema objects (tables, indexes, and folders).
* View descriptions of schema objects (table, index, and folder).
* View DB information.
* Run queries to read data.

A user with this role can also retrieve a list of folders in the cloud and a list of resources in a cloud folder.

All the `ydb.viewer` permissions are included in the `viewer` role.

### ydb.editor

A user with the `{{ roles-ydb-editor }}` role can perform the following actions:
* Manage DBs, for example, create a DB or reconfigure it.
* Create, modify, and delete schema objects (tables, indexes, and folders) in a database.
* Run the statements that write data.

The `ydb.editor` role also includes all permissions of the `viewer` role.

All the `ydb.editor` permissions are included in the `editor` role.

### ydb.admin

The `ydb.admin` role has the same permissions as the `ydb.editor` role.

### viewer

Users with the `viewer` role can view information about resources. For example, they can view a list of hosts or get information about a database cluster.

### editor

Users with the `editor` role can manage any resource, including creating a database cluster and creating or deleting cluster hosts.

The `editor` role also includes all permissions of the `viewer` role.

### admin

Users with the `admin` role can manage resource access rights, including allowing other users to create database clusters and to view information about them.

Additionally, the `{{ roles-admin }}` role includes all the permissions of the `{{ roles-editor }}` role.
