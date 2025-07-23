---
title: '{{ sws-full-name }} release notes'
description: This section contains {{ sws-name }} release notes.
---

# {{ sws-full-name }} release notes

## Q2 2025 {#q2-2025}

* Added a new functionality: [domains](concepts/domain-protect.md) for protection of websites and web applications hosted in {{ yandex-cloud }} or other platforms that do not use the L7 {{ alb-name }}.
  
    In addition to protection, we provide a proxy server with load balancing, request analysis and routing, and basic [DDoS protection](../vpc/ddos-protection/).

    The domain protection functionality is at the [Preview](../overview/concepts/launch-stages.md) stage.

* Added [subscription billing](pricing.md) allowing you to predict information security costs and optimize resource spending.

## January 2025 {#jan-2025}

{{ sws-name }} was certified for compliance with [152-FZ, GOST R 57580, and PCI DSS](https://yandex.cloud/ru/security/standards).

## Q4 2024 {#q4-2024}

* Added the [IP blacklist and whitelist](concepts/lists.md) feature to manage the traffic and create security rules based on IP reputation analysis. You can use the preset {{ yandex-cloud }} blacklists and whitelists or create your own.
* Added the [calculator](pricing.md) for quicker service cost calculations.
* Improved low-rate DoS analysis and blocking algorithms.
* Optimized the error code page size.
* {{ sws-name }} successfully passed an external audit for 152-FZ, GOST R 57580, and PCI DSS compliance.

## Q3 2024 {#q3-2024}

* Web Application Firewall (WAF) and Advanced Rate Limiter (ARL) entered the [General Availability](../overview/concepts/launch-stages.md) stage.
* Changes in the pricing: 
  * You only pay for [legitimate](concepts/rules.md#rule-action) requests.
  * Profiles and rules are not billable.
* Under basic rules, you can now send requests to [{{ captcha-full-name }}](../smartcaptcha/).
* Implemented sending [data events](./at-ref.md#data-plane-events) to {{ at-full-name }}: `ArlMatchedRequest`, `WafMatchedExclusionRule`, and `WafMatchedRule`.
* API, CLI, and {{ TF }} are now supported.
* For traffic conditions that use regular expressions, you can now use case-sensitive string search. For more information, see [Regular expression format](concepts/conditions.md#regular-expressions).

## Q2 2024 {#q2-2024}

* Implemented [Web Application Firewall (WAF)](./concepts/waf.md) to protect web applications against external threats, such as SQL injections, cross-site scripting, and other vulnerabilities. WAF analyzes and filters HTTP requests blocking potentially malicious data.

    This feature is available at the [Preview](../overview/concepts/launch-stages.md) stage.

* Implemented [Advanced Rate Limiter (ARL)](./concepts/arl.md) to manage web app loads. ARL allows you to set a limit on the number of requests over a certain period of time. This prevents overload and ensures stable operation of the application.

    This feature is available at the [Preview](../overview/concepts/launch-stages.md) stage.

## Q1 2024 {#q1-2024}

* The service has entered the [General Availability](../overview/concepts/launch-stages.md) stage.
* Added the [{{ captcha-full-name }}](../smartcaptcha/) custom CAPTCHA option.
* Added the [limit](./concepts/limits.md#limits) for the maximum number of requests per second (RPS) in total for all load balancer virtual hosts connected to the same security profile.
* Added logs of a security profile connected to a virtual host to the [{{ alb-full-name }}](../application-load-balancer/) log list.
* Implemented sending management event [audit logs](./at-ref.md) in [{{ at-full-name }}](../audit-trails/).

## Q4 2023 {#q4-2023}

* Now you can create security profiles from a preset template.
* Implemented sending [metrics](./metrics.md) to [{{ monitoring-full-name }}](../monitoring/).
* Fixed the error of matching a string in the `Host` [condition](./concepts/conditions.md) when creating a security rule.
* Improved the stability by implementing a new pattern for [{{ alb-name }}](../application-load-balancer/) and {{ sws-name }} interaction.

## Q3 2023 {#q3-2023}

* The service is available at the [Preview](../overview/concepts/launch-stages.md) stage.