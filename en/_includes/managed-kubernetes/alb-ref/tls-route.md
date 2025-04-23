# TLSRoute resource fields

The `TLSRoute` resource specifes routing rules for TLS traffic to {{ k8s }} services backends, i.e. [Service](../../../application-load-balancer/k8s-ref/service-for-gateway.md) resources. `TLSRoute` receives incoming traffic that has passed through [Gateway](../../../application-load-balancer/k8s-ref/gateway.md) resource filters.

`TLSRoute` is designed for application developers. Cluster operators should use the `Gateway` resource.

`TLSRoute` is a [{{ k8s }} Gateway API](https://gateway-api.sigs.k8s.io/) project resource. Below, we describe its fields and annotations used by {{ alb-name }} Gateway API. For configuration details, see the [{{ k8s }} Gateway API reference](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io/v1alpha2.TLSRoute).

## TLSRoute {#tlsroute}

```yaml
apiVersion: gateway.networking.k8s.io/v1alpha2
kind: TLSRoute
metadata: <ObjectMeta>
spec: <TLSRouteSpec>
```

#|
|| **Field**     | **Value / Type**   | **Description**                         ||
|| `apiVersion` | `gateway.networking.k8s.io/v1alpha2` | **This is a required field**.
                                                            Kubernetes API version. ||
|| `kind`       | `TLSRoute`              | **This is a required field**.
                                            Resource type.                        ||
|| `metadata`   | `ObjectMeta`            | **This is a required field**.
                                            [Resource metadata](#metadata).    ||
|| `spec`       | `TLSRouteSpec`          | **This is a required field**.
                                            [Resource specification](#spec).      ||
|#

{% cut "Example" %}

```yaml
apiVersion: gateway.networking.k8s.io/v1alpha2
kind: TLSRoute
metadata:
  name: sample-route
  namespace: route-namespace
spec:
  parentRefs:
  - name: sample-gateway
    sectionName: sample-listener
    namespace: gateway-namespace
  hostnames:
  - "sample.example.com"
  rules:
  - backendRefs:
    - name: sample-service
      port: 80
```

{% endcut %}

## ObjectMeta {#metadata}

```yaml
name: <string>
namespace: <string>
```

#|
|| **Field**     | **Value / Type** | **Description** ||
|| `name`       | `string`             | **This is a required field**.
                                         [Resource name](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

Do not mistake this name for the {{ alb-name }} route name. ||
|| `namespace`  | `string`  | Resource [namespace](../../../managed-kubernetes/concepts/index.md#namespace).

The default value is `default`. ||
|#

## TLSRouteSpec {#spec}

```yaml
parentRefs: <[]ParentReference>
hostnames: <[]Hostname>
rules: <[]TLSRouteRule>
```

#|
|| **Field**     | **Value / Type**  | **Description**                         ||
|| `parentRefs` | `[]ParentReference`   | **This is a required field**.
[`Gateway` resources or their listeners](#parentrefs) admitting traffic for the `TLSRoute`.

For the `TLSRoute` to receive `Gateway` traffic, it must comply with the rules specified in its [configuration](../../../application-load-balancer/k8s-ref/gateway.md#spec), i.e., `spec.listeners.allowedRoutes` field. ||
|| `hostnames`  | `[]Hostname`          | Domain names matching the `SNI` value in the `ClientHello` TLS handshake message.

{% include [k8s-ingress-controller-hostnames-wildcard](../../application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %} ||
|| `rules` | `[]TLSRouteRule` | **This is a required field**.
[Request routing rules](#rules). ||
|#

### ParentReference {#parentrefs}

```yaml
name: <string>
namespace: <string>
sectionName: <string>
```

#|
|| **Field**     | **Value / Type**  | **Description**                         ||
|| `name` | `string` | **This is a required field**.
`Gateway` resource name. ||
|| `namespace`       | `string`   | `Gateway` resource namespace.

By default, it matches the `TLSRoute` resource [metadata.namespace](#metadata) value. ||
|| `sectionName` | `string` | Name of the listener specified in the `Gateway` resource. ||
|#

### TLSRouteRule {#rules}

```yaml
backendRefs:
  - name: <string>
    namespace: <string>
    port: <int32>
    weight: <int32>
```

#|
|| **Field**     | **Value / Type**  | **Description**                         ||
|| `backendRefs` | `[]BackendRef` | **This is a required field**.
{{ k8s }} services acting as backends and processing requests.

All services from this list will be placed in the same [backend group](../../../application-load-balancer/concepts/backend-group.md). ||
|| `backendRefs.name`   | `string`              | **This is a required field**.
Name of the {{ k8s }} service backend.

The referred `Service` resource must be described per the [standard configuration](../../../application-load-balancer/k8s-ref/service-for-gateway.md). ||
|| `backendRefs.namespace` | `string`           | `Service` resource namespace.

By default, it matches the `TLSRoute` resource [metadata.namespace](#metadata) value. ||
|| `backendRefs.port`   | `int32`               | Service port number.

The port number must match one of the `Service` resource [spec.ports.port](../../../application-load-balancer/k8s-ref/service-for-gateway.md#servicespec) values. ||
|| `backendRefs.weight` | `int32`               | Backend weight. Backends in a group receive traffic in proportion to their weights.

You should either specify weights for all backends in a group, or not specify them at all. If weights are not specified, traffic will be equally distributed across backends.

A backend with zero or negative weight will not be receiving traffic. ||
|#
