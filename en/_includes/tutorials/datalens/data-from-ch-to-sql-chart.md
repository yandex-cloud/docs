# Visualizing data with a SQL chart

In this scenario, you will create charts using SQL queries. SQL queries enable you to configure data for visualization in a more flexible way than the standard dataset method does. For example, you can add parameters from dashboards to a SQL query.

We recommend using a SQL chart when creating a conventional chart from a dataset isn't suitable, or when you would like to experiment with data.

A direct connection to a demo database will be used as your data source.

To visualize and analyze data, make sure you have a [ready-to-use cloud](#before-you-begin) and follow these steps:

1. [Create a connection](#create-connection).
1. [Create a SQL chart](#create-sql-chart).
1. [Create a dashboard](#create-dashboard).
1. [Add the SQL chart to the dashboard](#add-sql-chart-to-dashboard).
1. [Add a selector to the dashboard](#add-selector-to-dashboard).

{% note warning %}

* SQL queries only work with databases. CSV, GoogleSheets, Yandex Metrica, and other service connections do not support SQL queries.

* SQL charts are currently available on non-public dashboards only. If you open a [public dashboard](../../../datalens/concepts/datalens-public.md), you will see an error in the chart.

{% endnote %}

## Before you start {#before-you-begin}

{% include [before-you-begin](../includes/before-you-begin-datalens.md) %}

## Create a connection {#create-connection}

{% include [datalens-create-sample-connection](../../datalens/operations/datalens-create-sample-connection.md) %}

## Create a SQL chart {#create-sql-chart}

1. Go to an existing database connection.
1. Make sure **Raw SQL level** → **Allow subqueries in datasets and queries from charts** is enabled.
1. In the upper right-hand corner, click **Create SQL chart**.
1. On the **Query** tab, enter the query code:

   ```sql
   SELECT 
      year(t2.FirstDate) as "Year",
      COUNT(t1.ClientID) as "Number of new  clients", t3.ClientStatus as "Status"
   FROM
      samples.MS_SalesFacts t1,
      (SELECT 
   	      ClientID, 
         MIN(OrderDatetime) as FirstDate
      FROM samples.MS_SalesFacts
      GROUP BY ClientID) as t2,
         samples.MS_Clients t3
   WHERE t1.ClientID =t2.ClientID and t3.ClientID=t2.ClientID and t3.ClientStatus in not_var{{status}} -- status: variable associated with parameter affected by selector
   GROUP BY "Year", "Status"
   ORDER BY "Year"
   ```

1. On the **Params** tab, click **Add param** and complete the input fields:

   * From the drop-down list, select `string` (default).
   * In the **Name** field, enter `status`.
   * In the **Default value** field, enter `Базовый`.
   * Below, click **Add param value** and enter `Золотой`.

     ![sql-chart-parameter](../../../_assets/datalens/sql-chart/sql-chart-parameter.png)

   The added parameter will be associated with the `not_var{{status}}` variable in the query.

   {% note info %}

   You can control the value of the parameter using a dashboard selector.

   {% endnote %}

1. Go back to the **Query** tab. In the lower left-hand corner, click **Run**. Running the query will produce a visualization in the right-hand window.
1. Configure the visualization:

   * Select **Column chart** as chart type.

     ![sql-chart-diagram](../../../_assets/datalens/sql-chart/sql-chart-diagram.png)

   * Drag the **Year** field to the **X** section.
   * Drag the **Number of new clients** field to the **Y** section.
   * Drag the **Status** field to the **Colors** section.
   * Make sure the **Available** section is empty. This is the section that contains fields not involved in calculations. Otherwise, the visualization will display incorrectly.

     ![sql-chart-rezult](../../../_assets/datalens/sql-chart/sql-chart-rezult.png)

1. In the upper right-hand corner, click **Save**.

You can place the chart created on the dashboard. You can also add a selector to the dashboard to control the SQL chart `status` parameter.

## Create a dashboard {#create-dashboard}

Create a [dashboard](../../../datalens/concepts/dashboard.md) to add your charts to.

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. Click **Create dashboard**.

   ![image](../../../_assets/datalens/solution-02/35-create-dashboard.png)

1. Enter `Change in number of clients by year` as the name for the dashboard and click **Create**.

   The dashboard created will open for editing.

## Add a SQL chart to your dashboard {#add-sql-chart-to-dashboard}

1. At the top of the page, click **Add** and select **Chart**.

   ![image](../../../_assets/datalens/sql-chart/add-chart.png)

1. In the **Chart** field, click **Select** and select the previously created **New clients** chart from the chart list.

   ![image](../../../_assets/datalens/sql-chart/select-chart.png)

   Click **Add**.

1. The chart is displayed on the dashboard. Stretch it to improve visualization.

   ![image](../../../_assets/datalens/sql-chart/add-chart-on-dashboard.png)

1. Save the dashboard.

## Add a selector to the dashboard {#add-selector-to-dashboard}

Add a [selector](../../../datalens/concepts/dashboard.md#selector) to be able to filter charts by customer status.

1. At the top of the page, click **Add**.
1. Choose **Selector**.

   ![image](../../../_assets/datalens/sql-chart/add-selector.png)

1. In the **Title** field, enter `Select client status`.
1. Enable the **Show** option.
1. Select **Manual input** as source type.
1. Select **List** as element type.
1. In the **Field name** field, enter `status`. Certain selector values will be passed into this SQL query variable.
1. Click on the **Possible values** input field. In the resulting window, add:

   * Золотой
   * Серебряный
   * Базовый

   ![image](../../../_assets/datalens/sql-chart/add-selector-values.png)

   Click **Apply**.

1. Enable **Multiple choice**.
1. In the **Default value** list, specify **Select all**.

   ![image](../../../_assets/datalens/sql-chart/add-selector-select-all.png)

1. Verify the specified selector parameters.

   ![image](../../../_assets/datalens/sql-chart/add-selector-parameters.png)

1. Click **Add**.
1. Place the selector above the chart on the dashboard and stretch to match the width of the chart.
1. Save the dashboard.

   ![image](../../../_assets/datalens/sql-chart/add-selector-on-dashboard.png)

1. Your dashboard is ready. Now, you can filter the chart using the selector.

   ![image](../../../_assets/datalens/sql-chart/selector-2-values.png)

#### See also {#see-also}

- [{#T}](../../../datalens/operations/dashboard/add-chart.md)
- [{#T}](../../../datalens/operations/dashboard/add-selector.md)
- [SQL charts](../../../datalens/concepts/chart/index.md#sql-charts)

