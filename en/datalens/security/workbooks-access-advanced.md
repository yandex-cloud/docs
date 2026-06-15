---
title: Access in workbooks and collections
description: In this tutorial, you will learn how to manage access to objects in {{ datalens-short-name }} with workbook and collection navigation on.
---

# Advanced access permission management using shared objects

If setting up access to objects at the workbook and collection level is not enough, you can resort to shared objects. _Shared objects_ are connections and datasets you can reuse and link to several workbooks for different teams.

* [How to create a shared object](#create).
* [How to add a shared object to a workbook](#usage).
* [Roles for shared objects](#shared-roles).
* [Roles for a collection with shared objects](#shared-collection).

## How to create a shared object {#create}

Shared objects are created within a collection.

To create a shared object:

{% list tabs %}

- Shared connection

  1. Create a collection to store shared objects.

     1. In the left-hand panel, click ![image](../../_assets/console-icons/plus.svg) **Collections and workbooks**.
     1. On the top panel, click **Create** → **Collection**.
     1. Enter a name for the collection.
     1. Optionally, enter a description of the collection.
     1. Click **Create**.

  1. Go to the collection you created in the previous step.
  1. On the top panel, click **Create** → **Shared objects** → **Connection**.
  1. Create the connection using the instructions from the [list](../concepts/connection/index.md).

- Shared dataset

  Shared datasets are created based on shared connections.

  1. Open the collection storing the shared connection.
  
     1. In the left-hand panel, select ![collections](../../_assets/console-icons/rectangles-4.svg) **Collections and workbooks**.
     1. Select a collection with a shared connection from the list and open it.

  1. In the top-right corner, click **Create** → **Shared objects** → **Dataset**.
  1. Create a dataset by following [this guide](../dataset/create-dataset.md#create).
  1. Configure rules for delegation of access permissions to the shared connection:

     * **Delegate access permissions**: Access permissions to the shared connection will not be checked within the workbook that will use the shared dataset. This means that anyone with access to the workbook the connection is linked to will also have access to the connection.
     * **Do not delegate access permissions**: For users to access the connection from the workbook the connection is linked to, they must be granted access to the original, i.e., the shared connection.

  1. Click **Apply**.

{% endlist %}

## How to add a shared object to a workbook {#usage}

Shared objects are linked at the workbook level. In the workbook, they are displayed under **Linked objects**.

Shared objects can be linked to a workbook by a user with the following permissions:

1. `Admin` for the workbook the shared object will be linked to.
1. `Admin` or `Links without delegation` or `Links with delegation` for a collection of shared objects or directly for the shared objects that will be linked to the workbook.

To link a shared object to a workbook:

{% list tabs %}

- Shared connection

  1. In the left-hand panel, click ![image](../../_assets/console-icons/plus.svg) **Collections and workbooks**.
  1. Select a workbook to link the shared connection to and open it.
  1. On the top panel, click **Create** → **Shared objects** → **Connection**.
  1. Select from the list a collection with the shared connection you need, click it, and click the shared connection.
  1. Configure rules for delegation of access permissions to the shared connection:

     * **Delegate access permissions**: Access permissions to the shared connection will not be checked within the workbook. This means that anyone with access to the workbook the connection is linked to will also have access to the connection.
     * **Do not delegate access permissions**: For users to access the connection from the workbook, they must be granted access to the original, i.e., the shared connection.

  1. Click **Apply**.

- Shared dataset

  1. In the left-hand panel, click ![image](../../_assets/console-icons/plus.svg) **Collections and workbooks**.
  1. Select a workbook to link the shared dataset to and open it.
  1. On the top panel, click **Create** → **Shared objects** → **Dataset**.
  1. Select from the list a collection with the shared dataset you need, click it, and click the shared dataset.
  1. Configure rules for delegation of access permissions to the shared dataset:

     * **Delegate access permissions**: Access permissions to the shared dataset will not be checked within the workbook. This means that anyone with access to the workbook the connection is linked to will also have access to the dataset.
     * **Do not delegate access permissions**: For users to access the dataset from the workbook, they must be granted access to the original, i.e., the shared dataset.

  1. Click **Apply**.

{% endlist %}

## Roles for shared objects {#shared-roles}

#### Limited viewer {#shared-limitedViewer}

The `Limited viewer` role for a shared object allows you to view [charts](../concepts/chart/index.md) and [dashboards](../concepts/dashboard.md) that use the shared object without directly accessing it.

#### Viewer {#shared-viewer}

The `Viewer` role for a shared object allows you to view that shared object and the access permissions for it.

Includes permissions granted by the `Limited viewer` role.

#### Editor {#shared-editor}

The `Editor` role for a shared object allows you to edit it and view access permissions for that object.

Includes permissions granted by the `Viewer` role.

#### Admin {#shared-admin}

The `Admin` role for a shared object allows you to manage it: edit, move, delete, and configure access permissions for it.

Includes permissions granted by the `Editor` role.

#### Links without delegation {#shared-limitedEntryBindingCreator}

The `Links without delegation` role for a shared object allows you to link it to workbooks without delegating access permissions.

#### Links with delegation {#shared-entryBindingCreator}

The `Links with delegation` role for a shared object allows you to link it to workbooks with or without delegating access permissions.

## Roles for a collection with shared objects {#shared-collection}

#### Links without delegation {#collections-limitedEntryBindingCreator}

The `Links without delegation` role for a collection allows you to link shared objects from the collection to workbooks without delegating access permissions.

#### Links with delegation {#collections-entryBindingCreator}

The `Links with delegation` role for a collection allows you to link shared objects from the collection to workbooks with or without delegating access permissions.

