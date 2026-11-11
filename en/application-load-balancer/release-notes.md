---
title: '{{ alb-full-name }} release notes'
description: This section contains the {{ alb-name }} release notes.
---

# {{ alb-full-name }} release notes

## Q3 2026 {#q3-2026}

* Extended support for [mutual TLS (mTLS) authentication](concepts/application-load-balancer.md#mtls). For inbound client TLS certificates, added the `accept_untrusted` setting for accepting without trust chain verification and the `allow_expired` setting for accepting expired certificates. For outbound connections to backends and health checks, {{ alb-name }} can use a client certificate from {{ certificate-manager-name }}.

   These settings are available via the API, CLI and {{ TF }}.

* For [target resources](concepts/target-group.md), added the ability to explicitly specify an availability zone in the `locality` field. The availability zone is used for [traffic localization](concepts/backend-group.md#locality). This setting is available via the API.

* Added host description (the `description` field) to {{ at-name }} events about creating, updating, and deleting [virtual hosts](concepts/http-router.md#virtual-host).


* Added automatic processing of incomplete operations that could previously require a manual restart after failure or a timeout.

* Added the check of the internal IPv4 listener subnet: it must belong to the load balancer network. An incorrect configuration is rejected before the operation starts.

* Fixed bugs related to:

  * Managing links to certificates used for mTLS.
  * Applying approved exceptions from the listener number limit when creating a load balancer.
  * Action menu position in resource cards in the management console.

## Q2 2026 {#q2-2026}

* Added the ability to preserve the case of HTTP header names for HTTP/1.1 using the `preserve_http1_header_casing` setting. This setting is specified for a specific [listener](concepts/application-load-balancer.md#listener) and helps you with applications that are case-sensitive to header names.

   This setting is available via the API, CLI, and {{ TF }}.

* Added `labels` and `description` for [virtual hosts](concepts/http-router.md#virtual-host). This setting is available via the API.

* Added sending of [{{ at-name }} events](at-ref.md#control-plane-events) about virtual host updates due to HTTP router updates. Changes in hosts are now recorded when they are updated within a router too.

* Made the [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail) format validation of trusted CA certificates stricter: invalid certificates are rejected before applying the load balancer configuration.

* In the management console, added the ability to add load balancers, HTTP routers, backend groups, and target groups to favorites.

* Accelerated the completion of operations when configuring a load balancer.

* Fixed the following errors in the management console:

  * When cyrillic characters are saved in the body of a direct HTTP response when configuring an HTTP router.
  * When [Global RateLimit](concepts/rate-limiter.md) limitations are linked to routes when sorting, updating, or disabling limitations.
  * When redirect HTTP codes are displayed in the HTTP router configuration form.

## Q1 2026 {#q1-2026}

* Added the support for [mutual TLS (mTLS) authentication](concepts/application-load-balancer.md#mtls) between the client and load balancer HTTPS listener. To verify client certificates, specify a root CA certificate in [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail) format. You can provide the client certificate as well as information about its issuer and subject to the backend in HTTP headers for client identification and audit.

  This setting is available via the API and CLI. See the configuration procedure in [Terminating TLS connections](tutorials/tls-termination/console.md#client-certificate).

* Extended sending of [{{ at-name }} events](at-ref.md#control-plane-events) for virtual hosts. Events are sent on host operations via the HTTP router as well as on creating or deleting hosts together with the router.

* Fixed bugs related to:

  * When a link to a connected [{{ sws-name }} security profile](../smartwebsecurity/operations/host-connect.md#host) was deleted when updating other virtual host fields via the API with `update_mask`.
  * When displaying target group VMs in the management console with matching IP addresses in different subnets.

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
