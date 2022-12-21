# Getting started with {{ datalens-short-name }}


In this tutorial, you'll create your first [dataset](concepts/dataset/index.md), build several [charts](concepts/chart/index.md) to visualize data, and place them on a [dashboard](concepts/dashboard.md).



{% include [before-you-begin](../_tutorials/includes/before-you-begin-datalens.md) %}


## Create a connection {#create-connection}

{% include [datalens-create-sample-connection](../_includes/datalens/operations/datalens-create-sample-connection.md) %}

## Create a dataset {#create-dataset}

1. In the upper-right corner, click **Create dataset**.
1. Drag the **MS_SalesMiniTable** table to the workspace.

   ![drag-table](../_assets/datalens/quickstart/02-drag-table.png)

1. Go to the **Fields** tab.
1. In the **Aggregation** column, select **Sum** for the **Sales** field.
1. Create a measure for the number of orders.
   1. Rename the **OrderID** field to **OrderCount**.
   1. Change the aggregation type to **Number of unique**.
1. For the **ShopAddressCoord** field, change the data type to **Geopoint**.
1. Click **Save** in the upper-right corner to save the dataset.
1. Enter the dataset name and click **Create**.

   ![create-dataset](../_assets/datalens/quickstart/03-create-dataset.png)

## Create a column chart {#create-column-chart}

1. In the upper-right corner, click **Create chart**.
1. For the visualization type, choose **Bar chart**.
1. Add the product subcategory to the chart. To do this, drag the **ProductSubcategory** field from the **Dimensions** section to the **X** section.
1. Add a sales measure to the chart. To do this, drag the **Sales** field from the **Measures** section to the **Y** section.
1. Sort the chart in descending order of sales measure. Drag the **Sales** field from the **Measures** section to the **Sorting** section.
1. Save the chart.
   1. In the upper-right corner, click **Save**.
   1. In the window that opens, enter the **Sales by subcategory** name for the chart and click **Save**.

   ![create-chart-1](../_assets/datalens/quickstart/04-create-column-chart.png)

## Create a stacked area chart {#create-area-chart}

1. In the created chart, select **Stacked area chart** as the visualization type.
1. Replace the product subcategories with the order date on the X-axis. To do this, drag the **OrderDate** field from the **Dimensions** section to the **X** section and hold it over the **ProductSubcategory** field until it turns red.
1. Add the product category to the chart. To do this, drag the **ProductCategory** field from the **Dimensions** section to the **Colors** section.
1. Display the chart by week.
   1. Click the calendar icon next to the **OrderDate** field in the **X** section.
   1. In the drop-down list of grouping options, select **Week** under **Grouping**.
   1. Click **Apply**.
1. Save the chart.
   1. Click the down arrow next to the **Save** button in the upper-right corner.
   1. Choose **Save as**.
   1. In the window that opens, enter the **Sales by week** name for the new chart and click **Save**.

   ![create-chart-2](../_assets/datalens/quickstart/05-create-area-chart.png)

## Create a map {#create-map-chart}

1. In the created chart, select **Map** as the visualization type.
1. Add the coordinates of the points of sale to the map. To do this, drag the **ShopAddressCoord** field from the **Dimensions** section to the **Geopoints** section.
1. Change the point size based on the number of orders. To do this, drag the **OrderCount** field from the **Measures** section to the **Size** section.
1. Change the point color based on the sales measure. To do this, drag the **Sales** field from the **Measures** section to the **Colors** section.
1. Add the following fields to the **Tooltips** section:
   * ShopAddress
   * ShopName
   * Sales
   * OrderCount
1. Save the chart.
   1. Click the down arrow next to the **Save** button in the upper-right corner.
   1. Choose **Save as**.
   1. In the window that opens, enter the **Sales map** name for the new chart and click **Save**.

   ![create-chart-3](../_assets/datalens/quickstart/06-create-map-chart.png)

## Create a dashboard {#create-dashboard}

1. Go to the {{ datalens-short-name }} [homepage]({{ link-datalens-main }}).
1. Click **Create dashboard**.
1. Enter a name for the dashboard and click **Create**.

## Add charts to the dashboard {#add-charts}

1. In the upper-right corner, click **Add** and choose **Chart**.
1. In the window that opens, click **Select**.
1. Select the **Sales map** chart. This will automatically fill in the **Name** field.
1. Click **Add**.
1. Repeat the steps to add the **Sales by subcategory** and the **Sales by week** charts.
1. Position the charts on the dashboard however you like.

   ![add-charts](../_assets/datalens/quickstart/07-add-charts.png)

## Add a selector to the dashboard {#add-selectors}

1. Click **Add** and choose **Selector**.
1. Add the calendar selector for the order date.
   1. Select the created dataset.
   1. Select the **OrderDate** field.
   1. This will automatically fill in the **Name** field. Click the **Show** checkbox next to the selector title.
   1. Select the **Calendar** type.
   1. Enable **Range**.
   1. Click **Add**.
1. Position the selector on the dashboard wherever you like.
1. Save the dashboard. To do this, click **Save** in the upper-right corner.

   ![add-selectors](../_assets/datalens/quickstart/08-add-selectors.png)



## What's next {#whats-next}

* Review the [tutorials](tutorials/index.md) for examples of using the service.
* Read about [service concepts](concepts/index.md).
* See [step-by-step instructions](operations/index.md).
* View an [example of a ready-to-use dashboard](https://datalens.yandex/9fms9uae7ip02).
