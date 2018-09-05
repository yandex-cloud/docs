# Identity and access management

Operations on resources are restricted by roles assigned to Yandex.Cloud users. If a user doesn't have any roles assigned, almost all operations are forbidden.

To allow access to the [!KEYREF mdb-name] service resources (DB clusters and hosts, cluster backups, databases, and their users), assign the user the appropriate roles from the list below. At this time, a role can only be assigned to a parent resource (folder or cloud).  Roles are inherited by nested resources.

> [!NOTE]
> 
> For more information about role inheritance, see [[!TITLE]](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the [!KEYREF resmgr-full-name] service documentation.

## Assigning roles

To assign a role to a user:

[!INCLUDE [grant-role-console](../../_includes/grant-role-console.md)]

## Roles

Below is a list of all roles that are used for verifying access rights in the [!KEYREF mdb-name] service.

### Service roles

_Service roles_ are roles that allow access to the resources of a particular service.

[!INCLUDE [cloud-roles](../../_includes/cloud-roles.md)]

### Primitive roles

You can assign primitive roles to any resource in any service.

#### [!KEYREF roles-viewer]

A user with the role `[!KEYREF roles-viewer]` can view information about resources, for example, view a list of drives or obtain information about a DB cluster.

#### [!KEYREF roles-editor]

A user with the role `[!KEYREF roles-editor]` can manage any resources, for example, create a DB cluster, and create or delete a host in a cluster.

In addition, the role `[!KEYREF roles-editor]` includes all permissions of the role `[!KEYREF roles-viewer]`.

#### [!KEYREF roles-admin]

A user with the role `[!KEYREF roles-admin]` can manage access rights to resources, for example, allow other users to create DB clusters or view information about them.

In addition, the role `[!KEYREF roles-admin]` includes all permissions of the role  `[!KEYREF roles-editor]`.

