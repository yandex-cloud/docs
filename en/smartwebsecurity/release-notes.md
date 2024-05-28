# {{ sws-full-name }} release notes

## Q1 2024 {#q1-2024}

* Released the service for [general availability](../overview/concepts/launch-stages.md).
* Now you can select the [{{ captcha-full-name }}](../smartcaptcha/) user CAPTCHA.
* Added the [limit](./concepts/limits.md#limits) for the maximum number of requests per second (RPS) in total for all load balancer virtual hosts connected to the same security profile.
* In the [{{ alb-full-name}}](../application-load-balancer/) log list, added logs of a security profile connected to a virtual host.
* Implemented sending of management event [audit logs](./at-ref.md) in [{{ at-full-name }}](../audit-trails/).

## Q4 2023 {#q4-2023}

* Now you can create security profiles from a preset template.
* Supported sending of [metrics](./metrics.md) to [{{ monitoring-full-name }}](../monitoring/).
* Fixed the error of matching a string in the `Host` [condition](./concepts/conditions.md) when creating a security rule.
* Improved the service's stability by implementing a new pattern for [{{ alb-name}}](../application-load-balancer/) and {{ sws-name }} interaction.

## Q3 2023 {#q3-2023}

* The service is available at the [Preview](../overview/concepts/launch-stages.md) stage.