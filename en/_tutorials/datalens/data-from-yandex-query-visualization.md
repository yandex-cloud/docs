# Visualizing {{ objstorage-full-name }} data in {{ datalens-full-name }}

{{ yq-full-name }} and {{ datalens-full-name }} integration allows you to visualize data stored in {{ objstorage-full-name }}. {{ datalens-short-name }} generates a YQL query, while {{ yq-full-name }} runs the query and returns the results, which are visualized using charts.

For the solution architecture, see below.

![datalens-architecture](../../_assets/datalens/data-lens-architecture.png)

As an example, let's visualize how the time of day affects the number and average cost of New York City yellow taxi trips. The data was previously uploaded to {{ objstorage-full-name }} and stored in a public bucket named `yq-sample-data`, in the `nyc_taxi_csv` folder.

{% note info %}

{% include [yellow-taxi-disclaimer](../../_includes/datalens/yellow-taxi-disclaimer.md) %}

{% endnote %}

To visualize and explore data, [set up your cloud](#before-you-begin) and follow the steps below:

1. [Connect to data in {{ objstorage-name }}](#create_connection).
1. [Create a connection in {{ datalens-full-name }}](#create_connection_lens).
1. [Configure the dataset fields](#create_dataset).
1. [Configure visualization](#create_comdo_chart).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% note info %}

To create a {{ datalens-short-name }} connection to {{ yq-full-name }}, you need a [service account](../../iam/concepts/users/service-accounts.md) with the `{{ roles-editor }}` [role](../../iam/operations/sa/assign-role-for-sa.md) for the folder where the {{ objstorage-short-name }} [bucket](../../storage/concepts/bucket.md) [connection will be created](#create_connection).

{% endnote %}

## Connect to data in {{ objstorage-name }} {#create_connection}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [connection](../../query/concepts/glossary.md#connection).

   ![select-catalog](../../_assets/datalens/yandex-query-visualization/select-catalog.png)

1. In the list of services, select **{{ yq-full-name }}**.

   ![select-yq](../../_assets/datalens/yandex-query-visualization/select-yq.png)

1. In the left-hand panel, select ![study](../../_assets/query/study.svg) **Tutorial**.
1. Click **Create connection**. In the Create connection section, all parameter fields are filled out, just type a description (optional) and click **Create**. You'll be taken to the screen for creating data [binding](../../query/concepts/glossary.md#binding).
1. Type a description of data binding (optional) and click **Create**. Appropriate training resources are created.

## Create a connection in {{ datalens-full-name }} {#create_connection_lens}

To create a {{ yq-full-name }} connection:

1. Go to the {{ datalens-short-name }} [homepage]({{ link-datalens-main }}).
1. On the home page, click **Create connection**.
1. Select a **{{ yq-full-name }}** connection.
1. Specify the connection parameters:

   * **Cloud and folder**: Select the folder where your service account is located.
   * **Service account**: Select an existing [service account](../../iam/concepts/users/service-accounts.md) or create a new one.
   * **Cache TTL in seconds**: Specify the cache time-to-live or leave the default value.
   * **Raw SQL level**: Select **Allow subqueries in datasets and queries from charts**.

1. Click **Create connection**.
1. Enter the `yq-connect` connection name and click **Create**.

## Set up the dataset fields {#create_dataset}

1. In the top-right corner of the page where you created the connection, click **Create dataset**.

   ![create-dataset](../../_assets/datalens/yandex-query-visualization/create-dataset.png)

1. In the window that opens, enter the query text provided below and click **Create**.

   ```sql
   SELECT
       *
   FROM
       bindings.`tutorial-analytics`
   ```

   If everything is set up correctly, the **Preview** section in the lower part of the screen will contain the following data:

   ![dataset-results](../../_assets/datalens/yandex-query-visualization/datalens-dataset-results.png)

1. Create a calculated field with the pick-up time data:

   1. Go to the **Fields** tab and click **Add field**.

      ![create-field](../../_assets/datalens/yandex-query-visualization/create-field.png)

   1. In **Field name**, specify `hour_trip`.
   1. In the formula line, enter:

      ```
      HOUR([tpep_pickup_datetime])
      ```

   1. Click **Create**. The new `hour_trip` field will appear in the dataset field list.

1. In the **Aggregation** column, select the `Average` aggregation type for the **total_amount** field.

   ![field-agg](../../_assets/datalens/yandex-query-visualization/field-agg.png)

1. In the top-right corner, click **Save**. Enter the dataset name: `yellow-taxi-dataset`, and click **Create**.
1. When the dataset is saved, click **Create chart** in the top-right corner.

   ![create-chart](../../_assets/datalens/yandex-query-visualization/create-chart.png)

## Configure visualization {#create_comdo_chart}

To visualize and analyze the data, use a [combined](../../datalens/visualization-ref/combined-chart.md) [chart](../../datalens/concepts/chart/index.md).

1. For the visualization type, choose **Combined chart**.

   ![chart-type](../../_assets/datalens/yandex-query-visualization/chart-type.png)

1. Drag the `hour_trip` dimension to the **X** section. In the **X** section, the dimension will be common for all layers.
1. For the first layer, choose **Bar chart**.

   ![select-layer-column](../../_assets/datalens/yandex-query-visualization/select-layer-column.png)

1. Drag the `total_amount` measure to the **Y** section. You will see a bar chart in the visualization area.
1. Add a layer. To do this, click ![plus](../../_assets/datalens/plus.svg) to the right of the first layer's name.
1. For the second layer, choose **Line chart**.

   ![select-layer-line](../../_assets/datalens/yandex-query-visualization/select-layer-line.png)

1. Add a field to the chart:

   1. In the left-hand panel, click ![plus](../../_assets/datalens/plus.svg) and select **Field**.

      ![chart-add-field](../../_assets/datalens/yandex-query-visualization/chart-add-field.png)

   1. In the window that opens:

      * In **Field name**, enter `count_trip`.
      * In the formula line, enter `COUNT()`.

         ![chart-field-create](../../_assets/datalens/yandex-query-visualization/chart-field-create.png)

   1. Click **Create**.

1. Drag the `count_trip` measure to the **Y2** section. You will see a line chart on top of the first chart in the visualization area.
1. In the top-right corner, click **Save**. Enter the chart name: `yellow-taxi-combo-chart`, and click **Save**.

The chart you created shows how the time of day affects the number of trips (line chart) and the average trip cost (bar chart).

![datalens-yq-combo-chart](../../_assets/datalens/yandex-query-visualization/datalens-yq-combo-chart.png)

In the same way, you can create additional [charts](../../datalens/operations/chart/create-chart.md) and [dashboards](../../datalens/operations/dashboard/create.md) or [share the results](../../datalens/concepts/datalens-public.md) with your teammates.
