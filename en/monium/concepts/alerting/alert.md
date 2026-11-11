---
title: Alerts in {{ monitoring-full-name }}
description: In {{ monitoring-short-name }}, an alert is a sequence of named queries calculated on a regular basis. Learn more about alerts, their statuses, setup, and usage in this article.
---

# Alert

{% include [alert-definition](../../../_includes/monium/alert-definition.md) %}

A _multialert_ is an alert that creates a separate subalert for every unique combination of values in the selected metric labels. For example, if a metric has the `host` label with three values (`host1`, `host2`, and `host3`), the multialert will create three independent subalerts, one for each host. This allows you to monitor metrics from different resources using a single alert.

You can add no more than {{ alerting-metrics-limit }} metrics to a single standard alert or sub-alert. If there are more metrics:

* Create a [multialert](#multi-alerts) to distribute metrics across sub-alerts.
* Aggregate metrics within the application before sending them.

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

{{ monium-name }} determines the time range for loading metrics based on the [evaluation window](#evaluation-window), [evaluation delay](#evaluation-delay), and functions that modify this range, such as `shift` or `moving_avg`. Metrics that do not pass the [time range filter](../querying.md#time-range-filtering) are not loaded.

You can:

* Disable query calculation by clicking ![image](../../../_assets/console-icons/ellipsis.svg) and selecting **{{ ui-key.yacloud_monitoring.actions.common.deactivate }}**. Links to queries that are not calculated will return errors.
* Hide query calculation results from the chart by clicking ![image](../../../_assets/console-icons/eye.svg).
* Display query calculation results on the chart by clicking ![image](../../../_assets/console-icons/eye-slash.svg).

### Alert triggers {#condition}

#### Test query {#request}

Name of query to whose calculation result an [aggregation function](#aggregation) applies.

#### Aggregation function {#aggregation}

The aggregation function is applied to the [test query](#request) calculation result. It decides which value will be compared against the `Warning` and `Alarm` thresholds.

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

Choose the comparison based on the meaning of the metric. For latency, error rate, CPU utilization, and disk usage the **{{ ui-key.yacloud_monitoring.alert.title_comparison-gt }}** or **{{ ui-key.yacloud_monitoring.alert.title_comparison-gte }}** conditions are typically used. For free disk space, available memory, number of available replicas, and remaining quota, **{{ ui-key.yacloud_monitoring.alert.title_comparison-lt }}** or **{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}** are typically used.

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

* **{{ ui-key.yacloud_monitoring.monitoring-alerts.downsampling.aggregation.default }}**: Use if no separate logic is required for a dense stream of data points.
* **{{ ui-key.yacloud_monitoring.monitoring-alerts.downsampling.aggregation.avg }}**: Suitable for stable load metrics, e.g., average CPU load.
* **{{ ui-key.yacloud_monitoring.monitoring-alerts.downsampling.aggregation.max }}**: Keeps the peak values, e.g., maximum response latency or disk utilization.
* **{{ ui-key.yacloud_monitoring.monitoring-alerts.downsampling.aggregation.min }}**: Keeps the lower boundary, e.g., minimum free space.
* **{{ ui-key.yacloud_monitoring.monitoring-alerts.downsampling.aggregation.last }}**: Suitable for status metrics, e.g., instance availability indicator.
* **{{ ui-key.yacloud_monitoring.monitoring-alerts.downsampling.aggregation.sum }}**: Suitable for event counters, e.g., the number of errors over a period.
* **{{ ui-key.yacloud_monitoring.monitoring-alerts.downsampling.aggregation.count }}**: Shows the number of data points that fall within a period.

If the alert needs respond to a short spike, do not use decimation with averaging as it may hide the peak. For p95 or p99 latency, **Maximum** is commonly used to capture the worst values. For error counters, **Sum** is used to avoid losing the total volume of events.

The **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.downsampling-fill }}** parameter determines how gaps between data points are handled before an alert is calculated. **{{ ui-key.yacloud_monitoring.monitoring-alerts.downsampling.fill.previous }}** is suitable for state metrics that change infrequently, e.g., an instance's availability status. **{{ ui-key.yacloud_monitoring.monitoring-alerts.downsampling.fill.null }}** preserves the gap, which helps in detecting failures in metric delivery. **{{ ui-key.yacloud_monitoring.monitoring-alerts.downsampling.fill.empty }}** does not insert a point into the calculation and reduces the risk of a false average value.

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

This policy determines the alert status if no metrics are found based on the selector. For example, they have not yet been created, have not passed the [time interval filter](../querying.md#time-range-filtering), or have been deleted after their [retention period](../common-ttl.md#ttl-metrics) expired.

The possible causes include the deletion of the resource, change in the label, or termination of metric recording. This is different from [having no data points](#no-points-policy): in that case, the metric is found, but there are no values ​​for it within the calculation window. For critical resources, use `No data` to detect selector errors or metric collection failures.

Its possible values are:

* `Default`: `No data` for all alert types.
* `{{ ui-key.yacloud_monitoring.alert-template.no-metrics-policy.ok }}`: Changes the alert status to `OK`.
* `{{ ui-key.yacloud_monitoring.alert-template.no-metrics-policy.warn }}`: Changes the alert status to `Warning`.
* `{{ ui-key.yacloud_monitoring.alert-template.no-metrics-policy.alarm }}`: Changes the alert status to `Alarm`.
* `{{ ui-key.yacloud_monitoring.alert-template.no-metrics-policy.no-data-key-value }}`: Changes the alert status to `No data`.

### No points in evaluation window {#no-points-policy}

The policy determines the alert status if at least one of the metrics in the evaluation window has no points.

The metric still exists but has not received any new values during the selected window. This can be caused by agent delays, infrequent metric delivery, application downtime, or network failures. If a metric comes once every five minutes, do not set the window to `1m` because the alert will be getting the `No data` status often.

For threshold alerts that monitor several metrics, predicates are checked for each metric independently. The final alert status is an aggregation of statuses for each of the metrics in the following order: `No data` < `OK` < `Warning` < `Error` < `Alarm`. If there is a line that has no points, and the `No points in evaluation window` policy changes the status of a threshold alert to `Warning`, while for another line, the predicate that changes the alert to `Alarm` is true, the resulting alert status will be `Alarm`.

Its possible values are:

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

Noise suppression reduces the number of notifications when the alert status changes frequently. After the first status change, {{ monium-name }} starts a wait interval. If the status changes several times within this interval, {{ monium-name }} will send a single notification with the resulting status.

This setting is useful for metrics that fluctuate rapidly around the threshold. For example, an API latency alert may switch between `OK` and `Warning` several times during a brief load spike. Without noise suppression, the on-call engineer will receive multiple notifications, while with noise suppression, a single notification once the status stabilizes.

The interval should be longer than the typical duration of a brief spike but shorter than the acceptable incident response time. For example, you can set an interval of several minutes for an unstable background task, or use a short interval or disable noise suppression for a critical API.

The resulting status depends on the priority setting. If preventing missed incidents is more important, choose the priority of the more critical status. If receiving the system’s latest state after stabilization is more important, choose the priority of the latest status.

## Composite alerts {#composite-alerts}

A _composite alert_ is an alert that calculates its status based on the statuses of other alerts. It helps reduce notification noise and respond only to specific combinations of alert statuses.

The composite alert uses a selector to find source alerts and then applies the selected composition strategy:

* **{{ ui-key.yacloud_monitoring.monitoring-alerts.aggregate.strategy-type.percentage }}**: The composite alert triggers if the specified share of the found alerts are in the selected statuses.
* **{{ ui-key.yacloud_monitoring.monitoring-alerts.aggregate.strategy-type.count }}**: The composite alert triggers if at least the specified number of the found alerts are in the selected statuses.

For `Warning` and `Alarm`, you need to configure separate thresholds and source statuses. The threshold type depends on the composition strategy: **{{ ui-key.yacloud_monitoring.monitoring-alerts.aggregate.strategy-type.percentage }}** uses a percentage, **{{ ui-key.yacloud_monitoring.monitoring-alerts.aggregate.strategy-type.count }}**, an integer.

Let's assume, the selected strategy is **{{ ui-key.yacloud_monitoring.monitoring-alerts.aggregate.strategy-type.percentage }}**, the `Alarm` threshold equals `10%`, and the statuses are `Warning` and `Alarm`. In this case, the composite alert will change to `Alarm` when at least 10% of the alerts found by the selector are in one of these statuses.

Additional composite alert settings:

* **Force the composite status to No Data**: Sets the composite alert status to `No data` if at least one source alert has this status.
* **Force the composite status to Error**: Sets the composite alert status to `Error` if at least one source alert has this status.
* **Treat muted alerts as Ok**: Counts muted source alerts as the `Ok` status.

You can add source alert annotations to a composite alert. To do this, select one or more annotations from the alerts found by the selector. The values of these annotations are built from the annotation keys and values of multiple source alerts that have recently changed their status.

## SLO alerts {#slo-alerts}

_SLO alerts_ monitor [error budgets](../../slo/index.md#basic-terms) of the selected [SLOs](../../slo/index.md). They help respond not only to individual failures but also to the risk of falling below the service’s target reliability level.

An SLO alert uses the calculated metrics of a selected SLO. You cannot set your own queries for metrics in it. An SLO project may differ from an alert project. Breaking down an SLO alert by labels is not supported.

There are two available types of SLO alerts:

* **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo-type.error-budget-key-value }}**: Monitors the remaining error budget or its actual consumption over the alert window.
* **Burn Rate**: Compares the rate at which the error budget is being consumed to the defined thresholds. Helps you detect the risk of an SLO violation in advance, assuming the current rate of budget consumption continues.

For `Warning` and `Alarm`, you need to configure separate thresholds. You need to set at least one of them. If both are set, the `Alarm` threshold value must be lower than the `Warning` threshold value when checking the remaining budget, and higher when checking expenditure or burn rate.

SLO alerts complement metric alerts but do not replace them. Metric alerts help find the technical cause of an issue, while SLO alerts show its impact on service reliability.

To create an SLO alert, follow [{#T}](../../operations/alert/create-slo-alert.md).

### Error budget remaining and consumed {#slo-error-budget}

For the type **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo-type.error-budget-key-value }}**, two calculation methods are available: **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alert-type.absolute }}** and **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alert-type.diff }}**. Specify the thresholds for both methods as a percentage of the error budget.

