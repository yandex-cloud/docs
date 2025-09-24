---
sourcePath: en/_gwin-ref/gwin-ref/grpcroute.md
---
# GRPCRoute

GRPCRoute provides a way to route gRPC requests. This includes the capability to match requests by hostname, gRPC service, or method. Requests are routed to backend services that support gRPC.

GRPCRoute is a [Kubernetes Gateway API](https://gateway-api.sigs.k8s.io/) project resource. Below, we describe its fields and annotations used by Gwin. For configuration details, see the [upstream documentation](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io/v1.GRPCRoute).

GRPCRoute resources must be attached to [Gateway](./gateway.md) resources to function properly.

* [Cheatsheet](#cheatsheet)
* [GRPCRouteMeta](#grpcroutemeta)
  * [Annotations cheatsheet](#annotations-cheatsheet)
  * [Annotations reference](#annotations-reference)
* [GRPCRouteSpec](#grpcroutespec)
  * [ParentReference](#parentreference)
  * [GRPCRouteRule](#grpcrouterule)
  * [GRPCRouteMatch](#grpcroutematch)
  * [GRPCMethodMatch](#grpcmethodmatch)
  * [GRPCHeaderMatch](#grpcheadermatch)
  * [GRPCRouteFilter](#grpcroutefilter)
  * [GRPCHeaderFilter](#grpcheaderfilter)
  * [GRPCBackendRef](#grpcbackendref)

## Cheatsheet

{% note info %}

Specification provided below is not valid configuration.

It's just demonstration of all `GRPCRoute` fields.

{% endnote %}

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: GRPCRoute
metadata:
  name: example-grpc-route
  namespace: example-ns
  annotations: ...  # see annotations example below
spec:
  parentRefs:  # attach to Gateway resources
    - group: gateway.networking.k8s.io
      kind: Gateway
      namespace: gateway-ns
      name: example-gateway
      sectionName: grpc-listener  # specific listener name
  hostnames:  # domains this route handles
    - "grpc.example.com"  # gRPC service domain
    - "api.example.com"   # API domain
  rules:
    - name: service-rule  # rule identifier
      matches:  # conditions for this rule
        - method:
            type: Exact  # exact method match
            service: "example.UserService"  # gRPC service
            method: "GetUser"  # gRPC method
        - method:
            type: RegularExpression  # regex method match
            method: "List.*"  # match List* methods
        - headers:  # header matching
            - name: "grpc-timeout"
              value: "30s"
      filters:  # modify requests before routing
        - type: RequestHeaderModifier
          requestHeaderModifier:
            set:  # replace header values
              - name: "x-custom-header"
                value: "custom-value"
            add:  # add new headers
              - name: "x-added-header"
                value: "added-value"
            remove:  # remove headers
              - "x-remove-header"
        - type: ResponseHeaderModifier
          responseHeaderModifier: ... # same as RequestHeaderModifier
      backendRefs:  # where to route requests
        - group: ""  # core Kubernetes API
          kind: Service  # Kubernetes service
          name: grpc-service
          namespace: grpc-ns
          port: 9090
          weight: 80  # 80% of traffic
        - group: gwin.yandex.cloud  # Gwin custom resources
          name: grpc-backends
          weight: 20  # 20% of traffic
```

| Field | Description |
|-------|-------------|
| metadata | **[GRPCRouteMeta](#grpcroutemeta)** <br> Name, namespace and annotations. |
| spec | **[GRPCRouteSpec](#grpcroutespec)** <br> Resource specification. |

## GRPCRouteMeta

*Appears in:* [GRPCRoute](#cheatsheet)

| Field | Description |
|-------|-------------|
| name | **string** <br> Name of the GRPCRoute. |
| namespace | **string** <br> Namespace of the GRPCRoute. |
| annotations | **map[string]string** <br> Annotations of the GRPCRoute. |

### Annotations cheatsheet

{% note info %}

You can also set policy parameters using [RoutePolicy](./routepolicy.md) resource. The RoutePolicy resource parameters and GRPCRoute annotations are equivalent.

{% endnote %}

Specification provided below is not valid configuration.
It's just demonstration of all `GRPCRoute` annotations.

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: GRPCRoute
metadata:
  annotations:
    # Backend group configuration
    gwin.yandex.cloud/rules.backends.balancing.mode: "ROUND_ROBIN"  # load balancing algorithm
    gwin.yandex.cloud/rules.backends.balancing.localityAwareRouting: "80"  # prefer same zone
    gwin.yandex.cloud/rules.backends.balancing.strictLocality: "false"  # allow cross-zone routing
    gwin.yandex.cloud/rules.backends.balancing.panicThreshold: "50"  # panic mode threshold
    
    # Health checks
    gwin.yandex.cloud/rules.backends.hc.timeout: "5s"  # health check timeout
    gwin.yandex.cloud/rules.backends.hc.interval: "10s"  # check interval
    gwin.yandex.cloud/rules.backends.hc.healthyThreshold: "2"  # checks to mark healthy
    gwin.yandex.cloud/rules.backends.hc.unhealthyThreshold: "3"  # checks to mark unhealthy
    gwin.yandex.cloud/rules.backends.hc.port: "9090"  # health check port
  
    gwin.yandex.cloud/rules.backends.hc.grpc.serviceName: "health.HealthService"  # gRPC service
    
    # Health check transport settings
    gwin.yandex.cloud/rules.backends.hc.transportSettings.plaintext: "true"  # use plaintext for health checks
    gwin.yandex.cloud/rules.backends.hc.transportSettings.tls.sni: "health.example.com"  # SNI for health check TLS
    gwin.yandex.cloud/rules.backends.hc.transportSettings.tls.trustedCA.id: "health-cert-123"  # health check TLS cert ID
    gwin.yandex.cloud/rules.backends.hc.transportSettings.tls.trustedCA.bytes: "-----BEGIN CERTIFICATE-----..."  # health check TLS cert PEM
    
    # Backend TLS configuration
    gwin.yandex.cloud/rules.backends.tls.sni: "grpc.example.com"  # SNI for TLS
    gwin.yandex.cloud/rules.backends.tls.trustedCA.id: "cert-123456"  # cloud certificate ID
    gwin.yandex.cloud/rules.backends.tls.trustedCA.bytes: "-----BEGIN CERTIFICATE-----..."  # PEM certificate
    
    # Session affinity
    gwin.yandex.cloud/rules.sessionAffinity.header.name: "X-Session-ID"  # header-based affinity
    gwin.yandex.cloud/rules.sessionAffinity.cookie.name: "session"  # cookie name
    gwin.yandex.cloud/rules.sessionAffinity.cookie.ttl: "3600s"  # cookie lifetime
    gwin.yandex.cloud/rules.sessionAffinity.sourceIP: "true"  # IP-based affinity
    
    # Route timeouts
    gwin.yandex.cloud/rules.timeout: "60s"  # overall connection timeout
    gwin.yandex.cloud/rules.idleTimeout: "300s"  # idle connection timeout
    
    # Security
    gwin.yandex.cloud/rules.securityProfileID: "security-profile-1"  # WAF profile for routes
    gwin.yandex.cloud/hosts.securityProfileID: "host-security-profile-1"  # WAF profile for hosts
    
    # Rate limiting
    gwin.yandex.cloud/hosts.rateLimit.allRequests.perSecond: "100"  # global rate limit
    gwin.yandex.cloud/hosts.rateLimit.allRequests.perMinute: "6000"  # global rate limit
    gwin.yandex.cloud/hosts.rateLimit.requestsPerIP.perSecond: "10"  # per-IP rate limit
    gwin.yandex.cloud/hosts.rateLimit.requestsPerIP.perMinute: "600"  # per-IP rate limit
    
    # RBAC configuration
    gwin.yandex.cloud/rules.rbac.action: "ALLOW"  # default RBAC action
    gwin.yandex.cloud/rules.rbac.principals.admin.check-token.header.name: "authorization"  # header to check
    gwin.yandex.cloud/rules.rbac.principals.admin.check-token.header.exact: "Bearer admin123"  # required value
    gwin.yandex.cloud/rules.rbac.principals.admin.check-ip.ip.remoteIp: "10.0.0.0/8"  # allowed IP range
    gwin.yandex.cloud/hosts.rbac.action: "DENY"  # host-level RBAC action
    
    # Rule-specific configuration (overrides global settings)
    gwin.yandex.cloud/rule.service-rule.backends.balancing.mode: "LEAST_REQUEST"  # per-rule balancing
    gwin.yandex.cloud/rule.service-rule.timeout: "30s"  # per-rule timeout
    gwin.yandex.cloud/rule.service-rule.idleTimeout: "120s"  # per-rule idle timeout
```

### Annotations reference

#### Backend group configuration

| Annotation and description |
|------------|
| `gwin.yandex.cloud/rules.backends.balancing.mode` <br> _(string)_ <br> Load balancing mode for backend group. Possible values: `RANDOM`, `ROUND_ROBIN`, `LEAST_REQUEST`. <br> Example: `ROUND_ROBIN` |
| `gwin.yandex.cloud/rules.backends.balancing.localityAwareRouting` <br> _(number)_ <br> Percentage of traffic sent to backends in the same availability zone. <br> Example: `80` |
| `gwin.yandex.cloud/rules.backends.balancing.strictLocality` <br> _(boolean)_ <br> Route traffic only to backends in the same availability zone. <br> Example: `false` |
| `gwin.yandex.cloud/rules.backends.balancing.panicThreshold` <br> _(number)_ <br> Panic mode threshold percentage for load balancing. <br> Example: `50` |

#### Health check configuration

##### Common health check settings

| Annotation and description |
|------------|
| `gwin.yandex.cloud/rules.backends.hc.timeout` <br> _(duration)_ <br> Health check timeout. <br> Example: `5s` |
| `gwin.yandex.cloud/rules.backends.hc.interval` <br> _(duration)_ <br> Interval between health checks. <br> Example: `10s` |
| `gwin.yandex.cloud/rules.backends.hc.healthyThreshold` <br> _(number)_ <br> Number of successful checks to mark backend as healthy. <br> Example: `2` |
| `gwin.yandex.cloud/rules.backends.hc.unhealthyThreshold` <br> _(number)_ <br> Number of failed checks to mark backend as unhealthy. <br> Example: `3` |
| `gwin.yandex.cloud/rules.backends.hc.port` <br> _(number)_ <br> Port for health checks. <br> Example: `9090` |

##### gRPC health checks

| Annotation and description |
|------------|
| `gwin.yandex.cloud/rules.backends.hc.grpc.serviceName` <br> _(string)_ <br> gRPC service name for health checks. <br> Example: `health.HealthService` |

##### Health check transport settings

| Annotation and description |
|------------|
| `gwin.yandex.cloud/rules.backends.hc.transportSettings.plaintext` <br> _(boolean)_ <br> Use plaintext protocol for health checks. Set to `true` to force HTTP health checks even for HTTPS backends. <br> Example: `true` |
| `gwin.yandex.cloud/rules.backends.hc.transportSettings.tls.sni` <br> _(string)_ <br> Server Name Indication (SNI) for health check TLS connections. <br> Example: `health.example.com` |
| `gwin.yandex.cloud/rules.backends.hc.transportSettings.tls.trustedCA.id` <br> _(string)_ <br> Cloud certificate ID for health check TLS validation. <br> Example: `health-cert-123` |
| `gwin.yandex.cloud/rules.backends.hc.transportSettings.tls.trustedCA.bytes` <br> _(string)_ <br> X.509 certificate contents in PEM format for health check TLS validation. <br> Example: `-----BEGIN CERTIFICATE-----...` |

#### Backend TLS configuration

| Annotation and description |
|------------|
| `gwin.yandex.cloud/rules.backends.tls.sni` <br> _(string)_ <br> Server Name Indication (SNI) for TLS connections to backends. <br> Example: `grpc.example.com` |
| `gwin.yandex.cloud/rules.backends.tls.trustedCA.id` <br> _(string)_ <br> Cloud certificate ID for backend TLS validation. <br> Example: `cert-123456` |
| `gwin.yandex.cloud/rules.backends.tls.trustedCA.bytes` <br> _(string)_ <br> X.509 certificate contents in PEM format for backend TLS validation. <br> Example: `-----BEGIN CERTIFICATE-----...` |

#### Session affinity

| Annotation and description |
|------------|
| `gwin.yandex.cloud/rules.sessionAffinity.header.name` <br> _(string)_ <br> HTTP header name for session affinity. <br> Example: `X-Session-ID` |
| `gwin.yandex.cloud/rules.sessionAffinity.cookie.name` <br> _(string)_ <br> Cookie name for session affinity. <br> Example: `session` |
| `gwin.yandex.cloud/rules.sessionAffinity.cookie.ttl` <br> _(duration)_ <br> Cookie TTL for session affinity. <br> Example: `3600s` |
| `gwin.yandex.cloud/rules.sessionAffinity.sourceIP` <br> _(boolean)_ <br> Use source IP for session affinity. <br> Example: `true` |

#### Route configuration

| Annotation and description |
|------------|
| `gwin.yandex.cloud/rules.timeout` <br> _(duration)_ <br> Overall timeout for gRPC connection between load balancer and backend. <br> Example: `60s` |
| `gwin.yandex.cloud/rules.idleTimeout` <br> _(duration)_ <br> Idle timeout for gRPC connection. <br> Example: `300s` |

#### Security configuration

| Annotation and description |
|------------|
| `gwin.yandex.cloud/rules.securityProfileID` <br> _(string)_ <br> Security profile ID for route-level protection. <br> Example: `security-profile-1` |
| `gwin.yandex.cloud/hosts.securityProfileID` <br> _(string)_ <br> Security profile ID for host-level protection. <br> Example: `host-security-profile-1` |

#### Rate limiting

| Annotation and description |
|------------|
| `gwin.yandex.cloud/hosts.rateLimit.allRequests.perSecond` <br> _(number)_ <br> Rate limit for all requests per second. <br> Example: `100` |
| `gwin.yandex.cloud/hosts.rateLimit.allRequests.perMinute` <br> _(number)_ <br> Rate limit for all requests per minute. <br> Example: `6000` |
| `gwin.yandex.cloud/hosts.rateLimit.requestsPerIP.perSecond` <br> _(number)_ <br> Rate limit per IP address per second. <br> Example: `10` |
| `gwin.yandex.cloud/hosts.rateLimit.requestsPerIP.perMinute` <br> _(number)_ <br> Rate limit per IP address per minute. <br> Example: `600` |

#### RBAC configuration

RBAC allows controlling access to routes or hosts based on request attributes.

Annotations follow the pattern:
`gwin.yandex.cloud/{resource}.rbac.principals.{principal-group}.{principal}.{rule-type}`

Where:
* `{resource}` — resource type (`rules`, `hosts`);
* `{principal-group}` — logical group of checks (e.g. `admin`);
* `{principal}` — specific principal identifier (e.g. `check-token`);
* `{rule-type}` — matching rule type (`header`, `ip`, etc.).

##### Combination Rules

* All checks within the same principal group are combined with AND logic.
* Different principal groups are combined with OR logic.

| Annotation and description |
|------------|
| `gwin.yandex.cloud/rules.rbac.action` <br> _(string)_ <br> Action when principals match (ALLOW/DENY) for route access control. <br> Example: `ALLOW` |
| `gwin.yandex.cloud/rules.rbac.principals.{group}.{principal}.header.name` <br> _(string)_ <br> Header name to match for route RBAC. <br> Example: `authorization` |
| `gwin.yandex.cloud/rules.rbac.principals.{group}.{principal}.header.exact` <br> _(string)_ <br> Exact header value match for route RBAC. <br> Example: `Bearer admin123` |
| `gwin.yandex.cloud/rules.rbac.principals.{group}.{principal}.header.regex` <br> _(string)_ <br> Regex pattern for header value match for route RBAC. <br> Example: `^Bearer .*` |
| `gwin.yandex.cloud/rules.rbac.principals.{group}.{principal}.header.prefix` <br> _(string)_ <br> Header value prefix match for route RBAC. <br> Example: `Bearer ` |
| `gwin.yandex.cloud/rules.rbac.principals.{group}.{principal}.ip.remoteIp` <br> _(string)_ <br> IP address or CIDR block for route RBAC. <br> Example: `10.0.0.0/8` |
| `gwin.yandex.cloud/rules.rbac.principals.{group}.{principal}.any` <br> _(boolean)_ <br> Match any request for route RBAC. <br> Example: `true` |
| `gwin.yandex.cloud/hosts.rbac.action` <br> _(string)_ <br> Action when principals match (ALLOW/DENY) for host access control. <br> Example: `DENY` |

#### Rule-specific configuration

{% note info %}

Any `rules` option can be applied to a specific rule by prefixing with `rule.{rule-name}`.

For example: `gwin.yandex.cloud/rule.service-rule.backends.balancing.mode: "LEAST_REQUEST"`.

{% endnote %}

| Annotation and description |
|------------|
| `gwin.yandex.cloud/rule.{rule-name}.backends.balancing.mode` <br> _(string)_ <br> Load balancing mode for specific rule. <br> Example: `LEAST_REQUEST` |
| `gwin.yandex.cloud/rule.{rule-name}.timeout` <br> _(duration)_ <br> Timeout for specific rule. <br> Example: `30s` |
| `gwin.yandex.cloud/rule.{rule-name}.idleTimeout` <br> _(duration)_ <br> Idle timeout for specific rule. <br> Example: `120s` |

## GRPCRouteSpec

GRPCRoute specification defines the desired state of GRPCRoute.

*Appears in:* [GRPCRoute](#cheatsheet)

| Field | Description |
|-------|-------------|
| parentRefs | **[[]ParentReference](#parentreference)** <br> References to Gateway resources that this GRPCRoute should attach to. |
| hostnames | **[]string** <br> Hostnames that should match against the gRPC :authority header. |
| rules | **[[]GRPCRouteRule](#grpcrouterule)** <br> Rules for routing gRPC requests. |

### ParentReference

Reference to a Gateway resource that this route should attach to.

*Appears in:* [GRPCRouteSpec](#grpcroutespec)

| Field | Description |
|-------|-------------|
| group | **string** <br> API group of the parent resource. <br> Example: `gateway.networking.k8s.io` |
| kind | **string** <br> Kind of the parent resource. <br> Example: `Gateway` |
| namespace | **string** <br> Namespace of the parent resource. <br> Example: `gateway-ns` |
| name | **string** <br> Name of the parent resource. <br> Example: `example-gateway` |
| sectionName | **string** <br> Name of the specific listener to attach to. <br> Example: `grpc-listener` |
| port | **int32** <br> Port number of the listener to attach to. <br> Example: `80` |

### GRPCRouteRule

GRPCRouteRule defines semantics for matching a gRPC request based on conditions (matches), processing it (filters), and forwarding the request to an API object (backendRefs).

*Appears in:* [GRPCRouteSpec](#grpcroutespec)

| Field | Description |
|-------|-------------|
| name | **string** <br> Name of the route rule. Must be unique within a Route if set. <br> Example: `service-rule` |
| matches | **[[]GRPCRouteMatch](#grpcroutematch)** <br> Conditions required for a request to match this rule. |
| filters | **[[]GRPCRouteFilter](#grpcroutefilter)** <br> Filters to modify requests before forwarding to backends. |
| backendRefs | **[[]GRPCBackendRef](#grpcbackendref)** <br> Backend services to route requests to. |
| sessionPersistence | **SessionPersistence** <br> Session persistence configuration for the route rule. |

### GRPCRouteMatch

GRPCRouteMatch defines the predicate used to match requests to a given action. Multiple match types are ANDed together.

*Appears in:* [GRPCRouteRule](#grpcrouterule)

| Field | Description |
|-------|-------------|
| method | **[GRPCMethodMatch](#grpcmethodmatch)** <br> gRPC method matcher. |
| headers | **[[]GRPCHeaderMatch](#grpcheadermatch)** <br> gRPC header matchers. |

### GRPCMethodMatch

GRPCMethodMatch describes how to select a gRPC route by matching the gRPC request method.

*Appears in:* [GRPCRouteMatch](#grpcroutematch)

| Field | Description |
|-------|-------------|
| type | **string** <br> Method match type. `Exact` for exact method match, `RegularExpression` for regex match. <br> Example: `Exact`, `RegularExpression`. |
| service | **string** <br> gRPC service name to match against. <br> Example: `example.UserService` |
| method | **string** <br> gRPC method name to match against. For regex type, this is a regular expression pattern. <br> Example: `GetUser`, `List.*`. |

### GRPCHeaderMatch

GRPCHeaderMatch describes how to select a gRPC route by matching gRPC request headers.

*Appears in:* [GRPCRouteMatch](#grpcroutematch)

| Field | Description |
|-------|-------------|
| type | **string** <br> Header match type. `Exact` for exact match, `RegularExpression` for regex match. <br> Example: `Exact`, `RegularExpression`. |
| name | **string** <br> Name of the gRPC header to be matched. <br> Example: `grpc-timeout` |
| value | **string** <br> Value of the gRPC header to be matched. <br> Example: `30s` |

### GRPCRouteFilter

GRPCRouteFilter defines processing steps that must be completed during the request or response lifecycle.

*Appears in:* [GRPCRouteRule](#grpcrouterule), [GRPCBackendRef](#grpcbackendref)

| Field | Description |
|-------|-------------|
| type | **string** <br> Filter type. Supported: `RequestHeaderModifier`, `ResponseHeaderModifier`, `RequestMirror`, `ExtensionRef` <br> Example: `RequestHeaderModifier` |
| requestHeaderModifier | **[GRPCHeaderFilter](#grpcheaderfilter)** <br> Request header modification configuration. |
| responseHeaderModifier | **[GRPCHeaderFilter](#grpcheaderfilter)** <br> Response header modification configuration. |

### GRPCHeaderFilter

GRPCHeaderFilter defines configuration for header modification filters (both RequestHeaderModifier and ResponseHeaderModifier).

*Appears in:* [GRPCRouteFilter](#grpcroutefilter)

| Field | Description |
|-------|-------------|
| set | **[]GRPCHeader** <br> Headers to set, replacing any existing values. |
| add | **[]GRPCHeader** <br> Headers to add to the request/response. |
| remove | **[]string** <br> Header names to remove from the request/response. |

### GRPCBackendRef

GRPCBackendRef defines how a GRPCRoute forwards a gRPC request.

*Appears in:* [GRPCRouteRule](#grpcrouterule)

| Field | Description |
|-------|-------------|
| group | **string** <br> API group of the backend resource. <br> Example: `""`, `gwin.yandex.cloud`. |
| kind | **string** <br> Kind of the backend resource. <br> Example: `Service` |
| name | **string** <br> Name of the backend resource. <br> Example: `grpc-service` |
| namespace | **string** <br> Namespace of the backend resource. <br> Example: `grpc-ns` |
| port | **int32** <br> Port of the backend service (for Service kind only). <br> Example: `9090` |
| weight | **int32** <br> Weight for traffic distribution between backends. <br> Example: `80` |
