---
title: How to create and configure a regression dashboard
description: Follow this guide to create and configure a regression dashboard in {{ load-testing-name }}.
---

# Creating and configuring a regression dashboard

In {{ load-testing-name }}, you can create and configure [regression](../../concepts/load-test-regressions.md) dashboards with [load test](../../concepts/index.md) metric charts.
If you have no completed tests yet, [create](../create-test-bucket.md) one and run it several times in a row. For examples of test scenarios, see the [Tutorials](../../tutorials/index.md) section. 

## Creating a dashboard {#create-dashboard}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. In the left-hand panel, select ![image](../../../_assets/load-testing/regressions.svg) **{{ ui-key.yacloud.load-testing.label_regressions-title }}**.
  1. Click **{{ ui-key.yacloud.load-testing.button_create-regression-dashboard }}**.
  1. In the window that opens, enter a name and description for the dashboard and click **{{ ui-key.yc-ui-datasphere.common.apply }}**.

{% endlist %}

## Selecting a time interval {#choose-interval}

To view load test results, you must select an interval.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. In the left-hand panel, select ![image](../../../_assets/load-testing/regressions.svg) **{{ ui-key.yacloud.load-testing.label_regressions-title }}**.
  1. From the list of dashboards, select the one you need.
  1. Set the interval in one of the following ways:

      * Move the interval in the required direction using the [timeline](../../concepts/load-test-regressions.md).
      * Select an interval from the drop-down list on the left above the timeline. You can also select a preset interval from the list, such as `Last 5 minutes`, `Last hour`, `Today`, `Yesterday`, etc.
      * Click one of the buttons to the right of the date and time:
        * **2w**: Two weeks
        * **1M**: One month
        * **2M**: Two months
        * **3M**: Three months
        * **6M**: Six months

      * Specify the interval in the drop-down list to the right of the buttons. You will see interval scale options:
        * `s`, seconds
        * `m`, minutes
        * `h`, hours
        * `d`, days
        * `w`, weeks
        * `M`, months
        
        For numbers `1` and `2`, you can also select `y` (year).

      * Move the interval using the ![image](../../../_assets/load-testing/shift-left.svg) and ![image](../../../_assets/load-testing/shift-right.svg) boundary shift buttons, to the right of the date and time. The shift amount is determined by the current interval length.

  To shift the interval to the current time, click **Now** to the right of the interval shift buttons.

  Click ![image](../../../_assets/load-testing/minus.svg) and ![image](../../../_assets/load-testing/plus.svg) on the right side of the timeline to change the scale.

{% endlist %}

## Adding a regression chart {#add-graph}

On the dashboard, you can set up regression charts with metrics for [response time](../../concepts/load-test-results.md#quantiles), number of [testing threads](../../concepts/load-test-results.md#test-streams), or RPS breaking points. 

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. In the left-hand panel, select ![image](../../../_assets/load-testing/regressions.svg) **{{ ui-key.yacloud.load-testing.label_regressions-title }}**.
  1. From the list of dashboards, select the one you need.
  1. Click **{{ ui-key.yc-ui-datasphere.common.edit }}** and select ![image](../../../_assets/load-testing/plus.svg) **{{ ui-key.yacloud.load-testing.button_create-chart }}**.
  1. In the window that opens:
    * In the **{{ ui-key.yacloud.load-testing.field_chart-name }}** field, specify a regression chart name.
    * Optionally, enter a description in the **{{ ui-key.yc-ui-datasphere.common.description }}** field.
    * In the **{{ ui-key.yacloud.load-testing.field_test-data-type }}** field, select one of the [metrics](../../concepts/load-test-regressions.md): `{{ ui-key.yacloud.load-testing.value_cumulative-quantiles-chart-type }}`, `{{ ui-key.yacloud.load-testing.value_instances-chart-type }}`, or `{{ ui-key.yacloud.load-testing.value_imbalance_rps-chart-type }}`.
  1. Select the values you want to add to the chart.
  1. Under **{{ ui-key.yacloud.load-testing.label_test-rules-section }}**:
      * Optionally, in the **{{ ui-key.yacloud.load-testing.label_test-text }}** field, specify a name for the tests you want to include in the sample. If you do not specify a name, all your tests will be included in the sample.
      * In the **{{ ui-key.yacloud.load-testing.label_test-tags }}** field, click **{{ ui-key.yacloud.load-testing.button_add-tag }}** and assign labels to tests in `key:value` format. Make sure at least one of your tests is labeled.

        You can also pre-assign labels to tests. To do this, go to the ![image](../../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** page, select the tests from the list, and click **{{ ui-key.yacloud.load-testing.button_tags-link }}**.

      The **{{ ui-key.yacloud.load-testing.label_tests-example-section }}** section will display the filtered tests.
  1. Click **{{ ui-key.yacloud.common.create }}**.

  A widget will appear on the panel. Adjust its height and width as needed.

{% endlist %}

## Adding more information {#add-info}

To improve the readability of your charts, add more elements to your dashboard. These can be headings, text, code blocks, images, tables, etc. 

### Adding a title {#add-title}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. In the left-hand panel, select ![image](../../../_assets/load-testing/regressions.svg) **{{ ui-key.yacloud.load-testing.label_regressions-title }}**.
  1. From the list of dashboards, select the one you need.
  1. Click ![image](../../../_assets/load-testing/header.svg) **Title**.
  1. Specify the title and its size.
  1. Click **{{ ui-key.yacloud.common.add }}**.
  1. Place the title where you need on the dashboard. Change the height and width of the title field as needed.

{% endlist %}

### Adding an element {#add-element}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. In the left-hand panel, select ![image](../../../_assets/load-testing/regressions.svg) **{{ ui-key.yacloud.load-testing.label_regressions-title }}**.
  1. From the list of dashboards, select the one you need.
  1. Click ![image](../../../_assets/load-testing/text.svg) **Text**.
  1. Specify the text or click ![image](../../../_assets/options.svg) and select an element from the list. 
  1. Click **{{ ui-key.yacloud.common.add }}**.
  1. Place the information where you need on the dashboard.

{% endlist %}

#### See also {#see-also}

* [{#T}](update.md)
* [{#T}](delete.md)