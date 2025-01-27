---
title: Alerts in {{ monitoring-full-name }}
description: In {{ monitoring-short-name }}, an alert is a sequence of named queries calculated on a regular basis. Learn more about alerts, their statuses, setup, and usage in this article.
---

# Alert

An _alert_ is a set of consecutive named [queries](../data-model.md#queries) calculated on a regular basis.

A set of queries is calculated once a minute. The resulting query value specified in the [settings](#alert-parameters) is compared to the preset threshold values.

If the result of the query specified in the [settings](#alert-parameters) reaches the preset threshold value, {{ monitoring-short-name }} changes the alert [status](#alert-statuses) to `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` or `{{ ui-key.yacloud_monitoring.alert.status_warn }}` and notifies the user via a [notification channel](./notification-channel.md).

## Alert statuses {#alert-statuses}

An alert can have one of the following statuses:

Status | Description
----- | -----
`{{ ui-key.yacloud_monitoring.alert.status_ok }}` | The metric value is within the specified normal threshold.
`{{ ui-key.yacloud_monitoring.alert.status_warn }}` | The metric value has reached the `Warning` threshold.
`{{ ui-key.yacloud_monitoring.alert.status_alarm }}` | The metric value has reached the `Alarm` critical status threshold.
`{{ ui-key.yacloud_monitoring.alert.status_no_data }}` | Lack of metric data to calculate the alert function.
`{{ ui-key.yacloud_monitoring.alert.status_error }}` | The alert value cannot be calculated.

## Alert evaluation history {#evaluation-history}

Alert evaluation history is represented as a chart that consists of columns colored depending on the alert status as of its calculation.

To navigate through history, you can choose one of the preset output scales:

* `1h`: 1 hour
* `1d`: 1 day
* `1w`: 1 week
* `1m`: 1 month

The minimum history output scale is `1h`: each column in a chart shows the alert status for the respective minute. For big output scales, the column color is made up of the statuses calculated within the interval.

By clicking a column, you bring up the alert settings information as of the selected evaluation point.

{% note info %}

When drawing data from the evaluation history, the alert status is re-evaluated and presented in the **{{ ui-key.yacloud_monitoring.monitoring-alerts.list-table.evaluation-stats-single }}** field. The alert status in the history may differ from the current evaluation result due to the specifics of [historical data decimation](../decimation.md) or delays in [data delivery](../data-collection/unified-agent/index.md) to {{ monitoring-name }}.

{% endnote %}

## Alert settings {#alert-parameters}

Alert settings are configured when creating an alert. You can edit them after you save the alert.

### Queries {#queries}

This is a set of [queries](../data-model.md#queries) that return a line or multiple lines.

You can:

* Disable query calculation by clicking ![image](../../../_assets/console-icons/ellipsis.svg) and selecting **{{ ui-key.yacloud_monitoring.actions.common.deactivate }}**. Links to queries that are not calculated will return errors.
* Hide query calculation results from the chart by clicking ![image](../../../_assets/console-icons/eye.svg).
* Display query calculation results on the chart by clicking ![image](../../../_assets/console-icons/eye-slash.svg).

### Alert triggers {#condition}

#### Test query {#request}

Name of query to whose calculation result an [aggregation function](#aggregation) applies.

#### Aggregation function {#aggregation}

Aggregation function is applied to the [test query](#request) calculation results.

Aggregation function| Description
----- | -----
**{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.at-least-one }}** | At least one metric value in the query exceeds the thresholds set in the specified period.
**{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.at-all-times }}** | All metric values in the query exceed the thresholds set in the specified period.
**{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.avg }}** | Calculates an average value for each metric in the specified period. For example, if a query returns two metrics, {{ monitoring-short-name }} calculates an average value for each of them in the specified window.
**{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.count }}** | Calculates the number of metric values in the specified period.
**{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.last-non-nan }}** | Uses the latest metric value in the specified period. If {{ monitoring-full-name }} could not obtain the metric value, it changes the alert status to `{{ ui-key.yacloud_monitoring.alert.status_no_data }}`.
**{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.max }}** | Uses the maximum metric value in the specified period.
**{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.min }}** | Uses the minimum metric value in the specified period.
**{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.sum }}** | Calculates the sum of values for each metric in the specified period.

