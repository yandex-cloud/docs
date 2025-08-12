---
title: How to configure {{ sws-full-name }} alerts
description: Follow this guide to configure {{ sws-full-name }} alerts.
---

# Configuring alerts for the service

[Alerting](../../monitoring/concepts/alerting/alert.md) allows you to monitor changes in metrics and notifies you when they hit critical levels using periodic queries known as _alerts_. When metrics reach threshold values, the system sends a notification via the specified communication channel, e.g., by email or messenger.

{{ sws-name }} offers these incoming request rate metrics:

* `load_balancer.smart_web_security.requests_per_second`: Number of requests sent to the protected resource per second. This value matches the number of requests processed by the security profile.
* `load_balancer.smart_web_security.arl_requests_per_second`: Number of requests sent to the protected resource per second, processed by Advanced Rate Limiter.

You can configure alerts for metrics reaching the specified rate thresholds. You can also use labels to track metrics by individual events.

To configure alerting:

1. [Create a notification channel](../../monitoring/operations/alert/create-channel.md).
1. Select [metrics and labels](../../monitoring/metrics-ref/smartwebsecurity-ref.md) for monitoring.
1. [Create an alert](../../monitoring/operations/alert/create-alert.md).

Let's take a look how you can create some alerts to detect anomalies:

* [Alert for increased percentage of blocked requests](#increased-deny-requests).
* [Alert for a high rate of legitimate requests](#exceeding-speed-requests).

## Alert for increased percentage of blocked requests {#increased-deny-requests}

The alert will be triggered when the number of blocked requests reaches 50% or more of the total requests. This alert helps detect different types of attacks, e.g., DDoS or bot-based hack attempts.

Let's use letters to indicate the number of incoming requests per second:

* `A`: Total requests.
* `B`: Number of requests blocked by the security profile.

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

* We will get the `A` value using the `load_balancer.smart_web_security.requests_per_second` metric.
* We will get the `B` value using the `load_balancer.smart_web_security.requests_per_second` metric filtered by the `antirobot_verdict` = `deny` label.
* We will calculate the `B` to `A` ratio (in percent) using the `100 * B / A` formula and save it as `C`.

### Creating an alert {#create-alert}

1. On the **{{ monitoring-short-name }}** home page, click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}**.
1. Name your alert, e.g., `exceeding-blocked-requests`.
1. Under **{{ ui-key.yacloud_monitoring.alert.title_alerts-config }}**, describe your query to get the `A` value:
   1. Click ![image](../../_assets/monitoring/plus.svg) next to ![image](../../_assets/monitoring/chart-lines2.svg) and add these settings:
     * `service` = `Application Load Balancer`
     * `name` = `load_balancer.smart_web_security.requests_per_second`
     * `antirobot_verdict` = `allow`
     * `load_balancer` = `<load_balancer_name>`.
   1. Click ![image](../../_assets/monitoring/plus.svg) next to ![image](../../_assets/monitoring/function.svg).
   1. Set the `replace_nan(0)` function to replace missing data with `0`, ensuring a continuous chart.

1. Click **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.

1. Describe your query to get the `B` value:
   1. Specify the data to collect:
     * `service` = `Application Load Balancer`
     * `name` = `load_balancer.smart_web_security.requests_per_second`
     * `antirobot_verdict` = `deny`
     * `load_balancer` = `<load_balancer_name>`
   1. Set the `replace_nan(0)` function.

1. Click **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.
   
1. Describe you query for `C` to get the `B` to `A` ratio in percent:
   1. Click ![image](../../_assets/monitoring/raw.svg) to switch to text mode to edit the query.
   1. Enter `100 * B / A` in the query string.

1. Under **{{ ui-key.yacloud_monitoring.alert.section_alert-conditions }}**, specify:
     * `Query to evaluate`: `C`
     * `Aggregation function`: `All values`
     * `Warning`: `30`
     * `Alarm`: `50` (critical level)
     * `Evaluation window`: `30 seconds`
     * `Evaluation delay`: `15 seconds`

1. Leave the default values under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.no-data }}**.
1. Optionally, under [**{{ ui-key.yacloud_monitoring.monitoring-alerts.title.annotations }}**](../../monitoring/concepts/alerting/annotation.md), add the information to log when the alert is triggered.
1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}**, add the notification channel.
1. Click **{{ ui-key.yacloud.common.create }}**.

