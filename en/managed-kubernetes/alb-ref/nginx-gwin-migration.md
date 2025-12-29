---
title: Migrating applications from Ingress NGINX to Gwin in {{ managed-k8s-full-name }}
description: This article maps Ingress NGINX custom annotations against Gwin custom annotations you will need to migrate applications to Gwin in {{ managed-k8s-name }}.
---

# Migrating applications from NGINX Ingress to Gwin

{{ alb-full-name }} allows you to create and manage load balancers in [{{ managed-k8s-full-name }} clusters](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) using the [Gwin](gwin-index.md) controller. Installed in a cluster, the Gwin controller automatically deploys [L7 load balancers](../../application-load-balancer/concepts/application-load-balancer.md) based on the configuration of your {{ k8s }} resources.

To migrate applications from the NGINX Ingress Controller to Gwin, follow these steps:

1. [Install the Gwin controller](../../application-load-balancer/tools/gwin/quickstart.md) in your cluster.
1. Migrate custom annotations from the NGINX Ingress controller to the Gwin controller using the [mapping table](#table-nginx-gwin).
1. [Switch the workload over to the Gwin controller](#switch-controller).

## Mapping table of Ingress NGINX and Gwin annotations {#table-nginx-gwin}

The table gives abbreviated annotation names for NGINX and Gwin. Full annotation names start with `nginx.ingress.kubernetes.io/` for NGINX, and `gwin.yandex.cloud/` for Gwin.

#|
|| **NGINX** | **Gwin** | **Description** ||
|| **Redirection** |  |  ||
|| `force-ssl-redirect`
`ssl-redirect`|  [redirect.{name}.replaceScheme](../gwin-ref/ingress.md#redirect-actions) | Redirects to another protocol (HTTP/HTTPS) ||
|| `permanent-redirect`
`temporal-redirect`
`app-root`
| [redirect.{name}.replaceScheme](../gwin-ref/ingress.md#redirect-actions)
[redirect.{name}.replaceHost](../gwin-ref/ingress.md#redirect-actions)
[redirect.{name}.replacePort](../gwin-ref/ingress.md#redirect-actions)
[redirect.{name}.path.replacePath](../gwin-ref/ingress.md#redirect-actions)
[redirect.{name}.path.replacePrefix](../gwin-ref/ingress.md#redirect-actions)
[redirect.{name}.removeQuery](../gwin-ref/ingress.md#redirect-actions)
[redirect.{name}.responseCode](../gwin-ref/ingress.md#redirect-actions)
| Redirect to another address

Gwin specifies `redirect.{name}.responseCode = "301"` for permanent redirection and `redirect.{name}.responseCode = "302"` for temporary redirection ||
|| `rewrite-target`
| [rules.prefixRewrite](../gwin-ref/ingress.md#route-configuration)
[rules.hostRewrite.auto](../gwin-ref/ingress.md#host-rewriting)
[rules.hostRewrite.replace](../gwin-ref/ingress.md#host-rewriting)
[rules.http.regexRewrite.regex](../gwin-ref/ingress.md#path-rewriting)
[rules.http.regexRewrite.substitute](../gwin-ref/ingress.md#path-rewriting)
| Rewrites URLs at the proxy level without changing the address in the browser ||
|| **Backend configuration** |  |  ||
|| `backend-protocol`
| [rules.backends.http.useHTTP2](../gwin-ref/ingress.md#backend-group-configuration)

[rules.backends.tls.sni](../gwin-ref/ingress.md#backend-tls-configuration)
[rules.backends.tls.trustedCA.id](../gwin-ref/ingress.md#backend-tls-configuration)
[rules.backends.tls.trustedCA.bytes](../gwin-ref/ingress.md#backend-tls-configuration)
| Establishes the connection protocol between the load balancer and backends ||
|| **Client authentication** | |  ||
|| `auth-type`
`auth-secret`
`auth-secret-type`
`auth-realm`

`auth-tls-secret`
`auth-tls-verify-depth`
`auth-tls-verify-client`
`auth-tls-error-page`
`auth-tls-pass-certificate-to-upstream`
`auth-tls-match-cn`
| [{resource}.rbac.principals.{principal-group}.{principal}.{rule-type}](../gwin-ref/ingress.md#rbac-configuration)
| In NGINX, authentication is performed via HTTP (Basic/Digest) or TLS certificates, whereas in Gwin, using the role-based access control (RBAC) system. RBAC manages access to routes and hosts based on request attributes. ||
|| **Binding a session to a backend** |  |  ||
|| `affinity`
`affinity-mode`
`affinity-canary-behavior`

`session-cookie-name`
`session-cookie-path`
`session-cookie-domain`
`session-cookie-change-on-failure`
`session-cookie-samesite`
`session-cookie-conditional-samesite-none`
| [rules.sessionAffinity.header.name](../gwin-ref/ingress.md#session-affinity)
[rules.sessionAffinity.cookie.name](../gwin-ref/ingress.md#session-affinity)
[rules.sessionAffinity.cookie.ttl](../gwin-ref/ingress.md#session-affinity)
[rules.sessionAffinity.sourceIP](../gwin-ref/ingress.md#session-affinity)
| NGINX allows session binding via cookies; Gwin does the same via cookies, headers, or IP addresses ||
|| **Backend certificate verification** |  |  ||
|| `proxy-ssl-secret`
`proxy-ssl-verify`
`proxy-ssl-verify-depth`
`proxy-ssl-ciphers`
`proxy-ssl-name`
`proxy-ssl-protocols`
| [rules.backends.tls.sni](../gwin-ref/ingress.md#backend-tls-configuration)
[rules.backends.tls.trustedCA.id](../gwin-ref/ingress.md#backend-tls-configuration)
[rules.backends.tls.trustedCA.bytes](../gwin-ref/ingress.md#backend-tls-configuration)
| NGINX sets up certificate verification through SSL; Gwin uses TLS ||
|| **Connection timeouts** |  |  ||
|| `proxy-connect-timeout`
`proxy-send-timeout`
`proxy-read-timeout`
`proxy-next-upstream`
`proxy-next-upstream-timeout`
`proxy-next-upstream-tries`
`proxy-request-buffering`
| [rules.timeout](../gwin-ref/ingress.md#route-configuration)
[rules.idleTimeout](../gwin-ref/ingress.md#route-configuration)
| In Gwin, you set a general backend response timeout and an idle timeout ||
|| **Rate limit** |  |  ||
|| `global-rate-limit`
`global-rate-limit-window`
`global-rate-limit-key`
`global-rate-limit-ignored-cidrs`
| [hosts.rateLimit.allRequests.perSecond](../gwin-ref/ingress.md#rate-limiting)
[hosts.rateLimit.allRequests.perMinute](../gwin-ref/ingress.md#rate-limiting)
[hosts.rateLimit.requestsPerIP.perSecond](../gwin-ref/ingress.md#rate-limiting)
[hosts.rateLimit.requestsPerIP.perMinute](../gwin-ref/ingress.md#rate-limiting)
| Sets the maximum number of requests you can send within a time interval ||
|| **Logging** |  |  ||
|| `enable-access-log` 
| [logs.logGroupID](../gwin-ref/ingress.md#cloud-logging)
[logs.logs.disable](../gwin-ref/ingress.md#cloud-logging)
[logs.discardRule.{name}.httpCodes](../gwin-ref/ingress.md#cloud-logging)
[logs.discardRule.{name}.httpCodeIntervals](../gwin-ref/ingress.md#cloud-logging)
[logs.discardRule.{name}.grpcCodes](../gwin-ref/ingress.md#cloud-logging)
[logs.discardRule.{name}.discardPercent](../gwin-ref/ingress.md#cloud-logging)
| Enables logging

In Gwin, you can also configure logging parameters ||
|| **Other** |  |  ||
|| `custom-http-errors`
| [directResponse.{name}.responseCode](../gwin-ref/ingress.md#direct-response-actions)
[directResponse.{name}.responseBody.text](../gwin-ref/ingress.md#direct-response-actions)
| Specifies the error code and response text ||
|| `proxy-http-version`
| [rules.backends.http.useHTTP2](../gwin-ref/ingress.md#backend-group-configuration)
| Determines the HTTP version for backend interaction ||
|| `limit-rps`
| [hosts.rateLimit.requestsPerIP.perSecond](../gwin-ref/ingress.md#rate-limiting)
| Sets the number of requests from one IP per second ||
|| `proxy-cookie-domain`
`proxy-cookie-path`
| [rules.modifyResponseHeaders.append.{header-name}](../gwin-ref/ingress.md#response-header-modifications)
[rules.modifyResponseHeaders.rename.{old-header-name}](../gwin-ref/ingress.md#response-header-modifications)
[rules.modifyResponseHeaders.replace.{header-name}](../gwin-ref/ingress.md#response-header-modifications)
[rules.modifyResponseHeaders.remove](../gwin-ref/ingress.md#response-header-modifications)
| Set response headers ||
|| `load-balance`
| [rules.backends.balancing.mode](../gwin-ref/ingress.md#backend-group-configuration)
| Sets the load balancing algorithm ||
|#

## Switch workload to the Gwin controller {#switch-controller}

{% include [switch-controller](../../_includes/managed-kubernetes/alb-ref/switch-controller.md) %}