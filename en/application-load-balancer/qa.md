---
title: FAQ about {{ alb-full-name }}
description: Questions and answers about logging client IP addresses, the no_route error, and troubleshooting the ingress controller in {{ alb-name }}.
---

# FAQ about {{ alb-name }}

* [{#T}](#client-ip)
* [{#T}](#no-route)
* [{#T}](#ingress-route)

## How do I log client IP addresses on a web server? {#client-ip}

{{ alb-name }} provides the source IP address of an HTTP request in the `X-Forwarded-For` header. To log this address on the backend web server, add this header to the log format.

{% list tabs %}

- Nginx

    In the `http` section, define a log format using the `$http_x_forwarded_for` variable. Then, specify the format name in the `access_log` directive:

    ```nginx
    log_format alb '$remote_addr - $remote_user [$time_local] "$request" '
                   '$status $body_bytes_sent "$http_referer" '
                   '"$http_user_agent" "$http_x_forwarded_for"';
    access_log /var/log/nginx/access.log alb;
    ```

    If the `access_log` directive is already defined in the `server` or `location` section, set its format to `alb` as well.

- Apache HTTP Server

    In the `LogFormat` directive, the header is indicated as `%{X-Forwarded-For}i`. This format is used in `CustomLog`:

    ```apache
    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{X-Forwarded-For}i\"" alb
    CustomLog "logs/access_log" alb
    ```

{% endlist %}

Log file paths depend on the web server configuration. After you apply the configuration and restart the web server, the header will be written to the request logs. If the request passes through intermediate proxies, the header may contain multiple IP addresses.

In {{ network-load-balancer-full-name }}, the source IP address is preserved by default. For a `LoadBalancer` {{ k8s }} service, set `externalTrafficPolicy: Local` to keep the client IP address unchanged on the backend. For more on creating a network load balancer, see [this guide](../managed-kubernetes/operations/create-load-balancer.md#create-lb).

## Why do I get a `no_route` error when switching between domains? {#no-route}

The `no_route` error means that the request does not match any route in the load balancer’s HTTP routers.

If multiple domains resolve to the same IP address and are covered by a single TLS certificate, the browser may reuse an existing connection when switching between domains. The SNI handler is not reselected, so the request may be routed to a different HTTP router. For information about configuring certificates and virtual hosts, see [Listener](concepts/application-load-balancer.md#listener).

## Why is the route missing after I apply the ingress configuration? {#ingress-route}

You can identify the cause by checking the {{ alb-name }} ingress controller logs. For more on how to check the created load balancer and select the controller pod, see [this guide on applying the configuration](operations/k8s-ingress-controller-apply.md#apply).

If your static public IP address quota has been exceeded, a load balancer with a public IP address may not be created. However, this is only one possible cause, as resource configuration issues can also lead to errors. [Increase the quota](../quota-manager/operations/set-quotas.md) only if the logs confirm that it has been exceeded.
