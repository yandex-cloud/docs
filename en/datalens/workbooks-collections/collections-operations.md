---
title: Working with a {{ datalens-full-name }} collection
description: Follow this guide to create, edit, move, delete, and set up access to a {{ datalens-full-name }} collection.
---

# Working with a {{ datalens-full-name }} collection

In this section, you will learn how to use a collection:

* [Creating a collection](#create-collection)
* [Editing a collection](#edit-collections)
* [Moving a collection](#move-collections)
* [Setting up access to a collection](#security)
* [Deleting a collection](#delete-collections)
* [Restoring deleted objects and workbooks](#restore-objects-workbooks)


## Creating a collection {#create-collections}
   

To create a collection:

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![collections](../../_assets/console-icons/rectangles-4.svg) **Collections and workbooks**.

   
   {% include [datalens-workbooks-enable](../../_includes/datalens/datalens-workbooks-enable.md) %}


1. In the top-right corner, click **Create** → **Create collection**.
1. Enter a name for the collection.
1. Click **Create**.




## Editing a collection {#edit-collections}

To change a collection name and description:

1. At the top of the collection page, next to the name, click ![image](../../_assets/console-icons/pencil-to-line.svg) **Edit**.
1. Enter a new name and description for the collection and click **Save**.

## Moving a collection {#move-collections}

To move a collection:

1. At the top of the collection page, click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/arrow-right.svg) **Move**.
1. Select the collection you want to move your collection to and click **Move**. To move it to a new collection, click **Create collection**.


## Setting up access to a collection {#security}

{% include [workbooks-collections-access](../../_includes/datalens/workbooks-collections-access.md) %}

### Assigning access permissions {#wb-coll-grant}

To assign access permissions for a collection:
  
1. At the top of the collection page, click ![icon](../../_assets/console-icons/lock-open.svg) **Access**.

   Under **Inherited permissions**, you can see the users who inherited object permissions, because they were granted permissions for one of its parent objects. For each user, the inherited permission and the object it is inherited from are displayed.

   Under **Direct permissions**, you can see the users who have permissions for the selected object.

1. Click ![image](../../_assets/console-icons/plus.svg) **Add user**.
1. In the window that opens, select a user or user group, specify the appropriate permission, and click **Save**. The user or user group will get permissions for this object.

### Revoking permissions {#wb-coll-revoke}

To revoke access permissions for a collection:

1. At the top of the collection page, click ![icon](../../_assets/console-icons/lock-open.svg) **Access**.
1. Under **Direct permissions**, click ![image](../../_assets/console-icons/trash-bin.svg) next to the user or user group to revoke permissions from.

   {% note info %}

   If the user is missing from the list, they might have permissions for the parent object. You can revoke permissions for the parent object. To switch to the object that inherits permissions, find the user in the **Inherited permissions** list and click the object name.

   {% endnote %}

1. In the window that opens, click **Revoke role**.


## Deleting a collection {#delete-collections}

To delete a collection:
  
1. At the top of the collection page, click ![image](../../_assets/console-icons/ellipsis.svg) → ![icon](../../_assets/console-icons/trash-bin.svg) **Delete**.
1. Confirm the deletion.


## Restoring deleted objects and workbooks {#restore-objects-workbooks}

An administrator, i.e., a user holding the `{{ roles-datalens-admin }}` role, can use [settings](../settings/deleted-objects.md) to view and restore deleted workbooks or objects, including connections, datasets, charts, dashboards, reports, and HTML pages.

To restore an object or a workbook:

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![sliders](../../_assets/console-icons/sliders.svg) **Service settings**.
1. Select the **Deleted objects** tab.
1. This tab displays information about all deleted objects and workbooks:

   * **Name**: Object or workbook name.
   * **Parent object**: Name of the collection or workbook the object or workbook was deleted from. If the parent object has been deleted, the column shows the ![sliders](../../_assets/console-icons/circle-exclamation.svg) icon. If the workbook was deleted from the root collection, a dash symbol (`-`) is displayed.
   * **Deletion at**: Date and time when the object or workbook was deleted.
   * **Deleted by**: Name of the user who deleted the object or workbook.

   You can sort the list by name or deletion date.

   You can also search by object name or switch between tabs with object types: `Workbooks`, `Charts`, `Dashboards`, `Reports`, `More` → `Datasets` / `Connections` / `HTML pages`.

   ![image](../../_assets/datalens/settings/deleted-objects-in-settings.png)

   Click ![icon](../../_assets/console-icons/arrow-rotate-left.svg) next to the object or workbook to restore.
   
1. Confirm restoring the object or workbook. Also note:

   * In standard scenarios, the object or workbook is restored to the same location it was deleted from.
   * If the parent collection is deleted, the system will prompt you to select or create a collection that will house the object or workbook.
   * If an object or workbook with the same name and location already exists, you will be prompted to rename the object or workbook being restored.
   * If the object’s parent workbook is also deleted, the system will bring back the workbook with all its contents first, and then restore your selected object.

