---
title: How to configure {{ sws-full-name }} alerts
description: Follow this guide to configure {{ sws-full-name }} alerts.
---

# Configuring alerts for the service

[Alerting](../../monitoring/concepts/alerting/alert.md) allows you to track the changes in metrics and send notifications when indicators reach critical values. The changes in metrics are tracked with the help of requests sent from time to time, called _alerts_. When threshold values are reached, the system sends a notification via the specified communication channel. For example, by email or messenger.

{{ sws-name }} offers these inbound request rate metrics:

* `load_balancer.smart_web_security.requests_per_second`: Number of requests to the protected resource per second. This value matches the number of requests processed by the security profile.
* `load_balancer.smart_web_security.arl_requests_per_second`: Number of requests to the protected resource per second processed by Advanced Rate Limiter.

You can configure alerts for metrics reaching the specified rate thresholds. You can also use labels to calculate metrics by individual events.

To configure alerting:

1. [Create a notification channel](../../monitoring/operations/alert/create-channel.md).
1. Select [metrics and labels](../../monitoring/metrics-ref/smartwebsecurity-ref.md) for monitoring.
1. [Create an alert](../../monitoring/operations/alert/create-alert.md).

Let's take a look at how to create some alerts you can use for anomaly detection:

* [Alert of increasing share of blocked requests](#increased-deny-requests).
* [Alert of high rate of legitimate requests](#exceeding-speed-requests).

## Alert of increasing share of blocked requests {#increased-deny-requests}

The alert will be triggered when the number of blocked requests reaches 50% or more of the total number of requests. This alert can help detect different types of attacks, e.g., DDoS or bot-based hack attempts.

Let's use letters to represent the number of incoming requests per second:

* `A`: Total number of requests.
* `B`: Number of requests blocked by security profile.

Let's set up our alerts:

* `B` is 30% of `A`: Warning (`Warning`).
* `B` is 50% of `A`: Critical level (`Alarm`).

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
* We will get the `B` value using the `load_balancer.smart_web_security.requests_per_second` metric filtered by label `antirobot_verdict` = `deny`.
* We will calculate the `B` to `A` ratio (in percent) using the formula `100 * B / A` and save it as `C`.

### Creating an alert {#create-alert}

1. On the **{{ monitoring-short-name }}** homepage, click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}**.
1. Name your alert, e.g., `exceeding-blocked-requests`.
1. Describe your request to get the `A` value under **{{ ui-key.yacloud_monitoring.alert.title_alerts-config }}**.
   1. Click ![image](../../_assets/monitoring/plus.svg) next to ![image](../../_assets/monitoring/chart-lines2.svg) and add these parameters:
     * `service` = `Application Load Balancer`
     * `name` = `load_balancer.smart_web_security.requests_per_second`
     * `antirobot_verdict` = `allow`
     * `load_balancer` = `<load_balancer_name>`.
   1. Click ![image](../../_assets/monitoring/plus.svg) next to the ![image](../../_assets/monitoring/function.svg) icon.
   1. Specify the data processing function `replace_nan(0)`: Replaces the lacking data with `0` for a continuous chart.

1. Click **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.

1. Describe your request to get the `B` value:
   1. Specify data to collect:
     * `service` = `Application Load Balancer`
     * `name` = `load_balancer.smart_web_security.requests_per_second`
     * `antirobot_verdict` = `deny`
     * `load_balancer` = `<load_balancer_name>`.
   1. Specify the `replace_nan(0)` function.

1. Click **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.
   
1. Describe you request for `C` to get the `B` to `A` ratio in percent:
   1. Click ![image](../../_assets/monitoring/raw.svg) to switch to text mode to edit the request.
   1. Enter `100 * B / A` in the request string.

1. Under **{{ ui-key.yacloud_monitoring.alert.section_alert-conditions }}**, specify:
     * `Test request`: `C`
     * `Aggregation function`: `All values`
     * `Warning`: `30` (warning)
     * `Alarm`: `50` (critical level)
     * `Evaluation window`: `30 seconds`
     * `Evaluation delay`: `15 seconds`

1. Leave the default values under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.no-data }}**.
1. Optionally, under [**{{ ui-key.yacloud_monitoring.monitoring-alerts.title.annotations }}**](../../monitoring/concepts/alerting/annotation.md), add the information that must be written when the alert is triggered.
1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}**, add the notification channel.
1. Click **{{ ui-key.yacloud.common.create }}**.

