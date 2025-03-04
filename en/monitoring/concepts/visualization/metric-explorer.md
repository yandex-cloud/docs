---
title: '{{ monitoring-full-name }} Metric Explorer'
description: Metric Explorer in {{ monitoring-full-name }} helps you define and view real-time service and application metrics.
---

# Metric Explorer in {{ monitoring-name }}

In **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**, you can monitor various indicators of your infrastructure and applications in real time. For example, you can track RAM usage for a {{ compute-name }} VM instance or the number of requests to an {{ alb-name }} virtual host.

{{ monitoring-name }} allows you to:

* Flexibly configure regular and derived metrics with custom formulas.
* Display one or multiple metrics on charts.
* View detailed data for each metric.
* Duplicate charts with a metric split by a certain parameter. 
* Track changes over time and compare metrics for similar elements of your infrastructure.

With Metric Explorer, you can perform the following tasks:

* _Performance monitoring_: Estimate system load, total allowed and denied requests to a host, and the number of errors.

* _Trend analysis_: Find out how metrics changed over time, detect downtime and peak loads.

* _Issue tracking and troubleshooting_: Spot problems in service performance by looking at suspicious indicators.

* _Incident investigation_: View metric changes before the incident as well as the metrics and system elements related to the anomaly.

* _Configuring dashboard charts and adding alerts_: Add charts to a dashboard to save them and monitor on a regular basis. Create alerts to get notifications about sudden changes in metrics.

To learn how to configure and use charts, see [{#T}](../../operations/metric/metric-explorer.md).

## Chart repetition by parameter {#repeated-graphs}

Chart repetition based on a specific parameter allows you to build several similar charts but with different values of this parameter. This helps you to analyze indicator anomalies and problems as you can split a metric into multiple ones and examine each of them separately.

Let’s say you have multiple VMs deployed in your cloud and observe a spike in CPU utilization. To track down the issue fast:

1. Create a CPU utilization chart for all VMs.
1. Enable chart repetition by VM to create separate charts for each VM.
1. When you spot a VM with high indicators, create CPU utilization charts for each of its vCPUs.


This data analysis method is known as drilling down, where you move from general to more detailed data to identify a problem or anomaly more precisely.

For more information about chart repetition, see [{#T}](../../operations/metric/metric-explorer.md#repeated-graphs).
