[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Kubernetes](../index.md) > Инструменты Application Load Balancer > Gwin > Конфигурация ресурсов (англ.) > ListenerSet

# ListenerSet

ListenerSet allows attaching additional listeners to an existing [Gateway](gateway.md). It enables different teams or namespaces to extend a shared Gateway with their own listeners without modifying the Gateway resource itself.

ListenerSet is a [Kubernetes Gateway API](https://gateway-api.sigs.k8s.io/) project resource. Below, we describe its fields used by Gwin. For configuration details, see the [upstream documentation](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io/v1.ListenerSet).

* [Cheatsheet](#cheatsheet)
* [ListenerSetMeta](#listenersetmeta)
  * [Annotations cheatsheet](#annotations-cheatsheet)
  * [Annotations reference](#annotations-reference)
* [ListenerSetSpec](#listenersetspec)
  * [ParentGatewayReference](#parentgatewayreference)
  * [ListenerEntry](#listenerentry)
  * [ListenerTLSConfig](#listenertlsconfig)
  * [SecretObjectReference](#secretobjectreference)
  * [AllowedRoutes](#allowedroutes)
  * [RouteNamespaces](#routenamespaces)
  * [LabelSelector](#labelselector)
  * [LabelSelectorRequirement](#labelselectorrequirement)
* [ListenerSetStatus](#listenersetstatus)
  * [ListenerEntryStatus](#listenerentrystatus)

## Cheatsheet

{% note info %}

Specification provided below is not valid configuration.

It's just demonstration of all `ListenerSet` fields.

{% endnote %}

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: ListenerSet
metadata:
  name: my-listenerset
  namespace: my-ns  # ListenerSet namespace, may differ from Gateway namespace
spec:
  parentRef:
    name: my-gateway  # Gateway to attach listeners to
    namespace: gateway-ns  # omit if Gateway is in the same namespace
  listeners:
    - name: https  # listener identifier, unique within this ListenerSet
      hostname: "*.example.com"  # accept requests for this domain
      port: 443
      protocol: HTTPS
      tls:
        mode: Terminate  # decrypt TLS at load balancer
        certificateRefs:
          - group: gwin.yandex.cloud
            kind: YCCertificate  # Yandex Cloud certificate
            name: some-certificate
            namespace: some-ns
          - kind: Secret  # Kubernetes secret certificate
            name: some-secret
            namespace: some-ns
      allowedRoutes:  # which routes can use this listener
        namespaces:
          from: Selector  # select by labels (Any or Same can be used as alternative)
          selector:
            matchLabels:
              app: my-app
            matchExpressions:
              - key: app
                operator: In
                values:
                  - my-app
    - name: http
      port: 8080
      protocol: HTTP
      hostname: "service.example.com"
      allowedRoutes:
        namespaces:
          from: Same  # only routes in the same namespace as this ListenerSet
```

| Field | Description |
|-------|-------------|
| metadata | **[ListenerSetMeta](#listenersetmeta)** <br> Name and namespace. |
| spec | **[ListenerSetSpec](#listenersetspec)** <br> Resource specification. |
| status | **[ListenerSetStatus](#listenersetstatus)** <br> Resource status populated by the controller. |

## ListenerSetMeta

| Field | Description |
|-------|-------------|
| name | **string** <br> Name of the ListenerSet. |
| namespace | **string** <br> Namespace of the ListenerSet. May differ from the parent Gateway's namespace. |
| annotations | **map[string]string** <br> Annotations of the ListenerSet. |

### Annotations cheatsheet

{% note info %}

You can also set policy parameters using [ListenerSetPolicy](listenersetpolicy.md) resource. The ListenerSetPolicy resource parameters and ListenerSet annotations are equivalent.

{% endnote %}

Specification provided below is not valid configuration.
It's just demonstration of all `ListenerSet` annotations.

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: ListenerSet
metadata:
  name: my-listenerset
  annotations:
    # Listener configuration (applies to all listeners in this ListenerSet)
    gwin.yandex.cloud/listeners.http.protocolSettings.allowHTTP10: "true"  # support old HTTP
    gwin.yandex.cloud/listeners.http.protocolSettings.http2Options.maxConcurrentStreams: "100"  # limit connections
    gwin.yandex.cloud/listeners.stream.idleTimeout: "300s"  # stream backend idle timeout

    # Specific listener configuration
    gwin.yandex.cloud/listener.my-listener.http.protocolSettings.allowHTTP10: "true"  # per-listener HTTP setting
    gwin.yandex.cloud/listener.my-listener.stream.idleTimeout: "300s"  # per-listener timeout

    # ALB resource naming
    gwin.yandex.cloud/listener.my-listener.albListenerName: "my-alb-listener"  # custom listener name
    gwin.yandex.cloud/listener.my-listener.albHTTPRouterName: "my-http-router"  # custom HTTP router name

    # Virtual host attachment
    gwin.yandex.cloud/listener.my-listener.attach.virtualHosts.httpRouterID: "http-router-id"  # manage virtual hosts in an existing HTTP router
    ...
```

### Annotations reference

{% note info %}

Any `listeners` annotation can be applied to a specific listener by prefixing with `listener.{listener-name}`.

For example: `gwin.yandex.cloud/listener.my-listener.http.protocolSettings.allowHTTP10: "true"`.

{% endnote %}

Gateway policies are **not** inherited by ListenerSets. Each ListenerSet manages its own listener settings independently.

#### Listener configuration

| Annotation and description |
|------------|
| `gwin.yandex.cloud/listeners.http.protocolSettings.allowHTTP10` <br> _(boolean)_ <br> Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. Applies to all HTTP listeners in this ListenerSet. <br> Example: `true` |
| `gwin.yandex.cloud/listeners.http.protocolSettings.http2Options.maxConcurrentStreams` <br> _(number)_ <br> Maximum number of concurrent HTTP/2 streams in a connection. Applies to all HTTP listeners in this ListenerSet. <br> Example: `100` |
| `gwin.yandex.cloud/listeners.stream.idleTimeout` <br> _(duration)_ <br> The idle timeout is duration during which no data is transmitted or received on either the upstream or downstream connection. Applies to all stream listeners in this ListenerSet. <br> Example: `300s` |

#### ALB resource naming

Custom names for ALB resources created by the controller. By default, the controller generates names automatically.

| Annotation and description |
|------------|
| `gwin.yandex.cloud/listener.{listener-name}.albListenerName` <br> _(string)_ <br> Custom name for the ALB listener associated with the specified listener. <br> Example: `my-alb-listener` |
| `gwin.yandex.cloud/listener.{listener-name}.albHTTPRouterName` <br> _(string)_ <br> Custom name for the ALB HTTP router associated with the specified listener. <br> Example: `my-http-router` |

#### Virtual host attachment

Make the controller manage virtual hosts inside an existing ALB HTTP router instead of creating its own. Attachment is configured per listener and follows the parent Gateway rule: either all listeners are attached or none.

| Annotation and description |
|------------|
| `gwin.yandex.cloud/listener.{listener-name}.attach.virtualHosts.httpRouterID` <br> _(string)_ <br> Cloud HTTP router ID whose virtual hosts are managed by this listener. The controller manages the full lifecycle (create, update, delete) of those virtual hosts and does not create an HTTP router of its own for this listener. <br> Example: `http-router-id` |

## ListenerSetSpec

ListenerSet specification.

*Appears in*: [ListenerSet](#listenerset)

| Field | Description |
|-------|-------------|
| parentRef | **[ParentGatewayReference](#parentgatewayreference)** <br> Reference to the Gateway this ListenerSet attaches to. The Gateway must explicitly allow attachment via its `spec.allowedListeners` field. |
| listeners | **[[]ListenerEntry](#listenerentry)** <br> Listeners to add to the parent Gateway. Must contain between 1 and 64 entries. Listener names must be unique within this ListenerSet, but may overlap with listener names in the parent Gateway. |

### ParentGatewayReference

Reference to the parent Gateway.

*Appears in*: [ListenerSetSpec](#listenersetspec)

| Field | Description |
|-------|-------------|
| group | **string** <br> API group of the parent Gateway. Defaults to `gateway.networking.k8s.io`. <br> Example: `gateway.networking.k8s.io` |
| kind | **string** <br> Kind of the parent resource. Defaults to `Gateway`. <br> Example: `Gateway` |
| name | **string** <br> Name of the parent Gateway. <br> Example: `my-gateway` |
| namespace | **string** <br> Namespace of the parent Gateway. Defaults to the ListenerSet's own namespace. <br> Example: `gateway-ns` |

### ListenerEntry

A listener to add to the parent Gateway. The fields are identical to the Gateway's [Listener](gateway.md#listener).

*Appears in*: [ListenerSetSpec](#listenersetspec)

| Field | Description |
|-------|-------------|
| name | **string** <br> Listener internal name. Unique within this ListenerSet. Does not need to be unique across the parent Gateway. The name must match `[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*` and be at most 63 characters. <br> Example: `http`, `example.com`. |
| hostname | **string** <br> Virtual hostname to match. Supports wildcard prefix (`*.example.com`). If omitted, all hostnames are matched. <br> Example: `*.example.com` |
| port | **int32** <br> Network port to listen on (1–65535). <br> Example: `80`, `443`. |
| protocol | **string** <br> Protocol for incoming traffic: `HTTP`, `HTTPS`, or `TLS`. <br> Example: `HTTP`, `HTTPS`, `TLS`. |
| tls | **[ListenerTLSConfig](#listenertlsconfig)** <br> TLS settings. Required when `protocol` is `HTTPS` or `TLS`. Must not be set for `HTTP`. |
| allowedRoutes | **[AllowedRoutes](#allowedroutes)** <br> Namespaces from which routes may attach to this listener. Defaults to `Same` namespace. |

### ListenerTLSConfig

TLS settings for HTTPS and TLS traffic termination.

*Appears in*: [ListenerEntry](#listenerentry)

| Field | Description |
|-------|-------------|
| mode | **string** <br> TLS termination mode. Only `Terminate` is supported (incoming traffic is decrypted using `certificateRefs`). <br> Example: `Terminate` |
| certificateRefs | **[[]SecretObjectReference](#secretobjectreference)** <br> Kubernetes resources containing TLS certificates. Required when `protocol` is `HTTPS` or `TLS`. Must contain at least one entry. |

### SecretObjectReference

Reference to a Kubernetes resource containing a TLS certificate. Identical to the Gateway's [SecretObjectReference](gateway.md#secretobjectreference).

You can specify a certificate from Certificate Manager ([YCCertificate](yccertificate.md)) or from a `Secret` resource. When using a cross-namespace reference, a `ReferenceGrant` in the target namespace is required. Note that `ReferenceGrant` objects applied to the parent Gateway are **not** inherited by the ListenerSet.

*Appears in*: [ListenerTLSConfig](#listenertlsconfig)

| Field | Description |
|-------|-------------|
| group | **string** <br> Kubernetes API group of the certificate resource. Default is empty (core API group). <br> Example: `gwin.yandex.cloud` |
| kind | **string** <br> Kind of the certificate resource. Default is `Secret`. Use `YCCertificate` for a Yandex Cloud certificate. <br> Example: `Secret`, `YCCertificate`. |
| name | **string** <br> Name of the certificate resource. <br> Example: `some-certificate` |
| namespace | **string** <br> Namespace of the certificate resource. Defaults to the ListenerSet's namespace. Requires a `ReferenceGrant` when referencing a different namespace. <br> Example: `some-ns` |

### AllowedRoutes

Rules for selecting which routes can use this listener. Identical to Gateway's [AllowedRoutes](gateway.md#allowedroutes).

*Appears in*: [ListenerEntry](#listenerentry)

| Field | Description |
|-------|-------------|
| namespaces | **[RouteNamespaces](#routenamespaces)** <br> Namespace selection rule for routes. |

### RouteNamespaces

Namespace selection rules for routes that may attach to this listener.

*Appears in*: [AllowedRoutes](#allowedroutes)

| Field | Description |
|-------|-------------|
| from | **string** <br> Selection rule: `All` — any namespace; `Same` — only the ListenerSet's own namespace; `Selector` — namespaces matching `selector`. Default is `Same`. <br> Example: `All`, `Same`, `Selector`. |
| selector | **[LabelSelector](#labelselector)** <br> Namespace label selector. Used only when `from` is `Selector`. |

### LabelSelector

Label-based selection criteria for namespaces.

*Appears in*: [RouteNamespaces](#routenamespaces)

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

## ListenerSetStatus

Status populated by the controller.

*Appears in*: [ListenerSet](#listenerset)

| Field | Description |
|-------|-------------|
| conditions | **[]Condition** <br> Overall ListenerSet conditions. Known types: `Accepted` and `Programmed`. |
| listeners | **[[]ListenerEntryStatus](#listenerentrystatus)** <br> Per-listener status. |

### ListenerEntryStatus

Status for an individual listener in this ListenerSet.

*Appears in*: [ListenerSetStatus](#listenersetstatus)

| Field | Description |
|-------|-------------|
| name | **string** <br> Name of the listener this status corresponds to. |
| supportedKinds | **[]RouteGroupKind** <br> Route kinds supported by this listener. |
| attachedRoutes | **int32** <br> Number of routes with `Accepted: true` attached to this listener. |
| conditions | **[]Condition** <br> Listener conditions. Known types: `Accepted`, `Programmed`, `ResolvedRefs`, `Conflicted`. |