---
title: Monitoring in {{ sws-full-name }}
description: Follow this guide to configure monitoring in {{ sws-name }}.
---

# Monitoring in {{ sws-name }}

Monitoring allows you to track the rate of requests to a protected resource: allowed, blocked, redirected to a JS challenge, cookie challenge, or {{ captcha-name }}, and processed by an ARL profile. You can also [set up alerts](../../monitoring/operations/alert/create-alert.md) to get notifications when request rate thresholds are exceeded.

{{ yandex-cloud }} offers pre-configured dashboards for {{ sws-name }} monitoring.

You can view the dashboards using one of the following options:

* On the {{ sws-name }} page, select ![display-pulse](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** and a tab:
  * **Anti-DDoS**: Charts for security profiles and ARL profiles.
  * **SolidWall WAF**: Charts for your [SolidWall WAF](../concepts/solidwall-waf.md) profile.
* To view the dashboard in {{ monium-name }}, click **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}** at the top right of the **{{ ui-key.yacloud.common.monitoring }}** section.
* On the {{ alb-name }} page:
  1. Select the load balancer with an associated security profile.
  1. Navigate to **{{ ui-key.yacloud.common.monitoring }}**.
  1. Go to the **Smart Web Security** tab.

## Description of {{ sws-name }} monitoring dashboards {#monitoring-dashboards}

Charts of requests sent for verification use metrics with the `service=application-load-balancer` label. The metric name is set in the `name` label. Traffic is selected based on folder (`folderId`), load balancer (`load_balancer`), security profile (`security_profile`), and rule (`rule_name`). For security profile charts, the HTTP router (`http_router`) and virtual host (`virtual_host`) labels are also used; for ARL charts, the ARL profile ID (`arl_profile`) is used.

The values ​​of the selected time series are summed by the `series_sum()` function, and the `NaN` values are replaced with zero using `replace_nan(0)`.

* **Inbound total RPS**: Total number of incoming requests per second (RPS) reaching the load balancer with the security profile.

  Metric: `load_balancer.requests_count_per_second`.

* **Allowed by Security Profile RPS**: Number of incoming requests per second the security profile has checked and allowed.

  Metric: `load_balancer.smart_web_security.requests_per_second` filtered by `antirobot_verdict`=`allow`.

* **Denied by Security Profile RPS**: Number of incoming requests per second the security profile has checked and blocked.

   Metric: `load_balancer.smart_web_security.requests_per_second` filtered by `antirobot_verdict`=`deny`.

* **Redirected to SmartCaptcha RPS**: Number of incoming requests per second routed to {{ captcha-name }} for additional verification.

    Metric: `load_balancer.smart_web_security.requests_per_second` filtered by `antirobot_verdict`=`captcha`.

* **Redirected to JS challenge RPS**: Number of incoming requests per second redirected to a client-side [JavaScript challenge](../concepts/rules.md#client-checks).

    Metric: `load_balancer.smart_web_security.requests_per_second` filtered by `antirobot_verdict`=`js_challenge`.

* **Redirected to Cookie challenge RPS**: Number of incoming requests per second redirected to a client-side [cookie challenge](../concepts/rules.md#client-checks).

    Metric: `load_balancer.smart_web_security.requests_per_second` filtered by `antirobot_verdict`=`cookie_challenge`.

    {% note info %}

    When matching against **Inbound total RPS**, consider the charts of requests that were allowed, blocked, or routed for various types of checks. Not all requests allowed at this stage and labeled with `antirobot_verdict`=`allow` will reach the protected node. They may get blocked by the ARL profile limiting the incoming request rate.

    {% endnote %}

* **Allowed by ARL Profile RPS**: Number of incoming requests per second not exceeding the ARL profile limit.

  Metric: `load_balancer.smart_web_security.arl_requests_per_second` filtered by the `arl_verdict`=`allow` label.

* **Denied by ARL Profile RPS**: Number of incoming requests per second exceeding the ARL profile limit and blocked.

  Metric: `load_balancer.smart_web_security.arl_requests_per_second` filtered by `arl_verdict`=`deny`.

* **Redirected to SmartCaptcha by ARL Profile RPS**: Number of incoming requests per second the ARL profile routes to {{ captcha-name }} for additional verification.

    Metric: `load_balancer.smart_web_security.arl_requests_per_second` filtered by `arl_verdict`=`captcha`.


    {% note info %}

    When matching against **Allowed by Security Profile RPS**, consider the charts of requests that were allowed, blocked, or routed for CAPTCHA within the ARL profile.

    {% endnote %}

You can combine multiple metrics in a single chart and [configure your own dashboards](../../monitoring/operations/dashboard/create.md) in {{ monitoring-short-name }}.

#### Useful links {#see-also}

* [{#T}](../metrics.md)
* [{#T}](../../monitoring/concepts/visualization/dashboard.md)
