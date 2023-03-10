# Alerting

Alerting in {{ monitoring-full-name }} allows notifying cloud users of changes to metrics. For example, you can set up alerts about changes in your cloud resource status and timely respond to an issue.

Alerting tracks changes to certain metrics using [alerts](#alert) and sends notifications via a [notification channel](#notification-channel).

## Alert {#alert}

An _alert_ is a function that is calculated on a regular basis and applied to a metric value.

The function is calculated once a minute. The resulting value is compared to the preset threshold values.

If the function value reaches the specified threshold value, {{ monitoring-short-name }} changes the alert [status](#alert-statuses) to `Alert` or `Warning` and notifies the user via the [notification channel](#notification-channel).

### Alert statuses {#alert-statuses}

An alert can have one of the following statuses:

| Status | Description |
----- | -----
| `OK` | The metric value is within the norm set |
| `Warning` | The metric value has reached the `Warning` threshold |
| `Alarm` | The metric value has reached the `Alarm` critical status threshold |
| `No Data` | Missing metric data for calculating the alert function |
| `Error` | Can't calculate the alert value |

### Alert parameters {#alert-parameters}

Alert parameters are set when creating an alert. You can edit them after you save the alert.

You can use them to change conditions for calculating alert functions, such as set an [aggregation function](#aggregation) or specify an [evaluation window](#evaluation-window).

Metrics whose values a function is calculated on is the main parameter of an alert. Metrics for alerts are set using [requests](data-model.md#queries). For example, you can create a single alert for multiple VMs.

#### Alert triggers {#condition}

You can set threshold metric values upon reaching which {{ monitoring-short-name }} will change an alert's status to `Alarm` and `Warning`.

#### Evaluation window {#evaluation-window}

A time interval to calculate an alert aggregation function in.
The window allows excluding sudden changes in metric values only responding to changes over a longer period. 

You can select one of the preset window values or specify your own value in the following format: 
* `1h`: One hour.
* `1m`: One minute.
* `1s`: One second.

The minimum allowed value is `1m`.
The maximum allowed value is `1h`.

> For example, the value `3m 45s` sets an evaluation window of 3 minutes 45 seconds.

#### Aggregation functions {#aggregation}

A function applies to metric values within an [evaluation window](#evaluation-window).
The resulting function value is compared to the preset alert threshold values.
If the value has reached the threshold for triggering the alert, {{ monitoring-full-name }} changes its status.

| Aggregation function | Description |
----- | -----
| **Average** | Calculates an average value for each metric in the specified period.<br/>For example, if a request returns two metrics, {{ monitoring-short-name }} calculates an average value for each of them within the window set. |
| **Amount** | Calculates the number of metric values in the specified period. |
| **Latest** | Uses the latest metric value in the specified period. If {{ monitoring-full-name }} couldn't obtain the metric value, it changes the alert status to `No Data`. |
| **Maximum** | Uses the maximum metric value in the specified period. |
| **Minimum** | Uses the minimum metric value in the specified period. |
| **Sum** | Calculates the sum of values for each metric in the specified period. |

> For example, if you want to track the latest metric value within the last 15 minutes, select the **Latest** function and set the **Evaluation window** to `15m`.

## Notification channel {#notification-channel}

To enable notifications of alert status changes, specify a notification channel. The channel contains information about notification recipients and sending methods.

One channel can be used multiple times for different alerts.

### Notification channel parameters {#channel-parameters}

- **Recipients**. List of recipients to get notifications in the event an alert function is triggered.

   {% note info %}

   You can only specify an account in {{ yandex-cloud }} as a notification recipient.
   To send SMS, link a phone number to the user account.

   For more information about accounts in {{ yandex-cloud }}, see the [{{ iam-full-name }}](../../iam/concepts/index.md#accounts) documentation.

   {% endnote %}

- **Notification method**. Method for sending notifications to users. The following notification methods are supported:
   - Email.
   - SMS.
   - Push notifications in the {{ yandex-cloud }} [mobile app](../../overview/mobile-app/index.md).

Once the notification channel is created, the following additional parameters are available:

- **Notify about statuses**. Select a list of alert statuses to notify users of via the notification channel.
- **Re-notification**. Select a period for {{ monitoring-short-name }} to send repeated notifications saying that an alert is in the same status.

### Notification sending statuses {#dispatch-statuses}

Each sending of a notification can have one of the following statuses:

| Status | Description |
----- | -----
| `Sent` | Notification has been sent |
| `Failed to send` | Notification hasn't been sent due to an error |
| `Resource limit reached` | Notification hasn't been sent due to the sending method restriction |
