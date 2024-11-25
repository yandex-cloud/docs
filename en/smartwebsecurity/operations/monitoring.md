---
title: Monitoring in {{ sws-full-name }}
description: Follow this guide to configure monitoring in {{ sws-name }}.
---

# Monitoring in {{ sws-name }}

Monitoring allows you to track the rate of requests to a protected resource: allowed, blocked, routed to {{ captcha-name }}, and processed by an ARL profile. You can also [set up alerts](../../monitoring/operations/alert/create-alert.md) to get notifications when a request speed threshold is exceeded.

{{ yandex-cloud }} offers pre-configured dashboards for {{ sws-name }} monitoring. 

You can view the dashboards using one of the following options:

* On the {{ sws-name }} page, select **{{ ui-key.yacloud.common.monitoring }}**.
* Under **{{ ui-key.yacloud.common.monitoring }}**, click **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}** at the top right.
* On the {{ alb-name }} page:
  1. Select the load balancer with a linked security profile.
  1. Go to the **{{ ui-key.yacloud.common.monitoring }}** section.
  1. Go to the **Smart Web Security** tab.

{% note info %}

All the dashboards currently available for {{ sws-name }} are listed on the {{ monitoring-name }} page. You can find their descriptions below.

{% endnote %}

## Description of {{ sws-name }} monitoring dashboards {#monitoring-dashboards}

* **Inbound total RPS**: Total number of inbound requests per second (RPS) received by the load balancer with the security profile.

  Metric: `load_balancer.requests_count_per_second`.

* **Allowed by Security Profile RPS**: Number of inbound requests per second the security profile has checked and allowed.

  Metric: `load_balancer.smart_web_security.requests_per_second` filtered by the `antirobot_verdict`=`allow` label.

* **Denied by Security Profile RPS**: Number of inbound requests per second the security profile has checked and blocked.

   Metric: `load_balancer.smart_web_security.requests_per_second` filtered by the `antirobot_verdict`=`deny` label.

* **Redirected to SmartCaptcha RPS**: Number of inbound requests per second routed to {{ captcha-name }} for additional verification.

    Metric: `load_balancer.smart_web_security.requests_per_second` filtered by the `antirobot_verdict`=`captcha` label.

    {% note info %}

    The total number of requests on **Allowed by Security Profile RPS**, **Denied by Security Profile RPS**, and **Redirected to SmartCaptcha RPS** equals the **Inbound total RPS** value at any given time. However, not all the requests allowed at this stage and labeled with `antirobot_verdict`=`allow` will reach the protected node. They may get blocked by the ARL profile limiting the inboud request rate.

    {% endnote %}

* **Allowed by ARL Profile RPS**: Number of inbound requests per second not exceeding the ARL profile limit.

  Metric: `load_balancer.smart_web_security.arl_requests_per_second` filtered by the `arl_verdict`=`allow` label.

* **Denied by ARL Profile RPS**: Number of inbound requests per second exceeding the ARL profile limit and blocked.

  Metric: `load_balancer.smart_web_security.arl_requests_per_second` filtered by the `arl_verdict`=`deny` label.

    {% note info %}

    The total number of request a point in time for **Allowed by ARL Profile RPS** and **Denied by ARL Profile RPS** matches the **Allowed by Security Profile RPS** value.

    {% endnote %}

You can combine multiple metrics in a single chart and [configure your own dashboards](../../monitoring/operations/dashboard/create.md) in {{ monitoring-short-name }}.

#### See also {#see-also}

* [{#T}](../metrics.md)
* [{#T}](../../monitoring/concepts/visualization/dashboard.md)