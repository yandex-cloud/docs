# Migrating objects to workbooks

You can choose any object (a [connection](../concepts/connection.md), [dataset](../concepts/dataset/index.md), [chart](../concepts/chart/index.md), or [dashboard](../concepts/dashboard.md)) for migration and transfer it to a [workbook](./index.md) along with all linked objects. Object IDs and links will not change.

{{ datalens-short-name }} finds linked objects recursively across all links. This enables you to start migration from any object. For example, you can do it from a dashboard. {{ datalens-short-name }} will find all linked charts, datasets, and connections. Then, it will repeat the search for links for each found object. Once finished, the service will prompt you to place all found objects in a workbook.

{% note warning %}

* Objects within a workbook cannot be migrated back to a folder.
* Immediately after the migration, all access rights to the migrated objects are revoked, and you become a sole [administrator](../security/roles.md#workbooks-admin) of the workbook who can assign [access rights](./security.md) to other users and user groups.

{% endnote %}

To migrate an object to a workbook:

1. Find the required object on the [navigation page](https://datalens.yandex.ru/navigation).

1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the object and select ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **Migration to workbook**.
1. In the window that opens, you will see a list of linked objects that will be transferred as well. If you are ready to transfer all of them to a new storage structure, click **Migrate**.

   {% note warning %}

   If you do not want to transfer any of the linked objects, close the migration window and create copies of these objects. Next, replace them with copies in the objects to be migrated. For more information, see [{#T}](#partial-migration).

   {% endnote %}

1. In the window that opens, select the target workbook and click **Move**. To migrate objects to a new workbook, click **Create workbook**.
1. In the **Manage access** window, set up the [workbook permissions](./security.md) and click **Close**.

## Partial object migration {#partial-migration}

Let's look at partial object migration with a chart migrated to a workbook as an example. For source objects, we will use the connection, dataset, and first chart from the [Visualizing data from a file](../tutorials/data-from-csv-visualization.md) scenario. Name them `SuperHeroes_Connection`, `SuperHeroes_Dataset`, and `SuperHeroes_Gender`, respectively. Let's assume that we only need to migrate a `SuperHeroes_Gender` chart and keep its linked objects, `SuperHeroes_Connection` and `SuperHeroes_Dataset`, in the current folder.

![image](../../_assets/datalens/migration/chart-migrate.png =750x455)

1. Create copies of the linked objects that you do not want to migrate:

   * `SuperHeroes_Connection_copy`
   * `SuperHeroes_Dataset_copy`

1. In the `SuperHeroes_Dataset_copy` dataset, replace the connection with `SuperHeroes_Connection_copy`:

   1. Open the dataset and go to the **Sources** tab.
   1. Delete all the tables from the workspace.
   1. On the left side of the screen, click ![image](../../_assets/console-icons/ellipsis.svg) next to `SuperHeroes_Connection` and select **Replace connection**.

      ![image](../../_assets/datalens/migration/replace-connection.png =450x496)

   1. Select `SuperHeroes_Connection_copy`.
   1. Drag the tables you need to the workspace.
   1. Add the required fields.
   1. In the top-right corner, click **Save**.

1. In the `SuperHeroes_Gender` chart, replace the dataset with `SuperHeroes_Dataset_copy`:

   1. Open the chart.
   1. On the left side of the screen, click ![image](../../_assets/console-icons/ellipsis.svg) next to `SuperHeroes_Dataset` and select **Replace dataset**.

      ![image](../../_assets/datalens/migration/replace-dataset.png =450x432)

   1. Select `SuperHeroes_Dataset_copy`.
   1. In the top-right corner, click **Save**.

You can now migrate the `SuperHeroes_Gender` chart to the workbook while keeping the `SuperHeroes_Connection` and `SuperHeroes_Dataset` objects in the current folder.

![image](../../_assets/datalens/migration/chart-migrate-copy.png =750x455)

## Copying a workbook {#copy-workbook}

If after migration you want your workbook to include only certain migrated objects, you can create a copy of the workbook and clear it of all unwanted objects.

Let's create a workbook with a dataset. For source objects, we will use a [ready-made dataset]({{ link-datalens-main }}/marketplace/f2e0000r63qkp2ywqpco) of a fictional company from the {{ datalens-short-name }} {{ marketplace-short-name }}.

1. On the [navigation page](https://datalens.yandex.ru/navigation), find **Sample Superstore Dataset**.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the dataset and select ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **Migration to workbook**.
1. In the window that opens, you will see a list of linked objects that will be transferred as well.

   ![image](../../_assets/datalens/migration/store-migrate.png =750x422)

1. Click **Migrate**.
1. In the window that opens, click **Create workbook**. Enter a name, such as **Sample Superstore All**, then click **Create**. Select the new workbook in the **Collections and workbooks** list and click **Move**.
1. In the **Manage access** window, set up the [workbook permissions](./security.md) and click **Close**.

   After the migration, the **Sample Superstore All** workbook with the migrated dataset and linked objects will open.

   ![image](../../_assets/datalens/migration/store-workbook.png =750x422)

1. Create a copy of the workbook:

   1. In the top-right corner of the workbook page, click **Copy**.
   1. In the window that opens, select the target collection and click **Copy**. To copy the workbook to a new collection, click **Create collection**.
   1. Enter a name for the new workbook, such as **Sample Superstore Copy**, then click **Copy**.

1. In the **Sample Superstore Copy** workbook, go to the **All objects** tab and delete everything except **Sample Superstore Connection** and **Sample Superstore Dataset**. To do this, click ![image](../../_assets/console-icons/ellipsis.svg) next to each object and select **Delete**.

Now your **Sample Superstore Copy** only contains **Sample Superstore Connection** and **Sample Superstore Dataset**. You can create charts and a dashboard in the workbook.

![image](../../_assets/datalens/migration/store-workbook-copy.png =750x422)
