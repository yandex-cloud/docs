# Migrating objects to workbooks

{% note info %}

* If you do not see ![collections](../../_assets/console-icons/rectangles-4.svg) **Collections and workbooks** in the panel on the left, [enable workbooks and collections](../../datalens/workbooks-collections/index.md#enable-workbooks) in your organization.
* To migrate objects, a user must have the `{{ roles-datalens-admin }}` role.

{% endnote %}

You can select any object ([connection](../concepts/connection.md), [dataset](../dataset/index.md), [chart](../concepts/chart/index.md), [dashboard](../concepts/dashboard.md)) for migration and perform it by [transferring](#migration-transfer) or [copying](#migration-copy).

## Migration by transfer {#migration-transfer}

When this migration type is selected, the object is transferred to the [workbook](./index.md) along with all related objects:

* Original objects are not saved in the folder.
* Object IDs remain the same.
* Links to objects do not change and lead to the workbook.

During migration, {{ datalens-short-name }} finds linked objects recursively across all links. Therefore, you to start your migration from any object. For example, from a dashboard. {{ datalens-short-name }} will find all linked charts, datasets, and connections. Then it will search for the links of the objects it found. Finally, it will prompt you to put all the objects it found into a single workbook.

{% note warning %}

* Objects within a workbook cannot be migrated back to a folder.
* Immediately after the migration, all access rights to the transferred objects are revoked, and you become a sole [administrator](../security/roles.md#datalens-workbooks-admin) of the workbook who can assign [access rights](./security.md) to other users and user groups.

{% endnote %}

## Migration by copying {#migration-copy}

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

## How to migrate to a workbook {#migration-operation}

To copy or transfer an object to a workbook:

1. Find the object you want to transfer or copy to a workbook on the [navigation page]({{ link-datalens-main }}/navigation).
1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the object and select ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **Migrate to workbook**.
1. Select a migration method and click **Select**.
1. In the window with a list of linked objects, click **Next**.
1. In the window that opens, select the workbook to which you want to transfer or copy objects and click **Move**. To transfer or copy objects to a new workbook, click **Create a workbook**.
1. In the **Manage access** window, configure [workbook permissions](./security.md) and click **Close**.

## Copying a workbook {#copy-workbook}

If after migration you want your workbook to include only certain transferred objects, you can create a copy of the workbook and clear it of all unwanted objects.

Let's create a workbook with a dataset. For source objects, we will use a [ready-made dataset]({{ link-datalens-main }}/marketplace/f2e0000r63qkp2ywqpco) of a fictitious company from {{ datalens-short-name }} {{ marketplace-short-name }}.

1. On the [navigation page]({{ link-datalens-main }}/navigation), find **Sample Superstore Dataset**.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to this dataset and select ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **Migrate to workbook**.
1. In the window that opens, you will see a list of linked objects that will be transferred.

   ![image](../../_assets/datalens/migration/store-migrate.png =750x422)

1. Click **Migrate**.
1. In the window that opens, click **Create workbook**. Enter a name, such as **Sample Superstore All**, then click **Create**. Select the new workbook in the **Collections and workbooks** list and click **Move**.
1. In the **Manage access** window, configure [workbook permissions](./security.md) and click **Close**.

   After the migration, the **Sample Superstore All** workbook with the transferred dataset and linked objects will open.

   ![image](../../_assets/datalens/migration/store-workbook.png =750x422)

1. Create a copy of your workbook:

   1. In the top-right corner of the workbook page, click **Copy**.
   1. In the window that opens, select the target collection and click **Copy**. To copy the workbook to a new collection, click **Create collection**.
   1. Enter a name for the new workbook, such as **Sample Superstore Copy**, then click **Copy**.

1. In the **Sample Superstore Copy** workbook, go to the **All objects** tab and delete everything except **Sample Superstore. Connection** and **Sample Superstore Dataset**. To do this, click ![image](../../_assets/console-icons/ellipsis.svg) next to each object and select **Delete**.

Now your **Sample Superstore Copy** workbook only contains the connection called **Sample Superstore Connection** and the dataset called **Sample Superstore Dataset**. You can create charts and a dashboard in the workbook.

![image](../../_assets/datalens/migration/store-workbook-copy.png =750x422)
