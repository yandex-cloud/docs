# Setting up alerts

[Alerting](../../monitoring/concepts/alerting/alert.md) allows you to monitor changes in metrics and notifies you when they hit critical levels using periodic queries known as _alerts_. When metrics reach threshold values, the system sends a notification via the specified communication channel, e.g., by email or messenger.

To configure alerting:

1. [Create a notification channel](../../monitoring/operations/alert/create-channel.md).
1. Select [metrics and labels](../../monitoring/metrics-ref/smartwebsecurity-ref.md) for monitoring.
1. [Create an alert](../../monitoring/operations/alert/create-alert.md).

Let's consider an example of creating an alert that notifies you when a service becomes unavailable.

The alert will trigger when the number of failed requests reaches 50% or more of the total requests. Such an alert helps detect DDoS attacks or infrastructure failures.

Let's use letters to indicate the number of incoming requests per second:

* `A`: Total requests.
* `B`: Failed requests.

Let's set up our alerts:

* `B` reaches 30% of `A`: `Warning`.
* `B` reaches 50% of `A`: `Alarm` (critical level).

### Creating a notification channel {#create-channel}

1. In the [management console]({{ link-console-main }}), select the folder on the left.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. Go to the **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.channels.title }}** section.
1. Click **{{ ui-key.yacloud_monitoring.channel.button_new-channel }}**.
1. Specify the channel name, notification method, and recipients.

    {% note info %}

    {% include [notifications-requirements](../../_includes/monitoring/notifications-requirements.md) %}

    {% endnote %}

1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

### Selecting metrics for monitoring {#select-metrics}

* We will get the `A` value using the `load_balancer.requests_count_per_second` metric.
* We will get the `B` value using the `load_balancer.requests_count_per_second` metric filtered by the `code` = `503` label.
* We will calculate the `B` to `A` ratio (in percent) using the `100 * B / A` formula and save it as `C`.

### Creating an alert {#create-alert}

1. On the **{{ monitoring-short-name }}** home page, click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}**.
1. Name your alert, e.g., `unavailable_service`.
1. Under **{{ ui-key.yacloud_monitoring.alert.title_alerts-config }}**, describe your query to get the `A` value:
   1. Next to ![image](../../_assets/monitoring/chart.svg), add the following parameters:
      * `service` = `Application Load Balancer`
      * `name` = `load_balancer.requests_count_per_second`
      * `load_balancer` = `<load_balancer_name>`
   1. Next to ![image](../../_assets/monitoring/function.svg), set the `replace_nan(0)` function to replace missing data with `0`, ensuring a continuous chart.

1. Click **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.

1. Describe your query to get the `B` value:
   1. Specify the data to collect:
      * `service` = `Application Load Balancer`
      * `name` = `load_balancer.requests_count_per_second`
      * `code` = `503`
      * `load_balancer` = `<load_balancer_name>`
   1. Set the `replace_nan(0)` function.

1. Click **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.
   
1. Describe you query for `C` to get the `B` to `A` ratio in percent:
   1. Click ![image](../../_assets/monitoring/raw.svg) to switch to text mode to edit the query.
   1. Enter `100 * B / A` in the query string.

1. Under **{{ ui-key.yacloud_monitoring.alert.title_conditions }}**, specify:
     * `Query to evaluate`: `C`
     * `Aggregation function`: `All values`
     * `Warning`: `30`
     * `Alarm`: `50` (critical level)
     * `Evaluation window`: `30 seconds`
     * `Evaluation delay`: `15 seconds`

1. Leave the default values under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.no-data }}**.
1. Optionally, under [**{{ ui-key.yacloud_monitoring.monitoring-alerts.title.annotations }}**](../../monitoring/concepts/alerting/annotation.md), add the information to log when the alert triggers.
1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}**, add the notification channel.
1. Click **{{ ui-key.yacloud.common.create }}**.