For example, to track the latest metric value within the last 15 minutes, select the **{{ ui-key.yacloud_monitoring.alert.title_aggregation-last_non_nan }}** function and set the [evaluation window](#evaluation-window) to `15m`.

#### Comparison function {#comparison}

Comparison functions are applied to [aggregation function](#aggregation) calculation results and the [{{ ui-key.yacloud_monitoring.alert.status_warn }}](#warn) and [{{ ui-key.yacloud_monitoring.alert.status_alarm }}](#alarm) threshold values. If an aggregated value matches the threshold one, {{ monitoring-name }} changes the alert status.

#### {{ ui-key.yacloud_monitoring.alert.status_warn }} {#warning}

Threshold value upon which the alert status changes to `{{ ui-key.yacloud_monitoring.alert.status_warn }}`.

#### {{ ui-key.yacloud_monitoring.alert.status_alarm }} {#alarm}

Threshold value upon which the alert status changes to `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`.

#### Evaluation window {#evaluation-window}

Time interval for which the [aggregation function](#aggregation) is calculated. The window allows to exclude sudden changes in metric values by only responding to changes over a longer period.

You can select a preset value or specify your own in the following format:
* `1h`: 1 hour
* `1m`: 1 minute
* `1s`: 1 second

For example, `3m 45s` sets an evaluation window of 3 minutes 45 seconds.

#### Evaluation delay {#evaluation-delay}

Back-shift of the time window in seconds. The default value is 0. Allows avoiding a situation when an alert is triggered unexpectedly, if a query uses metrics collected at a different interval. You can select a preset value or specify your own, same as for the [evaluation window](#evaluation-window).

## No data policy {#no-data-policy}

Policies set the alert status when there is no data or metrics in the evaluation window for a given criterion. Policies are applied prior to verifying trigger conditions.

When there are no metrics or points in an evaluation window, you can handle this scenario in two ways:

* Change the alert status using the [No metrics by selector](#no-metrics-policy) or [No points in evaluation window](#no-points-policy) policies.
* Handle it [manually](#manual-policy).

{% note info %}

To make alerts switch to the `No data` status when there are no metrics or points in the evaluation window, set the policy value for all alert types to `No data`. Avoid using the `Default` and `Manual` values as they require extra [manual handling](#manual-policy).

{% endnote %}

### No selector metrics {#no-metrics-policy}

The policy determines the alert status if no metrics were found for at least one selector. For example, these metrics do not exist or they were deleted after their [TTL](../ttl.md) expired.

The possible values are:

* `Default`: `No data` for all alert types.
* `OK`: Changes the alert status to `OK`.
* `Warn`: Changes the alert status to `Warning`.
* `Alarm`: Changes the alert status to `Alarm`.
* `No data`: Changes the alert status to `No data`.
* `Manual`: Supported only for alerts with the `Expression` type; gives control to the alert program for [manual handling](#manual-policy).
  
    If no metrics were found for such an alert for at least one selector and no status management function was triggered, the alert will switch to the `OK` state.

### No points in evaluation window {#no-points-policy}

The policy determines the alert status if at least one of the metrics in the evaluation window has no points.

For threshold alerts that monitor several metrics, predicates are checked for each metric independently. The final alert status is an aggregation of statuses for each of the metrics in the following order: `No data` < `OK` < `Warning` < `Error` < `Alarm`. If there is a line that has no points, and the `No points in evaluation window` policy changes the status of a threshold alert to `Warning`, while for another line, the predicate that changes the alert to `Alarm` is true, the resulting alert status will be `Alarm`.

The possible values are:

* `Default`: `No data` for all threshold alerts and `Manual` for `Expression` alerts.
* `OK`: Changes the alert status to `OK`.
* `Warning`: Changes the alert status to `Warning`.
* `Alarm`: Changes the alert status to `Alarm`.
* `No data`: Changes the alert status to `No data`.
* `Manual`: Gives control to the predicates or alert program for [manual handling](#manual-policy).

If the `No points in evaluation window` parameter is set to `Manual` or `Default` for an `Expression` alert, while its evaluation window has no points and no status management function has been triggered in the alert program, the alert status will change to `OK`. We recommend using the `No data` value for the `No points in evaluation window` policy. If you set the policy value to `Manual` or `Default`, the no-points situation is handled [manually](#manual-policy).

### Manual processing of no data {#manual-policy}

Setting the `Manual` value for any policy will give control to the alert predicates or program.

Avoid the `Manual` value as it complicates the alert program. The `No data` policy value should cover most cases.

#### No metrics {#no-metrics-manual}

To manually handle `Expression` alerts with no metrics, you can use the `size` function and status management functions: you will get the number of metrics for the selector you specify.

An example of a program that will change the alert to the `OK` status if the selector specified in the `xx5` variable has retrieved 0 metrics:

```javascript
let xx5 = {
  project="solomon",
  cluster="production",
  service="gateway",
  endpoint="*",
  code="5*",
  method="*",
  host="cluster",
  name="http.server.requests.status"
};
...
ok_if(size(xx5) == 0);
...
```

#### No points {#no-points-manual}

To manually handle the no-points situation, use the `count` function and the status management functions: you will get the number of points for a specified selector in the evaluation window.

Example of a program that will change the alert to `No data` if there are no points for the metric specified in the `source` variable within the alert's evaluation window:

```javascript
let source = {
  project="solomon",
  cluster="production",
  service="alerting",
  endpoint="api.telegram.org/send*",
  host="cluster",
  name="http.client.call.inFlight"
};
...
no_data_if(count(source) == 0);
...
```
