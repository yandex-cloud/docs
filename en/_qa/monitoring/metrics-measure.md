# Metrics and measurement units

#### What does the dot mean? {#comma}

It separates integer and fractional parts of a number. For example, the `123,456` means 123 and 456 thousandths.

#### Why does cpu_usage exceed 100%? {#cpu-usage}

You're using a VM with [guaranteed vCPU performance](../../compute/concepts/performance-levels.md) under 100%. For example, a VM guarantees you 20% of vCPU performance. The monitoring system considers this value as 100% of the expected load. If you are the only one using a physical core, your VM can use up to 100% of vCPU, which is 5 times higher than guaranteed vCPU performance. In this case, the chart can show values as high as 500%.

If the charts indicate that the 100% upper limit is exceeded consistently, we recommend increasing the guaranteed vCPU performance. At any time, concurrent activities on the physical core can reduce the actual vCPU usage to guaranteed 20%, i.e., about 400 MHz for Intel Cascade Lake.

#### Where can I find DB metric descriptions? {#metrics-description}

Metrics are described in our service guides, such as:
* [{{ mpg-full-name }}](../../managed-postgresql/operations/monitoring.md).
* [{{ mmy-full-name }}](../../managed-mysql/operations/monitoring.md).
* [{{ mrd-full-name }}](../../managed-redis/operations/monitoring.md).

You can see the most important metrics on a service dashboard. If you need a list of all service metrics, navigate to **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**. To export a full list of metrics, follow this [guide](../../monitoring/operations/metric/list.md).

#### How can I configure chart measurement units? {#graph-units}

You can set up measurement units in the **{{ ui-key.yacloud_monitoring.wizard.tab.axes }}** chart configuration tab. There you can select the measurement unit type, specify the number format, choose a linear or logarithmic scale, and set the maximum and minimum values.

#### How the maximum (peak) values are displayed on a chart? {#graph-peaks}

When creating a point, {{ monitoring-name }} averages metric values received for a certain period of time. As you shorten the time scale, the sample size grows, leading to higher peak chart values.

The opposite is also true; if you expand the time scale, peaks are averaged out and may not show up on the chart.

#### The chart is missing or looks cut off. Why? {#graph-lost}

The data may lie beyond the chart scale. Check the chart scale and its maximum and minimum values in the **{{ ui-key.yacloud_monitoring.wizard.tab.axes }}** tab.

#### Does query language contain function descriptions? {#function-description}

You can find function descriptions in the [Reference](../../monitoring/concepts/querying.md#functions).

You can test the functions in the **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** section.
