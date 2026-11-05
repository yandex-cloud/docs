---
title: Alerts in {{ monitoring-full-name }}
description: In {{ monitoring-short-name }}, an alert is a sequence of named queries calculated on a regular basis. Learn more about alerts, their statuses, setup, and usage in this article.
---

# Alert

{% include [alert-definition](../../../_includes/monium/alert-definition.md) %}

A _multialert_ is an alert that creates a separate subalert for every unique combination of values in the selected metric labels. For example, if a metric has the `host` label with three values (`host1`, `host2`, and `host3`), the multialert will create three independent subalerts, one for each host. This allows you to monitor metrics from different resources using a single alert.

## Alert statuses {#alert-statuses}

An alert can have one of the following statuses:

{% include [alert-statuses-table](../../../_includes/monium/alert-statuses-table.md) %}

The alert color is transmitted with the [Telegram notification](../../operations/alert/create-channel.md).

## Alert evaluation history {#evaluation-history}

Alert evaluation history is represented as a chart that consists of columns colored depending on the alert status as of its calculation.

To navigate through history, you can choose one of the preset output scales:

* `1h`: 1 hour
* `1d`: 1 day
* `1w`: 1 week
* `1m`: 1 month

The minimum scale is `1h`. Each chart column shows the alert status for the given minute. For big output scales, the column color is made up of the statuses calculated within the interval.

By clicking a column, you bring up the alert settings information as of the selected evaluation point.

{% note info %}

When drawing data from the evaluation history, the alert status is re-evaluated and presented in the **{{ ui-key.yacloud_monitoring.monitoring-alerts.list-table.evaluation-stats-single }}** field. The alert status in the history may differ from the current evaluation result due to the specifics of [historical data decimation](../decimation.md) or delays in [data delivery](../data-collection/unified-agent/index.md) to {{ monitoring-name }}.

{% endnote %}

## Alert settings {#alert-parameters}

### Alert severity {#severity}

Alert severity indicates how critical the alert is and helps prioritize the response. You can use alert severity to filter alerts, set up notifications, and route incidents.

Alerts can have the following severity levels:

* `Unspecified`: No severity specified, e.g., a test alert without a severity level selected.
* `Disaster`: Critical incident, e.g., service unavailable, writes not accepted by the database, risk of data loss.
* `Critical`: Serious issue, e.g., API latency growing, low disk space, some instances are unavailable.
* `Info`: Informational event, e.g., end of a planned operation or triggering of a test alert. This is a default value.

### Queries {#queries}

This is a set of [queries](../data-model.md#queries) that return a line or multiple lines.

You can:

* Disable query calculation by clicking ![image](../../../_assets/console-icons/ellipsis.svg) and selecting **{{ ui-key.yacloud_monitoring.actions.common.deactivate }}**. Links to queries that are not calculated will return errors.
* Hide query calculation results from the chart by clicking ![image](../../../_assets/console-icons/eye.svg).
* Display query calculation results on the chart by clicking ![image](../../../_assets/console-icons/eye-slash.svg).

### Trigger conditions {#condition}

#### Query for verification {#request}

Name of the query the result of which is processed using the [aggregation function](#aggregation).

#### Aggregation function {#aggregation}

The aggregation function is applied to the result of the [query for verification](#request). It decides which value will be compared against the `Warning` and `Alarm` thresholds.

Aggregation function| Description
----- | -----
**{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.at-least-one }}** | Checks if at least one evaluation window value has reached the threshold. Suitable for short but critical spikes, e.g., `5xx` errors or a sharp increase in API latency.
**{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.at-all-times }}** | Checks if all evaluation window values have reached the threshold. Helps respond only to persistent issues, e.g., consistently high CPU load.
**{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.avg }}** | Calculates an average value for each metric in the specified period. Use this function for smoothed metrics, e.g., average response latency or average CPU utilization.
**{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.count }}** | Calculates the number of metric values in the specified period. Use this function when the fact of data points coming in is what matters, e.g., to count errors or events within a window.
**{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.last-non-nan }}** | Uses the latest metric value in the specified period. Suitable for status metrics, e.g., instance availability or health check result.
**{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.max }}** | Uses the maximum metric value in the specified period. Helps detect peak values, e.g., maximum request latency or disk space usage.
**{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.min }}** | Uses the minimum metric value in the specified period. Suitable for free resource metrics, e.g., free disk space or available replica count.
**{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.sum }}** | Calculates the sum of values for each metric in the specified period. Use this function for event counters, e.g., error or container restart count.

For example, to track the metric's last value within the last 15 minutes, select the **{{ ui-key.yacloud_monitoring.alert.title_aggregation-last_non_nan }}** function and set the [evaluation window](#evaluation-window) to `15m`.

#### Comparison function {#comparison}

