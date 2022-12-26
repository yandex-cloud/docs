# Creating and publishing a chart with a map of Moscow from a CSV file

You can use {{datalens-short-name }} to grant public access to your charts and dashboards.

{% note warning %}

Before publishing your own data, make sure that your charts and dashboards don't contain personal data or trade secrets. Access to published data is not restricted.

{% endnote %}

In this scenario, we'll use {{ datalens-short-name }} to visualize the measures of the Moscow population on the Moscow district map and publish them to DataLens Public.

The file [Moscow Population 2018.csv](https://yadi.sk/d/H4dQKVDpU4Rd8g) is used as the source of data on the Moscow population and area for 2018. Source: [List of districts and settlements in Moscow](https://ru.wikipedia.org/wiki/%D0%A1%D0%BF%D0%B8%D1%81%D0%BE%D0%BA_%D1%80%D0%B0%D0%B9%D0%BE%D0%BD%D0%BE%D0%B2_%D0%B8_%D0%BF%D0%BE%D1%81%D0%B5%D0%BB%D0%B5%D0%BD%D0%B8%D0%B9_%D0%9C%D0%BE%D1%81%D0%BA%D0%B2%D1%8B).

To visualize and analyze data, [set up {{ datalens-short-name }}](#before-you-begin) and follow these steps:

1. [Create a connection](#step1).
1. [Create a dataset](#step2).
1. [Create a chart with a map of the various Moscow districts](#step3).
1. [Publish the chart to DataLens Public](#step4).


## Before you start {#before-you-begin}

{% include [before-you-begin](../includes/before-you-begin-datalens.md) %}


## Step 1. Create a connection and a dataset {#step1}

Create a dataset based on the [connection](../../datalens/concepts/connection.md) to the CSV file.

1. Go to the [{{ datalens-short-name }}]({{ link-datalens-main }}) home page.

1. Click **Create connection**.

    ![image](../../_assets/datalens/solution-05/01-create-connection.png)

1. Choose **CSV**.

    ![image](../../_assets/datalens/solution-05/02-CSV.png)

1. Click **Select CSV file**.

    ![image](../../_assets/datalens/solution-05/03-choose-CSV.png)

1. Select a file. For this example, use **Moscow Population 2018.csv** ([download link](https://yadi.sk/d/H4dQKVDpU4Rd8g)).

1. Wait until the table content appears on the screen.

1. Click **Create**.

    ![image](../../_assets/datalens/solution-05/04-save-connection.png)

1. After the connection is created, click **Create dataset**.

    ![image](../../_assets/datalens/solution-05/05-create-dataset.png)

## Step 2. Create a dataset {#step2}

1. If the workspace is empty, drag the **Moscow Population 2018.csv** spreadsheet from the selection panel to the workspace.

    ![image](../../_assets/datalens/solution-05/06-drag-table.png)

1. Go to the **Fields** tab.

    ![image](../../_assets/datalens/solution-05/07-dataset-tab.png)

1. For the fields **Area**, **Population**, and **Housing stock**, specify **Sum** as the aggregation type.

    ![image](../../_assets/datalens/solution-05/08-change-aggregation.png)

    The fields with the defined aggregate functions become measures and change their color to blue.

    ![image](../../_assets/datalens/solution-05/09-measures.png)

1. For the **District coordinates** field, change the data type to **Geopolygon**.

    ![image](../../_assets/datalens/solution-05/10-geopoligon.png)

1. In the upper-right corner, click **Save**.

    ![image](../../_assets/datalens/solution-05/11-save-dataset.png)

1. In the resulting window, enter **Moscow population** as the name for the dataset and click **Create**.

1. When the dataset is saved, click **Create chart**.

    ![image](../../_assets/datalens/solution-05/12-create-chart.png)

## Step 3. Create a chart with a map of Moscow districts {#step3}

1. Select the **Map** visualization type.

    ![image](../../_assets/datalens/solution-05/13-choose-map.png)

1. Select **Polygons (Geopolygons)** as the layer type.

   ![image](../../_assets/datalens/solution-05/13-1-choose-map-geo.png)

1. Add polygons of districts to the map. To do this, drag the **District coordinates** field from the **Dimensions** to the **Polygons (Geoplygons)** section.

    ![image](../../_assets/datalens/solution-05/14-use-coordinates.png)

1. Change the district colors based on the population. Drag the **Population** field from the **Measures** section to the **Colors** section.

    ![image](../../_assets/datalens/solution-05/15-use-measure.png)

1. In the upper-right corner, click **Save**.

    ![image](../../_assets/datalens/solution-05/15-1-save-chart.png)

1. In the window that opens, enter the name **Moscow population map by district** for the chart and click **Save**.

## Step 4. Publish the chart to DataLens Public {#step4}

1. Click ![image](../../_assets/datalens/horizontal-ellipsis.svg) and in the resulting list, select **Public access**.

    ![image](../../_assets/datalens/solution-05/16-share-button.png)

1. In the resulting **Public access settings** window, enable **Access via link**.

    ![image](../../_assets/datalens/solution-05/17-share1.png)

1. Confirm publication of the chart and its linked data.

1. Copy the unique URL of the chart. Click **Apply**.

    ![image](../../_assets/datalens/solution-05/18-share2.png)

1. Open a new tab in the browser and go to the copied link.

    ![image](../../_assets/datalens/solution-05/19-public.png)

You can share this link with your colleagues, partners, and friends. DataLens Public doesn't require authorization or authentication when the user follows the chart link.

**Also try:**

- Building a column chart by district and population.
- [Creating a dashboard](../../datalens/operations/dashboard/create.md) with a map, a column chart, and [selectors](../../datalens/operations/dashboard/add-selector.md).
- [Publishing a dashboard](../../datalens/operations/dashboard/publish.md).

