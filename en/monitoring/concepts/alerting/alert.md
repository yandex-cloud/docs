# Alert

An _alert_ is a set of consecutive named [queries](../data-model.md#queries) calculated on a regular basis.

A set of queries is calculated once a minute. The resulting query value specified in the [settings](#alert-parameters) is compared to the preset threshold values.

If the result of the query specified in the [settings](#alert-parameters) reaches the preset threshold value, {{ monitoring-short-name }} changes the alert [status](#alert-statuses) to `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` or `{{ ui-key.yacloud_monitoring.alert.status_warn }}` and notifies the user via a [notification channel](./notification-channel.md).

## Alert statuses {#alert-statuses}

An alert can have one of the following statuses:

| Status | Description |
----- | -----
| `{{ ui-key.yacloud_monitoring.alert.status_ok }}` | The metric value is within the specified normal threshold. |
| `{{ ui-key.yacloud_monitoring.alert.status_warn }}` | The metric value has reached the `Warning` threshold. |
| `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` | The metric value has reached the `Alarm` critical status threshold. |
| `{{ ui-key.yacloud_monitoring.alert.status_no_data }}` | Lack of metric data to calculate the alert function. |
| `{{ ui-key.yacloud_monitoring.alert.status_error }}` | The alert value cannot be calculated. |

## Alert evaluation history {#evaluation-history}

Alert evaluation history is represented as a chart that consists of columns colored depending on the alert status as of its calculation.

To navigate through history, you can choose one of the preset output scales:

* `1h`: One hour
* `1d`: One day
* `1w`: One week
* `1m`: One month

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

* Disable query calculation by clicking ![image](../../../_assets/console-icons/ellipsis.svg) or selecting **{{ ui-key.yacloud_monitoring.actions.common.deactivate }}**. Links to queries that are not calculated will return errors.
* Hide query calculation results on the chart by clicking ![image](../../../_assets/console-icons/eye.svg).
* Present query calculation results on the chart by clicking ![image](../../../_assets/console-icons/eye-slash.svg).

### Alert triggers {#condition}

#### Test query {#request}

Name of query to whose calculation result an [aggregation function](#aggregation) applies.

#### Aggregation function {#aggregation}

Aggregation function is applied to the [test query](#request) calculation results.

| Aggregation function | Description |
----- | -----
| **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.at-least-one }}** | At least one metric value in the query exceeds the thresholds set in the specified period. |
| **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.at-all-times }}** | All metric values in the query exceed the thresholds set in the specified period. |
| **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.avg }}** | Calculates an average value for each metric in the specified period. For example, if a query returns two metrics, {{ monitoring-short-name }} calculates an average value for each of them in the specified window. |
| **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.count }}** | Calculates the number of metric values in the specified period. |
| **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.last-non-nan }}** | Uses the latest metric value in the specified period. If {{ monitoring-full-name }} could not obtain the metric value, it changes the alert status to `{{ ui-key.yacloud_monitoring.alert.status_no_data }}`. |
| **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.max }}** | Uses the maximum metric value in the specified period. |
| **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.min }}** | Uses the minimum metric value in the specified period. |
| **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.sum }}** | Calculates the sum of values for each metric in the specified period. |

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
* `1h`: One hour
* `1m`: One minute
* `1s`: One second

For example, the value `3m 45s` sets an evaluation window of 3 minutes 45 seconds.

#### Evaluation delay {#evaluation-delay}

Back-shift of the time window in seconds. The default value is 0. Allows avoiding a situation when an alert is triggered unexpectedly, if a query uses metrics collected at a different interval. You can select a preset value or specify your own, same as for the [evaluation window](evaluation-window).

## No data processing {#no-data-policy}

Policies define the status an alert will get if there are no points in the evaluation window or no metrics matching the specified selector. Policies apply before calculating the alert trigger conditions and, depending on the result, the alert gets the status specified in the settings.
