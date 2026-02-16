# Examples of creating QL charts



{% include [datalens-folder-navigation-note](../../_includes/datalens/datalens-folder-navigation-note.md) %}


In this tutorial, you will create charts using SQL queries. SQL queries enable you to configure data for visualization in a more flexible way than the standard dataset method does. For example, you can add parameters from dashboards to a SQL query.

We recommend using a [QL chart](../../datalens/concepts/chart/ql-charts.md) if creating a regular [chart](../../datalens/concepts/chart/dataset-based-charts.md) using a dataset does not suit you or if you want to experiment with the data.

A direct connection to a demo database will be used as your data source. 


To visualize and explore data, [set up {{ datalens-short-name }}](#before-you-begin) and follow the steps below:


1. [Create a workbook](#create-workbook).
1. [Create a connection](#create-connection).
1. [Create a QL chart](#create-sql-chart).
1. [Create a dashboard](#create-dashboard).
1. [Add the QL chart to the dashboard](#add-sql-chart-to-dashboard).
1. [Add selectors to the dashboard](#add-selectors-to-dashboard).

{% note warning %}

SQL queries only work with databases. File, GoogleSheets, Yandex Metrica, and other service connections do not support SQL queries.

{% endnote %}


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin-datalens.md) %}

## Create a workbook {#create-workbook}

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![collections](../../_assets/console-icons/rectangles-4.svg) **Collections and workbooks**.
1. In the top-right corner, click **Create** → **Create workbook**.
1. Enter a name for the [workbook](../../datalens/workbooks-collections/index.md): `Tutorials`.
1. Click **Create**.


## Create a connection {#create-connection}

A connection named **Sample ClickHouse** will be created for database access.

{% include [datalens-create-sample-connection](../../_includes/datalens/operations/datalens-create-sample-connection-wb_or_folder.md) %}

## Create a QL chart {#create-sql-chart}

Create a QL chart based on the `Sample ClickHouse` connection:

1. In the top-right corner of the connection page, click **Create dataset**.

   {% note info %}

   Make sure **Raw SQL level** → **Allow subqueries in datasets and queries from charts** is enabled.

   {% endnote %}

1. In the top-right corner, click **Create QL chart**.
1. On the **Query** tab, enter the query code:

   ```sql
   SELECT 
      toDate(t1.OrderDatetime) as "Date",
      COUNT(t1.ClientID) as "Number of new clients", t3.ClientStatus as "Status"
   FROM
      samples.MS_SalesFacts t1,
      (SELECT 
	      ClientID, 
         MIN(OrderDatetime) as FirstDate
      FROM samples.MS_SalesFacts
      GROUP BY ClientID) as t2,
         samples.MS_Clients t3
   WHERE not_var{{interval_from}} < "Date" and "Date" < not_var{{interval_to}} and t1.ClientID=t2.ClientID and t3.ClientID=t2.ClientID and t3.ClientStatus in not_var{{status}} -- status, interval_from and interval_to are variables linked to the parameters affected by the following selectors:
   GROUP BY "Status", "Date"
   ORDER BY "Date"
   ```

1. On the **Parameters** tab, click **Add parameter** and complete the input fields:

   * From the drop-down list, select `string` (default).
   * In the **Name** field, enter `status`.
   * In the **Default value** field, enter `Gold`.
   * Click **Add value** below and enter `Silver`.
   * Click **Add value** below and enter `Basic`.

     ![sql-chart-parameter](../../_assets/datalens/sql-chart/sql-chart-parameter.png)

   The added parameter will be linked to the `not_var{{status}}` variable in the query.

1. Click **Add parameter** and complete the input fields:

   * From the drop-down list, select `date-interval`.
   * In the **Name** field, enter `interval`.
   * Click the field with the interval value and in the window that opens, specify:

     * **From:** `01.03.2017`
     * **To:** `31.03.2017`

       ![sql-chart-parameter-data2](../../_assets/datalens/sql-chart/sql-chart-parameter-data2.png)

     * Click **Apply**.

     The **From:** and **To:** values of the added parameter will be linked to the `not_var{{interval_from}}` and `not_var{{interval_to}}` variables in the SQL query, respectively.

     {% note info %}
   
     You can control the parameter values using dashboard selectors.

     {% endnote %}

1. Go back to the **Query** tab. In the bottom-left corner, click **Start**. Running the query will produce a visualization in the right-hand window.

   ![sql-chart-diagram](../../_assets/datalens/sql-chart/sql-chart-diagram.png)

1. Configure the visualization:

   * Make sure the **X** section contains the `Date` field; otherwise, drag it from the **Available** section.
   * Make sure the **Y** section contains the `Number of new clients` field; otherwise, drag it from the **Available** section.
   * Add color division of clients by status to the chart. To do this, drag the `Status` field from the **Available** section to the **Colors** section.

     ![sql-chart-rezult](../../_assets/datalens/sql-chart/sql-chart-rezult.png)

1. Save the chart:

   1. In the top-right corner, click **Save**.
   1. In the window that opens, enter `New clients` for chart name and click **Save**.

You can place the chart created on the dashboard. You can also add selectors to the dashboard to manage the values of the `status` and `interval` QL chart parameters.

## Create a dashboard {#create-dashboard}

Create a [dashboard](../../datalens/concepts/dashboard.md) to add charts and other widgets to:


1. In the left-hand panel, select ![collections](../../_assets/console-icons/rectangles-4.svg) **Collections and workbooks** and go to the `Tutorials` workbook.
1. In the top-right corner, click **Create** → ![image](../../_assets/console-icons/layout-cells-large.svg) **Dashboard**.



## Add the QL chart to the dashboard {#add-sql-chart-to-dashboard}

1. In the panel at the bottom of the page, hold down ![image](../../_assets/console-icons/chart-column.svg) **Chart** and drag it to the required area.

   ![add-chart](../../_assets/datalens/sql-chart/add-chart.png)

1. In the window that opens, click **Select**.
1. Select the `New clients` chart.

   ![image](../../_assets/datalens/sql-chart/select-chart.png)

1. Click **Add**.
1. Adjust the size of the chart with your mouse and place it on the dashboard as you prefer.

   ![image](../../_assets/datalens/sql-chart/add-chart-on-dashboard.png)

## Add selectors to the dashboard {#add-selectors-to-dashboard}

Add [selectors](../../datalens/dashboard/selector.md) to filter charts by date and client statuses:

1. In the panel at the bottom of the page, hold down ![image](../../_assets/console-icons/sliders.svg) **Selector** and drag it to the required area.

   ![image](../../_assets/datalens/sql-chart/add-selector.png)

1. Add a selector for client status:

   1. In the **Source** list, select `Manual input`.
   1. In **Field or parameter**, enter `status`. Certain selector values will be passed into this SQL query variable.
   1. Choose `List` as your selector type.   
   1. Enable **Multiple choice**.
   1. Next to the **Possible values** parameter, click **Add**. In the resulting window, add the following values:

      * Gold
      * Silver
      * Basic

      ![image](../../_assets/datalens/sql-chart/add-selector-values.png)

      Click **Apply**.

   1. In the **Default value** list, specify **Select all**.

      ![image](../../_assets/datalens/sql-chart/add-selector-select-all.png)

   1. In the **Header** field, enter `Select client status`.
   1. Click **Save**.

      ![image](../../_assets/datalens/sql-chart/add-selector-parameters.png)

1. Add the calendar selector to filter by date range:

   1. In the **Source** list, select `Manual input`.
   1. In **Field or parameter**, enter `interval`. The start and end values of the interval from the selector will be provided to the `not_var{{interval_from}}` and `not_var{{interval_to}}` variables of the SQL query.
   1. Choose `Calendar` as your selector type.
   1. Enable **Range**.
   1. In the **Header** field, enter `Order interval`.
   1. Click **Save**.

      ![image](../../_assets/datalens/sql-chart/add-selector-data-parameters.png)

1. Position the selectors on the dashboard however you like.
1. Save the dashboard:

   1. In the top-right corner of the dashboard, click **Save**.
   1. Enter `Change in number of clients by year` as the dashboard name and click **Create**.

Your dashboard is ready.

   ![image](../../_assets/datalens/sql-chart/add-selector-on-dashboard.png)

1. Your dashboard is ready. Now you can filter the chart by status using a selector.
   
   ![image](../../_assets/datalens/sql-chart/selector-2-values.png)

   You can also filter the chart by a date range using the second selector.

   ![image](../../_assets/datalens/sql-chart/selector-data-2-values.png)

#### See also {#see-also}

- [{#T}](../../datalens/operations/dashboard/add-chart.md)
- [{#T}](../../datalens/operations/dashboard/add-selector.md)
- [{#T}](../../datalens/operations/chart/create-sql-chart.md)
- [QL charts](../../datalens/concepts/chart/index.md#sql-charts)
