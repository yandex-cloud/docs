# Visualizing geodata from a CSV file

This scenario analyzes public data on road accidents in Russia. In addition to identifying the facts of accident statistics in Russia, during the analysis you'll learn how to:

- Work with the {{ datalens-short-name }} key entities: Connections, Datasets, Charts, and Dashboards.
- Combine multiple sources at the level of a single dataset.
- Use the `Date and time` data type and edit chart-level groupings.
- Work with geodata: geopoints and geopolygons.
- Create public dashboards that will be available to everyone from any device without authentication.

To visualize and analyze the data, [make sure you have a ready-to-use cloud](data-from-csv-geo-visualization.md#before-you-begin) and follow these steps:

1. [Create a connection to a CSV file](data-from-csv-geo-visualization.md#step1).
1. [Create a dataset and configure its fields](data-from-csv-geo-visualization.md#step2).
1. [Create your first chart: a heat map](data-from-csv-geo-visualization.md#step3).
1. [Create your second chart: a bar chart](data-from-csv-geo-visualization.md#step4).
1. [Create line charts](data-from-csv-geo-visualization.md#step5).
1. [Create a dashboard](data-from-csv-geo-visualization.md#step6).
1. [Add charts to the dashboard](data-from-csv-geo-visualization.md#step7).
1. [Add selectors and create a dashboard](data-from-csv-geo-visualization.md#step8).
1. [Connect an additional source with region geolayers](data-from-csv-geo-visualization.md#step9).
1. [Add new fields to the dataset](data-from-csv-geo-visualization.md#step10).
1. [Create a chart using the new fields](data-from-csv-geo-visualization.md#step11).
1. [Add the new chart to the dashboard](data-from-csv-geo-visualization.md#step12).
1. [Publish the dashboard](data-from-csv-geo-visualization.md#step13).

## Before you start {#before-you-begin}

To use {{ datalens-short-name }}, you have to sign up for {{ yandex-cloud }} and create a billing account (without a billing account, {{ datalens-short-name }} is only available in demo mode):

1. Go to the [management console]({{ link-console-main }}). Then log in to {{ yandex-cloud }} or sign up if you don't have an account yet.

1. [On the billing page]({{ link-console-billing }}) make sure that a [billing account](https://cloud.yandex.com/docs/billing/concepts/billing-account) is linked and that its status is `ACTIVE` or `TRIAL_ACTIVE`. If you don't have a billing account, [create one](https://cloud.yandex.com/docs/billing/quickstart/#create_billing_account).

When you activate your billing account, you automatically switch to the **Free** {{ datalens-short-name }} plan. By default, you can create a {{ datalens-short-name }} instance for no more than 1 folder. If you haven't done this yet:

1. Select a folder on the [cloud page](https://console.cloud.yandex.com/cloud).
1. Select the **DataLens** service.
1. Click **Activate DataLens**.

An instance of the service is created in the selected folder and you can go directly to the {{ datalens-short-name }} interface.

[Learn more about clouds and folders](https://cloud.yandex.com/docs/resource-manager/concepts/resources-hierarchy).

## Step 1. Create a connection to a CSV file {#step1}

1. Download [public accident statistics](https://xn--80abhddbmm5bieahtk5n.xn--p1ai/opendata) in CSV format. As of writing these instructions in February 2020, the most current dataset was for 2018. Unpack the downloaded archive. You can also download a [ready-to-use file](https://yadi.sk/d/zgo7RgjFWSMiyg) with data for 2018.

   ![image](../../_assets/datalens/solution-07/01-files.png)

1. Open the [{{ datalens-short-name }}](https://datalens.yandex.com/) homepage and click **Create connection**.

   ![image](../../_assets/datalens/solution-07/02-create-connection.png)

1. Select the **CSV** connection type.

   ![image](../../_assets/datalens/solution-07/03-choose-csv.png)

1. Click **Select CSV file** and select the downloaded file. It may take up to several minutes to load it, depending on the speed of your internet connection.

   ![image](../../_assets/datalens/solution-07/04-choose-file.png)

   When loaded, you'll see a preview of the file data. To view it, use the scroll bars on the right and at the bottom.

   ![image](../../_assets/datalens/solution-07/05-preview.png)

1. In the upper-right corner, click **Create**.

   ![image](../../_assets/datalens/solution-07/06-create.png)

The connection to the CSV file is created. The data is presented in the same form as in the file. To use it, you need to create a dataset.

## Step 2. Create a dataset and configure its fields {#step2}

The dataset will consist of a single source: the CSV file.

1. Click **Create dataset**.

   ![image](../../_assets/datalens/solution-07/07-create-dataset.png)

1. Go to the **Fields** tab.

   ![image](../../_assets/datalens/solution-07/08-dataset.png)

   Here you can add [data fields](https://cloud.yandex.com/docs/datalens/concepts/dataset/data-model#field) and [calculated fields](https://cloud.yandex.com/docs/datalens/concepts/calculations), change field data types and aggregation rules, as well as rename fields.

   ![image](../../_assets/datalens/solution-07/09-rename.png)

1. Change the field names to Russian ones in the following order:
   - Region code
   - Region name
   - Road code
   - Road name
   - Road type
   - OKTMO code
   - Address
   - Accident type

   ![image](../../_assets/datalens/solution-07/10-rename-attributes.png)

1. The accident date and time are shown in the following fields:
   - crash_date: The date in numeric format like `20190218`.
   - crash_time: The time written like `19:34`.

   They won't be used in the dataset in this form. Click the visibility icon to hide them.

   ![image](../../_assets/datalens/solution-07/11-hide-attributes.png)

1. To display information about the accident date and time, add a new field.

   1. Click **Add field**.

      ![image](../../_assets/datalens/solution-07/12-add-field.png)

   1. Specify the following data for it:
      - **Name**: Date and time
      - **Formula**: `datetime_parse(str([crash_date])+'-'+str([crash_time]))`

      ![image](../../_assets/datalens/solution-07/13-tune-field.png)

      {% note tip %}

      To review the documentation for these functions yourself, click **Reference**.

      {% endnote %}

   1. Click **Create**.

   The preview section now correctly displays the accident date and time as a value of the `Date and time` type. The new **Date and time** field is at the top of the table. Click ![image](../../_assets/datalens/formula-dataset.svg) to edit the field formula.

   ![image](../../_assets/datalens/solution-07/14-date-and-time.png)

1. Continue renaming the fields in the following order:
   - Cause of accident
   - Number of victims
   - Death toll
   - Number of vehicles
   - Number of participants

   Set the **Sum** aggregation type for the following fields:
   - Number of victims
   - Death toll
   - Number of vehicles
   - Number of participants

   ![image](../../_assets/datalens/solution-07/15-sum.png)

1. Add a field to display a geopoint.

   1. Click **Add field** at the top right.

      ![image](../../_assets/datalens/solution-07/12-add-field.png)

   1. Enter data for the new field:
      - **Name**: Geopoint
      - **Formula**: `GEOPOINT([latitude],[longitude])`

      where [latitude] and [longitude] are dataset fields.

      ![image](../../_assets/datalens/solution-07/16-new-field-geopoint.png)

   1. Click **Create**.

      {% note info %}

      The example is based on ready-to-use data in coordinate format. In other cases, to convert data to coordinate format, you can use the [geocoding](https://cloud.yandex.com/docs/datalens/function-ref/GEOCODE) function.

      {% endnote %}

   1. Make sure that the table and preview contain the new `Geopoint` type field.

      ![image](../../_assets/datalens/solution-07/17-geopoint.png)

1. Add a field to display the number of accidents.

   1. Click **Add field**.

      ![image](../../_assets/datalens/solution-07/12-add-field.png)

   1. Enter data for the new field:
      - **Name**: Number of accidents
      - **Formula**: `SUM(1)`

      ![image](../../_assets/datalens/solution-07/18-new-field-count-DTP.png)

   1. Click **Create**.

   You don't need to set the aggregation type for this field: when you add it to the chart, {{ datalens-short-name }} applies the aggregation function automatically.

1. Add a field for data on deaths in road accidents.

   1. Click **Add field**.

      ![image](../../_assets/datalens/solution-07/12-add-field.png)

   1. Enter data for the new field:
      - **Name**: Accident death rate
      - **Formula**: `[Death toll]/[Number of accidents]`

      ![image](../../_assets/datalens/solution-07/19-new-field-fatality.png)

   1. Click **Create**

   {% note info %}

   You can create calculated fields directly in charts. However, it's more convenient to do this at the dataset level. This makes them available in all charts.

   {% endnote %}

1. Save the dataset by clicking **Save** at the top right.

   ![image](../../_assets/datalens/solution-07/20-save-dataset.png)

1. Specify the dataset name: **Accidents**. Click **Create**.

   ![image](../../_assets/datalens/solution-07/21-name-dataset.png)

The dataset is created.

## Step 3. Create your first chart: a heat map {#step3}

Proceed to creating the first [chart](https://cloud.yandex.com/docs/datalens/concepts/chart).

1. Click **Create chart**.

   ![image](../../_assets/datalens/solution-07/22-create-chart.png)

1. In the wizard window that opens, click on the field that defaults to **Column chart** and select the **Map** chart type.

   ![image](../../_assets/datalens/solution-07/23-heatmap.png)

1. Under **Points**, select the **Points (heat map)** layer type.

   ![image](../../_assets/datalens/solution-07/23-1-heatmap-geopoint.png)

1. Drag the **Geopoint** field to the **Geopoints** section.

   ![image](../../_assets/datalens/solution-07/24-drag-geopoint.png)

   That's your first chart on the map.

1. To save it, click the arrow icon next to the **Save** button and select **Save as**.

   ![image](../../_assets/datalens/solution-07/25-save-heatmap.png)

1. In the dialog box, name the chart **Heat map** and click **Save**.

   ![image](../../_assets/datalens/solution-07/26-name-heatmap.png)

## Step 4. Create your second chart: a bar chart {#step4}

1. Analyze the number of accidents by region.

   1. In the same window, select **Bar chart** as the chart type.

      ![image](../../_assets/datalens/solution-07/27-choose-linely-diagram.png)

   1. Drag:
      - The **Region name** field to the **Y** section.
      - The **Number of accidents** field to the **X** section.
      - The **Number of accidents** field to the **Sorting** section.

      ![image](../../_assets/datalens/solution-07/28-drag-attributes.png)

      The chart shows the number of accidents by region. Most accidents occurred in the Moscow region.

      {% note info %}

      The legend may be missing for some of the chart lines. If this is the case, hover over the line and you'll see a tooltip with the region name.

      {% endnote %}

   1. Click **Save as** to save the chart.

      ![image](../../_assets/datalens/solution-07/29-save-chart-as.png)

      Name the chart **Number of accidents by region** and save it.

      ![image](../../_assets/datalens/solution-07/30-save-linely-diagram.png)

1. Analyze the death rate in accidents by region.

   1. Replace the **Number of accidents** measure with **Accident death rate** by dragging and dropping.

      ![image](../../_assets/datalens/solution-07/31-drag-attributes-2.png)

      This time, Ingushetia is far ahead in the number of deaths, followed by Tyva and Kalmykia.

   1. Save the chart by clicking **Save as**

      ![image](../../_assets/datalens/solution-07/29-save-chart-as.png)

      and name it **Death rate by region**.

      ![image](../../_assets/datalens/solution-07/32-save-linely-diagram-2.png)

## Step 5. Create line charts {#step5}

Let's see how the number of accidents and related deaths are distributed by week, day of the week, and time of day.

1. Analyze the number of accidents and death rate by week.

   1. In the same window, select **Line chart** as the chart type.

      ![image](../../_assets/datalens/solution-07/33-choose-line-diagram.png)

   1. The chart management sections contain the previous values. Delete them by clicking ![image](../../_assets/datalens/cross.svg).

      ![image](../../_assets/datalens/solution-07/34-clean.png)

   1. Drag the **Date and time** field to the **X** section and click the green calendar icon.

      ![image](../../_assets/datalens/solution-07/35-drag-date-and-time.png)

   1. In the **Grouping** field, choose **Date part** ⟶ **Week** and click **Apply**.

      ![image](../../_assets/datalens/solution-07/36-choose-week.png)

   1. Drag:
      - The **Number of accidents** field to the **Y** section.
      - The **Accident death rate** field to the **Y2** section.

      ![image](../../_assets/datalens/solution-07/37-drag-attributes-3.png)

      Now you can see a chart with two graphs: the number of accidents and death rate. If you hover over a point on the chart, a tooltip appears with specific values.

   1. Save the chart by clicking **Save as**

      ![image](../../_assets/datalens/solution-07/29-save-chart-as.png)

      and name it **Number of accidents and death rate by week**.

      ![image](../../_assets/datalens/solution-07/38-save-line-diagram-week.png)

1. Now analyze the number of accidents and death rate by day of the week.

   1. Change grouping by date and time to **Date part** ⟶ **Day of week**.

      ![image](../../_assets/datalens/solution-07/39-choose-day.png)

      This chart shows more obvious trends.

      ![image](../../_assets/datalens/solution-07/40-line-diagram-day.png)

   1. Save the chart by clicking **Save as**

      ![image](../../_assets/datalens/solution-07/29-save-chart-as.png)

      and name it **Number of accidents and death rate by day of week**.

      ![image](../../_assets/datalens/solution-07/41-save-line-diagram-day.png)

1. Analyze the number of accidents and death rate by hour of day.

   1. Change grouping by date and time to **Date part** ⟶ **Hour**.

      ![image](../../_assets/datalens/solution-07/42-choose-hour.png)

      The chart shows that less accidents occur at night, but they result in more casualties.

      ![image](../../_assets/datalens/solution-07/43-line-diagram-hour.png)

   1. Save the chart by clicking **Save as**

      ![image](../../_assets/datalens/solution-07/29-save-chart-as.png)

      and name it **Number of accidents and death rate by hour of day**.

      ![image](../../_assets/datalens/solution-07/44-save-line-diagram-hour.png)

## Step 6. Create a dashboard {#step6}

1. Open the menu by clicking the icon to the left of the logo and select **Dashboards**.

   ![image](../../_assets/datalens/solution-07/45-choose-menu-dashbords.png)

1. Click **Create**

   ![image](../../_assets/datalens/solution-07/46-create-dashbord.png)

   and select **Dashboard**.

   ![image](../../_assets/datalens/solution-07/47-choose-dashbord.png)

1. Name the dashboard **Accidents in Russia** and click **Create**.

   ![image](../../_assets/datalens/solution-07/48-name-dashbord.png)

{% note info %}

If this is the first dashboard you create in the folder, it opens as soon as it's created. If the folder already contains dashboards, the list of them opens. In this case, select the **Accidents in Russia** dashboard from the list.

{% endnote %}

## Step 7. Add charts to the dashboard {#step7}

1. Add the first chart.

   1. Click **Add** and select **Chart** from the drop-down list.

      ![image](../../_assets/datalens/solution-07/49-add-chart.png)

   1. In the **Chart** field, select the previously created **Heat Map** from the list of charts.

      ![image](../../_assets/datalens/solution-07/50-choose-chart-to-dashbord.png)

   1. Click **Add**.

      ![image](../../_assets/datalens/solution-07/51-add-chart-to-dashbord.png)

      The chart is displayed on the dashboard.

1. Repeat the previous three steps for the **Number of accidents by region**, **Number of accidents and death rate by week**, **Number of accidents and death rate by day of week**, and **Number of accidents and death rate by hour of day** charts by adding them to the dashboard.

1. Create a switch for the **Number of accidents by region** and **Death rate by region** charts on the dashboard.

   1. Click the **Number of accidents by region** chart settings icon to open them.

      ![image](../../_assets/datalens/solution-07/52-1-tune-chart.png)

   1. Click **Add** to the left of the screen.

      ![image](../../_assets/datalens/solution-07/52-2-add.png)

   1. In the **Chart** field, click **Select** and choose the **Death rate by region** chart.

      ![image](../../_assets/datalens/solution-07/52-3-choose-chart.png)

   1. Click **Save**.

      ![image](../../_assets/datalens/solution-07/52-4-save-tab.png)

## Step 8. Add selectors and create a dashboard {#step8}

[Selectors](https://cloud.yandex.com/docs/datalens/concepts/dashboard#selector) let you filter data by value.

1. Add a selector to show statistics by region name.

   1. Click **Add** and choose **Selector**.

      ![image](../../_assets/datalens/solution-07/52-add-selector.png)

   1. Select **Based on dataset**, click **Select**, and choose the previously created **Accidents** dataset.

      ![image](../../_assets/datalens/solution-07/53-choose-dataset-DTP.png)

   1. In the **Field** property, choose **Region name** and select **Show** next to the selector name. Click **Add**.

      ![image](../../_assets/datalens/solution-07/54-choose-field.png)

   The selector is displayed on the dashboard as a rectangle.

1. Repeat the previous three steps for the fields:
   - Cause of accident
   - Accident type
   - Road type
   - Road name

1. You can drag and resize dashboard elements. Place the elements according to the screenshot or however is convenient for you and click **Save** to save the dashboard.

   ![image](../../_assets/datalens/solution-07/55-dashbord-view.png)

If you choose any values in the selectors, the charts will display data for these values.

You can switch the **Number of accidents by region** chart to **Death rate by region**.

![image](../../_assets/datalens/solution-07/56-1-switch-chart.png)

## Step 9. Connect an additional source with region geolayers {#step9}

Heat maps aren't always the most informative. Upload the polygon reference and add a chart with a color fill for Russian regions.

1. Open the menu by clicking the button to the left of the logo and select **Connections**.

   ![image](../../_assets/datalens/solution-07/56-choose-connections.png)

1. At the top right, click **Create**

   ![image](../../_assets/datalens/solution-07/57-create.png)

   and select **Connection**.

   ![image](../../_assets/datalens/solution-07/58-choose-connection.png)

1. Select the **CSV** file type.

   ![image](../../_assets/datalens/solution-07/03-choose-csv.png)

   Download the [**Regions.csv**](https://yadi.sk/d/ZTgPWnjdnTo43w) file. Then, in the create connection window, upload it by clicking **Select CSV file**.

1. Take a look at a preview of the file data. For the **Table header** parameter, set the **Available** value. At the top right, click **Create**.

   ![image](../../_assets/datalens/solution-07/58-new-connection.png)

## Step 10. Add new fields to the dataset {#step10}

You need to add new fields to the previously created **Accidents** dataset.

1. In the left menu, select **Datasets**.

   ![image](../../_assets/datalens/solution-07/59-choose-datasets.png)

1. Choose the **Accidents** dataset.

   ![image](../../_assets/datalens/solution-07/60-choose-dataset-dtp.png)

1. Go to the **Sources** tab.

   ![image](../../_assets/datalens/solution-07/61-choose-data.png)

1. Click **Add**.

   ![image](../../_assets/datalens/solution-07/62-add.png)

1. Choose **Connections** and then **Regions**.

   ![image](../../_assets/datalens/solution-07/63-choose-regions.png)

   Since the connection data has not yet been merged, an error message may appear. Follow these steps.

1. Click the merge data icon.

   ![image](../../_assets/datalens/solution-07/64-choice.png)

1. Click **Add link**.

   ![image](../../_assets/datalens/solution-07/65-relation.png)

1. Select the fields to link: **reg_name** and **Accident region**. Then click **Save**.

   ![image](../../_assets/datalens/solution-07/66-choose-related-fields.png)

   Make sure the data preview is displayed correctly.

   ![image](../../_assets/datalens/solution-07/67-preview.png)

1. Go to the **Fields** tab.

   ![image](../../_assets/datalens/solution-07/68-go-to-dataset.png)

1. New fields are displayed at the bottom of the list. For the **Polygon** field, specify the **Geopolygon** data type.

   ![image](../../_assets/datalens/solution-07/69-geopolygon.png)

1. Click **Save** to save the dataset.

   ![image](../../_assets/datalens/solution-07/70-save.png)

## Step 11. Create a chart using the new fields {#step11}

1. Click **Create chart**.

   ![image](../../_assets/datalens/solution-07/22-create-chart.png)

1. Select the **Map** chart type.

   ![image](../../_assets/datalens/solution-07/72-fon-map.png)

1. Add polygons to the map. Drag the **Polygon** field from the **Dimensions** section to the **Polygons** section.

1. Change colors of the polygons based on the number of accidents. Drag the **Number of accidents** field from the **Measures** section to the **Colors** section.

1. Drag the following fields to the **Tooltips** section:
   - Region name
   - Number of accidents
   - Death toll
   - Number of victims
   - Number of vehicles
   - Number of participants
   - Accident death rate

   The chart shows a map with a color fill for regions. If you hover over a region, information for that region appears.

   ![image](../../_assets/datalens/solution-07/73-geopolygons-map.png)

1. Click **Save** at the top right to save the chart.

   ![image](../../_assets/datalens/solution-07/73-save.png)

1. Name the chart **Map of regions** and click **Save** once again.

   ![image](../../_assets/datalens/solution-07/74-save-map.png)

## Step 12. Add a new chart to the dashboard {#step12}

1. Select **Dashboards** in the top-left menu.

   ![image](../../_assets/datalens/solution-07/45-choose-menu-dashbords.png)

1. Select the previously created dashboard with accident data.

   ![image](../../_assets/datalens/solution-07/76-choose-dash-dtp.png)

1. Click **Edit** at the top right.

   ![image](../../_assets/datalens/solution-07/77-edit-dash.png)

1. Click the **Heat map** settings icon to open them.

   ![image](../../_assets/datalens/solution-07/78-tune-heatmap.png)

1. Click **Add** to the left of the screen.

   ![image](../../_assets/datalens/solution-07/79-add.png)

1. In the **Chart** field, click **Select** and choose the last chart named **Map of regions**.

   ![image](../../_assets/datalens/solution-07/80-choose-map.png)

1. Click **Save**.

   ![image](../../_assets/datalens/solution-07/81-save-tab.png)

You can now switch the type of map data visualization: heat map or region fill.

![image](../../_assets/datalens/solution-07/82-switch-map.png)

## Step 13. Publish the dashboard {#step13}

1. To set up public access to the dashboard, click ![image](../../_assets/datalens/share.svg).

   ![image](../../_assets/datalens/solution-07/83-share.png)

1. Enable access via link. You can copy and share the link that appears. Everyone can use the link to access the dashboard from any device and without authentication. Click **Apply**.

   ![image](../../_assets/datalens/solution-07/84-link.png)

   {% note info %}

   You can enable or disable public access separately for each chart and dataset associated with the dashboard.

   {% endnote %}

