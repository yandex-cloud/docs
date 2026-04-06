---
title: Migrating objects to workbooks
description: Follow this guide to migrate objects to workbooks.
---

# Migrating objects to workbooks from folders

{% note info %}

* If you do not see ![collections](../../_assets/console-icons/rectangles-4.svg) **Collections and workbooks** in the panel on the left, [enable workbooks and collections](../../datalens/workbooks-collections/index.md#enable-workbooks) in your organization.
* To migrate objects, a user must have the `{{ roles-datalens-admin }}` role.
* To transfer your workbook between installations or [organizations](../concepts/organizations.md), use the [export and import](./export-and-import.md) tool.

{% endnote %}

You can migrate any individual folder object (i.e., a [connection](../concepts/connection/index.md), [dataset](../dataset/index.md), [chart](../concepts/chart/index.md), or [dashboard](../concepts/dashboard.md)) by either [transferring](#migration-transfer) or [copying](#migration-copy) it.

{% note info %}

If you want to keep only some of the workbook objects after migration, create a [workbook copy](./workbooks-operations.md#copy-workbook) and remove any redundant items.

{% endnote %}

## How to migrate to a workbook {#migration-operation}

To copy or transfer an object to a workbook:

1. Find the object you want to transfer or copy to a workbook on the [navigation page]({{ link-datalens-main }}/navigation).
1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the object and select ![image](../../_assets/console-icons/arrow-chevron-right.svg) **Migrate to workbook**.
1. Select the [migration method](#migration-methods) and click **Select**.
1. In the window with the list of linked objects, click **Next**.
1. In the window that opens, select the workbook to which you want to transfer or copy objects and click **Move**. To transfer or copy objects to a new workbook, click **Create a workbook**.
1. In the **Manage access** window, configure [workbook permissions](./workbooks-operations.md#wb-coll-grant) and click **Close**.

## Migration methods {#migration-methods}

### Migration by transfer {#migration-transfer}

When this migration type is selected, the object is transferred to the [workbook](./index.md) along with all related objects:

* Original objects are not saved in the folder.
* Object IDs remain the same.
* Links to objects do not change and lead to the workbook.

During migration, {{ datalens-short-name }} finds linked objects recursively across all links. Therefore, you to start your migration from any object. For example, from a dashboard. {{ datalens-short-name }} will find all linked charts, datasets, and connections. Then it will search for the links of the objects it found. Finally, it will prompt you to put all the objects it found into a single workbook.

{% note warning %}

* Objects within a workbook cannot be migrated back to a folder.
* Right after the migration, all access permissions for the transferred objects get canceled, and you become the sole workbook [administrator](../security/roles.md#datalens-workbooks-admin) and can assign [access permissions](./workbooks-operations.md#wb-coll-grant) to other users and user groups.

{% endnote %}

### Migration by copying {#migration-copy}

If the original object is to be saved in a folder, it can be copied to a workbook along with its linked objects:

* Original objects remain saved in the folder.
* New IDs are generated for the copied objects.
* Links to objects do not change.

You can start copying from any object. Unlike in a transfer, linked objects are searched down the [hierarchy](../concepts/index.md#component-interrelation) starting from the dashboard:

* Charts residing on the dashboard as well as the datasets and connections they are linked with are copied with the dashboard.
* The dataset and the connection to which the chart is linked are copied with the chart.
* The connection on which the dataset is built is copied with the dataset.
* The connection is copied separately.

{{ datalens-short-name }} will prompt you to put the objects it found into a single workbook.

{% note warning %}

Copying the [Files](../operations/connection/create-file.md), [Google Sheets](../operations/connection/create-google-sheets.md), and [Yandex Documents](../operations/connection/create-yadocs.md) connections is not available.

{% endnote %}
