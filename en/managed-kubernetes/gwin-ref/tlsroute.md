# TLSRoute

TLSRoute provides a way to route TLS requests. This includes the capability to match requests by hostname and route them to backend services. TLSRoute is used for TCP traffic that is encrypted with TLS.

TLSRoute use only hosts with SNI matches to route traffic. Unlike [HTTPRoute](./httproute.md) and [GRPCRoute](./grpcroute.md) which use URLs, headers and more.

TLSRoute is a [Kubernetes Gateway API](https://gateway-api.sigs.k8s.io/) project resource. Below, we describe its fields and annotations used by Gwin. For configuration details, see the [upstream documentation](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io/v1alpha2.TLSRoute).

TLSRoute resources must be attached to [Gateway](./gateway.md) resources to function properly.

* [Cheatsheet](#cheatsheet)
* [TLSRouteMeta](#tlsroutemeta)
  * [Annotations cheatsheet](#annotations-cheatsheet)
  * [Annotations reference](#annotations-reference)
* [TLSRouteSpec](#tlsroutespec)
  * [ParentReference](#parentreference)
  * [TLSRouteRule](#tlsrouterule)
  * [BackendRef](#backendref)

## Cheatsheet

{% note info %}

Specification provided below is not valid configuration.

It's just demonstration of all `TLSRoute` fields.

{% endnote %}

```yaml
apiVersion: gateway.networking.k8s.io/v1alpha2
kind: TLSRoute
metadata:
  name: example-tls-route
  namespace: example-ns
  annotations: ...  # see annotations example below
spec:
  parentRefs:  # attach to Gateway resources
    - group: gateway.networking.k8s.io
      kind: Gateway
      namespace: gateway-ns
      name: example-gateway
      sectionName: tls-listener  # specific listener name
  hostnames:  # domains this route handles
    - "secure.example.com"  # TLS service domain
    - "api.example.com"     # API domain
  rules:
    - name: tls-rule  # rule identifier
      backendRefs:  # where to route requests
        - group: ""  # core Kubernetes API
          kind: Service  # Kubernetes service
          name: tls-service
          namespace: tls-ns
          port: 8443
          weight: 80  # 80% of traffic
```

| Field | Description |
|-------|-------------|
| metadata | **[TLSRouteMeta](#tlsroutemeta)** <br> Name, namespace and annotations. |
| spec | **[TLSRouteSpec](#tlsroutespec)** <br> Resource specification. |

## TLSRouteMeta

*Appears in:* [TLSRoute](#cheatsheet)

| Field | Description |
|-------|-------------|
| name | **string** <br> Name of the TLSRoute. |
| namespace | **string** <br> Namespace of the TLSRoute. |
| annotations | **map[string]string** <br> Annotations of the TLSRoute. |

### Annotations cheatsheet

{% note info %}

You can also set policy parameters using [RoutePolicy](./routepolicy.md) resource. The RoutePolicy resource parameters and TLSRoute annotations are equivalent.

{% endnote %}

Specification provided below is not valid configuration.It's just demonstration of all `TLSRoute` annotations.

```yaml
apiVersion: gateway.networking.k8s.io/v1alpha2
kind: TLSRoute
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
    gwin.yandex.cloud/rules.backends.hc.port: "8443"  # health check port
  
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
| `gwin.yandex.cloud/rules.backends.hc.port` <br> _(number)_ <br> Port for health checks. <br> Example: `8443` |

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

TLS settings for backend connections. \
Use when the load balancer must connect to its targets over TLS. \
If you only need “TLS as is” (no SNI and no backend certificate verification), set `gwin.yandex.cloud/rules.backends.tls.sni: ""`. \
Health check TLS settings work the same way, but are configured separately.

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

## TLSRouteSpec

TLSRoute specification defines the desired state of TLSRoute.

*Appears in:* [TLSRoute](#cheatsheet)

| Field | Description |
|-------|-------------|
| parentRefs | **[[]ParentReference](#parentreference)** <br> References to Gateway resources that this TLSRoute should attach to. |
| hostnames | **[]string** <br> Hostnames that should match against the TLS Server Name Indication (SNI). |
| rules | **[[]TLSRouteRule](#tlsrouterule)** <br> Rules for routing TLS requests. |

### ParentReference

Reference to a Gateway resource that this route should attach to.

*Appears in:* [TLSRouteSpec](#tlsroutespec)

| Field | Description |
|-------|-------------|
| group | **string** <br> API group of the parent resource. <br> Example: `gateway.networking.k8s.io` |
| kind | **string** <br> Kind of the parent resource. <br> Example: `Gateway` |
| namespace | **string** <br> Namespace of the parent resource. <br> Example: `gateway-ns` |
| name | **string** <br> Name of the parent resource. <br> Example: `example-gateway` |
| sectionName | **string** <br> Name of the specific listener to attach to. <br> Example: `tls-listener` |
| port | **int32** <br> Port number of the listener to attach to. <br> Example: `443` |

### TLSRouteRule

TLSRouteRule defines semantics for forwarding TLS requests to backend services.

*Appears in:* [TLSRouteSpec](#tlsroutespec)

| Field | Description |
|-------|-------------|
| name | **string** <br> Name of the route rule. Must be unique within a Route if set. <br> Example: `tls-rule` |
| backendRefs | **[[]BackendRef](#backendref)** <br> Backend services to route requests to. |

### BackendRef

BackendRef defines how a TLSRoute forwards a TLS request.

*Appears in:* [TLSRouteRule](#tlsrouterule)

| Field | Description |
|-------|-------------|
| group | **string** <br> API group of the backend resource. <br> Example: `""`, `gwin.yandex.cloud`. |
| kind | **string** <br> Kind of the backend resource. <br> Example: `Service` |
| name | **string** <br> Name of the backend resource. <br> Example: `tls-service` |
| namespace | **string** <br> Namespace of the backend resource. <br> Example: `tls-ns` |
| port | **int32** <br> Port of the backend service (for Service kind only). <br> Example: `8443` |
| weight | **int32** <br> Weight for traffic distribution between backends. <br> Example: `80` |
