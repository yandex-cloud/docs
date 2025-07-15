---
title: Monitoring in {{ sws-full-name }}
description: Follow this guide to configure monitoring in {{ sws-name }}.
---

# Monitoring in {{ sws-name }}

Monitoring allows you to track the rate of requests to a protected resource: allowed, blocked, routed to {{ captcha-name }}, and processed by an ARL profile. You can also [set up alerts](../../monitoring/operations/alert/create-alert.md) to get notifications when request rate thresholds are exceeded.

{{ yandex-cloud }} offers pre-configured dashboards for {{ sws-name }} monitoring.

You can view the dashboards using one of the following options:

* On the {{ sws-name }} page, select **{{ ui-key.yacloud.common.monitoring }}**.
* Under **{{ ui-key.yacloud.common.monitoring }}**, click **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}** at the top right.
* On the {{ alb-name }} page:
  1. Select the load balancer with a linked security profile.
  1. Navigate to **{{ ui-key.yacloud.common.monitoring }}**.
  1. Go to the **Smart Web Security** tab.

{% note info %}

All the dashboards currently available for {{ sws-name }} are listed on the {{ monitoring-name }} page. You can find their descriptions below.

{% endnote %}

## Description of {{ sws-name }} monitoring dashboards {#monitoring-dashboards}

* **Inbound total RPS**: Total number of incoming requests per second (RPS) reaching the load balancer with the security profile.

  Metric: `load_balancer.requests_count_per_second`.

* **Allowed by Security Profile RPS**: Number of incoming requests per second the security profile has checked and allowed.

  Metric: `load_balancer.smart_web_security.requests_per_second` filtered by `antirobot_verdict`=`allow`.

* **Denied by Security Profile RPS**: Number of incoming requests per second the security profile has checked and blocked.

   Metric: `load_balancer.smart_web_security.requests_per_second` filtered by `antirobot_verdict`=`deny`.

* **Redirected to SmartCaptcha RPS**: Number of incoming requests per second routed to {{ captcha-name }} for additional verification.

    Metric: `load_balancer.smart_web_security.requests_per_second` filtered by `antirobot_verdict`=`captcha`.

    {% note info %}

    The total number of requests for **Allowed by Security Profile RPS**, **Denied by Security Profile RPS**, and **Redirected to SmartCaptcha RPS** matches the **Inbound total RPS** value at any given time. However, not all the requests allowed at this stage and labeled with `antirobot_verdict`=`allow` will reach the protected node. They may get blocked by the ARL profile limiting the incoming request rate.

    {% endnote %}

* **Allowed by ARL Profile RPS**: Number of incoming requests per second not exceeding the ARL profile limit.

  Metric: `load_balancer.smart_web_security.arl_requests_per_second` filtered by `arl_verdict`=`allow`.

* **Denied by ARL Profile RPS**: Number of incoming requests per second exceeding the ARL profile limit and blocked.

  Metric: `load_balancer.smart_web_security.arl_requests_per_second` filtered by `arl_verdict`=`deny`.

    {% note info %}

    The total number of requests for **Allowed by ARL Profile RPS** and **Denied by ARL Profile RPS** matches the **Allowed by Security Profile RPS** value at any given time.

    {% endnote %}

You can combine multiple metrics in a single chart and [configure your own dashboards](../../monitoring/operations/dashboard/create.md) in {{ monitoring-short-name }}.

#### See also {#see-also}

* [{#T}](../metrics.md)
* [{#T}](../../monitoring/concepts/visualization/dashboard.md)