---
title: "{{ sws-full-name }} release notes"
description: "This section contains {{ sws-name }} release notes."
---

# {{ sws-full-name }} release notes

## Q2 2024 {#q2-2024}

* Implemented [Web Application Firewall (WAF)](./concepts/waf.md) to protect web applications against external threats, such as SQL injections, cross-site scripting, and other vulnerabilities. WAF analyzes and filters HTTP requests blocking potentially malicious data.

    This feature is available at the [Preview](../overview/concepts/launch-stages.md) stage.

* Implemented [Advanced Rate Limiter (ARL)](./concepts/arl.md) to manage web app loads. ARL allows you to set a limit on the number of requests over a certain period of time. This prevents overload and ensures stable operation of the application.

    This feature is available at the [Preview](../overview/concepts/launch-stages.md) stage.

## Q1 2024 {#q1-2024}

* Released the service for [general availability](../overview/concepts/launch-stages.md).
* Now you can select the [{{ captcha-full-name }}](../smartcaptcha/) user CAPTCHA.
* Added the [limit](./concepts/limits.md#limits) for the maximum number of requests per second (RPS) in total for all load balancer virtual hosts connected to the same security profile.
* Added logs of a security profile connected to a virtual host to the [{{ alb-full-name }}](../application-load-balancer/) log list.
* Implemented sending of management event [audit logs](./at-ref.md) in [{{ at-full-name }}](../audit-trails/).

## Q4 2023 {#q4-2023}

* Now you can create security profiles from a preset template.
* Supported sending of [metrics](./metrics.md) to [{{ monitoring-full-name }}](../monitoring/).
* Fixed the error of matching a string in the `Host` [condition](./concepts/conditions.md) when creating a security rule.
* Improved the stability by implementing a new pattern for [{{ alb-name }}](../application-load-balancer/) and {{ sws-name }} interaction.

## Q3 2023 {#q3-2023}

* The service is available at the [Preview](../overview/concepts/launch-stages.md) stage.