The **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alert-type.absolute }}** method compares the average remaining budget over the alert calculation window against thresholds. The smaller the remaining balance, the higher the risk of violating an SLO. For example, given the `Warning = 20%` and `Alarm = 10%` thresholds, an alert will switch to `Warning` if the average balance falls below 20%, and to `Alarm` if it falls below 10%. If an SLO has already been breached, the remaining budget may be negative.

The **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alert-type.diff }}** method compares actual expenditure against thresholds: the remaining budget at the end of the window is subtracted from the initial balance at the start. For example, with the `1h` window and the `Alarm = 5%` threshold, the alert will switch to `Alarm` if more than 5% of the budget is spent in an hour. This method is resilient to the issue of low traffic, as it tracks the budget actually spent.

### Burn Rate {#slo-burn-rate}

**Burn Rate**: Rate at which the error budget is being consumed. It equals the ratio of the share of bad events to the allowed error rate:

```text
Burn Rate = (Bad Events / Total Events) / (1 - SLO)
```

In this formula, the SLO is specified as a fraction between zero and one. For example, for an SLO of 99.9%, the 0.999 value is used. A coefficient of 1 means that the error rate is equal to the permissible level, while 2 means it is twice as high.

For an alert to work on the original SLO, you must [enable the calculation of the burn rate](../../slo/management.md#burn-rate). Otherwise, the `burn_rate` metrics are not published, and the alert switches to `No data`. The alert compares the calculated coefficients against the thresholds.

#### Check windows {#slo-burn-rate-windows}

The alert uses long and short windows. Select the long window in the alert settings; the short window is 1/12 of the long one. For example, for the `1h` long window, the short one is equal to `5m`.

For the alert to trigger, the coefficients in both windows must exceed the specified threshold. The long window helps detect a sustained exceedance of the permissible budget consumption rate, while the short one allows for faster detection of a recovery. If the coefficient for the short window drops below the `Alarm` threshold, the alert can switch to `Warning` or `OK`, even if the coefficient for the long window still exceeds that threshold.

#### Methods for setting thresholds {#slo-burn-rate-thresholds}

You can set thresholds using the burn rate coefficient or as a percentage of the budget consumed over the alert window. The share is calculated using this formula:

```text
Budget consumption share = burn rate × alert window / SLO window
```

Make sure the windows share the same unit of time. For example, a 30-day SLO window is equal to 720 hours. For an SLO of this type, a coefficient of 14.4 over the `1h` window matches the share of 14.4 × 1 / 720 = 0.02, i.e., the consumption of 2% of the budget. A coefficient of 6 for the `6h` window matches the expenditure of 5% of the budget.

When traffic is low, the burn rate can increase even if the number of errors remains constant: the error share rises because the total number of events has decreased. To reduce noise, you can maintain a background load using synthetic checks. If you need to monitor a budget that has already been spent, use the **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alert-type.diff }}** method.

