---
title: '{{ alb-full-name }} release notes'
description: This section contains the {{ alb-name }} release notes.
---

# {{ alb-full-name }} release notes

## Q4 2025 {#q4-2025}

* In the [management console]({{ link-console-main }}), now you can [start a zonal shift](operations/manage-zone/start-and-cancel-shift.md) for one or more availability zones, as well as schedule a time to automatically cancel the shift.

* Added request path support for cookie-based [session affinity](concepts/backend-group.md#session-affinity). This ensures correct session merges for specific sections of your website or web app.

## Q3 2025 {#q3-2025}

* Added the ability to manually [disable](./operations/manage-zone/start-and-cancel-shift.md) one or more [availability zones](../overview/concepts/geo-scope.md) in the event of local issues or to test the load redistribution mechanism. You can also specify the availability zone off time. After this time runs out, the availability zone will be automatically re-enabled.

  This feature is available through the [{{ yandex-cloud }} CLI](cli-ref/index.md) and [API](api-ref/authentication.md).

* Now, you can allow or deny [auto-disabling](operations/manage-zone/allow-and-deny-shift.md) an availability zone. The auto-disabling is performed by {{ yandex-cloud }} staff if an availability zone is under maintenance or shows signs of failure.

  This feature is available through the {{ yandex-cloud }} CLI, [{{ TF }}](tf-ref.md), and API.

* Added support for modification of HTTP request parameters for specific routes on a virtual host. This feature may be of use for managing API versions, microservice routing, backward compatibility, and URL normalization. 
 
  The `path-regex-rewrite` modification parameter was added to the following [route management](operations/manage-routes.md) commands: `append-http-route`, `prepend-http-route`, `insert-http-route`, and `update-http-route`.

  This feature is available through the {{ yandex-cloud }} CLI, {{ TF }}, and API.

* You can now [deactivate](../smartwebsecurity/operations/host-connect.md#host) the use of a {{ sws-name }} security profile to check traffic on a specific virtual host route. This can be of use when, on some routes, requests come from trusted sources and need not be analyzed.

  The `disable-security-profile` parameter was added to route managing commands.

  This feature is available through the {{ yandex-cloud }} CLI, {{ TF }}, and API.

## Q4 2024 {#q4-2024}

* Added the Global RateLimit module to limit HTTP and gRPC requests per virtual host. The limit can be applied to the entire virtual host or individual routes.
  
  This feature is currently in [preview](../overview/concepts/launch-stages.md). To enable it, contact [support]({{ link-console-support }}).

* Added support for custom HTTP status codes as valid responses for [backend health checks](concepts/backend-group.md#health-checks). Code values can range from 100 to 599.
  
* Added an option of keeping a connection alive even if the health check fails. This option is only available for [Stream health checks](concepts/backend-group.md#health-checks).

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