Comparison functions are applied to [aggregation function](#aggregation) calculation results and the [{{ ui-key.yacloud_monitoring.alert.status_warn }}](#warning) and [{{ ui-key.yacloud_monitoring.alert.status_alarm }}](#alarm) threshold values. If the aggregated value meets the specified comparison condition, {{ monitoring-name }} changes the alert status.

Choose the comparison based on the meaning of the metric. For latency, error rate, CPU utilization, and disk usage the **Greater than** or **Greater than or equals** conditions are typically used. For free disk space, available memory, number of available replicas, and remaining quota, **Less than** or **Less than or equals** are typically used.

#### {{ ui-key.yacloud_monitoring.alert.status_warn }} {#warning}

Threshold value upon which the alert status changes to `{{ ui-key.yacloud_monitoring.alert.status_warn }}`.

#### {{ ui-key.yacloud_monitoring.alert.status_alarm }} {#alarm}

Threshold value upon which the alert status changes to `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`.

#### Evaluation window {#evaluation-window}

Time interval for which the [aggregation function](#aggregation) is calculated. The window allows to exclude sudden changes in metric values by only responding to changes over a longer period.

With a short window, the alert detects issues faster but is more sensitive to random spikes. A long evaluation window reduces noise but increases the response time. For example, a `1m` window is suitable for the API availability, and a `15m` window, for sustained increase in disk latency or utilization.

You can select a preset value or specify your own in the following format:
* `1h`: 1 hour
* `1m`: 1 minute
* `1s`: 1 second

For example, `3m 45s` sets an evaluation window of 3 minutes 45 seconds.

#### Evaluation delay {#evaluation-delay}

Back-shift of the time window in seconds. The default value is 0. Allows avoiding a situation when an alert is triggered unexpectedly, if a query uses metrics collected at a different interval. You can select a preset value or specify your own, same as for the [evaluation window](#evaluation-window).

Latency is useful for aggregated metrics that arrive later than the source events. For example, if the application is sending its metrics once per minute and the agent delivers them with a delay of up to 30 seconds, set the latency to `30s` or more. This way, the alert will check the already filled window, not the incomplete most recent data.

### Data decimation {#decimation}

Data decimation reduces the number of points used to evaluate the alert. If there are too many points for the selected period, {{ monium-name }} uses a decimation aggregation function to consolidate them.

Select a decimation function based on the metric type:

* **Default**: Use if no separate logic is required for a dense stream of data points.
* **Average**: Suitable for stable load metrics, e.g., average CPU load.
* **Maximum**: Keeps the peak values, e.g., maximum response latency or disk utilization.
* **Minimum**: Keeps the lower boundary, e.g., minimum free space.
* **Last**: Suitable for status metrics, e.g., instance availability indicator.
* **Sum**: Suitable for event counters, e.g., the number of errors over a period.
* **Count**: Shows the number of data points that fall within a period.

If the alert needs respond to a short spike, do not use decimation with averaging as it may hide the peak. For p95 or p99 latency, **Maximum** is commonly used to capture the worst values. For error counters, **Sum** is used to avoid losing the total volume of events.

The **Fill** property determines how to process gaps between data points before evaluating the alert. **Previous value** is used for status metrics that change rarely, e.g., instance availability indicator. **Null** keeps the gap and helps detect metric delivery failures. **No value** does not substitute a data point into the evaluation and reduces the risk of false average.

## No data policy {#no-data-policy}

No data policies define how the service responds when no data points or metrics are available in the [evaluation window](#evaluation-window). Data points may be missing due to delays in data collection or for other reasons. These policies apply before calculating the [trigger conditions](#condition) and set the alert to the appropriate status.

The **Policy application** property says when to apply the selected policies:

* **Strict**: The policy triggers if there are no data points in any of the time series or no metrics in any of the selectors. Use this mode for critical checks where losing a single line is important by itself, e.g., for each database replica.
* **Simplified**: The policy triggers if there are no data points in all the time series or no metrics in all the selectors. Use this mode for dynamic infrastructure, where individual pods or instances may disappear during autoscaling.

{% note info %}

A data point is a metric value collected over a specific time period. Missing data points signify that no metric values were collected in the evaluation window, resulting in no data for analysis and visualization.

{% endnote %}

Available policy options:

* `{{ ui-key.yacloud_monitoring.alert-template.no-metrics-policy.manual }}`: Policy for manual no data handling. If historical data is available, the chart will be displayed even if the evaluation window contains no data. You can use this policy to view the current values for an in-depth analysis.
* `{{ ui-key.yacloud_monitoring.alert-template.no-metrics-policy.ok }}`, `{{ ui-key.yacloud_monitoring.alert-template.no-metrics-policy.warn }}`, `{{ ui-key.yacloud_monitoring.alert-template.no-metrics-policy.alarm }}`, `{{ ui-key.yacloud_monitoring.alert-template.no-metrics-policy.no-data-key-value }}`: If data for at least one metric is missing in the evaluation window, each of these policies automatically sets the alert to the appropriate status. Historical data is ignored. When there is no data in the evaluation window, the chart will no longer be displayed.

    Changing the evaluation window size may affect the availability of data points and the chart display.

When there are no metrics or points in an evaluation window, you can handle this scenario in two ways:

* Change the alert status using the [No metrics by selector](#no-metrics-policy) or [No points in evaluation window](#no-points-policy) policies.
* Handle it [manually](#manual-policy).

{% note info %}

To make alerts switch to the `No data` status when there are no metrics or points in the evaluation window, set the policy value for all alert types to `No data`. Avoid using the `Default` and `Manual` values as they require extra [manual handling](#manual-policy).

{% endnote %}

### No selector metrics {#no-metrics-policy}

The policy determines the alert status if no metrics were found for at least one selector. For example, these metrics do not exist or they were deleted after their [TTL](../ttl.md) expired.

This situation is different from having no data points. The selector returns no metrics if the resource was deleted, its label was changed, or the application stopped sending the metric. For critical resources, use `No data` to quickly detect selector errors or metric collection failures.

The possible values are:

* `Default`: `No data` for all alert types.
* `{{ ui-key.yacloud_monitoring.alert-template.no-metrics-policy.ok }}`: Changes the alert status to `OK`.
* `{{ ui-key.yacloud_monitoring.alert-template.no-metrics-policy.warn }}`: Changes the alert status to `Warning`.
* `{{ ui-key.yacloud_monitoring.alert-template.no-metrics-policy.alarm }}`: Changes the alert status to `Alarm`.
* `{{ ui-key.yacloud_monitoring.alert-template.no-metrics-policy.no-data-key-value }}`: Changes the alert status to `No data`.

### No points in evaluation window {#no-points-policy}

The policy determines the alert status if at least one of the metrics in the evaluation window has no points.

The metric still exists but has not received any new values during the selected window. This can be caused by agent delays, infrequent metric delivery, application downtime, or network failures. If a metric comes once every five minutes, do not set the window to `1m` because the alert will be getting the `No data` status often.

For threshold alerts that monitor several metrics, predicates are checked for each metric independently. The final alert status is an aggregation of statuses for each of the metrics in the following order: `No data` < `OK` < `Warning` < `Error` < `Alarm`. If there is a line that has no points, and the `No points in evaluation window` policy changes the status of a threshold alert to `Warning`, while for another line, the predicate that changes the alert to `Alarm` is true, the resulting alert status will be `Alarm`.

The possible values are:

* `Default`: Default value (`No data`) for all types of threshold alerts.
* `{{ ui-key.yacloud_monitoring.alert-template.no-points-policy.ok }}`: Changes the alert status to `OK`.
* `{{ ui-key.yacloud_monitoring.alert-template.no-points-policy.warn }}`: Changes the alert status to `Warning`.
* `{{ ui-key.yacloud_monitoring.alert-template.no-points-policy.alarm }}`: Changes the alert status to `Alarm`.
* `{{ ui-key.yacloud_monitoring.alert-template.no-points-policy.no-data-key-value }}`: Changes the alert status to `No data`.
* `{{ ui-key.yacloud_monitoring.alert-template.no-points-policy.manual }}`: Gives control to the predicates or alert program for [manual handling](#manual-policy).

### Manual processing of no data {#manual-policy}

Setting the `Manual` value for any policy will give control to the alert predicates or program.

Avoid the `Manual` value as it complicates the alert program. The `No data` policy value should cover most cases.

## Notifications {#notifications}

Notifications help keep relevant users or systems informed about alert status changes. You can select a notification channel and set up additional rules for an alert.

### Noise suppression {#noise-suppression}

Noise suppression reduces the number of notifications when the alert status changes frequently. After the first status change, {{ monium-name }} starts the timeout interval. If status changes several times during this interval, {{ monium-name }} will send one notification with the resulting status.

This setting is useful for metrics rapidly fluctuating near a threshold. For example, an API latency alert may switch between `OK` and `Warning` several times during a brief load spike. Without noise suppression, the operator on duty will receive several notifications; with noise suppression, one notification after the status stabilizes.

The interval should be longer than the typical duration of a brief spike but shorter than acceptable incident response time. For example, you can set an interval of several minutes for an unstable background task, and use a short interval or disable noise suppression altogether for a critical API.

The resulting status depends on your priority settings. If your priority is not to miss an incident, prioritize the more critical status. If your priority is to get the system’s last state after the stabilization, the last status should be prioritized.

## Composite alerts {#composite-alerts}

A _composite alert_ is an alert that calculates its status based on the statuses of other alerts. It can help you reduce the noise produced individual notifications and respond only to combinations of triggers.

The composite alert uses a selector to find the source alerts and applies the selected composition strategy to them:

* **By share**: The composite alert triggers if the specified share of the found alerts are in the selected statuses.
* **By count**: The composite alert triggers if at least the specified number of the found alerts are in the selected statuses.

For `Warning` and `Alarm`, you need to configure separate thresholds and source statuses. The threshold type depends on the composition strategy: **By share** uses a percentage, **By count**, an integer.

Let's assume, the selected strategy is **By share**, the `Alarm` threshold equals `10%`, and the statuses are `Warning` and `Alarm`. In this case, the composite alert will get the `Alarm` status if at least 10% of alerts found by the selector are in one of these statuses.

Additional composite alert settings:

* **Force the composite status to No Data**: Sets the composite alert status to `No data` if at least one source alert has this status.
* **Force the composite status to Error**: Sets the composite alert status to `Error` if at least one source alert has this status.
* **Treat muted alerts as Ok**: Counts muted source alerts as the `Ok` status.

You can add source alert annotations to a composite alert. Do it by selecting one or more annotations from the alerts found by the selector. The values of such annotations are built from the keys and values of annotation of several source alerts which have recently changed their status.

## SLO alerts {#slo-alerts}

An _SLO alert_ is an alert which monitors the [error budget](../../slo/index.md#basic-terms) of the selected [SLO](../../slo/index.md). It helps respond not only to individual failures but also to the risk of falling below the service’s target reliability level.

SLO alerts use calculated SLO values, SLI value, SLO target, and the balance of error budget. This type of alert is useful when you need to monitor user scenario quality over a period rather than an individual technical metric.

There are two available types of SLO alerts:

* **Error Budget**: Triggers when the remaining error budget falls below the specified threshold. Use it for early detection of the risk of error budget depletion.
* **Burn Rate**: Triggers when the rate of error budget consumption over the selected evaluation window exceeds the specified threshold. Use it to detect incidents that quickly degrade the SLO.

For `Warning` and `Alarm`, you need to configure separate thresholds. Typically, `Warning` is used for early warning, and `Alarm` for situations that require a response from the operator on duty.

SLO alerts complement metric alerts but do not replace them. Metric alerts help you find the technical cause of the issue, while SLO alerts show how it affects the reliability of the service.

To create an SLO alert, follow [this guide](../../operations/alert/create-slo-alert.md).

## Multialerts {#multi-alerts}

Multialerts allow you to use the same checks for same-type entities, e.g., for all cluster hosts, server disks, or database shards. Instead of creating several separate alerts, you create a single parent alert and select labels for decomposition.

### Creating a multialert {#create-multi-alert}

To create a multialert, specify one or more labels in **Decomposition by labels**. {{ monium-name }} will automatically create a separate subalert for each unique label value or a combination of several label values.

Decomposition examples:

* If you specify the `host` label, it will create a subalert for each host.
* If you specify the `disk` label, it will create a subalert for each disk.
* If you specify the `host` and `disk` labels, it will create a subalert for each host-disk combination.

Select the labels that require separate diagnostics or a separate response. For example, the `disk` label helps you get a separate full disk trigger, and the `zone` label, see an issue in a specific availability zone.

Do not use labels with many unique values, e.g., `request_id`, `trace_id`, and `user_id`, or dynamic container IDs. These may create numerous subalerts, complicate incident forensics, and increase alert quota usage.

### Subalerts {#sub-alerts}

A _subalert_ is an automatically created alert which cannot be edited manually. Its parameters are decided by the parent multialert. Each subalert is:

* Calculated and triggered independently of other subalerts.
* Created automatically when metrics with new label values appear.
* Deleted automatically when the matching metrics are deleted.

A subalert has a status and evaluation history of its own. This helps you quickly identify the affected entity, be it a specific host, disk, availability zone, or shard. If the issue affects only one disk, only that disk’s subalert will get the `Alarm` status, not all the multialert checks.

Subalerts inherit queries, thresholds, no data policies, and notifications from the parent multialert. You cannot update an individual subalert separately. To temporarily disable notifications for a specific entity, use a mute based on the subalert’s labels.

### Multialert example {#multi-alert-example}

To create a multialert to monitor CPU utilization by the {{ compute-name }} resources, use the following selector:

```text
{project = "<project_id>", service = "__compute__", cluster = "default", name = "cpu_usage", resource_id = "*", resource_type = "*"}
```

Specify the `resource_id` and `resource_type` labels in **Decomposition by labels**. This create a separate subalert for every unique combination of type and resource ID.

### Viewing a multialert {#view-multi-alert}

On the multialert page:

* Under **Alert evaluation history**, you can see a summary of the number of subalerts in each status.
* Under **Subalerts**, there is a list of subalerts which you can filter by label and status.
