---
title: "Setting up access in {{ datalens-full-name }} workbooks and collections"
description: "You can grant users or user groups permissions to each workbook and collection. Permissions determine what you can do with a workbook or collection."
---

# Setting up access in workbooks and collections {{ datalens-short-name }}

You can grant users or [user groups](../../iam/operations/groups/create.md) permissions to each workbook and collection. [Permissions](../security/roles.md#workbooks-collections-roles) determine what you can do with a workbook or collection. Permissions are inherited as follows:

* Workbook permissions apply to all objects within the workbook.
* Collection permissions apply to all collections and their workbooks, as well as objects within workbooks.

You can grant permissions to individual users or groups of [authenticated](../../iam/concepts/authorization/index.md#authentication) users.

{% note info %}

* You can assign permissions for workbooks and collections to users even if they have yet to accept their [invitation to {{ datalens-short-name }}](../security/add-new-user.md).
* Permissions are inherited by all nested objects. You can update the inherited permissions only at the parent object level.

{% endnote %}

## Granting permissions {#wb-coll-grant}

To grant workbook or collection permissions:

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![collections](../../_assets/console-icons/rectangles-4.svg) **Collections and workbooks**.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the collection or workbook and select **Access**.

   Under **Inherited permissions**, you can see the users who inherited object permissions, because they were granted permissions to one of its parent objects. For each user, the inherited permission and the object that it is inherited from are displayed.

   Under **Direct permissions**, you can see the users who are granted permissions to the selected object.

1. Click **Add user**.
1. In the window that opens, select a user or user group, specify the appropriate permission, and click **Save**. The user or user group will be granted permissions to this object.

## Revoking permissions {#wb-coll-revoke}

To revoke workbook or collection permissions:

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![collections](../../_assets/console-icons/rectangles-4.svg) **Collections and workbooks**.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the collection or workbook and select **Access**.
1. Under **Direct permissions**, click ![image](../../_assets/console-icons/trash-bin.svg) next to the user or user group to revoke permissions from.

   {% note info %}

   If the user is missing from the list, they might have been granted permissions to the parent object. You can revoke permissions for the parent object. To switch to the object that inherits permissions, find the user in the **Inherited permissions** list and click the object name.

   {% endnote %}

1. In the window that opens, click **Revoke role**.
