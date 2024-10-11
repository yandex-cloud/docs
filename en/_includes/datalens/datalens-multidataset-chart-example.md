We will use a Moscow retail chain's demo sales {{ CH }} database as our data source. For an example of creating a connection, see [this guide](../../tutorials/datalens/data-from-ch-visualization.md#step1).

1. Build two datasets using a [SQL query against the data source](../../datalens/dataset/create-dataset.md#add-data):

   * SQL query code for the `count_client_sql` dataset:

     ```sql
     SELECT samples.MS_Shops.ShopName, count(t2.ClientID) AS count_clients
     FROM samples.MS_Shops,
     (SELECT DISTINCT samples.MS_Shops.ShopID, samples.MS_Shops.ShopName, samples.MS_SalesFacts.ClientID
     FROM samples.MS_SalesFacts
     INNER JOIN samples.MS_Shops
     ON samples.MS_Shops.ShopID=samples.MS_SalesFacts.ShopID) AS t2
     WHERE t2.ShopName=samples.MS_Shops.ShopName
     GROUP BY ShopName
     ```

   * SQL query code for the `count_sales_sql` dataset:

     ```sql
     SELECT DISTINCT samples.MS_Shops.ShopName, COUNT(*) AS count_sales
     FROM samples.MS_SalesFacts
     INNER JOIN samples.MS_Shops
     ON samples.MS_Shops.ShopID=samples.MS_SalesFacts.ShopID
     GROUP BY ShopName
     ```

1. On the {{ datalens-name }} [home page]({{ link-datalens-main }}), click **Create chart**.
1. Under **Dataset**, select the `count_client_sql` dataset.

   ![image](../../_assets/datalens/concepts/multidataset-chart-1.png)

1. Select **Line chart** as your chart type.
1. Drag the `ShopName` dimension from the dataset to the **X** section. The values will be displayed in the lower part of the chart on the X axis.
1. Drag the `count_clients` measure from the dataset to the **Y** section. This will display the values along the Y axis as a chart.

   ![image](../../_assets/datalens/concepts/multidataset-chart-2.png)

1. Under the dataset list, click **Add dataset** and select `count_sales_sql`.
1. In the window that opens, a link will be automatically created by the `ShopName` field. Click **Save**.

   ![image](../../_assets/datalens/concepts/multidataset-chart-3.png)

1. Drag the `count_sales` measure from the dataset to the **Y** section. This will display the values along the Y axis as a second chart.

   ![image](../../_assets/datalens/concepts/multidataset-chart-4.png)

1. At the top of the screen, click **Save**. In the resulting window, enter the following name for the chart: `Customers and sales by store - Line chart`. Then click **Save**.

   ![image](../../_assets/datalens/concepts/multidataset-chart-5.png)
