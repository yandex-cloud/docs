---
title: Setting limits on the number of requests in {{ alb-full-name }}
description: This page covers the concepts for setting limits in {{ alb-name }}.
---

# Setting limits on the number of requests using the Global RateLimit module

{% include [rate-limiter-preview](../../_includes/application-load-balancer/rate-limiter-preview.md) %}

Use Global RateLimit to set a limit on the number of HTTP and gRPC requests to a virtual host. You can set this limit for the entire virtual host or its individual route.

{% note info %}

You can also set the request limits in [{{ sws-full-name }}](../../smartwebsecurity/concepts/arl.md). We recommend setting request limits in one service only, either in {{ alb-name }} or in {{ sws-name }}. Duplicate settings may complicate monitoring and support of your applications.

{% endnote %}

Limiting incoming traffic helps you to do the following:

* Protect your host from overload by setting limits to match your system capacity.
* Distribute application resources more evenly among customers by setting per-IP address request limits.

In Global RateLimit, you can set:

* Limit on the number of requests per second (RPS) or per minute (RPM).
* Methods for tracking the number of requests: 
  * `all-requests`: Single limit for all incoming requests.
  * `requests-per-ip`: Limit for each separate IP address. This way, each IP address can accept only a specified number of requests per unit of time.

Response codes returned by RateLimit when blocking requests:

* `429`: For HTTP
* `UNAVAILABLE`: For gRPC

## How Global RateLimit works {#grl-specific}

* When the RateLimit module is unavailable, limits do not apply (_Fail Open_ mode).
* If the load spikes or there are delays in data synchronization between load balancer nodes, the number of routed requests may exceed the limits. Requests allowed beyond the limit will be accounted for in the next time intervals.
   
> For example, you set a limit of 50 requests per second (`50 RPS`). In the first second, 52 requests were routed, exceeding the limit. This means that, in the next second, only 48 requests will be routed.

## Request routing when using limits {#routing-requests-with-limits}

In the examples below, _allowed requests_ are requests the load balancer routed to the virtual host. If you have a [security profile](../../smartwebsecurity/concepts/profiles.md) configured, a request may be blocked by {{ sws-full-name }}.

### Limits for individual virtual host routes {#routes-limits}

Here is an example with non-IP specific limits set for two virtual host routes.

![image](../../_assets/application-load-balancer/alb-ratelimit-01.svg)

In this example, requests will be processed as follows:

* Request `1`: Allowed, as it does not exceed the limit for `/foo`.
* Request `2`: Allowed, as it does not exceed the limit for `/bar`.
* Requests `3` and `4`: Rejected, as they exceed the limit for `/foo`.

### Per-IP address limits for individual virtual host routes {#routes-limits-per-ip}

Here is an example with per-IP address limits set for two virtual host routes.

![image](../../_assets/application-load-balancer/alb-ratelimit-02.svg)

In this example, requests will be processed as follows:

* Request `1`: Allowed, as it does not exceed the limit for `/foo` for the `1.2.3.4` IP address.
* Request `2`: Rejected, as it exceeds the limit for `/foo` for the `1.2.3.4` IP address.
* Request `3`: Allowed, as it does not exceed the limit for `/foo` for the `1.2.3.5` IP address.
* Request `4`: Allowed, as it does not exceed the limit for `/bar` for the `1.2.3.4` IP address.

### Limits for individual routes and entire virtual host {#routes-and-hosts-limits}

In this example, non-IP specific limits are set for the virtual host and its individual routes. The same logic applies to virtual host and route limits that include IP-address limiting.

![image](../../_assets/application-load-balancer/alb-ratelimit-03.svg)

* Request `1`: Allowed, as it does not exceed the limit for `/foo` for the `1.2.3.4` IP address.
 
   Virtual host request counter: 1.
* Request `2`: Rejected, as it exceeds the limit for `/foo` for the `1.2.3.4` IP address.

   Virtual host request counter: 2.
* Request `3`: Allowed, as it does not exceed the limit for `/bar` for the `1.2.3.4` IP address.

   Virtual host request counter: 3.
* Request `4`: Rejected, as it exceeds the request limit for the virtual host.

## Recommendations for setting limits {#limits-recommendations}

To determine the optimal request rate:

1. Analyze your current traffic amount, infrastructure capacity, and application specifics. 
1. Start configuring RateLimit with a minimal limit that does not overload the system. 
1. Gradually increase the limit while monitoring system performance and health.
   
This way, you can configure request rate aligned with your actual needs and system capacity.

## Monitoring {#monitoring}

You can monitor Global RateLimit performance in the **{{ ui-key.yacloud.common.monitoring }}** section of the relevant load balancer or in [{{ monitoring-full-name }}]({{ link-monitoring }}).

There are two preconfigured charts you can use:

* **RPS**: Number of requests routed by the load balancer per second.
* **4XX**: Number of requests with a `4XX` response code.

In {{ monitoring-name }}, you can configure additional charts for more detailed information. For example, to monitor requests which received a `429` response code, use the following [token](../../monitoring/concepts/visualization/query-string.md) settings:

* `service` = `Application Load Balancer`.
* `name` = `load_balancer.requests_count_per_second`.
* `load_balancer` = `<load_balancer_ID>`.
* `http_router` = `*`.
* `virtual_host` = `*`.
* `route` = `*`.
* `backend_group` = `*`.
* `backend` = `*`.
* `zone` = `*`.
* `code` = `429`.

{% note info %}

Metric selection by parameters such as `backend_group`, `virtual_host`, `route`, and others is not available for requests denied by RateLimit.

{% endnote %}