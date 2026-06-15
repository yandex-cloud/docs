---
title: Basic access in workbooks and collections
description: In this tutorial, you will learn how to manage basic access to objects in {{ datalens-short-name }} with workbook and collection navigation on.
---

# Basic access permissions setup in workbooks and collections

Access to {{ datalens-name }} objects, such as connections, datasets, charts, and dashboards, is configured at the level of collections and workbooks they are stored in. Access permissions are inheritable: by granting access to a workbook or collection, you grant access to all objects within it.

* [Overview of access permissions](#overview).
* [Roles for workbooks](#workbook-roles).
* [Roles for collections](#collection-roles).
* [How to configure access](#set-access).
* [How to edit access](#edit-access).
* [How to delete access](#delete-access).

## Overview of access permissions {#overview}

The workbook or collection author automatically gets the `Admin` role for the workbook or collection as soon as it is created. With the `Viewer` or higher permissions for a workbook or collection, users can view the assigned permissions info.

To view permissions assigned for a workbook or collection:

1. In the left-hand panel, click ![image](../../_assets/console-icons/plus.svg) **Collections and workbooks**.
1. Select from the list and open the workbook or collection you want to view access permissions for.
1. In the top panel, click ![image](../../_assets/console-icons/lock-open.svg) **Access**. If you do not see this icon, it means you do not have enough permissions to view the object's access permissions.

In the window that opens, you will see a list of those who have access to the object:
* Users.
* User groups.
* Service accounts.
* Users invited to the organization.

Next to each position in the list, you will see the assigned role as well as the inherited ones. For example, if a user has the `Admin` role for a collection, this role is inherited to cover all workbooks and collections nested within the collection.

## Roles for workbooks {#workbook-roles}

#### Limited viewer {#workbooks-limitedViewer}

The `Limited viewer` role for a workbook allows you to view the workbook's nested [charts](../concepts/chart/index.md) and [dashboards](../concepts/dashboard.md), as well as information about the [access permissions](../../iam/concepts/access-control/index.md) assigned to it.

#### Viewer {#workbooks-viewer}

The `Viewer` role for a workbook allows you to view all its nested [objects](../concepts/index.md#component-interrelation), as well as information about the [access permissions](../../iam/concepts/access-control/index.md) assigned for it.

Includes permissions granted by the `Limited viewer` role.

#### Editor {#workbooks-editor}

The `Editor` role for a workbook allows you to edit it and all its nested objects.

Users with this role can:
* Edit the relevant [workbook](../workbooks-collections/index.md) and create copies of it.
* View and edit all workbook's nested [objects](../concepts/index.md#component-interrelation).
* View info on the [access permissions](../../iam/concepts/access-control/index.md) granted for the workbook.

Includes permissions granted by the `Viewer` role.

#### Admin {#workbooks-admin}

The `Admin` role for a workbook allows you to manage it, access the workbook itself and all its nested objects.

Users with this role can:
* View info on the [access permissions](../../iam/concepts/access-control/index.md) granted for the relevant [workbook](../workbooks-collections/index.md) and modify such permissions.
* Edit, move, create copies of, and delete the relevant workbook.
* View and edit all workbook's nested [objects](../concepts/index.md#component-interrelation).
* [Embed](./private-embedded-objects.md) the workbook's nested private objects to websites and apps.
* [Publish](../concepts/datalens-public.md#how-to-publish) the workbook's nested objects.

Includes permissions granted by the `Editor` role.

## Roles for collections {#collection-roles}

#### Collection visitor {#collections-visitor}

The `Collection visitor` role allows you to view information about the collection without accessing its nested objects.

#### Creator in collection {#collections-creator}

The `Creator in collection` role allows you to view a collection and create objects inside it without accessing the existing ones.

Users with this role can:
* View info on the relevant collection and its nested [workbooks and collections](../workbooks-collections/index.md).
* Create workbooks and collections inside the collection.

This role includes the `Collection visitor` permissions.

#### Limited viewer {#collections-limitedViewer}

The `Limited viewer` role for a collection allows you to view information about it and its nested collections and workbooks, including viewing charts and dashboards of the nested workbooks.

Users with this role can:
* View info on the relevant collection and its nested [workbooks and collections](../workbooks-collections/index.md).
* View info on the [access permissions](../../iam/concepts/access-control/index.md) granted for the appropriate collection, as well as for its nested collections and workbooks.
* View [charts](../concepts/chart/index.md) and [dashboards](../concepts/dashboard.md) nested into the workbooks related to the appropriate collection and its nested collections.

Includes permissions granted by the `Limited viewer` role for workbooks inside the collection.

#### Viewer {#collections-viewer}

The `Viewer` role for a collection allows you to view information about it and its nested collections and workbooks, as well as view all objects of nested workbooks.

Users with this role can:
* View info on the relevant collection and its nested [workbooks and collections](../workbooks-collections/index.md).
* View info on the [access permissions](../../iam/concepts/access-control/index.md) granted for the appropriate collection, as well as for its nested collections and workbooks.
* View all nested [objects](../concepts/index.md#component-interrelation) of the workbooks related to the appropriate collection and its nested collections.

Includes permissions granted by the `Limited viewer` role for collections and the `Viewer` role for workbooks inside the collection.

#### Editor {#collections-editor}

The `Editor` role for a collection allows you to edit it, all its nested collections, workbooks, and all objects within those workbooks.

Users with this role can:
* View info on the relevant collection and its nested [collections and workbooks](../workbooks-collections/index.md).
* Edit the appropriate collection and all its nested collections and workbooks.
* Create copies of the relevant collection and all its nested collections and workbooks.
* Create new collections and workbooks within the relevant collection and all its nested ones.
* View and edit all nested [objects](../concepts/index.md#component-interrelation) of the workbooks pertaining to the appropriate collection and its nested collections.
* View info on the [access permissions](../../iam/concepts/access-control/index.md) granted for the appropriate collection, as well as for its nested collections and workbooks.

Includes permissions granted by the `Viewer` role for collections and the `Editor` role for workbooks inside the collection.

#### Admin {#collections-admin}

The `Admin` role for a collection allows you to manage it, access the collection itself and all its nested collections, workbooks, and objects inside such workbooks.

Users with this role can:
* View info on the [access permissions](../../iam/concepts/access-control/index.md) granted for the appropriate collection and for its nested [collections and workbooks](../workbooks-collections/index.md), as well as modify such access permissions.
* View info on the appropriate collection and its nested collections and workbooks.
* Edit the relevant collection and all its nested collections and workbooks, as well as create copies of it.
* Move and delete the relevant collection and all its nested collections and workbooks.
* Create new collections and workbooks within the relevant collection.
* View and edit all nested [objects](../concepts/index.md#component-interrelation) of the workbooks pertaining to the appropriate collection and its nested collections.
* [Embed](./private-embedded-objects.md) private objects nested into workbooks related to the relevant collection and its nested ones, to websites and apps.
* [Publish](../concepts/datalens-public.md#how-to-publish) objects nested into the workbooks related to the appropriate collection and its nested collections.

Includes permissions granted by the `Editor` role for collections and the `Admin` role for workbooks inside the collection.

## How to configure access {#set-access}

To configure access:

1. In the left-hand panel, click ![image](../../_assets/console-icons/plus.svg) **Collections and workbooks**.
1. Select from the list and open the workbook or collection whose objects you want to configure access to.
1. In the top panel, click ![image](../../_assets/console-icons/lock-open.svg) **Access**.
1. Select the users you want to grant access to. Dot it by clicking **+ Select** and search through existing users, service accounts, or groups in the organization. You can also add a new user here: they will be emailed an invitation.
1. Select the role you want to assign from the list on the right.
1. Click **Add**.

## How to edit access {#edit-access}

To edit access:

1. In the left-hand panel, click ![image](../../_assets/console-icons/plus.svg) **Collections and workbooks**.
1. Select from the list and open the workbook or collection you want to edit access for.
1. In the top panel, click ![image](../../_assets/console-icons/lock-open.svg) **Access**.
1. Select the user you want to edit access for. Click ![](../../_assets/console-icons/gear.svg) in the list next to it.
1. To delete assigned roles, click ![](../../_assets/console-icons/xmark.svg). To assign roles, click **+Add** and select a role from the list.
1. Click **Save**.

## How to delete access {#delete-access}

To delete access:

1. In the left-hand panel, click ![image](../../_assets/console-icons/plus.svg) **Collections and workbooks**.
1. Select from the list and open the workbook or collection you want to edit access for.
1. In the top panel, click ![image](../../_assets/console-icons/lock-open.svg) **Access**.
1. Select the user you want to delete access for. Click ![](../../_assets/console-icons/gear.svg) in the list next to it.
1. Click ![](../../_assets/console-icons/xmark.svg) for all roles assigned to the user.
1. Click **Save**.
