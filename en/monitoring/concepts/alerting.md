# Alerting

Alerts in {{ monitoring-full-name }} are used to notify Yandex.Cloud users when metrics change.
For instance, you can set up an alert to be notified when your cloud resource status changes, so that you can respond to issues in time.

The alerting mechanism tracks changes in selected metrics using [alerts](#alert) and notifies users through [notification channels](#notification-channel).

## Alert {#alert}

_An alert_ is a function on the metric value that is calculated once per minute. The resulting value is compared with the preset thresholds.

If the function value reaches a threshold, {{ monitoring-short-name }} switches the alert to the [status](#alert-statuses) `Alert` or `Warning` and notifies the user via [the notification channel](#notification-channel).

### Alert statuses {#alert-statuses}

Alerts can have the following statuses:

| Status | Description |
| ----- | ----- |
| `OK` | The metric value is within the normal range |
| `Warning` | The metric value has reached the `Warning threshold` |
| `Alarm` | The metric value has reached the critical `Alarm threshold` |
| `No Data` | Not enough metric data to calculate the alert function |
| `Error` | Can't calculate the alert value |

### Alert parameters {#alert-parameters}

The alert parameters are set at alert creation. After saving the alert, you can edit the parameters.

Using the parameters, you can change the calculation conditions of the alert function (for example, define the [aggregation function](#aggregation) or [evaluation window](#evaluation-window)).

The main alert parameters are the metrics to use for calculating the function. You can use [queries](data-model. md#queries) to calculate metrics for the alert.
For example, you can create a single alert for multiple VM instances.

#### Alert conditions {#condition}

You can set the metric thresholds that {{ monitoring-short-name }}trigger your alerts for the `Alarm` and `Warning` statuses.

#### Evaluation window {#evaluation-window}

The time period for the alert aggregation function.
You can use the evaluation window to avoid reacting to spikes in metrics and only react to changes over extended periods of time.

You can pick from the preset window values or set up your own window in the format:

* `1h`: 1 hour.
* `1m`: 1 minute.
* `1s`: 1 second.

The minimum value is 1 minute (`1m`).
The maximum values is 1 hour (`1h`).

> For example, the value `3m 45s` sets a time window of 3 minutes and 45 seconds.

#### Aggregation functions {#aggregation}

This function is applied to the metric values within the [evaluation window](#evaluation-window).
The resulting function value is compared with the specified alert thresholds.
If the value meets the alert threshold, {{ monitoring-full-name }} changes its status.

| Aggregation function | Description |
| ----- | ----- |
| **Average** | Calculates the average value over the period for each metric.<br/>For example, if the query returns two metrics, then {{ monitoring-short-name }} calculates the average value for each of them within the given window |
| **Count** | Calculates the number of metric values within the specified period |
| **Last** | Uses the last metric value of the given period. If the metric values can't be obtained, {{ monitoring-full-name }} changes the alert status to `No Data` |
| **Maximum** | Uses the maximum metric value over the period |
| **Minimum** | Uses the minimum metric value over the period |
| **Sum** | Calculates the sum of values of each metric over the specified period |

> For example, if you want to keep track of the last metric value over the last 15 minutes, then select the **Last** function and set **Evaluation window to** `15m`.

## Notification channel {#notification-channel}

You can set up a notification channel to get notified when an alert changes to a different status.
The channel contains information about recipients and how to send notifications.

You can use the same channel for multiple alerts.

### Notification channel parameters {#channel-parameters}

- **Recipients**. List of users who get notified if the alert function is triggered.

    {% note info %}

    You can only specify a Yandex.Cloud account as a notification recipient.
To send an SMS, link a phone number to the user account.

    Learn more about Yandex.Cloud accounts in the documentation for [{{ iam-full-name }}](../../iam/concepts/index.md#accounts).

    {% endnote %}

- **Notification method**. The method for notifying users. Supported methods:
  - Email;
  - SMS.

After you create a channel, the additional parameters become available:

- **Notify about the status**. Select the list of alert statuses to send to the notification channel.
- **Re-notification**. Select the period for {{ monitoring-short-name }} to repeat notifications on the same alert status.

### Sending statuses {#dispatch-statuses}

Each sending can have one of the following statuses:

| Status | Description |
| ----- | ----- |
| `Success` | The notification has been sent successfully |
| `Failed to send` | Couldn't send the notification due to an error |
| `Resource unavailable` | Couldn't send the notification due to restrictions on the sending method |

