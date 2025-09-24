---
sourcePath: en/_gwin-ref/gwin-ref/ingresspolicy.md
---
# IngressPolicy

IngressPolicy is a Gwin custom resource for configuring ingress-level policies in Yandex Application Load Balancer. It allows you to define ingress group settings, load balancer configuration, backend settings, and virtual host options that apply to Ingress resources.

* [Cheatsheet](#cheatsheet)
* [IngressPolicySpec](#ingresspolicyspec)
  * [LocalObjectReference](#localobjectreference)
  * [LabelSelector](#labelselector)
  * [LabelSelectorRequirement](#labelselectorrequirement)
  * [Ingress](#ingress)
  * [IngressGroup](#ingressgroup)
  * [IngressBalancer](#ingressbalancer)
  * [IngressRule](#ingressrule)
  * [VirtualHost](#virtualhost)
  * [RateLimit](#ratelimit)
  * [RateLimitLimit](#ratelimitlimit)
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
  * [HeaderModifier](#headermodifier)
  * [RedirectAction](#redirectaction)
  * [RedirectActionPath](#redirectactionpath)
  * [DirectResponseAction](#directresponseaction)
  * [DirectResponseActionBody](#directresponseactionbody)
* [IngressPolicyStatus](#ingresspolicystatus)

## Cheatsheet

{% note info %}

Specification provided below is not valid configuration.

It's just demonstration of all `IngressPolicy` fields.

{% endnote %}

```yaml
apiVersion: gwin.yandex.cloud/v1
kind: IngressPolicy
metadata:
  name: example-ingress-policy
  namespace: example-ns
spec:
  # Target Ingress resources
  targetRefs:
    - group: networking.k8s.io
      kind: Ingress
      name: example-ingress
      namespace: ingress-ns
  # Or use label selector
  selector:
    matchLabels:
      app: my-ingress
    matchExpressions:
      - key: environment
        operator: In
        values: ["production", "staging"]
  # Ingress policy configuration
  policy:
    # Ingress group configuration
    groupName: "my-ingress-group"  # group multiple ingresses
    groupOrder: 100  # processing order within group
    
    # Load balancer configuration
    externalIPv4Address: "5.4.3.2"  # external IPv4 address
    externalIPv6Address: "2001:db8::1"  # external IPv6 address
    subnets: ["subnet-id-1", "subnet-id-2"]  # where to place balancer
    securityGroups: ["sg-id-1", "sg-id-2"]  # network access control
    allowZonalShift: true  # enable failover between zones
    
    # Cloud Logging
    logs:
      logGroupID: "log-group-id-1"  # where to send logs
      disable: false  # enable logging
      discardRule:
        rule1:  # custom rule name
          httpCodes: [404, 500]  # skip these status codes
          httpCodeIntervals: ["HTTP_4XX", "HTTP_5XX"]  # skip error ranges
          grpcCodes: ["INTERNAL", "UNIMPLEMENTED"]  # skip gRPC errors
          discardPercent: 10  # drop 10% of logs
    
    # Autoscaling
    autoScale:
      minZoneSize: 2  # min instances per zone
      maxSize: 10  # max total instances
    
    # Zone traffic control
    zone:
      ru-central1-a:
        receiveTraffic: false  # disable this zone
      ru-central1-b:
        receiveTraffic: true  # enable this zone
    
    # Listener configuration
    listeners:
      http:
        protocolSettings:
          allowHTTP10: true  # support old HTTP
          http2Options:
            maxConcurrentStreams: 100  # limit connections
      stream:
        idleTimeout: "300s"  # close idle connections
      # HTTP router configuration
      securityProfileID: "security-profile-id"  # WAF protection
      rbac:
        action: "ALLOW"  # access control policy
        principals:
          admin:  # principal group
            check-token:  # principal name
              header:
                name: "X-Api-Token"
                exact: "admin123"
    
    # Backend and route configuration
    rules:
      # Backend group configuration
      backends:
        http:
          useHTTP2: true  # enable HTTP/2 to backends
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
      
      # HTTP specific settings
      http:
        upgradeTypes: ["websocket"]  # supported upgrade protocols
      
      # HTTP method restrictions
      allowedMethods: ["GET", "POST", "PUT"]  # restrict allowed HTTP methods
      
      # Header modifications
      modifyRequestHeaders:
        append:
          X-Custom-Header: "custom-value"  # add request header
        rename:
          Old-Header: "New-Header"  # rename request header
        replace:
          Authorization: "Bearer token"  # replace request header
        remove: ["X-Remove-Me", "X-Also-Remove"]  # remove request headers
      modifyResponseHeaders:
        append:
          X-Response-Header: "response-value"  # add response header
        rename:
          Old-Response: "New-Response"  # rename response header
        replace:
          Cache-Control: "no-cache"  # replace response header
        remove: ["Server", "X-Powered-By"]  # remove response headers
      
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
    
    # Virtual host configuration
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
   
   # Redirect actions (referenced by Ingress backend resources)
   redirect:
     https-redirect:  # redirect action name
       replaceScheme: "https"  # change URL scheme
       replaceHost: "secure.example.com"  # change hostname
       replacePort: 443  # change port
       path:
         replacePath: "/new-path"  # replace entire path
       removeQuery: true  # remove query parameters
       responseCode: 301  # redirect status code
   
   # Direct response actions (referenced by Ingress backend resources)
   directResponse:
     maintenance-response:  # direct response action name
       responseCode: 503  # HTTP status code
       responseBody:
         text: "Service temporarily unavailable"  # response body text
status:
  conditions:
    - type: "Ready"
      status: "True"
      reason: "PolicyApplied"
  attachedIngresses: 3
```

| Field | Description |
|-------|-------------|
| metadata | **ObjectMeta** <br> Standard Kubernetes metadata. |
| spec | **[IngressPolicySpec](#ingresspolicyspec)** <br> Ingress policy specification. |
| status | **[IngressPolicyStatus](#ingresspolicystatus)** <br> Ingress policy status. |

## IngressPolicySpec

IngressPolicySpec defines the desired state of IngressPolicy.

*Appears in*: [IngressPolicy](#ingresspolicy)

| Field | Description |
|-------|-------------|
| targetRefs | **[]LocalObjectReference** <br> References to Ingress resources that this policy should apply to. |
| selector | **LabelSelector** <br> Label selector for Ingress resources that this policy should apply to. |
| policy | **[Ingress](#ingress)** <br> Ingress policy configuration. |

### Ingress

Ingress policy configuration that applies to ingress group, load balancer, and routing settings.

*Appears in*: [IngressPolicySpec](#ingresspolicyspec)

| Field | Description |
|-------|-------------|
| groupName | **string** <br> Name of the ingress group to group multiple ingresses together. <br> Example: `my-ingress-group` |
| groupOrder | **int** <br> Processing order within the ingress group. <br> Example: `100` |
| externalIPv4Address | **string** <br> External IPv4 address for the load balancer. <br> Example: `5.4.3.2` |
| externalIPv6Address | **string** <br> External IPv6 address for the load balancer. <br> Example: `2001:db8::1` |
| subnets | **[]string** <br> Subnets of the zones where load balancer will be instantiated. <br> Example: `["subnet-id-1", "subnet-id-2"]` |
| securityGroups | **[]string** <br> Security groups of load balancer. <br> Example: `["sg-id-1", "sg-id-2"]` |
| logs | **[LogOptions](./gatewaypolicy.md#logoptions)** <br> Cloud logging settings of the application load balancer. |
| autoScale | **[AutoScalePolicy](./gatewaypolicy.md#autoscalepolicy)** <br> Scaling settings of the application load balancer. |
| zone | **map[string][BalancerZone](./gatewaypolicy.md#balancerzone)** <br> Zone-specific traffic control settings. |
| allowZonalShift | **bool** <br> Specifies whether application load balancer is available to zonal shift. <br> Example: `true` |
| listeners | **[GatewayListener](./gatewaypolicy.md#gatewaylistener)** <br> Listener configuration settings. |
| rules | **[IngressRule](#ingressrule)** <br> Backend and route configuration |
| hosts | **[VirtualHost](#virtualhost)** <br> Virtual host configuration |
| redirect | **map[string][RedirectAction](#redirectaction)** <br> Redirect actions that can be referenced by Ingress path backends. |
| directResponse | **map[string][DirectResponseAction](#directresponseaction)** <br> Direct response actions that return responses without forwarding to backends. |

### IngressGroup

Ingress group configuration for grouping multiple ingresses.

*Appears in*: [Ingress](#ingress)

| Field | Description |
|-------|-------------|
| groupName | **string** <br> Name of the ingress group to group multiple ingresses together. <br> Example: `my-ingress-group` |
| externalIPv4Address | **string** <br> External IPv4 address for the load balancer. <br> Example: `5.4.3.2` |
| externalIPv6Address | **string** <br> External IPv6 address for the load balancer. <br> Example: `2001:db8::1` |
| subnets | **[]string** <br> Subnets of the zones where load balancer will be instantiated. <br> Example: `["subnet-id-1", "subnet-id-2"]` |
| securityGroups | **[]string** <br> Security groups of load balancer. <br> Example: `["sg-id-1", "sg-id-2"]` |
| logs | **[LogOptions](./gatewaypolicy.md#logoptions)** <br> Cloud logging settings of the application load balancer. |
| autoScale | **[AutoScalePolicy](./gatewaypolicy.md#autoscalepolicy)** <br> Scaling settings of the application load balancer. |
| zone | **map[string][BalancerZone](./gatewaypolicy.md#balancerzone)** <br> Zone-specific traffic control settings. |
| allowZonalShift | **bool** <br> Specifies whether application load balancer is available to zonal shift. <br> Example: `true` |
| listeners | **[GatewayListener](./gatewaypolicy.md#gatewaylistener)** <br> Listener configuration settings. |

### IngressBalancer

Load balancer configuration specific to ingress resources.

*Appears in*: [IngressGroup](#ingressgroup)

| Field | Description |
|-------|-------------|
| externalIPv4Address | **string** <br> External IPv4 address for the load balancer. <br> Example: `5.4.3.2` |
| externalIPv6Address | **string** <br> External IPv6 address for the load balancer. <br> Example: `2001:db8::1` |
| subnets | **[]string** <br> Subnets of the zones where load balancer will be instantiated. <br> Example: `["subnet-id-1", "subnet-id-2"]` |
| securityGroups | **[]string** <br> Security groups of load balancer. <br> Example: `["sg-id-1", "sg-id-2"]` |
| logs | **[LogOptions](./gatewaypolicy.md#logoptions)** <br> Cloud logging settings of the application load balancer. |
| autoScale | **[AutoScalePolicy](./gatewaypolicy.md#autoscalepolicy)** <br> Scaling settings of the application load balancer. |
| zone | **map[string][BalancerZone](./gatewaypolicy.md#balancerzone)** <br> Zone-specific traffic control settings. |
| allowZonalShift | **bool** <br> Specifies whether application load balancer is available to zonal shift. <br> Example: `true` |

### IngressRule

Ingress rule configuration that combines backend group and route settings.

*Appears in*: [Ingress](#ingress)

| Field | Description |
|-------|-------------|
| backends | **[Backend](#backend)** <br> Backend configuration settings. |
| sessionAffinity | **[SessionAffinity](#sessionaffinity)** <br> Session affinity configuration for the backend group. |
| timeout | **string** <br> Overall timeout for HTTP connection between load balancer and backend. <br> Example: `60s` |
| idleTimeout | **string** <br> Idle timeout for HTTP connection. <br> Example: `300s` |
| http | **[RouteALBHTTP](#routealbhttp)** <br> HTTP specific route options. |
| allowedMethods | **[]string** <br> Restricts which HTTP methods are allowed for this route. If not specified, all methods are allowed. <br> Example: `["GET", "POST", "PUT"]` |
| modifyRequestHeaders | **[HeaderModifier](#headermodifier)** <br> Specifies how to modify HTTP request headers before forwarding to backends. |
| modifyResponseHeaders | **[HeaderModifier](#headermodifier)** <br> Specifies how to modify HTTP response headers before returning to clients. |
| securityProfileID | **string** <br> Security profile ID for route-level protection. <br> Example: `security-profile-1` |
| rbac | **[RBAC](./gatewaypolicy.md#rbac)** <br> RBAC access control configuration. |

### VirtualHost

Virtual host configuration for rate limiting and access control.

*Appears in*: [Ingress](#ingress)

| Field | Description |
|-------|-------------|
| securityProfileID | **string** <br> Security profile ID for host-level protection. <br> Example: `host-security-profile-1` |
| rbac | **[RBAC](./gatewaypolicy.md#rbac)** <br> RBAC access control configuration. |
| rateLimit | **[RateLimit](#ratelimit)** <br> Rate limit configuration applied for a whole virtual host. |

### RateLimit

Rate limit configuration applied to virtual hosts.

*Appears in*: [VirtualHost](#virtualhost)

| Field | Description |
|-------|-------------|
| allRequests | **[RateLimitLimit](#ratelimitlimit)** <br> Rate limit configuration applied to all incoming requests. |
| requestsPerIP | **[RateLimitLimit](#ratelimitlimit)** <br> Rate limit configuration applied separately for each set of requests grouped by client IP address. |

### RateLimitLimit

Rate limit configuration with time-based limits.

*Appears in*: [RateLimit](#ratelimit)

| Field | Description |
|-------|-------------|
| perMinute | **int** <br> Limit value specified with per minute time unit. <br> Example: `6000` |
| perSecond | **int** <br> Limit value specified with per second time unit. <br> Example: `100` |

### BackendGroup

Backend group configuration for load balancing and health checks.

*Appears in*: [IngressRule](#ingressrule)

| Field | Description |
|-------|-------------|
| backends | **[Backend](#backend)** <br> Backend configuration settings. |
| sessionAffinity | **[SessionAffinity](#sessionaffinity)** <br> Session affinity configuration for the backend group. |

### Backend

Backend configuration for protocol-specific settings, load balancing, health checks, and TLS.

*Appears in*: [BackendGroup](#backendgroup)

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

*Appears in*: [Backend](#backend)

| Field | Description |
|-------|-------------|
| useHTTP2 | **bool** <br> Enables HTTP/2 usage in connections between load balancer nodes and backend targets. Default: `false`. <br> Example: `true` |

### GRPCBackend

gRPC specific backend settings.

*Appears in*: [Backend](#backend)

Reserved for future gRPC-specific settings.

### StreamBackend

TCP stream specific backend settings.

*Appears in*: [Backend](#backend)

| Field | Description |
|-------|-------------|
| enableProxy | **bool** <br> If set, proxy protocol will be enabled for this backend. <br> Example: `true` |
| keepConnectionsOnHostHealthFailure | **bool** <br> If a backend host becomes unhealthy, keep connections to the failed host. <br> Example: `false` |

### LoadBalancingConfig

Load balancing configuration for backends.

*Appears in*: [Backend](#backend)

| Field | Description |
|-------|-------------|
| panicThreshold | **int** <br> Threshold for panic mode (percentage). If healthy backends drop below this threshold, traffic routes to all backends. Set to `0` to disable panic mode. <br> Example: `50` |
| localityAwareRouting | **int** <br> Percentage of traffic sent to backends in the same availability zone. Remaining traffic is divided equally between other zones. <br> Example: `90` |
| strictLocality | **bool** <br> Send traffic only to backends in the same availability zone. If `true`, `localityAwareRouting` is ignored. <br> Example: `false` |
| mode | **string** <br> Load balancing mode. Options: `ROUND_ROBIN`, `LEAST_REQUEST`, `RANDOM`, `RING_HASH`, `MAGLEV_HASH`. <br> Example: `ROUND_ROBIN` |

### HealthCheck

Health check configuration for monitoring backend health.

*Appears in*: [Backend](#backend)

| Field | Description |
|-------|-------------|
| timeout | **string** <br> Health check timeout - time allowed for the target to respond. <br> Example: `5s` |
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

*Appears in*: [HealthCheck](#healthcheck)

| Field | Description |
|-------|-------------|
| host | **string** <br> Value for the HTTP/1.1 `Host` header or HTTP/2 `:authority` pseudo-header. <br> Example: `health.example.com` |
| path | **string** <br> HTTP path used in requests to targets. <br> Example: `/health` |
| useHTTP2 | **bool** <br> Enables HTTP/2 usage in health checks. Default: `false`. <br> Example: `true` |
| expectedStatuses | **[]int** <br> List of HTTP response statuses considered healthy. Default: `[200]`. <br> Example: `[200, 202, 204]` |

### HealthcheckGRPC

gRPC-specific health check settings.

*Appears in*: [HealthCheck](#healthcheck)

| Field | Description |
|-------|-------------|
| serviceName | **string** <br> Name of the gRPC service to be checked. If not specified, overall health is checked. <br> Example: `health.v1.HealthService` |

### HealthcheckStream

TCP stream-specific health check settings.

*Appears in*: [HealthCheck](#healthcheck)

| Field | Description |
|-------|-------------|
| send | **string** <br> Message sent to targets during TCP data transfer. If not specified, no data is sent. <br> Example: `PING` |
| receive | **string** <br> Data that must be contained in received messages for successful health check. If not specified, no messages are expected. <br> Example: `PONG` |

### HealthCheckTransportSettings

Transport protocol settings for health checks.

*Appears in*: [HealthCheck](#healthcheck)

| Field | Description |
|-------|-------------|
| plaintext | **bool** <br> Use plaintext protocol for health checks. Set to `true` to force HTTP health checks even for HTTPS backends. <br> Example: `true` |
| tls | **[BackendTLS](#backendtls)** <br> TLS settings for health checks. Use when health checks require different TLS configuration than backend. |

### BackendTLS

TLS settings for backend connections.

*Appears in*: [Backend](#backend), [HealthCheckTransportSettings](#healthchecktransportsettings)

| Field | Description |
|-------|-------------|
| sni | **string** <br> Server Name Indication (SNI) string for TLS connections. <br> Example: `backend.example.com` |
| trustedCA | **[BackendTLSTrustedCA](#backendtlstrustedca)** <br> Validation context for TLS connections. |

### BackendTLSTrustedCA

Trusted CA configuration for TLS validation.

*Appears in*: [BackendTLS](#backendtls)

| Field | Description |
|-------|-------------|
| id | **string** <br> Cloud certificate ID. <br> Example: `fpq6gvvm6piu********` |
| bytes | **string** <br> X.509 certificate contents in PEM format. <br> Example: `-----BEGIN CERTIFICATE-----\n...\n-----END CERTIFICATE-----` |

### SessionAffinity

Session affinity configuration for routing requests from the same client to the same backend.

*Appears in*: [BackendGroup](#backendgroup)

| Field | Description |
|-------|-------------|
| connection | **[SessionAffinityConnection](#sessionaffinityconnection)** <br> Connection-based session affinity (by client IP). |
| cookie | **[SessionAffinityCookie](#sessionaffinitycookie)** <br> Cookie-based session affinity. |
| header | **[SessionAffinityHeader](#sessionaffinityheader)** <br> HTTP header-based session affinity. |

### SessionAffinityConnection

Connection-based session affinity configuration.

*Appears in*: [SessionAffinity](#sessionaffinity)

| Field | Description |
|-------|-------------|
| sourceIP | **bool** <br> Use client IP address for session affinity. <br> Example: `true` |

### SessionAffinityCookie

Cookie-based session affinity configuration.

*Appears in*: [SessionAffinity](#sessionaffinity)

| Field | Description |
|-------|-------------|
| name | **string** <br> Name of the cookie used for session affinity. <br> Example: `session-cookie` |
| ttl | **string** <br> Maximum age of generated session cookies. Set to `0` for session cookies (deleted on client restart). If not set, balancer only uses incoming cookies. <br> Example: `3600s` |

### SessionAffinityHeader

HTTP header-based session affinity configuration.

*Appears in*: [SessionAffinity](#sessionaffinity)

| Field | Description |
|-------|-------------|
| name | **string** <br> Name of the HTTP header field used for session affinity. <br> Example: `X-Session-ID` |

### ALBRoute

Application Load Balancer route configuration.

*Appears in*: [IngressRule](#ingressrule)

| Field | Description |
|-------|-------------|
| timeout | **string** <br> Overall timeout for HTTP connection between load balancer and backend. Default: `60s`. <br> Example: `60s` |
| idleTimeout | **string** <br> Idle timeout for HTTP connection. <br> Example: `300s` |
| http | **[RouteALBHTTP](#routealbhttp)** <br> HTTP specific route options. |
| securityProfileID | **string** <br> Security profile ID for route-level protection. <br> Example: `security-profile-1` |
| rbac | **[RBAC](./gatewaypolicy.md#rbac)** <br> RBAC access control configuration. |

### RouteALBHTTP

HTTP-specific route configuration.

*Appears in*: [ALBRoute](#albroute)

| Field | Description |
|-------|-------------|
| upgradeTypes | **[]string** <br> Supported values for HTTP `Upgrade` header. <br> Example: `["websocket"]` |

### HeaderModifier

HeaderModifier defines various operations that can be performed on HTTP headers. Operations are applied in the following order: append, rename, replace, remove.

*Appears in*: [IngressRule](#ingressrule)

| Field | Description |
|-------|-------------|
| append | **map[string]string** <br> Adds new headers. Key is the header name, value is the header value to append. |
| rename | **map[string]string** <br> Changes the name of existing headers. Key is the original header name, value is the new header name. |
| replace | **map[string]string** <br> Overwrites the value of existing headers or creates new ones. Key is the header name, value is the new header value. |
| remove | **[]string** <br> Specifies which headers should be removed. |

### RedirectAction

RedirectAction defines an HTTP redirect response that sends clients to a different URL. This action terminates the request processing and returns a redirect response.

*Appears in*: [Ingress](#ingress)

| Field | Description |
|-------|-------------|
| replaceScheme | **string** <br> Changes the URL scheme (http/https) in the redirect location. <br> Example: `https` |
| replaceHost | **string** <br> Changes the hostname in the redirect location. <br> Example: `secure.example.com` |
| replacePort | **int** <br> Changes the port number in the redirect location. <br> Example: `443` |
| path | **[RedirectActionPath](#redirectactionpath)** <br> Specifies how to modify the path component of the redirect URL. |
| removeQuery | **bool** <br> Determines whether to remove query parameters from the redirect URL. <br> Example: `true` |
| responseCode | **int** <br> HTTP status code for the redirect response. (e.g., 301, 302, 303, 307, 308) <br> Example: `301` |

### RedirectActionPath

RedirectActionPath defines how to modify the path component in redirect URLs. Only one of ReplacePrefix or ReplacePath should be specified.

*Appears in*: [RedirectAction](#redirectaction)

| Field | Description |
|-------|-------------|
| replacePrefix | **string** <br> Replaces the matching path prefix with the specified value. <br> Example: `/new-prefix` |
| replacePath | **string** <br> Replaces the entire path with the specified value. <br> Example: `/new-path` |

### DirectResponseAction

DirectResponseAction defines a direct HTTP response that is returned to the client without forwarding the request to any backend service.

*Appears in*: [Ingress](#ingress)

| Field | Description |
|-------|-------------|
| responseCode | **int** <br> HTTP status code to return. <br> Example: `503` |
| responseBody | **[DirectResponseActionBody](#directresponseactionbody)** <br> Response body content |

### DirectResponseActionBody

DirectResponseActionBody defines the content of a direct response body.

*Appears in*: [DirectResponseAction](#directresponseaction)

| Field | Description |
|-------|-------------|
| text | **string** <br> Plain text content to include in the response body. <br> Example: `Service temporarily unavailable` |

## IngressPolicyStatus

IngressPolicyStatus defines the observed state of IngressPolicy.

*Appears in*: [IngressPolicy](#ingresspolicy)

| Field | Description |
|-------|-------------|
| conditions | **[]Condition** <br> Current state conditions of the ingress policy. |
| attachedIngresses | **int32** <br> Number of currently attached ingresses. |
