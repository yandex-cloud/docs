---
sourcePath: en/_gwin-ref/httproute.md
---
# HTTPRoute

HTTPRoute provides a way to route HTTP requests. This includes the capability to match requests by hostname, path, header, or query param. Filters can be used to modify requests, and requests should be routed to backend services.

HTTPRoute is a [Kubernetes Gateway API](https://gateway-api.sigs.k8s.io/) project resource. Below, we describe its fields and annotations used by Gwin. For details, see the [upstream documentation](https://gateway-api.sigs.k8s.io/reference/spec/#httproute).

HTTPRoute resources must be attached to [Gateway](./gateway.md) resources to function properly.

* [Cheatsheet](#cheatsheet)
* [HTTPRouteMeta](#httproutemeta)
  * [Annotations cheatsheet](#annotations-cheatsheet)
  * [Annotations reference](#annotations-reference)
* [HTTPRouteSpec](#httproutespec)
  * [ParentReference](#parentreference)
  * [HTTPRouteRule](#httprouterule)
  * [HTTPRouteMatch](#httproutematch)
  * [HTTPPathMatch](#httppathmatch)
  * [HTTPRouteFilter](#httproutefilter)
  * [HTTPHeaderFilter](#httpheaderfilter)
  * [HTTPRequestRedirectFilter](#httprequestredirectfilter)
  * [HTTPPathModifier](#httppathmodifier)
  * [HTTPBackendRef](#httpbackendref)
  * [HTTPRouteTimeouts](#httproutetimeouts)

## Cheatsheet

{% note info %}

Specification provided below is not valid configuration.

It's just demonstration of all `HTTPRoute` fields.

{% endnote %}

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: example-route
  namespace: example-ns
  annotations: ...  # see annotations example below
spec:
  parentRefs:  # attach to Gateway resources
    - group: gateway.networking.k8s.io
      kind: Gateway
      namespace: gateway-ns
      name: example-gateway
      sectionName: http-listener  # specific listener name, can be omitted
  hostnames:  # domains this route handles
    - "*.example.com"  # wildcard domain
    - "api.example.com"  # specific subdomain
  rules:
    - name: api-rule  # rule identifier
      matches:  # conditions for this rule
        - path:
            type: PathPrefix  # match path prefix
            value: "/api"
          method: GET  # HTTP method
          headers:  # header matching
            - name: "X-Version"
              value: "v1"
      filters:  # modify requests before routing
        - type: RequestHeaderModifier
          requestHeaderModifier:
            set:  # replace header values
              - name: "X-Custom-Header"
                value: "custom-value"
            add:  # add new headers
              - name: "X-Added-Header"
                value: "added-value"
            remove:  # remove headers
              - "X-Remove-Header"
        - type: ResponseHeaderModifier  # modify response headers
          responseHeaderModifier: ... # same as RequestHeaderModifier
        - type: RequestRedirect  # redirect instead of routing
          requestRedirect:
            scheme: https  # change protocol
            hostname: secure.example.com  # change host
            path:
              type: ReplaceFullPath  # replace entire path
              replaceFullPath: "/v2/api"
            port: 443  # change port
            statusCode: 301  # HTTP redirect code
      backendRefs:  # where to route requests
        - group: ""  # core Kubernetes API
          kind: Service  # Kubernetes service
          name: api-service
          namespace: api-ns
          port: 8080
          weight: 80  # 80% of traffic
        - group: gwin.yandex.cloud  # Gwin custom resources
          kind: YCStorageBucket  # Object Storage bucket
          name: static-bucket
          weight: 20  # 20% of traffic
      timeouts:  # request timeouts
        backendRequest: "25s"  # backend request timeout
```

| Field | Description |
|-------|-------------|
| metadata | **[HTTPRouteMeta](#httproutemeta)** <br> Name, namespace and annotations. |
| spec | **[HTTPRouteSpec](#httproutespec)** <br> Resource specification. |

## HTTPRouteMeta

| Field | Description |
|-------|-------------|
| name | **string** <br> Name of the HTTPRoute. |
| namespace | **string** <br> Namespace of the HTTPRoute. |
| annotations | **map[string]string** <br> Annotations of the HTTPRoute. |

### Annotations cheatsheet

{% note info %}

You can also set policy parameters using [RoutePolicy](./routepolicy.md) resource. The RoutePolicy resource parameters and HTTPRoute annotations are equivalent.

{% endnote %}

Specification provided below is not valid configuration.
It's just demonstration of all `HTTPRoute` annotations.

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  annotations:
    # Backend group configuration
    gwin.yandex.cloud/rules.backends.http.useHTTP2: "true"  # enable HTTP/2 to backends
    gwin.yandex.cloud/rules.backends.balancing.mode: "ROUND_ROBIN"  # load balancing algorithm
    gwin.yandex.cloud/rules.backends.balancing.localityAwareRouting: "80"  # prefer same zone
    gwin.yandex.cloud/rules.backends.balancing.strictLocality: "false"  # allow cross-zone routing
    gwin.yandex.cloud/rules.backends.balancing.panicThreshold: "50"  # panic mode threshold
    
    # Health checks
    gwin.yandex.cloud/rules.backends.hc.timeout: "5s"  # health check timeout
    gwin.yandex.cloud/rules.backends.hc.interval: "10s"  # check interval
    gwin.yandex.cloud/rules.backends.hc.healthyThreshold: "2"  # checks to mark healthy
    gwin.yandex.cloud/rules.backends.hc.unhealthyThreshold: "3"  # checks to mark unhealthy
    gwin.yandex.cloud/rules.backends.hc.port: "8080"  # health check port
  
    gwin.yandex.cloud/rules.backends.hc.http.path: "/health"  # HTTP health check path
    gwin.yandex.cloud/rules.backends.hc.http.useHTTP2: "false"  # use HTTP/1.1 for checks
    gwin.yandex.cloud/rules.backends.hc.http.host: "health.example.com"  # Host header
    
    gwin.yandex.cloud/rules.backends.hc.grpc.serviceName: "health.HealthService"  # gRPC service
    
    gwin.yandex.cloud/rules.backends.hc.stream.send: "PING"  # TCP check data to send
    gwin.yandex.cloud/rules.backends.hc.stream.receive: "PONG"  # expected TCP response
    
    # Health check transport settings
    gwin.yandex.cloud/rules.backends.hc.transportSettings.plaintext: "true"  # use plaintext for health checks
    gwin.yandex.cloud/rules.backends.hc.transportSettings.tls.sni: "health.example.com"  # SNI for health check TLS
    gwin.yandex.cloud/rules.backends.hc.transportSettings.tls.trustedCA.id: "health-cert-123"  # health check TLS cert ID
    gwin.yandex.cloud/rules.backends.hc.transportSettings.tls.trustedCA.bytes: "-----BEGIN CERTIFICATE-----..."  # health check TLS cert PEM
    
    # Backend TLS configuration
    gwin.yandex.cloud/rules.backends.tls.sni: "backend.example.com"  # SNI for TLS
    gwin.yandex.cloud/rules.backends.tls.trustedCA.id: "cert-123456"  # cloud certificate ID
    gwin.yandex.cloud/rules.backends.tls.trustedCA.bytes: "-----BEGIN CERTIFICATE-----..."  # PEM certificate
    
    # Stream backend configuration
    gwin.yandex.cloud/rules.backends.stream.enableProxy: "true"  # enable proxy protocol
    gwin.yandex.cloud/rules.backends.stream.keepConnectionsOnHostHealthFailure: "false"  # drop failed connections
    
    # Session affinity
    gwin.yandex.cloud/rules.sessionAffinity.header.name: "X-Session-ID"  # header-based affinity
    gwin.yandex.cloud/rules.sessionAffinity.cookie.name: "session"  # cookie name
    gwin.yandex.cloud/rules.sessionAffinity.cookie.ttl: "3600s"  # cookie lifetime
    gwin.yandex.cloud/rules.sessionAffinity.sourceIP: "true"  # IP-based affinity
    
    # Route timeouts
    gwin.yandex.cloud/rules.timeout: "60s"  # overall connection timeout
    gwin.yandex.cloud/rules.idleTimeout: "300s"  # idle connection timeout
    
    # HTTP specific settings
    gwin.yandex.cloud/rules.httpUpgradeTypes: "websocket"  # supported upgrade protocols
    
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
    gwin.yandex.cloud/rules.rbac.principals.admin.check-token.header.name: "X-Api-Token"  # header to check
    gwin.yandex.cloud/rules.rbac.principals.admin.check-token.header.exact: "admin123"  # required value
    gwin.yandex.cloud/rules.rbac.principals.admin.check-ip.ip.remoteIp: "10.0.0.0/8"  # allowed IP range
    gwin.yandex.cloud/rules.rbac.principals.admin.any.any: "true"  # match any request
    gwin.yandex.cloud/hosts.rbac.action: "DENY"  # host-level RBAC action
    
    # Rule-specific configuration (overrides global settings)
    gwin.yandex.cloud/rule.api-rule.backends.balancing.mode: "LEAST_REQUEST"  # per-rule balancing
    gwin.yandex.cloud/rule.api-rule.timeout: "30s"  # per-rule timeout
    gwin.yandex.cloud/rule.api-rule.idleTimeout: "120s"  # per-rule idle timeout
```

### Annotations reference

#### Backend group configuration

| Annotation and description |
|------------|
| `gwin.yandex.cloud/rules.backends.http.useHTTP2` <br> _(boolean)_ <br> Use HTTP/2 for connections between load balancer and backends. <br> Example: `true` |
| `gwin.yandex.cloud/rules.backends.balancing.mode` <br> _(string)_ <br> Load balancing mode for backend group. Possible values: `RANDOM`, `ROUND_ROBIN`, `LEAST_REQUEST`. <br> Example: `ROUND_ROBIN` |
| `gwin.yandex.cloud/rules.backends.balancing.localityAwareRouting` <br> _(number)_ <br> Percentage of traffic sent to backends in the same [availability zone](https://yandex.cloud/en/docs/overview/concepts/geo-scope). <br> Example: `80` |
| `gwin.yandex.cloud/rules.backends.balancing.strictLocality` <br> _(boolean)_ <br> Route traffic only to backends in the same [availability zone](https://yandex.cloud/en/docs/overview/concepts/geo-scope). <br> Example: `false` |
| `gwin.yandex.cloud/rules.backends.balancing.panicThreshold` <br> _(number)_ <br> [Panic mode](https://yandex.cloud/en/docs/application-load-balancer/concepts/backend-group#panic-mode) threshold percentage for load balancing. <br> Example: `50` |

#### Health check configuration

##### Common health check settings

| Annotation and description |
|------------|
| `gwin.yandex.cloud/rules.backends.hc.timeout` <br> _(duration)_ <br> Health check timeout. <br> Example: `5s` |
| `gwin.yandex.cloud/rules.backends.hc.interval` <br> _(duration)_ <br> Interval between health checks. <br> Example: `10s` |
| `gwin.yandex.cloud/rules.backends.hc.healthyThreshold` <br> _(number)_ <br> Number of successful checks to mark backend as healthy. <br> Example: `2` |
| `gwin.yandex.cloud/rules.backends.hc.unhealthyThreshold` <br> _(number)_ <br> Number of failed checks to mark backend as unhealthy. <br> Example: `3` |
| `gwin.yandex.cloud/rules.backends.hc.port` <br> _(number)_ <br> Port for health checks. <br> Example: `8080` |

##### HTTP health checks

| Annotation and description |
|------------|
| `gwin.yandex.cloud/rules.backends.hc.http.path` <br> _(string)_ <br> HTTP path for health checks. <br> Example: `/health` |
| `gwin.yandex.cloud/rules.backends.hc.http.useHTTP2` <br> _(boolean)_ <br> Use HTTP/2 for health checks. <br> Example: `false` |
| `gwin.yandex.cloud/rules.backends.hc.http.host` <br> _(string)_ <br> Host header for HTTP health checks. <br> Example: `health.example.com` |

##### gRPC health checks

| Annotation and description |
|------------|
| `gwin.yandex.cloud/rules.backends.hc.grpc.serviceName` <br> _(string)_ <br> gRPC service name for health checks. <br> Example: `health.HealthService` |

##### Stream health checks

| Annotation and description |
|------------|
| `gwin.yandex.cloud/rules.backends.hc.stream.send` <br> _(string)_ <br> Data to send for TCP health checks. <br> Example: `PING` |
| `gwin.yandex.cloud/rules.backends.hc.stream.receive` <br> _(string)_ <br> Expected response for TCP health checks. <br> Example: `PONG` |

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
| `gwin.yandex.cloud/rules.backends.tls.sni` <br> _(string)_ <br> Server Name Indication (SNI) for TLS connections to backends. <br> Example: `backend.example.com` |
| `gwin.yandex.cloud/rules.backends.tls.trustedCA.id` <br> _(string)_ <br> Cloud certificate ID for backend TLS validation. <br> Example: `cert-123456` |
| `gwin.yandex.cloud/rules.backends.tls.trustedCA.bytes` <br> _(string)_ <br> X.509 certificate contents in PEM format for backend TLS validation. <br> Example: `-----BEGIN CERTIFICATE-----...` |

#### Stream backend configuration

| Annotation and description |
|------------|
| `gwin.yandex.cloud/rules.backends.stream.enableProxy` <br> _(boolean)_ <br> Enable proxy protocol for stream backends. <br> Example: `true` |
| `gwin.yandex.cloud/rules.backends.stream.keepConnectionsOnHostHealthFailure` <br> _(boolean)_ <br> Keep connections when backend host becomes unhealthy. <br> Example: `false` |

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
| `gwin.yandex.cloud/rules.timeout` <br> _(duration)_ <br> Overall timeout for HTTP connection between load balancer and backend. The maximum time the connection is kept alive, regardless of data transfer. Default: 60s. On timeout, returns UNAVAILABLE status. _NOTE_: In HTTPRoute you can use rules[].timeouts.backendRequest field instead, it overrides annotation value. <br> Example: `60s` |
| `gwin.yandex.cloud/rules.idleTimeout` <br> _(duration)_ <br> Idle timeout for HTTP connection. <br> Example: `300s` |
| `gwin.yandex.cloud/rules.httpUpgradeTypes` <br> _(comma separated strings)_ <br> Supported HTTP Upgrade header values. <br> Example: `websocket` |

#### Security configuration

| Annotation and description |
|------------|
| `gwin.yandex.cloud/rules.securityProfileID` <br> _(string)_ <br> [Security profile](https://yandex.cloud/en/docs/smartwebsecurity/) ID for route-level protection. <br> Example: `security-profile-1` |
| `gwin.yandex.cloud/hosts.securityProfileID` <br> _(string)_ <br> [Security profile](https://yandex.cloud/en/docs/smartwebsecurity/) ID for host-level protection. <br> Example: `host-security-profile-1` |

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
| `gwin.yandex.cloud/rules.rbac.principals.{group}.{principal}.header.name` <br> _(string)_ <br> Header name to match for route RBAC. <br> Example: `X-Api-Token` |
| `gwin.yandex.cloud/rules.rbac.principals.{group}.{principal}.header.exact` <br> _(string)_ <br> Exact header value match for route RBAC. <br> Example: `admin123` |
| `gwin.yandex.cloud/rules.rbac.principals.{group}.{principal}.header.regex` <br> _(string)_ <br> Regex pattern for header value match for route RBAC. <br> Example: `^admin.*` |
| `gwin.yandex.cloud/rules.rbac.principals.{group}.{principal}.header.prefix` <br> _(string)_ <br> Header value prefix match for route RBAC. <br> Example: `Bearer ` |
| `gwin.yandex.cloud/rules.rbac.principals.{group}.{principal}.ip.remoteIp` <br> _(string)_ <br> IP address or CIDR block for route RBAC. <br> Example: `10.0.0.0/8` |
| `gwin.yandex.cloud/rules.rbac.principals.{group}.{principal}.any` <br> _(boolean)_ <br> Match any request for route RBAC. <br> Example: `true` |
| `gwin.yandex.cloud/hosts.rbac.action` <br> _(string)_ <br> Action when principals match (ALLOW/DENY) for host access control. <br> Example: `DENY` |

#### Rule-specific configuration

{% note info %}

Any `rules` option can be applied to a specific rule by prefixing with `rule.{rule-name}`.

For example: `gwin.yandex.cloud/rule.api-rule.backends.balancing.mode: "LEAST_REQUEST"`.

{% endnote %}

| Annotation and description |
|------------|
| `gwin.yandex.cloud/rule.{rule-name}.backends.balancing.mode` <br> _(string)_ <br> Load balancing mode for specific rule. <br> Example: `LEAST_REQUEST` |
| `gwin.yandex.cloud/rule.{rule-name}.timeout` <br> _(duration)_ <br> Timeout for specific rule. <br> Example: `30s` |
| `gwin.yandex.cloud/rule.{rule-name}.idleTimeout` <br> _(duration)_ <br> Idle timeout for specific rule. <br> Example: `120s` |

## HTTPRouteSpec

HTTPRoute specification defines the desired state of HTTPRoute.

*Appears in*: [HTTPRoute](#httproute)

| Field | Description |
|-------|-------------|
| parentRefs | **[]ParentReference** <br> References to Gateway resources that this HTTPRoute should attach to. |
| hostnames | **[]string** <br> Hostnames that should match against the HTTP Host header. |
| rules | **[[]HTTPRouteRule](#httprouterule)** <br> Rules for routing HTTP requests. |

### ParentReference

Reference to a Gateway resource that this route should attach to.

*Appears in*: [HTTPRouteSpec](#httproutespec)

| Field | Description |
|-------|-------------|
| group | **string** <br> API group of the parent resource. <br> Example: `gateway.networking.k8s.io` |
| kind | **string** <br> Kind of the parent resource. <br> Example: `Gateway` |
| namespace | **string** <br> Namespace of the parent resource. <br> Example: `gateway-ns` |
| name | **string** <br> Name of the parent resource. <br> Example: `example-gateway` |
| sectionName | **string** <br> Name of the specific listener to attach to. <br> Example: `http-listener` |
| port | **int32** <br> Port number of the listener to attach to. <br> Example: `80` |

### HTTPRouteRule

HTTPRouteRule defines semantics for matching an HTTP request based on conditions (matches), processing it (filters), and forwarding the request to an API object (backendRefs).

*Appears in*: [HTTPRouteSpec](#httproutespec)

| Field | Description |
|-------|-------------|
| name | **string** <br> Name of the route rule. Must be unique within a Route if set. <br> Example: `api-rule` |
| matches | **[[]HTTPRouteMatch](#httproutematch)** <br> Conditions required for a request to match this rule. |
| filters | **[[]HTTPRouteFilter](#httproutefilter)** <br> Filters to modify requests before forwarding to backends. |
| backendRefs | **[[]HTTPBackendRef](#httpbackendref)** <br> Backend services to route requests to. |
| timeouts | **[HTTPRouteTimeouts](#httproutetimeouts)** <br> Timeout configuration for this rule. |

### HTTPRouteMatch

HTTPRouteMatch defines the predicate used to match requests to a given action. Multiple match types are ANDed together.

*Appears in*: [HTTPRouteRule](#httprouterule)

| Field | Description |
|-------|-------------|
| path | **[HTTPPathMatch](#httppathmatch)** <br> HTTP request path matcher. |
| headers | **[]HTTPHeaderMatch** <br> HTTP request header matchers. |
| queryParams | **[]HTTPQueryParamMatch** <br> HTTP query parameter matchers. |
| method | **string** <br> HTTP method to match. <br> Example: `GET`, `POST`, `PUT`. |

### HTTPPathMatch

HTTPPathMatch describes how to select a HTTP route by matching the HTTP request path.

*Appears in*: [HTTPRouteMatch](#httproutematch)

| Field | Description |
|-------|-------------|
| type | **string** <br> Path match type. `Exact` for exact path match, `PathPrefix` for path prefix match. <br> Example: `Exact`, `PathPrefix`. |
| value | **string** <br> Path value to match against. <br> Example: `/api/v1`, `/`. |

### HTTPRouteFilter

HTTPRouteFilter defines processing steps that must be completed during the request or response lifecycle.

*Appears in*: [HTTPRouteRule](#httprouterule), [HTTPBackendRef](#httpbackendref)

| Field | Description |
|-------|-------------|
| type | **string** <br> Filter type. Supported: `RequestHeaderModifier`, `ResponseHeaderModifier`, `RequestRedirect`, `URLRewrite` <br> Example: `RequestHeaderModifier` |
| requestHeaderModifier | **[HTTPHeaderFilter](#httpheaderfilter)** <br> Request header modification configuration. |
| responseHeaderModifier | **[HTTPHeaderFilter](#httpheaderfilter)** <br> Response header modification configuration. |
| requestRedirect | **[HTTPRequestRedirectFilter](#httprequestredirectfilter)** <br> Request redirect configuration. |
| urlRewrite | **HTTPURLRewriteFilter** <br> URL rewrite configuration. |

### HTTPHeaderFilter

HTTPHeaderFilter defines configuration for header modification filters (both RequestHeaderModifier and ResponseHeaderModifier).

*Appears in*: [HTTPRouteFilter](#httproutefilter)

| Field | Description |
|-------|-------------|
| set | **[]HTTPHeader** <br> Headers to set, replacing any existing values. |
| add | **[]HTTPHeader** <br> Headers to add to the request/response. |
| remove | **[]string** <br> Header names to remove from the request/response. |

### HTTPRequestRedirectFilter

HTTPRequestRedirectFilter defines configuration for the RequestRedirect filter.

*Appears in*: [HTTPRouteFilter](#httproutefilter)

| Field | Description |
|-------|-------------|
| scheme | **string** <br> Scheme to redirect to. <br> Example: `https` |
| hostname | **string** <br> Hostname to redirect to. <br> Example: `secure.example.com` |
| path | **[HTTPPathModifier](#httppathmodifier)** <br> Path modification for redirect. |
| port | **int32** <br> Port to redirect to. <br> Example: `443` |
| statusCode | **int** <br> HTTP status code for redirect. <br> Example: `301`, `302`. |

### HTTPPathModifier

HTTPPathModifier defines configuration for path modification in redirects.

*Appears in*: [HTTPRequestRedirectFilter](#httprequestredirectfilter)

| Field | Description |
|-------|-------------|
| type | **string** <br> Path modification type. `ReplaceFullPath` or `ReplacePrefixMatch`. <br> Example: `ReplaceFullPath` |
| replaceFullPath | **string** <br> Complete path replacement. <br> Example: `/v2/api` |
| replacePrefixMatch | **string** <br> Path prefix replacement. <br> Example: `/api/v2` |

### HTTPBackendRef

HTTPBackendRef defines how an HTTPRoute forwards an HTTP request. 

[`Service`](./service.md) or [`YCStorageBucket`](./ycstoragebucket.md) can be used as a backend.

*Appears in*: [HTTPRouteRule](#httprouterule)

| Field | Description |
|-------|-------------|
| group | **string** <br> API group of the backend resource. <br> Example: `""`, `gwin.yandex.cloud`. |
| kind | **string** <br> Kind of the backend resource. <br> Example: `Service`, `YCStorageBucket`. |
| name | **string** <br> Name of the backend resource. <br> Example: `api-service` |
| namespace | **string** <br> Namespace of the backend resource. <br> Example: `api-ns` |
| port | **int32** <br> Port of the backend service (for `Service` kind only). <br> Example: `8080` |
| weight | **int32** <br> Weight for traffic distribution between backends. <br> Example: `80` |

### HTTPRouteTimeouts

HTTPRouteTimeouts defines timeouts that can be configured for an HTTPRoute.

*Appears in*: [HTTPRouteRule](#httprouterule)

| Field | Description |
|-------|-------------|
| backendRequest | **string** <br> Maximum duration for a request from balancer to a backend. <br> Example: `25s` |
