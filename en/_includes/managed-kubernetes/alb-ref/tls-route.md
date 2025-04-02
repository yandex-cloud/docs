# TLSRoute resource fields

The `TLSRoute` resource defines the rules for routing traffic across backends, i.e., {{ k8s }} services (the [Service](../../../application-load-balancer/k8s-ref/service-for-gateway.md) resources). `TLSRoute` handles incoming traffic from the [Gateway](../../../application-load-balancer/k8s-ref/gateway.md) resources whose criteria it meets.

`TLSRoute` is designed for application developers. Cluster operators should use `Gateway`.

`TLSRoute` is a {{ k8s }} resource specified by the [{{ k8s }} Gateway API](https://gateway-api.sigs.k8s.io/) project. Below, you can find the descriptions of the resource fields {{ alb-name }} Gateway API interfaces with. For a full description of the resource configuration, see the [{{ k8s }} Gateway API documentation](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io/v1alpha2.TLSRoute).

## TLSRoute {#tlsroute}

```yaml
apiVersion: gateway.networking.k8s.io/v1alpha2
kind: TLSRoute
metadata: <ObjectMeta>
spec: <TLSRouteSpec>
```

#|
|| **Field**     | **Value or type**   | **Description**                         ||
|| `apiVersion` | `gateway.networking.k8s.io/v1alpha2` | **Required**.
                                                            Kubernetes API version. ||
|| `kind`       | `TLSRoute`              | **Required**.
                                            Resource type.                        ||
|| `metadata`   | `ObjectMeta`            | **Required**.
                                            [Resource metadata](#metadata).    ||
|| `spec`       | `TLSRouteSpec`          | **Required**.
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
|| **Field**     | **Value or type** | **Description** ||
|| `name`       | `string`             | **Required**.
                                         [Resource name](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

This name is not the route name in {{ alb-name }}. ||
|| `namespace`  | `string`  | [Namespace](../../../managed-kubernetes/concepts/index.md#namespace) the resource belongs to.

The default value is `default`. ||
|#

## TLSRouteSpec {#spec}

```yaml
parentRefs: <[]ParentReference>
hostnames: <[]Hostname>
rules: <[]TLSRouteRule>
```

#|
|| **Field**     | **Value or type**  | **Description**                         ||
|| `parentRefs` | `[]ParentReference`   | **Required**.
[List of `Gateway` resources or their listeners](#parentrefs) `TLSRoute` must be linked to.

To get linked, the route must meet the rules described in the `Gateway` [configuration](../../../application-load-balancer/k8s-ref/gateway.md#spec) (the `spec.listeners.allowedRoutes` field). ||
|| `hostnames`  | `[]Hostname`          | List of domain names matching the `SNI` attribute of the `ClientHello` message used during the TLS handshake.

{% include [k8s-ingress-controller-hostnames-wildcard](../../application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %} ||
|| `rules` | `[]TLSRouteRule` | **Required**.
[Request routing rules](#rules). ||
|#

### ParentReference {#parentrefs}

```yaml
name: <string>
namespace: <string>
sectionName: <string>
```

#|
|| **Field**     | **Value or type**  | **Description**                         ||
|| `name` | `string` | **Required**.
`Gateway` resource name. ||
|| `namespace`       | `string`   | Namespace the `Gateway` resource belongs to.

By default, it matches the `TLSRoute` resource namespace (the [metadata.namespace](#metadata) field). ||
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
|| **Field**     | **Value or type**  | **Description**                         ||
|| `backendRefs` | `[]BackendRef` | **Required**.
List of {{ k8s }} services acting as backends and processing requests.

All the listed services will be placed in the same [backend group](../../../application-load-balancer/concepts/backend-group.md). ||
|| `backendRefs.name`   | `string`              | **Required**.
Name of the {{ k8s }} service acting as a backend.

The `Service` resource this field refers to must be described in line with the [standard configuration](../../../application-load-balancer/k8s-ref/service-for-gateway.md). ||
|| `backendRefs.namespace` | `string`           | Namespace the `Service` resource belongs to.

By default, it matches the namespace of the `TLSRoute` resource (the [metadata.namespace](#metadata) field). ||
|| `backendRefs.port`   | `int32`               | Service port number.

This number must match one of the port numbers specified in the [spec.ports.port](../../../application-load-balancer/k8s-ref/service-for-gateway.md#servicespec) fields of the `Service` resource. ||
|| `backendRefs.weight` | `int32`               | Relative backend weight. In a backend group, traffic between backends is distributed in proportion to their weights.

Weights must be specified either for all backends in a group, or for none. If weights are not specified, traffic is distributed to the backends as if they had identical positive weights.

If a non-positive weight is specified, a backend will not receive traffic. ||
|#
