---
title: '{{ alb-full-name }} release notes'
description: This section contains {{ alb-name }} release notes.
---

# {{ alb-full-name }} release notes

## Q4 2024 {#q4-2024}

* Added the Global RateLimit module to limit HTTP and gRPC requests per virtual host. The limit can be applied to the entire virtual host or individual routes.
  
  This feature is currently in [preview](../overview/concepts/launch-stages.md). To enable it, contact [support]({{ link-console-support }}).

* Added support for custom HTTP status codes (100-599) as valid responses for [backend health checks](concepts/backend-group.md#health-checks).
  
* Added an option to maintain connections even when health checks fail. This option is only available for [Stream health checks](concepts/backend-group.md#health-checks).

* Added configurable idle timeout settings for Stream and SNI [listeners](concepts/application-load-balancer#listener).
  
* Added a description for the [x_forwarded_for](logs-ref.md) field in load balancer logs.

All new features are now available through CLI, API, and {{ TF }} interfaces.

## Q2 2024 {#q2-2024}

* Added validation for internal IPv4 addresses during load balancer creation and updates.
* Fixed the validation issue causing mixing weighted and non-weighted backends in target groups during their creation and updates.

## Q1 2024 {#q1-2024}

* Improved data plane stability for more reliable service data processing and transmission.
* Implemented integration with [{{ sws-full-name }}](../smartwebsecurity/):
  * Associating [virtual hosts](./concepts/http-router.md#virtual-host) with [security profiles](../smartwebsecurity/concepts/profiles.md) using the management console, CLI, {{ TF }}, or API.
  * {{ sws-name }} event log forwarding to the{{ cloud-logging-full-name }} [log group](../logging/concepts/log-group.md).
  * {{ sws-name }} metric forwarding to [{{ monitoring-full-name }}](../monitoring/).
* Changed behavior for `Stream` [backend groups](./concepts/backend-group.md): The [load balancer](./concepts/application-load-balancer.md) now terminates connections to backends that fail [health checks](./concepts/backend-group.md#health-checks).
* Optimized work with the service resource operation list.
* Added support for searching load balancers by internal IP address in the management console.
* Added granular availability zone selection for load balancer nodes in the management console.
* Resolved validation errors when changing load balancer listener types between `TLS` and `Stream` in the {{ TF }} provider.