## Alert of high rate of legitimate requests {#exceeding-speed-requests}

Let's use letters to represent the number of incoming requests per second:

* `A`: Allowed by the security profile.
* `B`: Allowed the ARL profile.

Normally `A` must be slightly greater or equal to `B`. In other words, the number of requests allowed by the security profile slightly exceeds the limit set in the ARL profile. Which means the majority of requests allowed by the security profile will reach the virtual host. In which case the system load is within the norm.

A significant difference in the number of requests means the system is unable to cope with the load and blocks potentially legitimate requests. This can be down to insufficient capacity or an attack. If this situation persists, we recommend reviewing your security profile settings or rate limits.

Let's set up alerts to detect such exceeded rate limits:

* `A` is 30% grater than `B`: Warning (`Warning`).
* `A` is 50% grater than `B`: Critical level (`Alarm`).

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

* We will get the `A` value using the `load_balancer.smart_web_security.requests_per_second` metric filtered by label `antirobot_verdict` = `allow`.
* We will get the `B` value using the `load_balancer.smart_web_security.arl_requests_per_second` metric filtered by label `arl_verdict` = `allow`.
* We will calculate the excess of `A` over `B` (in percent) using the formula `100 * abs(A - B) / B` and save it as `C`.

### Creating an alert {#create-alert}

1. On the **{{ monitoring-short-name }}** homepage, click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}**.
1. Name your alert, e.g., `inbound-over-ARL`.
1. Describe your request to get the `A` value under **{{ ui-key.yacloud_monitoring.alert.title_alerts-config }}**.
   * Click ![image](../../_assets/monitoring/plus.svg) next to ![image](../../_assets/monitoring/chart-lines2.svg) and add these parameters:
     * `service` = `Application Load Balancer`
     * `name` = `load_balancer.smart_web_security.requests_per_second`
     * `antirobot_verdict` = `allow`
     * `load_balancer` = `<load_balancer_name>`.
   * Click ![image](../../_assets/monitoring/plus.svg) next to ![image](../../_assets/monitoring/function.svg) and set the data processing functions:
     * `series_sum()`: Sum of metrics with different labels for a particular point. In our example, there is one label: `antirobot_verdict`, but this function will be useful for other metrics.
     * `replace_nan(0)`: Replaces the lacking data with `0` for a continuous chart.

1. Click **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.

1. Describe your request to get the `B` value:
   * Specify data to collect:
     * `service` = `Application Load Balancer`
     * `name` = `load_balancer.smart_web_security.arl_requests_per_second`
     * `arl_verdict` = `allow`
     * `load_balancer` = `<load_balancer_name>`.
   * Specify the `series_sum()` and `replace_nan(0)` functions.

1. Click **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.
   
1. Describe your request for `C` to get the difference between `A` and `B` in percent:
   1. Click ![image](../../_assets/monitoring/raw.svg) to switch to text mode to edit the request.
   1. Enter `100 * abs(A - B) / B` in the request string.

1. Under **{{ ui-key.yacloud_monitoring.alert.section_alert-conditions }}**, specify:
     * `Test request`: `C`
     * `Aggregation function`: `All values`
     * `Warning`: `30` (warning)
     * `Alarm`: `50` (critical level)
     * `Evaluation window`: `30 seconds`
     * `Evaluation delay`: `15 seconds`

1. Leave the default values under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.no-data }}**.
1. Optionally, under [**{{ ui-key.yacloud_monitoring.monitoring-alerts.title.annotations }}**](../../monitoring/concepts/alerting/annotation.md), add the information that must be written when the alert is triggered.
1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}**, add the notification channel.
1. Click **{{ ui-key.yacloud.common.create }}**.

#### See also {#see-also}

* [{#T}](../metrics.md)
* [{#T}](../../monitoring/concepts/visualization/query-string.md)
