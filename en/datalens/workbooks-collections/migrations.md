# Migrating objects to workbooks

You can choose any object (a [connection](../concepts/connection.md), [dataset](../concepts/dataset/index.md), [chart](../concepts/chart/index.md), or [dashboard](../concepts/dashboard.md)) for migration and transfer it to a workbook along with all linked objects.

{% note warning %}

You cannot transfer them back.

{% endnote %}

To migrate an object to a workbook:

1. Find the required object on the [navigation page](https://datalens.yandex.ru/navigation).

1. Click ![image](../../_assets/datalens/horizontal-ellipsis.svg) next to the object and select ![image](../../_assets/datalens/replace.svg) **Migration to workbook**.
1. In the window that opens, you will see a list of linked objects that will be transferred as well. If you are ready to transfer all of them to a new storage structure, click **Migrate**.

   {% note warning %}

   If you do not want to transfer any of the linked objects, close the migration window and create copies of these objects. Next, replace them with copies in the objects to be migrated. For more information, see [{#T}](#partial-migration).

   {% endnote %}

1. In the window that opens, select the target workbook and click **Move**. To migrate objects to a new workbook, click **Create workbook**.
1. In the **Manage access** window, set up the [workbook permissions](./security.md) and click **Close**.

## Partial object migration {#partial-migration}

Let's look at partial object migration with a chart migrated to a workbook as an example. Let's assume that we only need to migrate a `Table` chart and keep its linked objects, `Guides_Connection` and `Guides_Dataset`, in the current folder.

![image](../../_assets/datalens/chart-migrate.png =750x447)

1. Create copies of the linked objects that you do not want to migrate:

   * `Guides_Connection_copy`
   * `Guides_Dataset_copy`

1. In the `Guides_Dataset_copy` dataset, replace the connection with `Guides_Connection_copy`:

   1. Open the dataset and go to the **Sources** tab.
   1. Delete all the tables from the workspace.
   1. On the left side of the screen, click ![image](../../_assets/datalens/horizontal-ellipsis.svg) next to `Guides_Connection` and select **Replace connection**.

      ![image](../../_assets/datalens/replace-connection.png =450x447)

   1. Select `Guides_Connection_copy`.
   1. Drag the tables you need to the workspace.
   1. In the top-right corner, click **Save**.

1. In the `Table` chart, replace the dataset with `Guides_Dataset_copy`:

   1. Open the chart.
   1. On the left side of the screen, click ![image](../../_assets/datalens/horizontal-ellipsis.svg) next to `Guides_Dataset` and select **Replace dataset**.

      ![image](../../_assets/datalens/replace-dataset.png =450x395)

   1. Select `Guides_Dataset_copy`.
   1. In the top-right corner, click **Save**.

You can now migrate the `Table` chart to the workbook while keeping the `Guides_Connection` and `Guides_Dataset` objects in the current folder.

![image](../../_assets/datalens/chart-migrate-copy.png =750x447)
