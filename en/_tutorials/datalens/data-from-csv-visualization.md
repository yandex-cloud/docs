# Visualizing data from a file

For our source data, let's use a file named [SuperHeroes.csv](https://storage.yandexcloud.net/datalens/SuperHeroes.csv) with information about superheroes, such as their name, gender, race, and comic book publisher.

This scenario demonstrates how to use {{ datalens-short-name }} to analyze dependencies, for example:
- A superhero's weight from their gender.
- A superhero's weight from whether they're good or bad.

To visualize and explore data, {% if audience != "internal" %}[set up {{ datalens-short-name }}](#before-you-begin) and follow the steps below:{% else %}follow the steps below:{% endif %}

1. [Create a connection](#step1).
1. [Create a dataset](#step2).
1. [Create the first chart](#step3).
1. [Create the second chart](#step4).
1. [Create a dashboard](#step5).
1. [Add charts to the dashboard](#step6).
1. [Add selectors to the dashboard](#step7).
1. [Set up widgets and start analyzing dependencies](#step8).
1. [Continue to analyze the data about superheroes](#step9).

{% if audience != "internal" %}

## Before you begin {#before-you-begin}

{% include [before-you-begin](../includes/before-you-begin-datalens.md) %}

{% endif %}

## Step 1. Create a connection and dataset {#step1}

Create a dataset based on the **File** [connection](../../datalens/concepts/connection.md) type.

1. Go to the {{ datalens-short-name }} [homepage]({{ link-datalens-main }}).
1. Click **Create connection**.

   ![image](../../_assets/datalens/solution-01/01-create-connection.png)

1. Select **File**.

   ![image](../../_assets/datalens/solution-01/select-file-connection.png)

1. Click **Upload files**.

   ![image](../../_assets/datalens/solution-01/03-choose-file.png)

1. Select the file. For this example, use **SuperHeroes.csv** ([download link](https://storage.yandexcloud.net/datalens/SuperHeroes.csv)).

   Wait until the table content appears on the screen.

1. Click **Create connection**.

   ![image](../../_assets/datalens/solution-01/04-save-file-connection.png)

1. Enter the `SuperHeroes` connection name and click **Create**.

   ![image](../../_assets/datalens/solution-01/04-2-save-file-connection.png)

1. After the data is saved, click **Create dataset**.

   ![image](../../_assets/datalens/solution-01/05-create-dataset_file_connection.png)

## Step 2. Create a dataset {#step2}

1. If there is no **SuperHeroes.csv** table in the workspace, drag the table from the selection panel to the workspace.

   ![image](../../_assets/datalens/solution-01/06-Drag-Table-file.png)

1. Go to the **Fields** tab.

   ![image](../../_assets/datalens/solution-01/07-Fields-Tab.png)

1. Create a field for the superheros's average weight:

   1. Click ![image](../../_assets/datalens/horizontal-ellipsis.svg) in the **Weight** row.
   1. Select **Duplicate**.

      ![image](../../_assets/datalens/solution-01/08-Weight-Duplication.png)

   1. Rename the **Weight (1)** duplicate field to **Weight avg**: click the row name, delete the current name, and enter the new one.
   1. In the **Aggregation** column, select **Average** for the **Weight avg** field.

      ![image](../../_assets/datalens/solution-01/09-Weght-AVG.png)

1. In the upper-right corner, click **Save**.

   ![image](../../_assets/datalens/solution-01/10-Save-Dataset.png)

1. Enter a name for the dataset: **SuperHeroes dataset**, then click **Create**.

1. When the dataset is saved, click **Create chart**.

   ![image](../../_assets/datalens/solution-01/11-Create-Chart.png)

## Step 3. Create the first chart {#step3}

To visualize data divided by gender, create a column chart type [chart](../../datalens/concepts/chart/index.md).

1. Add the names of superheroes to the chart. To do this, drag the **Name** field from the **Dimensions** section to the **X** section.
1. Add the superheros' weight to the chart. To do this, drag the **Weight avg** field from the **Measures** section to the **Y** section.

   ![image](../../_assets/datalens/solution-01/12-Chart-XY.png)

1. Sort the chart by weight (for example, in descending order).

   1. From the first column in the **Measures** section, drag the **Weight avg** field to the **Sorting** section.

      ![image](../../_assets/datalens/solution-01/13-Chart-Sort.png)

1. Leave only the superheroes whose weight is known on the chart (greater than zero).

   1. From the first column in the **Measures** section, drag the **Weight avg** field to the **Filters** section.
   1. In the window that opens, specify the operation **Greater** than and the value **0**.
   1. Click **Apply filter**.

      ![image](../../_assets/datalens/solution-01/14-Chart-Filter.png)

1. Add a color division for superheroes depending on their gender to the chart. To do this, drag the **Gender** field from the **Dimensions** section to the **Colors** section.

   ![image](../../_assets/datalens/solution-01/15-Chart-Color.png)

1. Redefine the colors for the **Gender** dimension.

   1. Click the settings icon in the **Colors** section.

      ![image](../../_assets/datalens/solution-01/16-Chart-Color-Set-Buttun.png)

   1. Select the colors: **Female** — pink, **Male** — blue, **unknown** — orange.

      ![image](../../_assets/datalens/solution-01/17-Chart-Color-Set1.png)

1. Save the chart.

   1. In the upper-right corner, click **Save**.

      ![image](../../_assets/datalens/solution-01/18-Chart-Save.png)

   1. In the window that opens, enter a name for the chart: **SuperHeroes — gender**, then click **Save**.

## Step 4. Create the second chart {#step4}

To visualize whether a superhero is good or bad, create a bar chart.

1. Copy the chart from the previous step.

   1. Click the down arrow next to the **Save** button in the upper-right corner.
   1. Click **Save as**.

      ![image](../../_assets/datalens/solution-01/19-Chart-SaveAs.png)

   1. In the window that opens, enter the name of the new chart: **SuperHeroes — alignment**.
   1. Click **Done**.

1. Add to the chart a color division for superheroes depending on whether they are good or bad. To do this, drag the **Alignment** field from the **Dimensions** section to the **Colors** section.

   The previous value of the section (the **Gender** field) is replaced with **Alignment**.

   ![image](../../_assets/datalens/solution-01/20-Charts-Alignment.png)

1. Redefine the colors for the **Alignment** dimension.

   1. Click the settings icon in the **Colors** section.
   1. Select the colors: **good** — green, **neutral** — blue, **bad** — red, **unknown** — orange.

      ![image](../../_assets/datalens/solution-01/21-Chart-Color-Set2.png)

1. In the upper-right corner, click **Save**.

## Step 5. Create a dashboard {#step5}

Create a [dashboard](../../datalens/concepts/dashboard.md) to add these charts to.

1. Go to the {{ datalens-short-name }} [homepage]({{ link-datalens-main }}).
1. Click **Create dashboard**.

   ![image](../../_assets/datalens/solution-01/22-Create-Dashboard.png)

1. Enter the name **SuperHeroes dashboard** for the dashboard and click **Create**.

## Step 6. Add charts to the dashboard {#step6}


1. The first time you open the dashboard after saving, it opens in edit mode. If you open it later, click **Edit** in the upper-right corner.

   ![image](../../_assets/datalens/solution-01/23-Dash-Edit.png)

1. Click **Add**.
1. Choose **Chart**.

   ![image](../../_assets/datalens/solution-01/24-Dash-Add-Chart.png)

1. In the window that opens, click **Select** and choose the **SuperHeroes — gender** chart.

   This will automatically fill in the **Title** field.

1. Click **Add**.

   ![image](../../_assets/datalens/solution-01/25-Dash-Gender-Add.png)

1. Add another chart. Perform step 6 from the beginning and specify the **SuperHeroes — alignment** chart in item 4.

   ![image](../../_assets/datalens/solution-01/26-Dash-Aligmnnent-Add.png)

## Step 7. Add selectors to the dashboard {#step7}

Add [selectors](../../datalens/concepts/dashboard.md#selector) to be able to filter superheroes by race (the **Race** field) and publisher (the **Publisher** field).

1. Click **Add**.
1. Choose **Selector**.

   ![image](../../_assets/datalens/solution-01/27-Add-Selector.png)

1. Select the **SuperHeroes dataset**.
1. Select the **Race** field.

   This will automatically fill in the **Title** field.

1. Click the **Show** checkbox next to the selector title.
1. Enable the **Multiple choice** option.
1. Click **Add**.

   ![image](../../_assets/datalens/solution-01/28-Selector-Race.png)

1. Add another selector. Perform step 7 from the beginning and specify the **Publisher** field in item 4.

   ![image](../../_assets/datalens/solution-01/29-Selector-Publisher.png)

## Step 8. Set up widgets and start analyzing dependencies {#step8}

1. Drag the selectors to the top of the page next to each other.
1. Stretch the charts by width and place them next to each other.
1. In the upper-right corner, click **Save**.

   ![image](../../_assets/datalens/solution-01/30-Dash.png)

1. Apply various filters and analyze the weight dependencies on a superhero's gender and good or bad alignment

   ![image](../../_assets/datalens/solution-01/31-Final-Dash.png)

   The dataset analyzed shows the following dependencies:
   - Men are generally heavier than women.
   - Bad superheroes are mostly heavier than good ones.

## Step 9. Continue to analyze the data about superheroes {#step9}

You can create new measures in the dataset, such as average height (average from the **Height** field) and the number of superheroes (number of unique entries from the **Name** field) and answer the following questions:

- Representatives of which race are the most numerous?
- Does a superhero's height depend on whether they are good or bad?
- Which studio created the most superheroes?
