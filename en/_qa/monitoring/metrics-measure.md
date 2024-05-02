# Metrics and units of measure

#### What does the dot mean? {#comma}

It separates the integer part from the fractional part of a number. For example, the value `123.456` should be interpreted as 123 and 456 thousandths.

#### Why does cpu_usage exceed 100%? {#cpu-usage}

You're using a VM with [guaranteed vCPU performance](../../compute/concepts/performance-levels.md) under 100%. For example, 20% of vCPU performance is guaranteed. For the monitoring system, this level is taken as 100% of the expected load. If there are no "neighbors" on the physical core, your VM can be allocated up to 100% of vCPU performance, which is 5 times more than the guaranteed share. The chart can show up to 500%.

If you see the upper limit of 100% exceeded for quite a while in the charts, we recommend increasing the guaranteed vCPU performance. At any time, "neighbors" may appear on the physical core and the actual vCPU usage may drop to the guaranteed 20% (about 400 MHz for Intel Cascade Lake).

#### Where can I find DB metric descriptions? {#metrics-description}

Metrics are described in the documentation for services, such as:
* [{{ mpg-full-name }}](../../managed-postgresql/operations/monitoring.md).
* [{{ mmy-full-name }}](../../managed-mysql/operations/monitoring.md).
* [{{ mrd-full-name }}](../../managed-redis/operations/monitoring.md).

Important metrics are displayed on each service's dashboard. For a full list of metrics for each service, see **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**. To export a full list of metrics, follow this [guide](../../monitoring/operations/metric/list.md).

#### How do I set up units on a chart? {#graph-units}

Units are set up in the **{{ ui-key.yacloud_monitoring.wizard.tab.axes }}** tab when editing a chart. You can select the unit type, set the number format, scale (linear or logarithmic), and the maximum and minimum values.

#### How are maximum/peak values displayed on a chart? {#graph-peaks}

{{ monitoring-name }} receives metrics for a certain period of time in groups and averages the values when creating a point. When choosing a shorter time interval, the number of values in the sample increases and the peak values on the chart may grow.

This also works in the opposite direction: when choosing a larger time interval, the point peak values are smoothed out and may not be visible on the chart.

#### The chart is missing or looks cropped. Why? {#graph-lost}

The data could fall outside the established chart boundaries. Check the scale settings and the maximum and minimum values in the **{{ ui-key.yacloud_monitoring.wizard.tab.axes }}** tab.

#### Is there a description of functions in the query language? {#function-description}

You can find the function description in the [Reference](../../monitoring/concepts/querying.md#functions).

You can test the functions in the **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** section.
