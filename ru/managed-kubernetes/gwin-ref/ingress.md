---
sourcePath: en/_gwin-ref/gwin-ref/ingress.md
---
# Ingress

Ingress manages external access to services in a cluster, typically HTTP. Gwin extends the standard Kubernetes Ingress resource with custom annotations for Yandex Application Load Balancer features.

Ingress is a standard [Kubernetes](https://kubernetes.io/docs/concepts/services-networking/ingress/) resource. Below, we describe its fields and annotations used by Gwin. For configuration details, see the [upstream documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/).

{% note info %}

Ingress is frozen. New features are being added to the [Gateway API](https://gateway-api.sigs.k8s.io/). See [k8s docs](https://kubernetes.io/docs/concepts/services-networking/ingress/) for details. Yandex Cloud docs for Gateway API are available [here](./gateway.md).

{% endnote %}

* [Cheatsheet](#cheatsheet)
* [IngressMeta](#ingressmeta)
  * [Annotations cheatsheet](#annotations-cheatsheet)
  * [Annotations reference](#annotations-reference)
* [IngressSpec](#ingressspec)
  * [IngressRule](#ingressrule)
  * [HTTPIngressRuleValue](#httpingressrulevalue)
  * [HTTPIngressPath](#httpingresspath)
  * [IngressBackend](#ingressbackend)
  * [TypedLocalObjectReference](#typedlocalobjectreference)
  * [IngressServiceBackend](#ingressservicebackend)
  * [ServiceBackendPort](#servicebackendport)
  * [IngressTLS](#ingresstls)

## Cheatsheet

{% note info %}

Specification provided below is not valid configuration.

It's just demonstration of all `Ingress` fields.

{% endnote %}

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  namespace: example-ns
  annotations: ...  # see annotations example below
spec:
  ingressClassName: gwin  # use Gwin ingress class
  defaultBackend:  # default backend for unmatched requests
    service:
      name: default-service
      port:
        number: 80
  rules:
    - host: "example.com"  # hostname to match
      http:
        paths:
          - path: "/api"  # path to match
            pathType: Prefix  # path matching type
            backend:
              service:
                name: api-service
                port:
                  number: 8080
          - path: "/static"
            pathType: Prefix
            backend:
              resource:  # custom backend resource
                apiGroup: gwin.yandex.cloud
                kind: IngressBackendGroup
                name: static-backend-group
          - path: "/regex.*"  # regex path matching
            pathType: ImplementationSpecific  # enables regex matching
            backend:
              service:
                name: regex-service
                port:
                  number: 8080
          - path: "/redirect"
            pathType: Prefix
            backend:
              resource:  # redirect backend
                kind: Redirect
                name: example-redirect
          - path: "/direct"
            pathType: Prefix
            backend:
              resource:  # direct response backend
                kind: DirectResponse
                name: example-response
  tls:
    - hosts:
        - "example.com"
      secretName: "yc-certmgr-cert-id-fpq6gvvm6piu********"  # Yandex Cloud certificate
```

| Field | Description |
|-------|-------------|
| metadata | **[IngressMeta](#ingressmeta)** <br> Name, namespace and annotations. |
| spec | **[IngressSpec](#ingressspec)** <br> Resource specification. |

## IngressMeta

| Field | Description |
|-------|-------------|
| name | **string** <br> Name of the Ingress. |
| namespace | **string** <br> Namespace of the Ingress. |
| annotations | **map[string]string** <br> Annotations of the Ingress. |

### Annotations cheatsheet

{% note info %}

You can also set policy parameters using [IngressPolicy](./ingresspolicy.md) resource. The IngressPolicy resource parameters and Ingress annotations are equivalent.

{% endnote %}

Specification provided below is not valid configuration. It's just demonstration of all `Ingress` annotations.

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    # Ingress group configuration
    gwin.yandex.cloud/groupName: "my-ingress-group"  # group multiple ingresses to single Balancer
    gwin.yandex.cloud/groupOrder: "100"  # processing order within group
    
    # Load balancer configuration
    gwin.yandex.cloud/externalIPv4Address: "5.4.3.2"  # external IPv4 address
    gwin.yandex.cloud/subnets: "subnet-id-1,subnet-id-2"  # where to place balancer
    gwin.yandex.cloud/securityGroups: "sg-id-1,sg-id-2"  # network access control
    gwin.yandex.cloud/allowZonalShift: "true"  # enable failover between zones
    
    # Cloud Logging
    gwin.yandex.cloud/logs.logGroupID: "log-group-id-1"  # where to send logs
    gwin.yandex.cloud/logs.disable: "false"  # enable logging
    gwin.yandex.cloud/logs.discardRule.rule1.httpCodes: "404,500"  # skip these status codes
    gwin.yandex.cloud/logs.discardRule.rule1.httpCodeIntervals: "HTTP_4XX,HTTP_5XX"  # skip error ranges
    gwin.yandex.cloud/logs.discardRule.rule1.grpcCodes: "INTERNAL,UNIMPLEMENTED"  # skip gRPC errors
    gwin.yandex.cloud/logs.discardRule.rule1.discardPercent: "10"  # drop 10% of logs
    
    # Autoscaling
    gwin.yandex.cloud/autoScale.minZoneSize: "2"  # min instances per zone
    gwin.yandex.cloud/autoScale.maxSize: "10"  # max total instances
    
    # Zone traffic control
    gwin.yandex.cloud/zone.ru-central1-a.receiveTraffic: "false"  # disable this zone
    gwin.yandex.cloud/zone.ru-central1-b.receiveTraffic: "true"  # enable this zone
    
    # Listener configuration
    gwin.yandex.cloud/listeners.rbac.action: "ALLOW"  # access control policy
    gwin.yandex.cloud/listeners.http.protocolSettings.allowHTTP10: "true"  # support old HTTP
    gwin.yandex.cloud/listeners.http.protocolSettings.http2Options.maxConcurrentStreams: "100"  # limit connections
    gwin.yandex.cloud/listeners.stream.idleTimeout: "300s"  # close idle connections
    
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
    gwin.yandex.cloud/rules.backends.hc.http.host: "health.example.com"  # Host header
    
    # Backend TLS configuration
    gwin.yandex.cloud/rules.backends.tls.sni: "backend.example.com"  # SNI for TLS
    gwin.yandex.cloud/rules.backends.tls.trustedCA.id: "cert-123456"  # cloud certificate ID
    
    # Session affinity
    gwin.yandex.cloud/rules.sessionAffinity.header.name: "X-Session-ID"  # header-based affinity
    gwin.yandex.cloud/rules.sessionAffinity.cookie.name: "session"  # cookie name
    gwin.yandex.cloud/rules.sessionAffinity.cookie.ttl: "3600s"  # cookie lifetime
    gwin.yandex.cloud/rules.sessionAffinity.sourceIP: "true"  # IP-based affinity
    
    # Route timeouts
    gwin.yandex.cloud/rules.timeout: "60s"  # overall connection timeout
    gwin.yandex.cloud/rules.idleTimeout: "300s"  # idle connection timeout
    
    # HTTP specific settings
    gwin.yandex.cloud/rules.http.upgradeTypes: "websocket"  # supported upgrade protocols
    gwin.yandex.cloud/rules.allowedMethods: "GET,POST,PUT"  # restrict allowed HTTP methods
    gwin.yandex.cloud/rules.prefixRewrite: "/new-prefix"  # rewrite URL path prefix
    
    # Header modifications
    gwin.yandex.cloud/rules.modifyRequestHeaders.append.X-Custom-Header: "custom-value"  # add request header
    gwin.yandex.cloud/rules.modifyRequestHeaders.rename.Old-Header: "New-Header"  # rename request header
    gwin.yandex.cloud/rules.modifyRequestHeaders.replace.Authorization: "Bearer token"  # replace request header
    gwin.yandex.cloud/rules.modifyRequestHeaders.remove: "X-Remove-Me,X-Also-Remove"  # remove request headers
    gwin.yandex.cloud/rules.modifyResponseHeaders.append.X-Response-Header: "response-value"  # add response header
    gwin.yandex.cloud/rules.modifyResponseHeaders.rename.Old-Response: "New-Response"  # rename response header
    gwin.yandex.cloud/rules.modifyResponseHeaders.replace.Cache-Control: "no-cache"  # replace response header
    gwin.yandex.cloud/rules.modifyResponseHeaders.remove: "Server,X-Powered-By"  # remove response headers
    
    # Redirect actions (referenced by backend resource)
    gwin.yandex.cloud/redirect.my-redirect.replaceScheme: "https"  # change URL scheme
    gwin.yandex.cloud/redirect.my-redirect.replaceHost: "new-host.com"  # change hostname
    gwin.yandex.cloud/redirect.my-redirect.replacePort: "443"  # change port
    gwin.yandex.cloud/redirect.my-redirect.path.replacePath: "/new-path"  # replace entire path
    gwin.yandex.cloud/redirect.my-redirect.path.replacePrefix: "/new-prefix"  # replace path prefix
    gwin.yandex.cloud/redirect.my-redirect.removeQuery: "true"  # remove query parameters
    gwin.yandex.cloud/redirect.my-redirect.responseCode: "301"  # redirect status code
    
    # Direct response actions (referenced by backend resource)
    gwin.yandex.cloud/directResponse.my-response.responseCode: "200"  # HTTP status code
    gwin.yandex.cloud/directResponse.my-response.responseBody.text: "Hello World"  # response body text
    
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
    gwin.yandex.cloud/hosts.rbac.action: "DENY"  # host-level RBAC action
```

### Annotations reference

#### Ingress Group Configuration

| Annotation and description |
|------------|
| `gwin.yandex.cloud/groupName` <br> _(string)_ <br> Name of the ingress group to group multiple ingresses together. <br> Example: `my-ingress-group` |
| `gwin.yandex.cloud/groupOrder` <br> _(number)_ <br> Processing order within the ingress group. <br> Example: `100` |

#### Load Balancer Configuration

| Annotation and description |
|------------|
| `gwin.yandex.cloud/externalIPv4Address` <br> _(string)_ <br> External IPv4 address for the load balancer. <br> Example: `5.4.3.2` |
| `gwin.yandex.cloud/subnets` <br> _(comma separated strings)_ <br> [Subnets](https://yandex.cloud/en/docs/vpc/concepts/network#subnet) of the zones where load balancer will be instantiated. <br> Example: `subnet-id-1,subnet-id-2` |
| `gwin.yandex.cloud/securityGroups` <br> _(comma separated strings)_ <br> [Security groups](https://yandex.cloud/en/docs/vpc/concepts/security-groups) of load balancer. <br> Example: `sg-id-1,sg-id-2` |
| `gwin.yandex.cloud/allowZonalShift` <br> _(boolean)_ <br> Specifies whether application load balancer is available to zonal shift. <br> Example: `true` |

#### Cloud Logging

For `discardRule` annotations you can set up any name. It does not affect ALB configuration in any way.

| Annotation and description |
|------------|
| `gwin.yandex.cloud/logs.logGroupID` <br> _(string)_ <br> [Cloud Logging](https://yandex.cloud/en/docs/logging/) log group ID to store [access logs](https://yandex.cloud/en/docs/application-load-balancer/logs-ref). <br> Example: `log-group-id-1` |
| `gwin.yandex.cloud/logs.disable` <br> _(boolean)_ <br> Disable sending logs to [Cloud Logging](https://yandex.cloud/en/docs/logging/). <br> Example: `false` |
| `gwin.yandex.cloud/logs.discardRule.{name}.httpCodes` <br> _(comma separated numbers)_ <br> HTTP status codes to discard from logs. <br> Example: `404,500` |
| `gwin.yandex.cloud/logs.discardRule.{name}.httpCodeIntervals` <br> _(comma separated strings)_ <br> HTTP code intervals to discard. <br> Example: `HTTP_4XX,HTTP_5XX` |
| `gwin.yandex.cloud/logs.discardRule.{name}.grpcCodes` <br> _(comma separated strings)_ <br> gRPC codes to discard from logs. <br> Example: `INTERNAL,UNIMPLEMENTED` |
| `gwin.yandex.cloud/logs.discardRule.{name}.discardPercent` <br> _(number)_ <br> Percentage of matching logs to discard (0-100). <br> Example: `10` |

#### Autoscaling

| Annotation and description |
|------------|
| `gwin.yandex.cloud/autoScale.minZoneSize` <br> _(number)_ <br> Minimum [resource units](https://yandex.cloud/en/docs/application-load-balancer/concepts/application-load-balancer#lcu-scaling) per zone (must be ≥2). <br> Example: `2` |
| `gwin.yandex.cloud/autoScale.maxSize` <br> _(number)_ <br> Maximum total [resource units](https://yandex.cloud/en/docs/application-load-balancer/concepts/application-load-balancer#lcu-scaling) (0 = no limit). <br> Example: `10` |

#### Zone traffic control

`<zone>` is a zone id, e.g. `ru-central1-a`.

| Annotation and description |
|------------|
| `gwin.yandex.cloud/zone.{zone}.receiveTraffic` <br> _(boolean)_ <br> Disable traffic to load balancer nodes in specified [availability zone](https://yandex.cloud/en/docs/overview/concepts/geo-scope). <br> Example: `false` |

#### Listener configuration

| Annotation and description |
|------------|
| `gwin.yandex.cloud/listeners.http.protocolSettings.allowHTTP10` <br> _(boolean)_ <br> Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. Applies to all HTTP listeners. <br> Example: `true` |
| `gwin.yandex.cloud/listeners.http.protocolSettings.http2Options.maxConcurrentStreams` <br> _(number)_ <br> Maximum number of concurrent HTTP/2 streams in a connection. Applies to all HTTP listeners. <br> Example: `100` |
| `gwin.yandex.cloud/listeners.stream.idleTimeout` <br> _(duration)_ <br> The idle timeout is duration during which no data is transmitted or received on either the upstream or downstream connection. Applies to all stream listeners. <br> Example: `300s` |
| `gwin.yandex.cloud/listeners.rbac.action` <br> _(string)_ <br> RBAC action (ALLOW/DENY) for HTTP router access control for all listeners. <br> Example: `ALLOW` |

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
| `gwin.yandex.cloud/rules.timeout` <br> _(duration)_ <br> Overall timeout for HTTP connection between load balancer and backend. The maximum time the connection is kept alive, regardless of data transfer. Default: 60s. On timeout, returns UNAVAILABLE status. <br> Example: `60s` |
| `gwin.yandex.cloud/rules.idleTimeout` <br> _(duration)_ <br> Idle timeout for HTTP connection. <br> Example: `300s` |
| `gwin.yandex.cloud/rules.http.upgradeTypes` <br> _(comma separated strings)_ <br> Supported HTTP Upgrade header values. <br> Example: `websocket` |
| `gwin.yandex.cloud/rules.allowedMethods` <br> _(comma separated strings)_ <br> Restricts which HTTP methods are allowed for this route. If not specified, all methods are allowed. <br> Example: `GET,POST,PUT` |
| `gwin.yandex.cloud/rules.prefixRewrite` <br> _(string)_ <br> Replaces URL paths in HTTP/gRPC requests. With pathType Exact, the entire path is replaced; with pathType Prefix, only the matching prefix is rewritten. <br> Example: `/new-prefix` |

#### Header modification

Header modifications are applied in the following order: append, rename, replace, remove.

##### Request header modifications

| Annotation and description |
|------------|
| `gwin.yandex.cloud/rules.modifyRequestHeaders.append.{header-name}` <br> _(string)_ <br> Adds a new request header with the specified value. <br> Example: `custom-value` |
| `gwin.yandex.cloud/rules.modifyRequestHeaders.rename.{old-header-name}` <br> _(string)_ <br> Renames an existing request header to the specified new name. <br> Example: `New-Header-Name` |
| `gwin.yandex.cloud/rules.modifyRequestHeaders.replace.{header-name}` <br> _(string)_ <br> Replaces the value of an existing request header or creates a new one. <br> Example: `new-value` |
| `gwin.yandex.cloud/rules.modifyRequestHeaders.remove` <br> _(comma separated strings)_ <br> Removes the specified request headers. <br> Example: `X-Remove-Me,X-Also-Remove` |

##### Response header modifications

| Annotation and description |
|------------|
| `gwin.yandex.cloud/rules.modifyResponseHeaders.append.{header-name}` <br> _(string)_ <br> Adds a new response header with the specified value. <br> Example: `custom-value` |
| `gwin.yandex.cloud/rules.modifyResponseHeaders.rename.{old-header-name}` <br> _(string)_ <br> Renames an existing response header to the specified new name. <br> Example: `New-Header-Name` |
| `gwin.yandex.cloud/rules.modifyResponseHeaders.replace.{header-name}` <br> _(string)_ <br> Replaces the value of an existing response header or creates a new one. <br> Example: `new-value` |
| `gwin.yandex.cloud/rules.modifyResponseHeaders.remove` <br> _(comma separated strings)_ <br> Removes the specified response headers. <br> Example: `Server,X-Powered-By` |

#### Redirect actions

Redirect actions can be referenced by Ingress path backends using `kind: Redirect` and `name: {redirect-name}`.

**Example**: Redirect HTTP traffic to HTTPS with a different host:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: redirect-example
  annotations:
    # Define redirect action
    gwin.yandex.cloud/redirect.https-redirect.replaceScheme: "https"
    gwin.yandex.cloud/redirect.https-redirect.replaceHost: "secure.example.com"
    gwin.yandex.cloud/redirect.https-redirect.responseCode: "301"
spec:
  ingressClassName: gwin
  rules:
    - host: "example.com"
      http:
        paths:
          - path: "/"
            pathType: Prefix
            backend:
              resource:
                kind: Redirect
                name: https-redirect  # References the redirect action above
```

This example redirects all HTTP requests from `http://example.com/*` to `https://secure.example.com/*` with a 301 (permanent redirect) status code.

| Annotation and description |
|------------|
| `gwin.yandex.cloud/redirect.{name}.replaceScheme` <br> _(string)_ <br> Changes the URL scheme (http/https) in the redirect location. <br> Example: `https` |
| `gwin.yandex.cloud/redirect.{name}.replaceHost` <br> _(string)_ <br> Changes the hostname in the redirect location. <br> Example: `new-host.com` |
| `gwin.yandex.cloud/redirect.{name}.replacePort` <br> _(number)_ <br> Changes the port number in the redirect location. <br> Example: `443` |
| `gwin.yandex.cloud/redirect.{name}.path.replacePath` <br> _(string)_ <br> Replaces the entire path with the specified value. <br> Example: `/new-path` |
| `gwin.yandex.cloud/redirect.{name}.path.replacePrefix` <br> _(string)_ <br> Replaces the matching path prefix with the specified value. <br> Example: `/new-prefix` |
| `gwin.yandex.cloud/redirect.{name}.removeQuery` <br> _(boolean)_ <br> Determines whether to remove query parameters from the redirect URL. <br> Example: `true` |
| `gwin.yandex.cloud/redirect.{name}.responseCode` <br> _(number)_ <br> HTTP status code for the redirect response (e.g., 301, 302, 303, 307, 308). <br> Example: `301` |

#### Direct response actions

Direct response actions can be referenced by Ingress path backends using `kind: DirectResponse` and `name: {response-name}`.

| Annotation and description |
|------------|
| `gwin.yandex.cloud/directResponse.{name}.responseCode` <br> _(number)_ <br> HTTP status code to return in the direct response. <br> Example: `200` |
| `gwin.yandex.cloud/directResponse.{name}.responseBody.text` <br> _(string)_ <br> Plain text content to include in the response. body <br> Example: `Hello World` |

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

## IngressSpec

IngressSpec describes the Ingress the user wishes to exist.

*Appears in*: [Ingress](#ingress)

| Field | Description |
|-------|-------------|
| ingressClassName | **string** <br> IngressClassName is the name of the IngressClass cluster resource. For Gwin, use `gwin`. <br> Example: `gwin` |
| defaultBackend | **[IngressBackend](#ingressbackend)** <br> DefaultBackend is the backend that should handle requests that don't match any rule. |
| tls | **[[]IngressTLS](#ingresstls)** <br> TLS configuration. |
| rules | **[[]IngressRule](#ingressrule)** <br> List of host rules used to configure the Ingress. |

### IngressRule

IngressRule represents the rules mapping the paths under a specified host to the related backend services.

*Appears in*: [IngressSpec](#ingressspec)

| Field | Description |
|-------|-------------|
| host | **string** <br> Host is the fully qualified domain name of a network host. <br> Example: `example.com` |
| http | **[HTTPIngressRuleValue](#httpingressrulevalue)** <br> HTTP represents a rule to apply against incoming requests. |

### HTTPIngressRuleValue

HTTPIngressRuleValue is a list of http selectors pointing to backends.

*Appears in*: [IngressRule](#ingressrule)

| Field | Description |
|-------|-------------|
| paths | **[[]HTTPIngressPath](#httpingresspath)** <br> Paths is a collection of paths that map requests to backends. |

### HTTPIngressPath

HTTPIngressPath associates a path with a backend.

*Appears in*: [HTTPIngressRuleValue](#httpingressrulevalue)

| Field | Description |
|-------|-------------|
| path | **string** <br> Path is matched against the path of an incoming request. For `ImplementationSpecific` pathType, this would be a regular expression. <br> Example: `/api` or `/regex.*` |
| pathType | **string** <br> PathType determines the interpretation of the Path matching. `Exact` for exact match, `Prefix` for prefix match, or `ImplementationSpecific` for regex matching. <br> Example: `Prefix` |
| backend | **[IngressBackend](#ingressbackend)** <br> Backend defines the referenced service endpoint to which the traffic will be forwarded. |

### IngressBackend

IngressBackend describes all endpoints for a given service and port.

*Appears in*: [IngressSpec](#ingressspec), [HTTPIngressPath](#httpingresspath)

| Field | Description |
|-------|-------------|
| service | **[IngressServiceBackend](#ingressservicebackend)** <br> Service references a Service as a Backend. |
| resource | **[TypedLocalObjectReference](#typedlocalobjectreference)** <br> Resource is an ObjectRef to another Kubernetes resource in the same namespace. Can reference [IngressBackendGroup](./ingressbackendgroup.md), [YCStorageBucket](./ycstoragebucket.md), `Redirect` or `DirectResponse` |

### TypedLocalObjectReference

Reference to a typed Kubernetes resource in the same namespace.

*Appears in*: [IngressBackend](#ingressbackend)

| Field | Description |
|-------|-------------|
| apiGroup | **string** <br> API group of the referenced resource <br> Example: `gwin.yandex.cloud` |
| kind | **string** <br> Kind of the referenced resource <br> Example: `IngressBackendGroup`, `YCStorageBucket`, `Redirect`, `DirectResponse` |
| name | **string** <br> Name of the referenced resource <br> Example: `static-backend-group` |
| apiGroup | **string** <br> API group of the referenced resource. <br> Example: `gwin.yandex.cloud` |
| kind | **string** <br> Kind of the referenced resource. <br> Example: `IngressBackendGroup`, `YCStorageBucket`, `Redirect`, `DirectResponse` |
| name | **string** <br> Name of the referenced resource. <br> Example: `static-backend-group` |

### IngressServiceBackend

IngressServiceBackend references a Kubernetes Service as a Backend.

*Appears in*: [IngressBackend](#ingressbackend)

| Field | Description |
|-------|-------------|
| name | **string** <br> Name is the referenced service. <br> Example: `api-service` |
| port | **[ServiceBackendPort](#servicebackendport)** <br> Port of the referenced service. |

### ServiceBackendPort

ServiceBackendPort is the service port being referenced.

*Appears in*: [IngressServiceBackend](#ingressservicebackend)

| Field | Description |
|-------|-------------|
| name | **string** <br> Name is the name of the port on the Service. <br> Example: `http` |
| number | **int32** <br> Number is the numerical port number on the Service. <br> Example: `8080` |

### IngressTLS

IngressTLS describes the transport layer security associated with an Ingress.

*Appears in*: [IngressSpec](#ingressspec)

| Field | Description |
|-------|-------------|
| hosts | **[]string** <br> Hosts are a list of hosts included in the TLS certificate. <br> Example: `["example.com"]` |
| secretName | **string** <br> SecretName is the name of the secret used to terminate TLS traffic. For Yandex Cloud certificates, use format `yc-certmgr-cert-id-{certificate-id}`. <br> Example: `yc-certmgr-cert-id-fpq6gvvm6piu********` |
