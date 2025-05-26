# Creating and configuring a regression dashboard

Follow this guide to create a [regression](../concepts/load-test-regressions.md) dashboard and configure metric chart widgets.
If you do not have any completed [load tests](../concepts/index.md) yet, create one and run it several times in a row. You can find examples of load test scenarios in **Tutorials**. 



To create and configure a regression dashboard:

1. [Create a dashboard](#create-dashboard).
1. [Select a time interval](#set-interval).
1. [Add regression charts](#first-chart).
1. [Add descriptive text](#text-info).
1. [Save or edit data on the dashboard](#save-edit).
1. [Add or delete a dashboard](#add-delete).

## Create a dashboard {#create-dashboard}

1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
1. In the left-hand panel, select ![image](../../_assets/load-testing/regressions.svg) **{{ ui-key.yacloud.load-testing.label_regressions-title }}**.
1. Create your first dashboard by clicking **{{ ui-key.yacloud.load-testing.button_create-regression-dashboard }}**.
1. In the dialog that opens, give your dashboard a name and, optionally, add a description. Click **{{ ui-key.yc-ui-datasphere.common.apply }}**.

## Select a time interval {#set-interval}

The dashboard page features a timeline at the top, highlighting the interval used to display regressions.
Two blue vertical lines indicate the interval boundaries.
The red vertical line shows the current moment.
Above the timeline, you will find a panel for selecting the interval length.

Configure the interval to include the tests you need.

{% cut "How to configure a time interval" %}

You can change the interval length in one of the following ways:

1. Drag the interval boundary along the timeline to adjust it as needed.
1. Select the start and end date and time of the interval from the drop-down list on the left side of the interval length selection panel.
   There, you will also find preset options, such as `Last 5 minutes`, `Last hour`, `Today`, and `Yesterday`.
1. Click one of the shortcuts on the right side of the interval length selection panel:
   - **2w**: Two weeks
   - **1M**: One month
   - **2M**: Two months
   - **3M**: Three months
   - **6M**: Six months
1. Set the interval in the drop-down list to the right of the shortcuts.
   To set the interval, enter any number in the drop-down box.
   You will see interval scale options: seconds (s), minutes (m), hours (h), days (d), weeks (w), and months (M).
   For numbers 1 and 2, there is an additional option for year (y).

Use the ![image](../../_assets/load-testing/shift-left.svg) and ![image](../../_assets/load-testing/shift-right.svg) shift buttons to the right of the drop-down list in the interval length selection panel to adjust the interval relative to the current moment (red vertical line).
The shift amount is determined by the current interval length.

To shift the interval to the current time, click **Now** to the right of the interval shift buttons.

You can change the interval display scale using the ![image](../../_assets/load-testing/minus.svg) and ![image](../../_assets/load-testing/plus.svg) buttons on the right of the timeline.

{% endcut %}

## Add a regression chart {#first-chart}

To customize your dashboard, add your first regression chart:

1. Click **{{ ui-key.yc-ui-datasphere.common.edit }}** in the center of the screen.
1. Click the ![image](../../_assets/load-testing/plus.svg) **{{ ui-key.yacloud.load-testing.button_create-chart }}** panel.
1. In the dialog that opens:
   - In the **{{ ui-key.yacloud.load-testing.field_chart-name }}** field, specify a regression chart name.
   - Optionally, provide a description for the regression in the **{{ ui-key.yc-ui-datasphere.common.description }}** field.
   - From the **{{ ui-key.yacloud.load-testing.field_test-data-type }}** drop-down list, select **{{ ui-key.yacloud.load-testing.value_cumulative-quantiles-chart-type }}**.
1. Optionally, in the **{{ ui-key.yacloud.load-testing.label_quantile }}** list, select the values to add to the chart and specify a condition for each.
1. Optionally, under **{{ ui-key.yacloud.load-testing.label_test-rules-section }}**, specify a name common for the tests you want to include in the sample. The test name serves as a filter: if left blank, all your tests will be included.
1. You can also filter tests using labels. To do this, click **{{ ui-key.yacloud.load-testing.button_add-tag }}** in the **{{ ui-key.yacloud.load-testing.label_test-tags }}** field and select a label and its value.
   Make sure at least one of your tests is labeled.

   {% note info %}

   To add labels to tests, go to the ![image](../../_assets/load-testing/test.svg)**{{ ui-key.yacloud.load-testing.label_tests-list }}** page, select the tests from the list, and click **Add labels**.
   Add labels in `key:value` format.
   
   {% endnote %}

1. Under **Tests included in the regression**, view the list of filtered tests.
1. To save the chart to your dashboard, click **Create**.

Add another regression chart: 

1. On the first chart widget you just created, click the ![image](../../_assets/load-testing/edit-copy.svg) copy button at the top right.
1. Enter a new name and description.
1. From the **{{ ui-key.yacloud.load-testing.field_test-data-type }}** drop-down list, select **{{ ui-key.yacloud.load-testing.value_instances-chart-type }}**.
1. In the list of options, select the values you want to add to the chart.
1. To save the chart to your dashboard, click **Create**.
1. Place the new widget next to the one you created earlier. Adjust the widget height and width as needed.

## Add descriptive text {#text-info}

If you want other users to easily read your dashboard, add a shared title for the charts and explanatory text:

1. In the panel at the bottom of the page, click ![image](../../_assets/load-testing/header.svg) **Title**.
1. Specify a title and select its size.
1. Click **Add**.
1. Drag the title so it sits above the charts. Change the height and width of the title field as needed.
1. In the panel at the bottom of the page, click ![image](../../_assets/load-testing/text.svg) **Text**.
1. Add text to explain the results shown in the charts. You can use formatting, add links, images, formulas, code, etc.
1. Click **Add**.
1. Change the height and width of the explanatory text field as needed.

## Save or edit data on the dashboard {#save-edit}

To save the chart and explanatory information on the dashboard, click **Save** in the top-right corner of the page.
You can always add, delete, or edit data on the dashboard by switching to edit mode. To do this, click **Edit** in the top-right corner of the page.
You can also switch to edit mode from the list of dashboards on the ![image](../../_assets/load-testing/regressions.svg) **{{ ui-key.yacloud.load-testing.label_regressions-title }}** page. To do this, in the list of dashboards, click ![image](../../_assets/options.svg) next to the dashboard you need and select **{{ ui-key.yc-ui-datasphere.common.edit }}**.

In edit mode, you can:
- Edit an element by clicking ![image](../../_assets/load-testing/edit-pen.svg).
- Copy an element by clicking ![image](../../_assets/load-testing/edit-copy.svg).
- Delete an element by clicking ![image](../../_assets/load-testing/edit-cross.svg).

## Add or delete a dashboard {#add-delete}

To add a new dashboard, click **Create dashboard** in the top-right corner of the ![image](../../_assets/load-testing/regressions.svg) **{{ ui-key.yacloud.load-testing.label_regressions-title }}** page.

To delete a dashboard, on the ![image](../../_assets/load-testing/regressions.svg) **{{ ui-key.yacloud.load-testing.label_regressions-title }}** page, click ![image](../../_assets/options.svg) in the dashboard list next to the dashboard in question and select **{{ ui-key.yc-ui-datasphere.common.delete }}**.
