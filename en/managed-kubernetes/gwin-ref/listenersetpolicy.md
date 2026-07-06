# ListenerSetPolicy

ListenerSetPolicy is a Gwin custom resource for configuring listener-level policies for [ListenerSet](./listenerset.md) resources. It allows you to define HTTP protocol settings, stream timeouts, and ALB resource naming that apply to ListenerSet resources matched by name or label selector.

ListenerSetPolicy and ListenerSet annotations are equivalent ways to configure the same settings. Use ListenerSetPolicy when you want to apply the same settings to multiple ListenerSets or manage policy separately from the ListenerSet resource.

* [Cheatsheet](#cheatsheet)
* [ListenerSetPolicySpec](#listenersetpolicyspec)
  * [LocalObjectReference](#localobjectreference)
  * [LabelSelector](#labelselector)
  * [LabelSelectorRequirement](#labelselectorrequirement)
  * [ListenerSetPolicyConfig](#listenersetpolicyconfig)
  * [GatewayListener](#gatewaylistener)
  * [Listener](#listener)
  * [ListenerHTTP](#listenerhttp)
  * [HTTPProtocolSettings](#httpprotocolsettings)
  * [HTTP2Options](#http2options)
  * [ListenerStream](#listenerstream)
* [ListenerSetPolicyStatus](#listenersetpolicystatus)

## Cheatsheet

{% note info %}

Specification provided below is not valid configuration.

It's just demonstration of all `ListenerSetPolicy` fields.

{% endnote %}

```yaml
apiVersion: gwin.yandex.cloud/v1
kind: ListenerSetPolicy
metadata:
  name: my-policy
  namespace: my-ns  # policy only matches ListenerSets in the same namespace
spec:
  targetRefs:
    - kind: ListenerSet
      name: my-listenerset  # target a specific ListenerSet by name
  selector:
    matchLabels:
      team: backend  # or target all ListenerSets with this label
  policy:
    listeners:  # applies to all listeners in matched ListenerSets
      albListenerName: "my-alb-listener"
      http:
        protocolSettings:
          allowHTTP10: "true"
          http2Options:
            maxConcurrentStreams: "100"
      stream:
        idleTimeout: "300s"
    listener:
      my-https-listener:  # applies only to the listener named "my-https-listener"
        albListenerName: "my-https-alb-listener"
        albHTTPRouterName: "my-https-router"
        http:
          protocolSettings:
            allowHTTP10: "false"
        attach:  # manage virtual hosts in an existing HTTP router
          virtualHosts:
            httpRouterID: "http-router-id"
```

| Field | Description |
|-------|-------------|
| metadata | Standard Kubernetes metadata. |
| spec | **[ListenerSetPolicySpec](#listenersetpolicyspec)** <br> Policy specification. |
| status | **[ListenerSetPolicyStatus](#listenersetpolicystatus)** <br> Status populated by the controller. |

## ListenerSetPolicySpec

*Appears in*: [ListenerSetPolicy](#listenersetpolicy)

The policy is restricted to ListenerSet resources within the same namespace.

When determining which resources the policy applies to, the following rules are used:
- If both `targetRefs` and `selector` are specified, a resource must match both criteria.
- If neither is specified, the policy applies to all ListenerSets in the same namespace.

| Field | Description |
|-------|-------------|
| targetRefs | **[[]LocalObjectReference](#localobjectreference)** <br> References to specific ListenerSets to target. |
| selector | **[LabelSelector](#labelselector)** <br> Label selector for targeting ListenerSets. |
| policy | **[ListenerSetPolicyConfig](#listenersetpolicyconfig)** <br> The listener policy configuration. |

### LocalObjectReference

Reference to a resource in the same namespace.

*Appears in*: [ListenerSetPolicySpec](#listenersetpolicyspec)

| Field | Description |
|-------|-------------|
| group | **string** <br> API group of the resource. <br> Example: `gateway.networking.k8s.io` |
| kind | **string** <br> Kind of the resource. <br> Example: `ListenerSet` |
| name | **string** <br> Name of the resource. <br> Example: `my-listenerset` |

### LabelSelector

Label-based selection criteria for ListenerSets.

*Appears in*: [ListenerSetPolicySpec](#listenersetpolicyspec)

| Field | Description |
|-------|-------------|
| matchLabels | **map[string]string** <br> Simple label matching requirements. <br> Example: `team: backend` |
| matchExpressions | **[[]LabelSelectorRequirement](#labelselectorrequirement)** <br> Advanced label matching expressions. |

### LabelSelectorRequirement

*Appears in*: [LabelSelector](#labelselector)

| Field | Description |
|-------|-------------|
| key | **string** <br> Label key to match. <br> Example: `team` |
| operator | **string** <br> Matching operator. <br> Example: `In`, `NotIn`, `Exists`. |
| values | **[]string** <br> Values to match against. <br> Example: `["backend"]` |

### ListenerSetPolicyConfig

Policy configuration for listeners in the matched ListenerSet.

*Appears in*: [ListenerSetPolicySpec](#listenersetpolicyspec)

| Field | Description |
|-------|-------------|
| listeners | **[GatewayListener](#gatewaylistener)** <br> Settings applied to all listeners in the matched ListenerSet. |
| listener | **map[string][GatewayListener](#gatewaylistener)** <br> Per-listener settings, keyed by listener name. Override the `listeners` defaults for specific listeners. |

### GatewayListener

Settings for a listener.

*Appears in*: [ListenerSetPolicyConfig](#listenersetpolicyconfig)

| Field | Description |
|-------|-------------|
| albListenerName | **string** <br> Custom name for the ALB listener. <br> Example: `my-alb-listener` |
| albHTTPRouterName | **string** <br> Custom name for the ALB HTTP router. <br> Example: `my-http-router` |
| http | **[ListenerHTTP](#listenerhttp)** <br> HTTP-specific listener settings. |
| stream | **[ListenerStream](#listenerstream)** <br> Stream-specific listener settings. |
| attach | **[HTTPRouterAttach](#httprouterattach)** <br> Make the controller manage virtual hosts inside an existing ALB HTTP router instead of creating its own. |

### HTTPRouterAttach

Attachment to an existing cloud HTTP router.

*Appears in*: [GatewayListener](#gatewaylistener)

| Field | Description |
|-------|-------------|
| virtualHosts | **[VirtualHostsAttach](#virtualhostsattach)** <br> Virtual hosts attachment configuration. |

### VirtualHostsAttach

*Appears in*: [HTTPRouterAttach](#httprouterattach)

| Field | Description |
|-------|-------------|
| httpRouterID | **string** <br> Cloud HTTP router ID whose virtual hosts are managed by this listener. The controller manages the full lifecycle (create, update, delete) of those virtual hosts. <br> Example: `http-router-id` |

### Listener

Base listener settings (embedded in GatewayListener).

*Appears in*: [GatewayListener](#gatewaylistener)

| Field | Description |
|-------|-------------|
| albListenerName | **string** <br> Custom name for the ALB listener. <br> Example: `my-alb-listener` |
| http | **[ListenerHTTP](#listenerhttp)** <br> HTTP-specific settings. |
| stream | **[ListenerStream](#listenerstream)** <br> Stream-specific settings. |

### ListenerHTTP

HTTP-specific listener settings.

*Appears in*: [GatewayListener](#gatewaylistener)

| Field | Description |
|-------|-------------|
| protocolSettings | **[HTTPProtocolSettings](#httpprotocolsettings)** <br> HTTP protocol options. |

### HTTPProtocolSettings

HTTP protocol options.

*Appears in*: [ListenerHTTP](#listenerhttp)

| Field | Description |
|-------|-------------|
| allowHTTP10 | **boolean** <br> Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. <br> Example: `true` |
| http2Options | **[HTTP2Options](#http2options)** <br> HTTP/2 connection settings. |

### HTTP2Options

HTTP/2 connection settings.

*Appears in*: [HTTPProtocolSettings](#httpprotocolsettings)

| Field | Description |
|-------|-------------|
| maxConcurrentStreams | **number** <br> Maximum number of concurrent HTTP/2 streams in a connection. <br> Example: `100` |

### ListenerStream

Stream listener settings.

*Appears in*: [GatewayListener](#gatewaylistener)

| Field | Description |
|-------|-------------|
| idleTimeout | **duration** <br> Duration during which no data is transmitted or received on either the upstream or downstream connection before the connection is closed. <br> Example: `300s` |

## ListenerSetPolicyStatus

*Appears in*: [ListenerSetPolicy](#listenersetpolicy)

| Field | Description |
|-------|-------------|
| conditions | **[]Condition** <br> Policy conditions. Known type: `Accepted`. |
| attachedListenerSets | **int32** <br> Number of ListenerSets this policy is currently attached to. |
