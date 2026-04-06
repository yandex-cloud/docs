---
title: Working with a {{ datalens-full-name }} collection
description: Follow this guide to create, edit, move, delete, and set up access to a {{ datalens-full-name }} collection.
---

# Working with a {{ datalens-full-name }} collection

In this section, you will learn how to use a workbook:

* [Creating a collection](#create-collection)
* [Editing a collection](#edit-collections)
* [Moving a collection](#move-collections)
* [Setting up access to a collection](#security)
* [Deleting a collection](#delete-collections)

## Creating a collection {#create-collections}

To create a collection:

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![collections](../../_assets/console-icons/rectangles-4.svg) **Collections and workbooks**.

   
   {% include [datalens-workbooks-enable](../../_includes/datalens/datalens-workbooks-enable.md) %}


1. In the top-right corner, click **Create** → **Create collection**.
1. Enter a name for the collection.
1. Click **Create**.

## Editing a collection {#edit-collections}

To change collection name and description:

1. At the top of the collection page, next to the name, click ![image](../../_assets/console-icons/pencil-to-line.svg) **Edit**.
1. Enter a new name and description for the collection and click **Save**.

## Moving a collection {#move-collections}

To move a collection:

1. At the top of the collection page, click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/arrow-right.svg) **Move**.
1. Select the collection you want to move the collection to and click **Move**. To move it to a new collection, click **Create collection**.


## Setting up access to a collection {#security}

{% include [workbooks-collections-access](../../_includes/datalens/workbooks-collections-access.md) %}

### Assigning access permissions {#wb-coll-grant}

To assign access permissions for a collection:
  
1. At the top of the collection page, click ![icon](../../_assets/console-icons/lock-open.svg) **Access**.

   Under **Inherited permissions**, you can see the users who inherited object permissions, because they were granted permissions to one of its parent objects. For each user, the inherited permission and the object that it is inherited from are displayed.

   Under **Direct permissions**, you can see the users who are granted permissions to the selected object.

1. Click ![image](../../_assets/console-icons/plus.svg) **Add user**.
1. In the window that opens, select a user or user group, specify the appropriate permission, and click **Save**. The user or user group will be granted permissions to this object.

### Revoking privileges {#wb-coll-revoke}

To revoke access permissions for a collection:

1. At the top of the collection page, click ![icon](../../_assets/console-icons/lock-open.svg) **Access**.
1. Under **Direct permissions**, click ![image](../../_assets/console-icons/trash-bin.svg) next to the user or user group to revoke permissions from.

   {% note info %}

   If the user is missing from the list, they might have been granted permissions to the parent object. You can revoke permissions for the parent object. To switch to the permission inheritance object, find the user in the **Inherited permissions** list and click the object name.

   {% endnote %}

1. In the window that opens, click **Revoke role**.


## Deleting a collection {#delete-collections}

To delete a collection:
  
1. At the top of the collection page, click ![image](../../_assets/console-icons/ellipsis.svg) → ![icon](../../_assets/console-icons/trash-bin.svg) **Delete**.
1. Confirm the deletion.
