# IngressBackendGroup

IngressBackendGroup is a Gwin custom resource for configuring backend groups in Yandex Application Load Balancer. It allows you to define backend targets, health checks, load balancing settings, and session affinity for your applications. It used as [Ingress](./ingress.md) backend.

* [Cheatsheet](#cheatsheet)
* [IngressBackendGroupSpec](#ingressbackendgroupspec)
  * [IngressBackend](#ingressbackend)
  * [BackendObjectReference](#backendobjectreference)
  * [HealthCheck](#healthcheck)
  * [HealthCheckTransportSettings](#healthchecktransportsettings)
  * [HealthcheckHTTP](#healthcheckhttp)
  * [HealthcheckGRPC](#healthcheckgrpc)
  * [HealthcheckStream](#healthcheckstream)
  * [HTTPBackend](#httpbackend)
  * [GRPCBackend](#grpcbackend)
  * [StreamBackend](#streambackend)
  * [LoadBalancingConfig](#loadbalancingconfig)
  * [SessionAffinity](#sessionaffinity)
  * [BackendTLS](#backendtls)
* [IngressBackendGroupStatus](#ingressbackendgroupstatus)

## Cheatsheet

{% note info %}

Specification provided below is not valid configuration.

It's just demonstration of all `IngressBackendGroup` fields.

{% endnote %}

```yaml
apiVersion: gwin.yandex.cloud/v1
kind: IngressBackendGroup
metadata:
  name: example-backend-group
  namespace: example-ns
spec:
  # Type of the backend group (HTTP, GRPC or STREAM)
  type: HTTP
  # Session affinity configuration
  sessionAffinity:
    connection:
      sourceIP: true
    cookie:
      name: "session-cookie"
      ttl: "3600s"
    header:
      name: "X-Session-ID"
  # List of backends
  backends:
    - name: "primary-backend"
      weight: 80
      backendRef:
        name: primary-service
        port: 8080
      # HTTP-specific settings
      http:
        useHTTP2: true
      # Health check configuration with transport settings
      hc:
        timeout: "5s"
        interval: "10s"
        healthyThreshold: 2
        unhealthyThreshold: 3
        port: 8080
        # HTTP health check
        http:
          host: "health.example.com"
          path: "/health"
          useHTTP2: false
          expectedStatuses: [200, 202]
        # Transport settings for health checks
        transportSettings:
          # Use plaintext for health checks even if backend uses TLS
          plaintext: true
          # Or configure TLS settings for health checks
          tls:
            sni: "health.example.com"
            trustedCA:
              id: "certificate-id"
              # or bytes: "-----BEGIN CERTIFICATE-----..."
      # Load balancing configuration
      balancing:
        panicThreshold: 50
        localityAwareRouting: 90
        strictLocality: false
        mode: "ROUND_ROBIN"
      # TLS settings for backend connections
      tls:
        sni: "backend.example.com"
        trustedCA:
          id: "backend-cert-id"
    - name: "secondary-backend"
      weight: 20
      backendRef:
        name: secondary-service
        port: 9090
      # gRPC-specific settings
      grpc: {}
      # gRPC health check
      hc:
        timeout: "3s"
        interval: "15s"
        grpc:
          serviceName: "health.v1.HealthService"
        # Use same transport as backend
        transportSettings:
          tls:
            sni: "grpc.example.com"
            trustedCA:
              bytes: "-----BEGIN CERTIFICATE-----\n...\n-----END CERTIFICATE-----"
status:
  conditions: ...
```

| Field | Description |
|-------|-------------|
| metadata | **ObjectMeta** <br> Standard Kubernetes metadata. |
| spec | **[IngressBackendGroupSpec](#ingressbackendgroupspec)** <br> Backend group specification. |
| status | **[IngressBackendGroupStatus](#ingressbackendgroupstatus)** <br> Backend group status. |

## IngressBackendGroupSpec

IngressBackendGroupSpec defines the desired state of IngressBackendGroup.

*Appears in*: [IngressBackendGroup](#ingressbackendgroup)

| Field | Description |
|-------|-------------|
| type | **string** <br> Type of the backend group. Enum: `HTTP`, `GRPC`, `STREAM`. <br> Example: `HTTP` |
| sessionAffinity | **[SessionAffinity](#sessionaffinity)** <br> Session affinity configuration for the backend group <br> For details about the concept, see [documentation](https://yandex.cloud/en/docs/application-load-balancer/concepts/backend-group#session-affinity). |
| backends | **[[]IngressBackend](#ingressbackend)** <br> List of backends that the backend group consists of. Minimum: 1 backend required. |

### IngressBackend

IngressBackend defines a backend configuration for load balancing.

*Appears in*: [IngressBackendGroupSpec](#ingressbackendgroupspec)

| Field | Description |
|-------|-------------|
| name | **string** <br> Name of the backend. Pattern: `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. <br> Example: `primary-backend` |
| weight | **int32** <br> Weight of the backend for load balancing. Default: `1`. <br> Example: `80` |
| backendRef | **[BackendObjectReference](#backendobjectreference)** <br> Reference to the Kubernetes service. <br> Example: `{name: "my-service", port: 8080}` |
| http | **[HTTPBackend](#httpbackend)** <br> HTTP-specific backend settings. |
| grpc | **[GRPCBackend](#grpcbackend)** <br> gRPC-specific backend settings. |
| stream | **[StreamBackend](#streambackend)** <br> TCP stream-specific backend settings. |
| balancing | **[LoadBalancingConfig](#loadbalancingconfig)** <br> Load balancing configuration for the backend. |
| hc | **[HealthCheck](#healthcheck)** <br> Health check configuration. |
| tls | **[BackendTLS](#backendtls)** <br> TLS settings for backend connections. |

### BackendObjectReference

Reference to a Kubernetes Service that serves as a backend.

*Appears in*: [IngressBackend](#ingressbackend)

| Field | Description |
|-------|-------------|
| group | **string** <br> API group of the backend resource. Empty string for core Kubernetes resources. <br> Example: `""` |
| kind | **string** <br> Kind of the backend resource. <br> Example: `Service` |
| name | **string** <br> Name of the backend service. <br> Example: `my-service` |
| namespace | **string** <br> Namespace of the backend service. <br> Example: `my-namespace` |
| port | **int32** <br> Port number of the backend service. <br> Example: `8080` |

### HealthCheck

Health check configuration allows you to monitor the health of your backend targets. The `transportSettings` field is particularly useful when your health checks need different protocol settings than your backend traffic.

*Appears in*: [IngressBackend](#ingressbackend)

| Field | Description |
|-------|-------------|
| timeout | **duration** <br> Health check timeout — time allowed for the target to respond. <br> Example: `5s` |
| interval | **duration** <br> Base interval between consecutive health checks. <br> Example: `10s` |
| healthyThreshold | **int** <br> Number of consecutive successful checks to mark target as healthy. Default: `0`. (1 check required) <br> Example: `2` |
| unhealthyThreshold | **int** <br> Number of consecutive failed checks to mark target as unhealthy. Default: `0`. (1 check required) <br> Example: `3` |
| port | **int** <br> Port used for health checks. If not specified, backend port is used. <br> Example: `8080` |
| http | **[HealthcheckHTTP](#healthcheckhttp)** <br> HTTP-specific health check settings. |
| grpc | **[HealthcheckGRPC](#healthcheckgrpc)** <br> gRPC-specific health check settings. |
| stream | **[HealthcheckStream](#healthcheckstream)** <br> TCP stream-specific health check settings. |
| transportSettings | **[HealthCheckTransportSettings](#healthchecktransportsettings)** <br> Optional transport protocol for health checks. |

### HealthCheckTransportSettings

The `transportSettings` field allows you to configure different transport protocols for health checks than what your backend uses. This is particularly useful in scenarios like:

* **Plaintext health checks for TLS backends**: your backend serves HTTPS traffic, but you want simple HTTP health checks.
* **Different TLS settings**: your health check endpoint uses different certificates or SNI than your main backend.
* **Protocol isolation**: separate health check traffic from application traffic.

*Appears in*: [HealthCheck](#healthcheck)

| Field | Description |
|-------|-------------|
| plaintext | **bool** <br> Use plaintext protocol for health checks. Set to `true` to force HTTP health checks even for HTTPS backends. <br> Example: `true` |
| tls | **[BackendTLS](#backendtls)** <br> TLS settings for health checks. Use when health checks require different TLS configuration than backend. |

### HealthcheckHTTP

*Appears in*: [HealthCheck](#healthcheck)

| Field | Description |
|-------|-------------|
| host | **string** <br> Value for the HTTP/1.1 `Host` header or HTTP/2 `:authority` pseudo-header. <br> Example: `health.example.com` |
| path | **string** <br> HTTP path used in requests to targets. <br> Example: `/health` |
| useHTTP2 | **bool** <br> Enables HTTP/2 usage in health checks. Default: `false`. <br> Example: `true` |
| expectedStatuses | **[]int** <br> List of HTTP response statuses considered healthy. Default: `[200]`. <br> Example: `[200, 202, 204]` |

### HealthcheckGRPC

*Appears in*: [HealthCheck](#healthcheck)

| Field | Description |
|-------|-------------|
| serviceName | **string** <br> Name of the gRPC service to be checked. If not specified, overall health is checked. See [gRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). <br> Example: `health.v1.HealthService` |

### HealthcheckStream

*Appears in*: [HealthCheck](#healthcheck)

| Field | Description |
|-------|-------------|
| send | **string** <br> Message sent to targets during TCP data transfer. If not specified, no data is sent <br> Example: `PING` |
| receive | **string** <br> Data that must be contained in received messages for successful health check. If not specified, no messages are expected <br> Example: `PONG` |

### HTTPBackend

*Appears in*: [IngressBackend](#ingressbackend)

| Field | Description |
|-------|-------------|
| useHTTP2 | **bool** <br> Enables HTTP/2 usage in connections between load balancer nodes and backend targets. Default: `false` (HTTP/1.1 is used). <br> Example: `true` |

### GRPCBackend

*Appears in*: [IngressBackend](#ingressbackend)

Reserved for future gRPC-specific settings.

### StreamBackend

*Appears in*: [IngressBackend](#ingressbackend)

| Field | Description |
|-------|-------------|
| enableProxy | **bool** <br> If set, proxy protocol will be enabled for this backend. <br> Example: `true` |
| keepConnectionsOnHostHealthFailure | **bool** <br> If a backend host becomes unhealthy, keep connections to the failed host. <br> Example: `false` |

### LoadBalancingConfig

*Appears in*: [IngressBackend](#ingressbackend)

| Field | Description |
|-------|-------------|
| panicThreshold | **int** <br> Threshold for [panic mode](https://yandex.cloud/en/docs/application-load-balancer/concepts/backend-group#panic-mode) (percentage). If healthy backends drop below this threshold, traffic routes to all backends. Set to `0` to disable panic mode. <br> Example: `50` |
| localityAwareRouting | **int** <br> Percentage of traffic sent to backends in the same [availability zone](https://yandex.cloud/en/docs/overview/concepts/geo-scope). Remaining traffic is divided equally between other zones. For details about zone-aware routing, see [documentation](https://yandex.cloud/en/docs/application-load-balancer/concepts/backend-group#locality). <br> Example: `90` |
| strictLocality | **bool** <br> Send traffic only to backends in the same [availability zone](https://yandex.cloud/en/docs/overview/concepts/geo-scope). If `true`, `localityAwareRouting` is ignored. For details about strict locality, see [documentation](https://yandex.cloud/en/docs/application-load-balancer/concepts/backend-group#locality). <br> Example: `false` |
| mode | **string** <br> [Load balancing mode](https://yandex.cloud/en/docs/application-load-balancer/concepts/backend-group#balancing-mode). Options: `ROUND_ROBIN`, `LEAST_REQUEST`, `RANDOM`, `RING_HASH`, `MAGLEV_HASH`. <br> Example: `ROUND_ROBIN` |

### SessionAffinity

Session affinity ensures that requests from the same client are routed to the same backend. For session affinity to work properly:
* Backend group should contain exactly one active backend with positive weight.
* Load balancing mode should be `MAGLEV_HASH`.

*Appears in*: [IngressBackendGroupSpec](#ingressbackendgroupspec)

| Field | Description |
|-------|-------------|
| connection | **[SessionAffinityConnection](#sessionaffinityconnection)** <br> Connection-based session affinity (by client IP). |
| cookie | **[SessionAffinityCookie](#sessionaffinitycookie)** <br> Cookie-based session affinity. |
| header | **[SessionAffinityHeader](#sessionaffinityheader)** <br> HTTP header-based session affinity. |

#### SessionAffinityConnection

*Appears in*: [SessionAffinity](#sessionaffinity)

| Field | Description |
|-------|-------------|
| sourceIP | **bool** <br> Use client IP address for session affinity. <br> Example: `true` |

#### SessionAffinityCookie

*Appears in*: [SessionAffinity](#sessionaffinity)

| Field | Description |
|-------|-------------|
| name | **string** <br> Name of the cookie used for session affinity. <br> Example: `session-cookie` |
| ttl | **duration** <br> Maximum age of generated session cookies. Set to `0` for session cookies (deleted on client restart). If not set, balancer only uses incoming cookies. <br> Example: `3600s` |

#### SessionAffinityHeader

*Appears in*: [SessionAffinity](#sessionaffinity)

| Field | Description |
|-------|-------------|
| name | **string** <br> Name of the HTTP header field used for session affinity. <br> Example: `X-Session-ID` |

### BackendTLS

TLS settings for backend connections. \
Use when the load balancer must connect to its targets over TLS. \
If you only need “TLS as is” (no SNI and no backend certificate verification), provide an empty `tls: {}` section.
Health check TLS settings work the same way, but are configured separately.

*Appears in*: [IngressBackend](#ingressbackend), [HealthCheckTransportSettings](#healthchecktransportsettings)

| Field | Description |
|-------|-------------|
| sni | **string** <br> Server Name Indication (SNI) string for TLS connections. <br> Example: `backend.example.com` |
| trustedCA | **[BackendTLSTrustedCA](#backendtlstrustedca)** <br> Validation context for TLS connections. |

#### BackendTLSTrustedCA

*Appears in*: [BackendTLS](#backendtls)

| Field | Description |
|-------|-------------|
| id | **string** <br> Cloud certificate ID. <br> Example: `fpq6gvvm6piu********` |
| bytes | **string** <br> X.509 certificate contents in PEM format. <br> Example: `-----BEGIN CERTIFICATE-----\n...\n-----END CERTIFICATE-----` |

## IngressBackendGroupStatus

IngressBackendGroupStatus defines the observed state of IngressBackendGroup.

*Appears in*: [IngressBackendGroup](#ingressbackendgroup)

| Field | Description |
|-------|-------------|
| conditions | **[]Condition** <br> Current state conditions of the backend group. |
