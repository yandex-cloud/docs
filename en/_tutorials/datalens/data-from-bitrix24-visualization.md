# Creating a Bitrix24 connection

In this tutorial, you'll connect to a demo Bitrix24 data source and get familiar with the dashboard and charts built by Bitrix24 based on {{ datalens-short-name }}. You'll also learn to work with datasets, charts, and dashboards.

The tutorial includes the following steps:

1. [Create a connection to Bitrix24](#step1).
1. [Review the dashboard and charts](#step2).
1. [Review the connection and datasets](#step3).


## Getting started {#before-you-begin}

{% include [before-you-begin](../includes/before-you-begin-datalens.md) %}


## Step 1. Create a connection to Bitrix24 {#step1}

1. Open the [{{ datalens-short-name }}]({{ link-datalens-main }}) home page and click **Create connection**.

1. Select the [**Bitrix24**]({{ link-datalens-main }}/connections/new/bitrix24) connection type.

1. To connect to a demo data source, specify:
   * **Portal**: `gds.office.bitrix.ru`
   * **Token**: `wJZIFjdYtbLRtfewYcnq71oSFyEgxlbQ`

   Leave the option **Automatically create a dashboard, charts, and a dataset on the connection** enabled.

1. Check the connection, and, if everything is fine, click **Create connection**.

1. Enter the name for the connection and click **Create**.

The connection has been created. Now you have the **Bitrix24** folder with the dashboard and nested folders **Leads** and **Deals** with datasets and charts inside.

## Step 2. Review the dashboard {#step7}

Open the **Bitrix24 dashboard**. The [dashboard](../../datalens/concepts/dashboard.md) is interactive, there you can:
* Set up a variety of filters.
* Sort rows in tables.
* Switch between charts.
* Drill down into charts.

You can see a copy of the main dashboard, so feel free to edit it as you like.

![bitrix24-dashboard](../../_assets/datalens/solution-14/bitrix24-dashboard.png)

For example on the dashboard's **Lead** page, let's change the **Dynamics in the number of leads by creation date** chart and add it to the dashboard:

1. Open the chart editor: click ![image](../../_assets/datalens/horizontal-ellipsis.svg) → **Edit**.

1. Change the chart type from **Stacked area chart** to **Bar chart**.

1. Drag the **Source** field to the **Colors** section.
   The chart shows the dynamics of lead generation by channels as a bar chart.
1. Save the resulting chart as an individual object:
   1. Click ![image](../../_assets/datalens/arrow-down.svg) → **Save as**.
   1. Select the location for the new chart and enter its name.
   1. Click **Save**.

   {% note tip %}

   To save the source chart by the edited one on the dashboard, click **Save** in the top right corner.

   {% endnote %}

1. Add the chart to your dashboard:
   1. Open the **Bitrix24 dashboard** and click **Edit** → **Add** → **Chart**.
   1. Enter a title for the chart to be shown on the dashboard, such as _Dynamics of leads by channels_.
   1. Select a relevant chart from the folder.
   1. Click **Add**.
   1. The dashboard is still in the editing mode: you can resize the new chart and move other items around it.
   1. Click **Save**.

![bitrix24-updated-dashboard](../../_assets/datalens/solution-14/bitrix24-updated-dashboard.png)

## Step 3. Review the connection and datasets {#step3}

Now, let's review the contents of the **Bitrix24** folder.

1. Go back to the Bitrix24 ![folder](../../_assets/datalens/folder.svg). In the navigation panel, select **Bitrix24**: it's one level up the open dashboard.

1. Besides the dashboard, the folder also includes two nested folders: **Leads** and **Deals**. Open the **Leads** folder:
   * ![chart](../../_assets/datalens/solution-14/chart.svg) includes [charts](../../datalens/concepts/chart/index.md), that is, individual reports.
   * ![dataset](../../_assets/datalens/solution-14/dataset.svg) is a [dataset](../../datalens/concepts/dataset/index.md), it describes the data model used to build the leads reporting.

1. Open the **Leads** dataset. Here for each field you can see its [type](../../datalens/concepts/data-types.md) and data source: some of them are taken from the Bitrix24 API and some, denoted as ![formula-dataset](../../_assets/datalens/formula-dataset.svg), are [calculated in {{ datalens-short-name }}](../../datalens/concepts/calculations/index.md).

Create a dataset based on Bitrix24 data. To do this:
1. In the left panel, select the **Datasets** icon and click it. You'll see a list of all your datasets in {{ datalens-short-name }}.
1. Click **Create dataset**.
1. In the **Sources** tab, click **+ Add** and select the Bitrix24 connection that you created in step 1.
   You can see a list of tables that can be updated from Bitrix24. Note the restriction for Bitrix24 tables: you can't [join](../../datalens/concepts/data-join.md) tables. But if you work with other connection types in {{ datalens-short-name }}, for example, with databases or files, no such restriction applies.
1. Select the `crm_activity` table and drag it to the working area. Wait for the data to load.
1. Go to the **Fields** tab. Here you can edit the dataset: rename its fields, create calculated fields, add descriptions. For the `ID` field, specify **Count** as the aggregation type and rename the field to `ID_COUNT`. Now you have an aggregate [measure field](../../datalens/concepts/chart/measure-values.md).
1. Click **Save**.
1. Enter a name for the dataset being created, then click **Create**.

Now let's build a chart for the created dataset.

1. Click **Create chart**.
1. Add the types of customer contacts on the chart. To do this, drag the `TYPE_NAME` field from the **Dimensions** section to the **X** section.
1. Add the number of interactions of each type to the chart. To do this, drag the `ID_COUNT` field from the Measures section to the **Y** section.

You can save your chart, create other charts based on it, or add it to the dashboard.