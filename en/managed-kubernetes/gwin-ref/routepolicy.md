---
sourcePath: en/_gwin-ref/gwin-ref/routepolicy.md
---
# RoutePolicy

RoutePolicy is a Gwin custom resource for configuring route-level policies in Yandex Application Load Balancer. It allows you to define backend settings, routing configuration, virtual host options, and security policies that apply to HTTPRoute, GRPCRoute, and TLSRoute resources.

* [Cheatsheet](#cheatsheet)
* [RoutePolicySpec](#routepolicyspec)
  * [LocalObjectReference](#localobjectreference)
  * [LabelSelector](#labelselector)
  * [LabelSelectorRequirement](#labelselectorrequirement)
  * [Route](#route)
  * [RouteRule](#routerule)
  * [BackendGroup](#backendgroup)
  * [Backend](#backend)
  * [HTTPBackend](#httpbackend)
  * [GRPCBackend](#grpcbackend)
  * [StreamBackend](#streambackend)
  * [LoadBalancingConfig](#loadbalancingconfig)
  * [HealthCheck](#healthcheck)
  * [HealthcheckHTTP](#healthcheckhttp)
  * [HealthcheckGRPC](#healthcheckgrpc)
  * [HealthcheckStream](#healthcheckstream)
  * [HealthCheckTransportSettings](#healthchecktransportsettings)
  * [BackendTLS](#backendtls)
  * [BackendTLSTrustedCA](#backendtlstrustedca)
  * [SessionAffinity](#sessionaffinity)
  * [SessionAffinityConnection](#sessionaffinityconnection)
  * [SessionAffinityCookie](#sessionaffinitycookie)
  * [SessionAffinityHeader](#sessionaffinityheader)
  * [ALBRoute](#albroute)
  * [RouteALBHTTP](#routealbhttp)
  * [HostRewrite](#hostrewrite)
  * [RegexMatchAndSubstitute](#regexmatchandsubstitute)
  * [VirtualHost](#virtualhost)
  * [RateLimit](#ratelimit)
  * [RateLimitLimit](#ratelimitlimit)
  * [RBAC](#rbac)
  * [AndPrincipals](#andprincipals)
  * [Principal](#principal)
  * [HeaderPrincipal](#headerprincipal)
  * [IPPrincipal](#ipprincipal)
* [RoutePolicyStatus](#routepolicystatus)

## Cheatsheet

{% note info %}

Specification provided below is not valid configuration.

It's just demonstration of all `RoutePolicy` fields.

{% endnote %}

```yaml
apiVersion: gwin.yandex.cloud/v1
kind: RoutePolicy
metadata:
  name: example-route-policy
  namespace: example-ns
spec:
  # Target Route resources
  targetRefs:
    - group: gateway.networking.k8s.io
      kind: HTTPRoute
      name: example-http-route
    - group: gateway.networking.k8s.io
      kind: GRPCRoute
      name: example-grpc-route
  # Or use label selector
  selector:
    matchLabels:
      app: my-routes
    matchExpressions:
      - key: environment
        operator: In
        values: ["production", "staging"]
  # Route policy configuration
  policy:
    # Common rules settings (applies to all rules)
    rules:
      # Backend group configuration
      backends:
        http:
          useHTTP2: true  # enable HTTP/2 to backends
        grpc: {}  # gRPC-specific settings
        stream:
          enableProxy: true  # enable proxy protocol
          keepConnectionsOnHostHealthFailure: false  # drop failed connections
        
        balancing:
          mode: "ROUND_ROBIN"  # load balancing algorithm
          localityAwareRouting: 80  # prefer same zone
          strictLocality: false  # allow cross-zone routing
          panicThreshold: 50  # panic mode threshold
        
        # Health checks
        hc:
          timeout: "5s"  # health check timeout
          interval: "10s"  # check interval
          healthyThreshold: 2  # checks to mark healthy
          unhealthyThreshold: 3  # checks to mark unhealthy
          port: 8080  # health check port
          
          http:
            path: "/health"  # HTTP health check path
            host: "health.example.com"  # Host header
            useHTTP2: false  # use HTTP/1.1 for checks
            expectedStatuses: [200, 202]  # healthy status codes
          
          grpc:
            serviceName: "health.HealthService"  # gRPC service
          
          stream:
            send: "PING"  # TCP check data to send
            receive: "PONG"  # expected TCP response
          
          # Health check transport settings
          transportSettings:
            plaintext: true  # use plaintext for health checks
            tls:
              sni: "health.example.com"  # SNI for health check TLS
              trustedCA:
                id: "health-cert-123"  # health check TLS cert ID
        
        # Backend TLS configuration
        tls:
          sni: "backend.example.com"  # SNI for TLS
          trustedCA:
            id: "cert-123456"  # cloud certificate ID
        
        # Session affinity
        sessionAffinity:
          connection:
            sourceIP: true  # IP-based affinity
          cookie:
            name: "session"  # cookie name
            ttl: "3600s"  # cookie lifetime
          header:
            name: "X-Session-ID"  # header-based affinity
      
      # Route timeouts
      timeout: "60s"  # overall connection timeout
      idleTimeout: "300s"  # idle connection timeout
      
      # Rate limiting for routes
      rateLimit:
        allRequests:
          perSecond: 100  # route-level rate limit for all requests
          perMinute: 6000  # route-level rate limit for all requests
        requestsPerIP:
          perSecond: 10  # route-level rate limit per IP
          perMinute: 600  # route-level rate limit per IP
      
      # Host rewriting
      hostRewrite:
        auto: true  # automatically rewrite host to backend target
        replace: "backend.example.com"  # static host replacement
      
      # HTTP specific settings
      http:
        upgradeTypes: ["websocket"]  # supported upgrade protocols
        regexRewrite:
          regex: "^/service/([^/]+)(/.*)$"  # regex pattern for path rewriting
          substitute: "\\2/instance/\\1"  # substitution with capture groups
      
      # Security
      securityProfileID: "security-profile-1"  # WAF profile for routes
      rbac:
        action: "ALLOW"  # default RBAC action
        principals:
          admin:
            check-token:
              header:
                name: "authorization"
                exact: "Bearer admin123"
            check-ip:
              ip:
                remoteIp: "10.0.0.0/8"
    
    # Specific rule settings (conflict with global settings is an error)
    rule:
      api-rule:  # rule name from HTTPRoute
        backends:
          balancing:
            mode: "LEAST_REQUEST"  # per-rule balancing
        ...

    # Common hosts settings (applies to all hosts)
    hosts:
      securityProfileID: "host-security-profile-1"  # WAF profile for hosts
      rateLimit:
        allRequests:
          perSecond: 100  # global rate limit
          perMinute: 6000  # global rate limit
        requestsPerIP:
          perSecond: 10  # per-IP rate limit
          perMinute: 600  # per-IP rate limit
      rbac:
        action: "DENY"  # host-level RBAC action
        principals:
          blocked:
            bad-ip:
              ip:
                remoteIp: "192.168.1.0/24"
    
    # Specific host settings (conflict with global settings is an error)
    host:
      "api.example.com":  # specific hostname
        securityProfileID: "api-host-security"  # per-host WAF
        ...
status:
  conditions:
    - type: "Ready"
      status: "True"
      reason: "PolicyApplied"
  attachedRoutes: 5
```

| Field | Description |
|-------|-------------|
| metadata | **ObjectMeta** <br> Standard Kubernetes metadata. |
| spec | **[RoutePolicySpec](#routepolicyspec)** <br> Route policy specification. |
| status | **[RoutePolicyStatus](#routepolicystatus)** <br> Route policy status. |

## RoutePolicySpec

RoutePolicySpec defines the desired state of RoutePolicy.

*Appears in:* [RoutePolicy](#cheatsheet)

| Field | Description |
|-------|-------------|
| targetRefs | **[[]LocalObjectReference](#localobjectreference)** <br> References to Route resources (HTTPRoute, GRPCRoute, TLSRoute) that this policy should apply to. |
| selector | **[LabelSelector](#labelselector)** <br> Label selector for Route resources that this policy should apply to. |
| policy | **[Route](#route)** <br> Route policy configuration. |

### LocalObjectReference

Reference to a local Kubernetes object.

*Appears in:* [RoutePolicySpec](#routepolicyspec)

| Field | Description |
|-------|-------------|
| group | **string** <br> API group of the target resource. <br> Example: `gateway.networking.k8s.io` |
| kind | **string** <br> Kind of the target resource. <br> Example: `HTTPRoute` |
| name | **string** <br> Name of the target resource. <br> Example: `example-http-route` |

### LabelSelector

Label selector for selecting resources by labels.

*Appears in:* [RoutePolicySpec](#routepolicyspec)

| Field | Description |
|-------|-------------|
| matchLabels | **map[string]string** <br> Map of key-value pairs for exact label matching. <br> Example: `app: my-routes` |
| matchExpressions | **[[]LabelSelectorRequirement](#labelselectorrequirement)** <br> List of label selector requirements. |

### LabelSelectorRequirement

Label selector requirement for advanced label matching.

*Appears in:* [LabelSelector](#labelselector)

| Field | Description |
|-------|-------------|
| key | **string** <br> Label key that the selector applies to. <br> Example: `environment` |
| operator | **string** <br> Operator for the requirement. Options: `In`, `NotIn`, `Exists`, `DoesNotExist`. <br> Example: `In` |
| values | **[]string** <br> Array of string values for `In` and `NotIn` operators. <br> Example: `["production", "staging"]` |

### Route

Route policy configuration that applies to routing rules and virtual hosts.

*Appears in:* [RoutePolicySpec](#routepolicyspec)

| Field | Description |
|-------|-------------|
| rules | **[RouteRule](#routerule)** <br> Common rules settings that apply to all route rules. |
| rule | **map[string][RouteRule](#routerule)** <br> Specific rules settings where key is the rule name. |
| hosts | **[VirtualHost](#virtualhost)** <br> Common hosts settings that apply to all virtual hosts. |
| host | **map[string][VirtualHost](#virtualhost)** <br> Specific hosts settings where key is the hostname. |

### RouteRule

Route rule configuration that combines backend group and route settings.

*Appears in:* [Route](#route)

| Field | Description |
|-------|-------------|
| backends | **[Backend](#backend)** <br> Backend configuration settings. |
| sessionAffinity | **[SessionAffinity](#sessionaffinity)** <br> Session affinity configuration for the backend group. |
| timeout | **string** <br> Overall timeout for HTTP connection between load balancer and backend. Default: `60s`. <br> Example: `60s` |
| idleTimeout | **string** <br> Idle timeout for HTTP connection. <br> Example: `300s` |
| rateLimit | **[RateLimit](#ratelimit)** <br> Rate limit configuration applied for route. |
| hostRewrite | **[HostRewrite](#hostrewrite)** <br> Host header rewriting configuration. |
| http | **[RouteALBHTTP](#routealbhttp)** <br> HTTP specific route options. |
| securityProfileID | **string** <br> Security profile ID for route-level protection. <br> Example: `security-profile-1` |
| rbac | **[RBAC](#rbac)** <br> RBAC access control configuration. |


### Backend

Backend configuration for protocol-specific settings, load balancing, health checks, and TLS.

*Appears in:* [RouteRule](#routerule)

| Field | Description |
|-------|-------------|
| http | **[HTTPBackend](#httpbackend)** <br> HTTP specific backend settings. |
| grpc | **[GRPCBackend](#grpcbackend)** <br> gRPC specific backend settings. |
| stream | **[StreamBackend](#streambackend)** <br> TCP stream specific backend settings. |
| balancing | **[LoadBalancingConfig](#loadbalancingconfig)** <br> Load balancing configuration for the backend. |
| hc | **[HealthCheck](#healthcheck)** <br> Health check configuration. |
| tls | **[BackendTLS](#backendtls)** <br> TLS settings for backend connections. |

### HTTPBackend

HTTP specific backend settings.

*Appears in:* [Backend](#backend)

| Field | Description |
|-------|-------------|
| useHTTP2 | **bool** <br> Enables HTTP/2 usage in connections between load balancer nodes and backend targets. Default: `false`. <br> Example: `true` |

### GRPCBackend

gRPC specific backend settings.

*Appears in:* [Backend](#backend)

Reserved for future gRPC-specific settings.

### StreamBackend

TCP stream specific backend settings.

*Appears in:* [Backend](#backend)

| Field | Description |
|-------|-------------|
| enableProxy | **bool** <br> If set, proxy protocol will be enabled for this backend. <br> Example: `true` |
| keepConnectionsOnHostHealthFailure | **bool** <br> If a backend host becomes unhealthy, keep connections to the failed host. <br> Example: `false` |

### LoadBalancingConfig

Load balancing configuration for backends.

*Appears in:* [Backend](#backend)

| Field | Description |
|-------|-------------|
| panicThreshold | **int** <br> Threshold for panic mode (percentage). If healthy backends drop below this threshold, traffic routes to all backends. Set to `0` to disable panic mode. <br> Example: `50` |
| localityAwareRouting | **int** <br> Percentage of traffic sent to backends in the same availability zone. Remaining traffic is divided equally between other zones. <br> Example: `90` |
| strictLocality | **bool** <br> Send traffic only to backends in the same availability zone. If `true`, `localityAwareRouting` is ignored. <br> Example: `false` |
| mode | **string** <br> Load balancing mode. Options: `ROUND_ROBIN`, `LEAST_REQUEST`, `RANDOM`, `RING_HASH`, `MAGLEV_HASH`. <br> Example: `ROUND_ROBIN` |

### HealthCheck

Health check configuration for monitoring backend health.

*Appears in:* [Backend](#backend)

| Field | Description |
|-------|-------------|
| timeout | **string** <br> Health check timeout — time allowed for the target to respond. <br> Example: `5s` |
| interval | **string** <br> Base interval between consecutive health checks. <br> Example: `10s` |
| healthyThreshold | **int** <br> Number of consecutive successful checks to mark target as healthy. Default: `0` (1 check required). <br> Example: `2` |
| unhealthyThreshold | **int** <br> Number of consecutive failed checks to mark target as unhealthy. Default: `0` (1 check required). <br> Example: `3` |
| port | **int** <br> Port used for health checks. If not specified, backend port is used. <br> Example: `8080` |
| http | **[HealthcheckHTTP](#healthcheckhttp)** <br> HTTP-specific health check settings. |
| grpc | **[HealthcheckGRPC](#healthcheckgrpc)** <br> gRPC-specific health check settings. |
| stream | **[HealthcheckStream](#healthcheckstream)** <br> TCP stream-specific health check settings. |
| transportSettings | **[HealthCheckTransportSettings](#healthchecktransportsettings)** <br> Optional transport protocol for health checks. |

### HealthcheckHTTP

HTTP-specific health check settings.

*Appears in:* [HealthCheck](#healthcheck)

| Field | Description |
|-------|-------------|
| host | **string** <br> Value for the HTTP/1.1 `Host` header or HTTP/2 `:authority` pseudo-header. <br> Example: `health.example.com` |
| path | **string** <br> HTTP path used in requests to targets. <br> Example: `/health` |
| useHTTP2 | **bool** <br> Enables HTTP/2 usage in health checks. Default: `false`. <br> Example: `true` |
| expectedStatuses | **[]int** <br> List of HTTP response statuses considered healthy. Default: `[200]`. <br> Example: `[200, 202, 204]` |

### HealthcheckGRPC

gRPC-specific health check settings.

*Appears in:* [HealthCheck](#healthcheck)

| Field | Description |
|-------|-------------|
| serviceName | **string** <br> Name of the gRPC service to be checked. If not specified, overall health is checked. <br> Example: `health.v1.HealthService` |

### HealthcheckStream

TCP stream-specific health check settings.

*Appears in:* [HealthCheck](#healthcheck)

| Field | Description |
|-------|-------------|
| send | **string** <br> Message sent to targets during TCP data transfer. If not specified, no data is sent. <br> Example: `PING` |
| receive | **string** <br> Data that must be contained in received messages for successful health check. If not specified, no messages are expected. <br> Example: `PONG` |

### HealthCheckTransportSettings

Transport protocol settings for health checks.

*Appears in:* [HealthCheck](#healthcheck)

| Field | Description |
|-------|-------------|
| plaintext | **bool** <br> Use plaintext protocol for health checks. Set to `true` to force HTTP health checks even for HTTPS backends. <br> Example: `true` |
| tls | **[BackendTLS](#backendtls)** <br> TLS settings for health checks. Use when health checks require different TLS configuration than backend. |

### BackendTLS

TLS settings for backend connections. \
Use when the load balancer must connect to its targets over TLS. \
If you only need “TLS as is” (no SNI and no backend certificate verification), provide an empty `tls: {}` section.
Health check TLS settings work the same way, but are configured separately.

*Appears in:* [Backend](#backend), [HealthCheckTransportSettings](#healthchecktransportsettings)

| Field | Description |
|-------|-------------|
| sni | **string** <br> Server Name Indication (SNI) string for TLS connections. <br> Example: `backend.example.com` |
| trustedCA | **[BackendTLSTrustedCA](#backendtlstrustedca)** <br> Validation context for TLS connections. |

### BackendTLSTrustedCA

Trusted CA configuration for TLS validation.

*Appears in:* [BackendTLS](#backendtls)

| Field | Description |
|-------|-------------|
| id | **string** <br> Cloud certificate ID. <br> Example: `fpq6gvvm6piu********` |
| bytes | **string** <br> X.509 certificate contents in PEM format. <br> Example: `-----BEGIN CERTIFICATE-----\n...\n-----END CERTIFICATE-----` |

### SessionAffinity

Session affinity configuration for routing requests from the same client to the same backend.

*Appears in:* [RouteRule](#routerule)

| Field | Description |
|-------|-------------|
| connection | **[SessionAffinityConnection](#sessionaffinityconnection)** <br> Connection-based session affinity (by client IP). |
| cookie | **[SessionAffinityCookie](#sessionaffinitycookie)** <br> Cookie-based session affinity. |
| header | **[SessionAffinityHeader](#sessionaffinityheader)** <br> HTTP header-based session affinity. |

### SessionAffinityConnection

Connection-based session affinity configuration.

*Appears in:* [SessionAffinity](#sessionaffinity)

| Field | Description |
|-------|-------------|
| sourceIP | **bool** <br> Use client IP address for session affinity. <br> Example: `true` |

### SessionAffinityCookie

Cookie-based session affinity configuration.

*Appears in:* [SessionAffinity](#sessionaffinity)

| Field | Description |
|-------|-------------|
| name | **string** <br> Name of the cookie used for session affinity. <br> Example: `session-cookie` |
| ttl | **string** <br> Maximum age of generated session cookies. Set to `0` for session cookies (deleted on client restart). If not set, balancer only uses incoming cookies. <br> Example: `3600s` |

### SessionAffinityHeader

HTTP header-based session affinity configuration.

*Appears in:* [SessionAffinity](#sessionaffinity)

| Field | Description |
|-------|-------------|
| name | **string** <br> Name of the HTTP header field used for session affinity. <br> Example: `X-Session-ID` |

### ALBRoute

Application Load Balancer route configuration.

*Appears in:* [RouteRule](#routerule)

| Field | Description |
|-------|-------------|
| timeout | **string** <br> Overall timeout for HTTP connection between load balancer and backend. Default: `60s`. <br> Example: `60s` |
| idleTimeout | **string** <br> Idle timeout for HTTP connection. <br> Example: `300s` |
| http | **[RouteALBHTTP](#routealbhttp)** <br> HTTP specific route options. |
| securityProfileID | **string** <br> Security profile ID for route-level protection. <br> Example: `security-profile-1` |
| rbac | **[RBAC](#rbac)** <br> RBAC access control configuration. |

### RouteALBHTTP

HTTP-specific route configuration.

*Appears in:* [ALBRoute](#albroute), [RouteRule](#routerule)

| Field | Description |
|-------|-------------|
| upgradeTypes | **[]string** <br> Supported values for HTTP `Upgrade` header. <br> Example: `["websocket"]` |
| regexRewrite | **[RegexMatchAndSubstitute](#regexmatchandsubstitute)** <br> Path rewriting using regular expressions. |

### VirtualHost

Virtual host configuration for rate limiting and access control.

*Appears in:* [Route](#route)

| Field | Description |
|-------|-------------|
| securityProfileID | **string** <br> Security profile ID for host-level protection. <br> Example: `host-security-profile-1` |
| rbac | **[RBAC](#rbac)** <br> RBAC access control configuration. |
| rateLimit | **[RateLimit](#ratelimit)** <br> Rate limit configuration applied for a whole virtual host. |

### RateLimit

Rate limit configuration applied to virtual hosts.

*Appears in:* [VirtualHost](#virtualhost)

| Field | Description |
|-------|-------------|
| allRequests | **[RateLimitLimit](#ratelimitlimit)** <br> Rate limit configuration applied to all incoming requests. |
| requestsPerIP | **[RateLimitLimit](#ratelimitlimit)** <br> Rate limit configuration applied separately for each set of requests grouped by client IP address. |

### RateLimitLimit

Rate limit configuration with time-based limits.

*Appears in:* [RateLimit](#ratelimit)

| Field | Description |
|-------|-------------|
| perMinute | **int** <br> Limit value specified with per minute time unit. <br> Example: `6000` |
| perSecond | **int** <br> Limit value specified with per second time unit. <br> Example: `100` |

### HostRewrite

Host header rewriting configuration for HTTP/1.1 Host headers and HTTP/2 :authority pseudo-headers.

*Appears in:* [RouteRule](#routerule)

| Field | Description |
|-------|-------------|
| auto | **bool** <br> Automatically replaces the host with that of the target backend. <br> Example: `true` |
| replace | **string** <br> Static host replacement value. <br> Example: `backend.example.com` |

### RegexMatchAndSubstitute

Regular expression-based path rewriting configuration for HTTP routes.

*Appears in:* [RouteALBHTTP](#routealbhttp)

| Field | Description |
|-------|-------------|
| regex | **string** <br> Regular expression pattern to match portions of the path for rewriting. <br> Example: `^/service/([^/]+)(/.*)$` |
| substitute | **string** <br> Substitution string for path rewriting with capture group support. Pattern `^/service/([^/]+)(/.*)$` with substitution `\\2/instance/\\1` transforms `/service/foo/v1/api` to `/v1/api/instance/foo`. <br> Example: `\\2/instance/\\1` |

## RoutePolicyStatus

RoutePolicyStatus defines the observed state of RoutePolicy.

*Appears in:* [RoutePolicy](#cheatsheet)

| Field | Description |
|-------|-------------|
| conditions | **[]Condition** <br> Current state conditions of the route policy. |
| attachedRoutes | **int32** <br> Number of currently attached routes. |

### RBAC

RBAC (Role-Based Access Control) configuration for controlling access to routes and hosts.

*Appears in:* [RouteRule](#routerule), [ALBRoute](#albroute), [VirtualHost](#virtualhost)

| Field | Description |
|-------|-------------|
| action | **string** <br> Action to take when principals match. Options: `ALLOW`, `DENY`. <br> Example: `ALLOW` |
| principals | **map[string][AndPrincipals](#andprincipals)** <br> Map of principal groups where each group contains multiple principals combined with AND logic. |

### AndPrincipals

Map of principals that are combined with AND logic within a group.

*Appears in:* [RBAC](#rbac)

| Field | Description |
|-------|-------------|
| *key* | **[Principal](#principal)** <br> Principal identifier mapped to principal configuration. |

### Principal

Principal configuration for RBAC matching.

*Appears in:* [AndPrincipals](#andprincipals)

| Field | Description |
|-------|-------------|
| header | **[HeaderPrincipal](#headerprincipal)** <br> Header-based principal matching. |
| ip | **[IPPrincipal](#ipprincipal)** <br> IP-based principal matching. |
| any | **bool** <br> Match any request. <br> Example: `true` |

### HeaderPrincipal

Header-based principal matching configuration.

*Appears in:* [Principal](#principal)

| Field | Description |
|-------|-------------|
| name | **string** <br> Name of the header to match. <br> Example: `authorization` |
| regex | **string** <br> Regular expression pattern for header value matching. <br> Example: `^Bearer .*` |
| exact | **string** <br> Exact header value match. <br> Example: `Bearer admin123` |
| prefix | **string** <br> Header value prefix match. <br> Example: `Bearer ` |

### IPPrincipal

IP-based principal matching configuration.

*Appears in:* [Principal](#principal)

| Field | Description |
|-------|-------------|
| remoteIp | **string** <br> IP address or CIDR block for matching client IP. <br> Example: `10.0.0.0/8` |
