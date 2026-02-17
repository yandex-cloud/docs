# GatewayPolicy

GatewayPolicy is a Gwin custom resource for configuring gateway-level policies in Yandex Application Load Balancer. It allows you to define load balancer settings, logging configuration, autoscaling, listener settings, and HTTP router options that apply to Gateway resources.

* [Cheatsheet](#cheatsheet)
* [GatewayPolicySpec](#gatewaypolicyspec)
  * [LocalObjectReference](#localobjectreference)
  * [LabelSelector](#labelselector)
  * [LabelSelectorRequirement](#labelselectorrequirement)
  * [Gateway](#gateway)
  * [AutoScalePolicy](#autoscalepolicy)
  * [BalancerZone](#balancerzone)
  * [LogOptions](#logoptions)
  * [LogDiscardRule](#logdiscardrule)
  * [GatewayListener](#gatewaylistener)
  * [Listener](#listener)
  * [ListenerHTTP](#listenerhttp)
  * [HTTPProtocolSettings](#httpprotocolsettings)
  * [HTTP2Options](#http2options)
  * [ListenerStream](#listenerstream)
  * [RouteOptions](#routeoptions)
  * [RBAC](#rbac)
  * [Principal](#principal)
  * [HeaderPrincipal](#headerprincipal)
  * [IPPrincipal](#ipprincipal)
* [GatewayPolicyStatus](#gatewaypolicystatus)

## Cheatsheet

{% note info %}

Specification provided below is not valid configuration.

It's just demonstration of all `GatewayPolicy` fields.

{% endnote %}

```yaml
apiVersion: gwin.yandex.cloud/v1
kind: GatewayPolicy
metadata:
  name: example-gateway-policy
  namespace: example-ns
spec:
  # Target Gateway resources
  targetRefs:
    - group: gateway.networking.k8s.io
      kind: Gateway
      name: example-gateway
  # Or use label selector
  selector:
    matchLabels:
      app: my-gateway
    matchExpressions:
      - key: environment
        operator: In
        values: ["production", "staging"]
  # Gateway policy configuration
  policy:
    # Load balancer configuration
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
    
    # Listener configuration (applies to all listeners)
    listeners:
      http:
        protocolSettings:
          allowHTTP10: true  # support old HTTP
          http2Options:
            maxConcurrentStreams: 100  # limit connections
      stream:
        idleTimeout: "300s"  # close idle connections
      # HTTP router configuration
      rbac:
        action: "ALLOW"  # access control policy
        principals:
          admin:  # principal group
            check-token:  # principal name
              header:
                name: "X-Api-Token"
                exact: "admin123"
            check-ip:
              ip:
                remoteIp: "10.0.0.0/8"
    
    # Specific listener configuration
    listener:
      http-listener:  # listener name
        http:
          protocolSettings:
            allowHTTP10: true  # per-listener HTTP setting
      stream-listener:
        stream:
          idleTimeout: "300s"  # per-listener timeout
status:
  conditions:
    - type: "Ready"
      status: "True"
      reason: "PolicyApplied"
  attachedGateways: 2
```

| Field | Description |
|-------|-------------|
| metadata | **ObjectMeta** <br> Standard Kubernetes metadata. |
| spec | **[GatewayPolicySpec](#gatewaypolicyspec)** <br> Gateway policy specification. |
| status | **[GatewayPolicyStatus](#gatewaypolicystatus)** <br> Gateway policy status. |

## GatewayPolicySpec

GatewayPolicySpec defines the desired state of GatewayPolicy.

*Appears in*: [GatewayPolicy](#gatewaypolicy)

| Field | Description |
|-------|-------------|
| targetRefs | **[[]LocalObjectReference](#localobjectreference)** <br> References to Gateway resources that this policy should apply to. |
| selector | **LabelSelector** <br> Label selector for Gateway resources that this policy should apply to. |
| policy | **[Gateway](#gateway)** <br> Gateway policy configuration. |

### LocalObjectReference

Reference to a Kubernetes resource in the same namespace.

*Appears in*: [GatewayPolicySpec](#gatewaypolicyspec)

| Field | Description |
|-------|-------------|
| group | **string** <br> API group of the referenced resource. <br> Example: `gateway.networking.k8s.io` |
| kind | **string** <br> Kind of the referenced resource. <br> Example: `Gateway` |
| name | **string** <br> Name of the referenced resource. <br> Example: `my-gateway` |

### LabelSelector

Label-based selection criteria for resources.

*Appears in*: [GatewayPolicySpec](#gatewaypolicyspec)

| Field | Description |
|-------|-------------|
| matchLabels | **map[string]string** <br> Simple label matching requirements. <br> Example: `app: my-app` |
| matchExpressions | **[[]LabelSelectorRequirement](#labelselectorrequirement)** <br> Advanced label matching expressions. |

### LabelSelectorRequirement

Advanced label matching expression with operator and values.

*Appears in*: [LabelSelector](#labelselector)

| Field | Description |
|-------|-------------|
| key | **string** <br> Label key to match. <br> Example: `app` |
| operator | **string** <br> Matching operator. <br> Example: `In`, `NotIn`, `Exists`. |
| values | **[]string** <br> Values to match against. <br> Example: `["my-app"]` |

### Gateway

Gateway policy configuration that applies to load balancer and listener settings.

*Appears in*: [GatewayPolicySpec](#gatewaypolicyspec)

| Field | Description |
|-------|-------------|
| subnets | **[]string** <br> [Subnets](https://yandex.cloud/en/docs/vpc/concepts/network#subnet) of the zones where load balancer will be instantiated. <br> Example: `["subnet-id-1", "subnet-id-2"]` |
| securityGroups | **[]string** <br> [Security groups](https://yandex.cloud/en/docs/vpc/concepts/security-groups) of load balancer. <br> Example: `["sg-id-1", "sg-id-2"]` |
| logs | **[LogOptions](#logoptions)** <br> [Cloud Logging](https://yandex.cloud/en/docs/logging/) settings of the application load balancer. |
| autoScale | **[AutoScalePolicy](#autoscalepolicy)** <br> [Autoscaling](https://yandex.cloud/en/docs/application-load-balancer/concepts/application-load-balancer#lcu-scaling) settings of the application load balancer. |
| zone | **map[string][BalancerZone](#balancerzone)** <br> Zone-specific traffic control settings. |
| allowZonalShift | **bool** <br> Specifies whether application load balancer is available to zonal shift. <br> Example: `true` |
| listener | **map[string][GatewayListener](#gatewaylistener)** <br> Specific listener configuration by listener name. |
| listeners | **[GatewayListener](#gatewaylistener)** <br> Common listener configuration for all listeners. |

### AutoScalePolicy

Scaling settings of the application load balancer. The scaling settings relate to a special internal instance group which facilitates the balancer's work. Instances in this group are called resource units.

*Appears in*: [Balancer](#balancer)

| Field | Description |
|-------|-------------|
| minZoneSize | **int** <br> Lower limit for the number of [resource units](https://yandex.cloud/en/docs/application-load-balancer/concepts/application-load-balancer#lcu-scaling) in each [availability zone](https://yandex.cloud/en/docs/overview/concepts/geo-scope). The minimum value is 2. <br> Example: `2` |
| maxSize | **int** <br> Upper limit for the total number of [resource units](https://yandex.cloud/en/docs/application-load-balancer/concepts/application-load-balancer#lcu-scaling) across all availability zones. If the value is 0, there is no upper limit. <br> Example: `10` |

### BalancerZone

Zone-specific traffic control settings.

*Appears in*: [Balancer](#balancer)

| Field | Description |
|-------|-------------|
| receiveTraffic | **bool** <br> Enables the load balancer node in the specified [availability zone](https://yandex.cloud/en/docs/overview/concepts/geo-scope). <br> Example: `true` |

### LogOptions

Cloud logging settings of the application load balancer.

*Appears in*: [Balancer](#balancer)

| Field | Description |
|-------|-------------|
| logGroupID | **string** <br> [Cloud Logging](https://yandex.cloud/en/docs/logging/) log group ID to store [access logs](https://yandex.cloud/en/docs/application-load-balancer/logs-ref). If not set then logs will be stored in default log group for the folder where load balancer located. <br> Example: `log-group-id-1` |
| disable | **bool** <br> Do not send logs to [Cloud Logging](https://yandex.cloud/en/docs/logging/) log group. <br> Example: `false` |
| discardRule | **map[string][LogDiscardRule](#logdiscardrule)** <br> Log discard rules where each key represents a user-defined ID. |

### LogDiscardRule

Log discard rule configuration.

*Appears in*: [LogOptions](#logoptions)

| Field | Description |
|-------|-------------|
| httpCodes | **[]int** <br> HTTP codes that should be discarded. <br> Example: `[404, 500]` |
| httpCodeIntervals | **[]string** <br> Groups of HTTP codes like 4xx that should be discarded. <br> Example: `["HTTP_4XX", "HTTP_5XX"]` |
| grpcCodes | **[]string** <br> gRPC codes that should be discarded. <br> Example: `["INTERNAL", "UNIMPLEMENTED"]` |
| discardPercent | **int** <br> Percent of logs to be discarded: 0 — keep all, 100 — discard all. <br> Example: `10` |

### GatewayListener

Gateway listener configuration that combines listener and HTTP router settings.

*Appears in*: [Gateway](#gateway)

| Field | Description |
|-------|-------------|
| http | **[ListenerHTTP](#listenerhttp)** <br> HTTP specific listener settings. |
| stream | **[ListenerStream](#listenerstream)** <br> Stream specific listener settings. |
| rbac | **[RBAC](#rbac)** <br> RBAC access control configuration. |

### Listener

Listener protocol-specific settings.

*Appears in*: [GatewayListener](#gatewaylistener)

| Field | Description |
|-------|-------------|
| http | **[ListenerHTTP](#listenerhttp)** <br> HTTP specific listener settings. |
| stream | **[ListenerStream](#listenerstream)** <br> Stream specific listener settings. |

### ListenerHTTP

HTTP specific listener settings.

*Appears in*: [Listener](#listener)

| Field | Description |
|-------|-------------|
| protocolSettings | **[HTTPProtocolSettings](#httpprotocolsettings)** <br> HTTP protocol configuration. |

### HTTPProtocolSettings

HTTP protocol configuration settings.

*Appears in*: [ListenerHTTP](#listenerhttp)

| Field | Description |
|-------|-------------|
| allowHTTP10 | **bool** <br> Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. <br> Example: `true` |
| http2Options | **[HTTP2Options](#http2options)** <br> HTTP/2 settings. If specified, incoming HTTP/2 requests are supported by the listener. |

### HTTP2Options

HTTP/2 protocol options.

*Appears in*: [HTTPProtocolSettings](#httpprotocolsettings)

| Field | Description |
|-------|-------------|
| maxConcurrentStreams | **int** <br> Maximum number of concurrent HTTP/2 streams in a connection <br> Example: `100` |

### ListenerStream

Stream specific listener settings.

*Appears in*: [Listener](#listener)

| Field | Description |
|-------|-------------|
| idleTimeout | **string** <br> The idle timeout is duration during which no data is transmitted or received on either the upstream or downstream connection. <br> Example: `300s` |

### RouteOptions

Route options for security and access control.

*Appears in*: [GatewayListener](#gatewaylistener)

| Field | Description |
|-------|-------------|
| rbac | **[RBAC](#rbac)** <br> RBAC access control configuration. |

### RBAC

Role-Based Access Control configuration.

*Appears in*: [RouteOptions](#routeoptions)

| Field | Description |
|-------|-------------|
| action | **string** <br> The action to take if a principal matches. Enum: `ALLOW`, `DENY`. <br> Example: `ALLOW` |
| principals | **map[string]map[string][Principal](#principal)** <br> A match occurs when at least one principal group matches the request. Each principal group contains AND conditions. |

### Principal

Principal configuration for RBAC matching.

*Appears in*: [RBAC](#rbac)

| Field | Description |
|-------|-------------|
| header | **[HeaderPrincipal](#headerprincipal)** <br> A header (or pseudo-header such as :path or :method) of the incoming HTTP request. |
| ip | **[IPPrincipal](#ipprincipal)** <br> A CIDR block or IP that describes the request remote/origin address. |
| any | **bool** <br> Match any request. <br> Example: `true` |

### HeaderPrincipal

Header-based principal matching.

*Appears in*: [Principal](#principal)

| Field | Description |
|-------|-------------|
| name | **string** <br> The name of the header to match. <br> Example: `X-Api-Token` |
| regex | **string** <br> Regular expression match for header value. <br> Example: `^admin.*` |
| exact | **string** <br> Exact match for header value. <br> Example: `admin123` |
| prefix | **string** <br> Prefix match for header value. <br> Example: `Bearer ` |

### IPPrincipal

IP-based principal matching.

*Appears in*: [Principal](#principal)

| Field | Description |
|-------|-------------|
| remoteIp | **string** <br> CIDR block or IP address to match. <br> Example: `10.0.0.0/8` |

## GatewayPolicyStatus

GatewayPolicyStatus defines the observed state of GatewayPolicy.

*Appears in*: [GatewayPolicy](#gatewaypolicy)

| Field | Description |
|-------|-------------|
| conditions | **[]Condition** <br> Current state conditions of the gateway policy. |
| attachedGateways | **int32** <br> Number of currently attached gateways. |