## Alert for a high rate of legitimate requests {#exceeding-speed-requests}

Let's use letters to indicate the number of incoming requests per second:

* `A`: Allowed by the security profile.
* `B`: Allowed by the ARL profile.

Normally, `A` must be slightly greater or equal to `B`. In other words, the number of requests allowed by the security profile slightly exceeds the limit set in the ARL profile. This means that most requests allowed by the security profile reach the virtual host. In this case, the system load remains within normal limits.

A significant difference in the number of requests means the system cannot handle the load and blocks potentially legitimate requests. This can be due to insufficient capacity or an attack. If this situation persists, we recommend reviewing your security profile settings or rate limits.

Let's set up alerts to detect exceeded rate limits:

* `A` exceeds `B` by 30%: `Warning`.
* `A` exceeds `B` by 50%: `Alarm` (critical level).

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

* We will get the `A` value using the `load_balancer.smart_web_security.requests_per_second` metric filtered by the `antirobot_verdict` = `allow` label.
* We will get the `B` value using the `load_balancer.smart_web_security.arl_requests_per_second` metric filtered by the `arl_verdict` = `allow` label.
* We will calculate the excess of `A` over `B` (in percent) using the `100 * abs(A - B) / B` formula and save it as `C`.

### Creating an alert {#create-alert}

1. On the **{{ monitoring-short-name }}** home page, click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}**.
1. Name your alert, e.g., `inbound-over-ARL`.
1. Under **{{ ui-key.yacloud_monitoring.alert.title_alerts-config }}**, describe your query to get the `A` value:
   * Click ![image](../../_assets/monitoring/plus.svg) next to ![image](../../_assets/monitoring/chart-lines2.svg) and add these settings:
     * `service` = `Application Load Balancer`
     * `name` = `load_balancer.smart_web_security.requests_per_second`
     * `antirobot_verdict` = `allow`
     * `load_balancer` = `<load_balancer_name>`.
   * Click ![image](../../_assets/monitoring/plus.svg) next to ![image](../../_assets/monitoring/function.svg) and set the data processing functions:
     * `series_sum()`: Sum of metrics with different labels for a particular point. In our example, there is one label (`antirobot_verdict`), but this function will be useful for other metrics.
     * `replace_nan(0)`: Replaces missing data with `0` for a continuous chart.

1. Click **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.

1. Describe your query to get the `B` value:
   * Specify the data to collect:
     * `service` = `Application Load Balancer`
     * `name` = `load_balancer.smart_web_security.arl_requests_per_second`
     * `arl_verdict` = `allow`
     * `load_balancer` = `<load_balancer_name>`
   * Set the `series_sum()` and `replace_nan(0)` functions.

1. Click **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.
   
1. Describe your query for `C` to get the difference between `A` and `B` in percent:
   1. Click ![image](../../_assets/monitoring/raw.svg) to switch to text mode to edit the query.
   1. Enter `100 * abs(A - B) / B` in the query string.

1. Under **{{ ui-key.yacloud_monitoring.alert.section_alert-conditions }}**, specify:
     * `Query to evaluate`: `C`
     * `Aggregation function`: `All values`
     * `Warning`: `30`
     * `Alarm`: `50` (critical level)
     * `Evaluation window`: `30 seconds`
     * `Evaluation delay`: `15 seconds`

1. Leave the default values under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.no-data }}**.
1. Optionally, under [**{{ ui-key.yacloud_monitoring.monitoring-alerts.title.annotations }}**](../../monitoring/concepts/alerting/annotation.md), add the information to log when the alert is triggered.
1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}**, add the notification channel.
1. Click **{{ ui-key.yacloud.common.create }}**.

#### See also {#see-also}

* [{#T}](../metrics.md)
* [{#T}](../../monitoring/concepts/visualization/query-string.md)
