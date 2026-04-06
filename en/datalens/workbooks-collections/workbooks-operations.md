---
title: Operations with a {{ datalens-full-name }} workbook
description: Follow this guide to create, edit, move, copy, export, delete, and manage access to a {{ datalens-full-name }} workbook.
---

# Operations with a {{ datalens-full-name }} workbook

In this section, you will learn how to use a workbook:

* [Creating a workbook](#create-workbook)
* [Editing a workbook](#edit-workbook)
* [Moving a workbook](#move-workbook)
* [Copying a workbook](#copy-workbook)
* [Exporting a workbook](#export-workbook)
* [Adding or removing embedding keys](#embedded-keys)
* [Setting up access to a workbook](#security)
* [Deleting a workbook](#delete-workbook)

You can perform most actions either from a collection or from the workbook page.

{% list tabs %}

- From a collection
  
  Next to the workbook, click ![image](../../_assets/console-icons/ellipsis.svg) and select the required action.

- In a workbook
  
  On the workbook page, click ![image](../../_assets/console-icons/ellipsis.svg) at the top and select the required action. Some actions have separate buttons.

{% endlist %}

The guides will describe the steps for the workbook method.

## Creating a workbook {#create-workbook}

To create a workbook:

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![collections](../../_assets/console-icons/rectangles-4.svg) **Collections and workbooks**.

   
   {% include [datalens-workbooks-enable](../../_includes/datalens/datalens-workbooks-enable.md) %}


1. In the top-right corner, click **Create** → **Create workbook**.
1. Enter a name for the workbook.
1. Optionally, enter a description for the workbook.
1. Optionally, click **Select file** to [import](./export-and-import.md#import-workbook) a workbook.
1. Click **Create**.

## Editing a workbook {#edit-workbook}

To change workbook name and description:

1. At the top of the workbook page, click ![image](../../_assets/console-icons/pencil-to-line.svg) **Edit** next to the name.
1. Enter a new name and description for the workbook and click **Save**.

## Moving a workbook {#move-workbook}

To move a workbook:

1. At the top of the workbook page, click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/arrow-right.svg) **Move**.
1. Select the collection you want to move the workbook to and click **Move**. To move the workbook to a new collection, click **Create collection**.

## Copying a workbook {#copy-workbook}

To create a copy of a workbook:

1. At the top of the workbook page, click ![image](../../_assets/console-icons/ellipsis.svg) → ![icon](../../_assets/console-icons/copy.svg) **Copy**.
1. In the window that opens, select the target collection and click **Copy**. To copy the workbook to a new collection, click **Create collection**.
1. Enter a name for the new workbook and click **Copy**.

After you have copied a workbook, you can delete redundant objects or create new ones in it.


## Exporting a workbook {#export-workbook}

You can [export a workbook](./export-and-import.md#export-workbook) and download the export file in JSON format. Using the export and import tools in {{ datalens-short-name }}, you can transfer [workbooks](./index.md) between installations. For more information, see [{#T}](./export-and-import.md).



## Adding or deleting embedding keys {#embedded-keys}

You can securely [embed private objects](../security/private-embedded-objects.md#how-to-private-embed) into a website or app using special JWT token links. A JWT token is generated using embedding keys.

To add embedding keys:

1. On the workbook page, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) at the top and select ![key](../../_assets/console-icons/key.svg) **Embedding keys**.
1. Click ![plus](../../_assets/console-icons/plus.svg) **Create key**.
1. Enter the key name and click **Create**.
1. At the bottom, click **Download key file** or copy the key value.

   {% note warning %}

   After you close the window, all data from it will be lost.

   {% endnote %}

   The new key for embedding will appear in the list.

To delete an embedding key:

1. On the workbook page, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) at the top and select ![key](../../_assets/console-icons/key.svg) **Embedding keys**.
1. Next to the key, click ![key](../../_assets/console-icons/trash-bin.svg) and confirm the deletion of the key.

For more information on embedding private objects, see [{#T}](../security/private-embedded-objects.md).



## Setting up access to a workbook {#security}

{% include [workbooks-collections-access](../../_includes/datalens/workbooks-collections-access.md) %}

### Assigning access permissions {#wb-coll-grant}

To assign access permissions for a workbook:
  
1. On the workbook page, click ![icon](../../_assets/console-icons/lock-open.svg) **Access** at the top.

   Under **Inherited permissions**, you can see the users who inherited object permissions, because they were granted permissions to one of its parent objects. For each user, the inherited permission and the object that it is inherited from are displayed.

   Under **Direct permissions**, you can see the users who are granted permissions to the selected object.

1. Click ![image](../../_assets/console-icons/plus.svg) **Add user**.
1. In the window that opens, select a user or user group, specify the appropriate permission, and click **Save**. The user or user group will be granted permissions to this object.

### Revoking privileges {#wb-coll-revoke}

To revoke access permissions for a workbook:

1. On the workbook page, click ![icon](../../_assets/console-icons/lock-open.svg) **Access** at the top.
1. Under **Direct permissions**, click ![image](../../_assets/console-icons/trash-bin.svg) next to the user or user group to revoke permissions from.

   {% note info %}

   If the user is missing from the list, they might have been granted permissions to the parent object. You can revoke permissions for the parent object. To switch to the permission inheritance object, find the user in the **Inherited permissions** list and click the object name.

   {% endnote %}

1. In the window that opens, click **Revoke role**.


## Deleting a workbook {#delete-workbook}

To delete a workbook:

1. At the top of the workbook page, click ![image](../../_assets/console-icons/ellipsis.svg) → ![icon](../../_assets/console-icons/trash-bin.svg) **Delete**.

1. Confirm the deletion of the workbook.