## Multialerts {#multi-alerts}

Multialerts enable you to set up similar tests for entities of the same type, e.g., for all cluster hosts, disks on a server, or database shards. Instead of creating several separate alerts, you create a single parent alert and select the labels for decomposition.

### Creating a multialert {#create-multi-alert}

To create a multialert, specify one or more labels in **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.group-by-labels }}**. For every unique label value (or a combination of several label values), {{ monium-name }} will automatically create a separate subalert.

Decomposition examples:

* Specifying the `host` label will create a subalert for each host.
* Specifying the `disk` label will create a subalert for each disk.
* If you specify the `host` and `disk` labels, it will create a subalert for each host-disk combination.

Select the labels that require separate diagnostics or a separate response. For example, the `disk` label helps generate a separate alert for a full disk, while the `zone` label helps identify an issue in a specific availability zone.

Do not use labels with many unique values, such as `request_id`, `trace_id`, and `user_id`, or dynamic container IDs. These may create numerous subalerts, complicate incident analysis, and increase alert quota usage.

### Subalerts {#sub-alerts}

A _subalert_ is an automatically created alert which cannot be edited manually. Its parameters are decided by the parent multialert. Each subalert is:

* Calculated and triggered independently of other subalerts.
* Created automatically when metrics with new label values appear.
* Deleted automatically when the matching metrics are deleted.

Each subalert has its own status and evaluation history. This helps quickly identify the affected entity, such as a specific host, disk, availability zone, or shard. If an issue affects only one disk, that disk’s subalert changes to `Alarm` rather than all checks in the multialert.

Subalerts inherit queries, thresholds, no data policies, and notifications from the parent multialert. You cannot update an individual subalert separately. To temporarily disable notifications for a specific entity, use a mute based on the subalert’s labels.

### Multialert example {#multi-alert-example}

To create a multialert to monitor CPU utilization by the {{ compute-name }} resources, use the following selector:

```text
{project = "<project_id>", service = "__compute__", cluster = "default", name = "cpu_usage", resource_id = "*", resource_type = "*"}
```

Specify the `resource_id` and `resource_type` labels in the **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.group-by-labels }}** parameter. This will result in creating a separate subalert for every unique combination of type and resource ID.

### Viewing a multialert {#view-multi-alert}

On the multialert page:

* Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.calculation-history-alert }}**, you can see a summary of the number of subalerts in each status.
* Under **Subalerts**, you can filter the list of subalerts by label and status.
