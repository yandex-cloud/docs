# Creating and configuring a regression dashboard

This guide will show you how to create a [regression](../concepts/load-test-regressions.md) dashboard and configure metric chart widgets.
If you do not have completed [load tests](../concepts/index.md) yet, create a test and run it several times in a row. You can find examples of load test scenarios in the **Tutorials** section.


To create and configure a regression dashboard:

1. [Create a dashboard](#create-dashboard).
1. [Select a time interval](#set-interval).
1. [Add regression charts](#first-chart).
1. [Add text information](#text-info).
1. [Save or edit data on the dashboard](#save-edit).
1. [Add or delete a dashboard](#add-delete).

## Create a dashboard {#create-dashboard}

1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
1. In the left-hand panel, select ![image](../../_assets/load-testing/regressions.svg) **{{ ui-key.yacloud.load-testing.label_regressions-title }}**.
1. Create your first dashboard by clicking **{{ ui-key.yacloud.load-testing.button_create-regression-dashboard }}**.
1. In the dialog box that opens, give your dashboard a name and, optionally, add a description. Click **{{ ui-key.yc-ui-datasphere.common.apply }}**.

## Select a time interval {#set-interval}

The dashboard page has a time scale at the top with the time interval highlighted to display regressions.
The interval is limited by two blue vertical lines.
The red vertical line shows the current moment.
Above the time scale, there is a panel for selecting the interval length.

Configure the interval so that it includes the tests you need.

{% cut "How to configure the time interval" %}

You can change the interval length in one of the following ways:

1. Drag the interval limit on the timeline in the required direction.
1. Select the start and end date and time of the interval from the drop-down list on the left side of the interval length selection panel.
   Additional options, such as `Last 5 minutes`, `Last hour`, `Today`, `Yesterday`, are also located there.
1. Click one of the shortcuts on the right side of the interval length selection panel:
   - **2w**: Two weeks
   - **1M**: One month
   - **2M**: Two months
   - **3M**: Three months
   - **6M**: Six months
1. Set the interval in the drop-down list to the right of the shortcuts.
   To set the interval, enter any number in the drop-down list box.
   Options will appear with interval scale options: seconds (s), minutes (m), hours (h), days (d), weeks (w), and months (M).
   For numbers 1 and 2, there is additionally a year (y) option.

Use the ![image](../../_assets/load-testing/shift-left.svg) and ![image](../../_assets/load-testing/shift-right.svg) interval limit shift buttons to the right of the drop-down list in the interval length selection panel to move the interval relative to the current moment (red vertical line).
The amount of the shift is determined by the current interval value.

To shift the interval to the current time, click **Now** to the right of the interval shift buttons.

You can change the scale of the interval display using the ![image](../../_assets/load-testing/minus.svg) and ![image](../../_assets/load-testing/plus.svg) buttons on the right side of the time scale.

{% endcut %}

## Add a regression chart {#first-chart}

To customize your dashboard, add your first regression chart:

1. Click **{{ ui-key.yc-ui-datasphere.common.edit }}** in the center of the screen.
1. Click the ![image](../../_assets/load-testing/plus.svg) **{{ ui-key.yacloud.load-testing.button_create-chart }}** panel.
1. In the dialog box that opens:
   - In the **{{ ui-key.yacloud.load-testing.field_chart-name }}** field, specify the regression chart name.
   - In the **{{ ui-key.yc-ui-datasphere.common.description }}** field, give a description of the regression (optional).
   - From the **{{ ui-key.yacloud.load-testing.field_test-data-type }}** drop-down list, select the **{{ ui-key.yacloud.load-testing.value_cumulative-quantiles-chart-type }}** option.
1. In the **{{ ui-key.yacloud.load-testing.label_quantile }}** list, mark the values to add to the chart and specify, for each of them, the condition imposed on the value (optional).
1. In the **{{ ui-key.yacloud.load-testing.label_test-rules-section }}** section, specify a name common to the tests you want to include in the selection (optional). The test name serves as a filter: if you do not specify it, all your tests will be included in the selection.
1. You can also filter the tests using labels. To do this, click **{{ ui-key.yacloud.load-testing.button_add-tag }}** in the **{{ ui-key.yacloud.load-testing.label_test-tags }}** field and select a label and its value.
   You must specify labels for at least one of your tests.

   {% note info %}

   To add labels to tests, go to the ![image](../../_assets/load-testing/test.svg)**{{ ui-key.yacloud.load-testing.label_tests-list }}** page, select the tests you need from the list, and click **Add labels**.
   Add labels in the `key:value` format.

   {% endnote %}

1. View the list of filtered tests in the **Tests included in regression** section.
1. To save the chart to the dashboard, click **Create**.

Add a second regression chart:

1. On the first chart widget you just created, click the ![image](../../_assets/load-testing/edit-copy.svg) copy button at the top right.
1. Provide a new name and description.
1. From the **{{ ui-key.yacloud.load-testing.field_test-data-type }}** drop-down list, select the **{{ ui-key.yacloud.load-testing.value_instances-chart-type }}** option.
1. In the list of options, check the values you want to add to the chart.
1. To save the chart to the dashboard, click **Create**.
1. Place the new widget next to the first widget. If required, adjust the height and width of the widget.

## Add text information {#text-info}

If you want other users to easily read your dashboard, add a common header for the charts and explanatory text:

1. In the panel at the bottom of the page, click ![image](../../_assets/load-testing/header.svg) **Text**.
1. Specify a header and select its size.
1. Click **Add**.
1. Drag the header to the position above the charts. If required, change the height and width of the header field.
1. In the panel at the bottom of the page, click ![image](../../_assets/load-testing/text.svg) **Text**.
1. Add text to explain the results shown in the charts. In your text, you can use formatting, add links, images, formulas, code, etc.
1. Click **Add**.
1. If required, change the height and width of the explanatory text field.

## Save or edit data on the dashboard {#save-edit}

To save the chart and explanatory information on the dashboard, click **Save** in the top-right corner of the page.
You can always add, delete, or edit data on the dashboard by switching to edit mode. To do this, click **Edit** in the top-right corner of the page.
You can also switch to the dashboard editing mode from the list of dashboards on the ![image](../../_assets/load-testing/regressions.svg) **{{ ui-key.yacloud.load-testing.label_regressions-title }}** page. To do this, in the list of dashboards, click ![image](../../_assets/options.svg) next to the required dashboard and select the **{{ ui-key.yc-ui-datasphere.common.edit }}** option.

In edit mode, you can:
- Edit an element. To do this, click ![image](../../_assets/load-testing/edit-pen.svg).
- Copy an element. To do this, click ![image](../../_assets/load-testing/edit-copy.svg).
- Delete an element. To do this, click ![image](../../_assets/load-testing/edit-cross.svg).

## Add or delete a dashboard {#add-delete}

To add a new dashboard, click **Create dashboard** on the ![image](../../_assets/load-testing/regressions.svg) **{{ ui-key.yacloud.load-testing.label_regressions-title }}** page in the top-right corner of the page.

To delete a dashboard, click ![image](../../_assets/options.svg) on the ![image](../../_assets/load-testing/regressions.svg) **{{ ui-key.yacloud.load-testing.label_regressions-title }}** page in the dashboard list next to the required dashboard and select **{{ ui-key.yc-ui-datasphere.common.delete }}**.
