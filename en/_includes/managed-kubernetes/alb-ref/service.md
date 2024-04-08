# Fields and annotations of the Service resource

The `Service` resource defines the [{{ k8s }} service](../../../managed-kubernetes/concepts/index.md#service). For {{ alb-name }} tools for {{ managed-k8s-name }}, such as the [Ingress controller](../../../application-load-balancer/tools/k8s-ingress-controller/index.md) and [Gateway API](../../../application-load-balancer/tools/k8s-gateway-api/index.md), the services are backends between which the incoming traffic is distributed. The services acting as {{ alb-name }} backends may be specified in the [`Ingress` resource](../../../application-load-balancer/k8s-ref/ingress.md) either directly or as part of [`HttpBackendGroup` backend groups](../../../application-load-balancer/k8s-ref/http-backend-group.md). When using the Gateway API, backend services are specified in the [`HTTPRoute` resource](../../../application-load-balancer/k8s-ref/http-route.md).

`Service` is a standard {{ k8s }} resource. This reference describes the fields and annotations of the resource the {{ alb-name }} tools for {{ managed-k8s-name }} interface with. For a complete reference for the resource, please see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/service-v1/).

## Service {#service}

```yaml
apiVersion: v1
kind: Service
metadata: <ObjectMeta>
spec: <ServiceSpec>
```

#|
|| **Field**     | **Value or type**   | **Description**               ||
|| `apiVersion`  | `v1`                | **Required**
                                        Kubernetes API version         ||
|| `kind`        | `Service`           | Resource type                 ||
|| `metadata`    | `ObjectMeta`        | **Required**
                                        [Resource metadata](#metadata) ||
|| `spec`        | `ServiceSpec`       | **Required**
[Resource specification](#servicespec)                                 ||
|#

{% cut "Example" %}

```yaml
apiVersion: v1
kind: Service
metadata:
  name: alb-demo-1
spec:
  selector:
    app: alb-demo-1
  type: NodePort
  ports:
    - name: http
      port: 80
      protocol: TCP
      nodePort: 30081
```

{% endcut %}

## ObjectMeta {#metadata}

```yaml
name: <string>
annotations:
  ingress.alb.yc.io/protocol: <string>
  ingress.alb.yc.io/transport-security: <string>
```

#|
|| **Field**      | **Value or type**  | **Description** ||
|| `name`         | `string`           | **Required**
                                        [Resource name](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names)
                                       Does not match the load balancer name in Application Load Balancer          ||
|| `annotations`  | `map[string]string` | **Required**
[Resource annotations](#annotations)                     ||
|#

### Annotations (metadata.annotations) {#annotations}

Annotations are collections of `key:value` pairs used for assigning metadata to objects. Annotation values are always of the `string` data type. For more on annotations, see the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/).

You can provide the following annotations for the `ObjectMeta` object:

* **ingress.alb.yc.io/protocol** {#annot-protocol}

   Connection protocol for the load balancer and backends described in `Ingress`:

   * `http`: HTTP/1.1; default value
   * `http2`: HTTP/2
   * `grpc`: gRPC

* **ingress.alb.yc.io/transport-security** {#annot-transport-security}

   Connection encryption protocol for the load balancer and backends specified in `Ingress` directly (without `HttpBackendGroup`).

   The acceptable value is `tls`: TLS with no certificate challenge.

   If no annotation is specified, the load balancer connects to the backends with no encryption.

   For backends belonging to groups, the annotation value is ignored. When you encrypt a connection between a load balancer and grouped backends, you configure the encryption via the `spec.backend.tls` field of the `HttpBackendGroup` resource (see the [resource reference](../../../application-load-balancer/k8s-ref/http-backend-group.md)).

## ServiceSpec {#servicespec}

```yaml
type: NodePort
ports:
  - <ServicePort>
  -
```

#|
|| **Field** | **Value or type** | **Description** ||
|| `type`    | `NodePort`        | **Required**
Service type.

{% include [k8s-ingress-controller-nodeport-note](../../application-load-balancer/k8s-ingress-controller-nodeport-note.md) %}
||
|| `ports`   | `[]ServicePort`   | **Required**
[List of ports on which the service is available](#ports).
||
|#

## ServicePort {#ports}

```yaml
port: <int32>
name: <string>
protocol: <protocol>
nodePort: <int32>
```

#|
|| **Field** | **Value or type** | **Description** ||
|| `port`    | `int32`           | **Required**
Port number the service is available on.

You can use this number if you designate a service as a backend:

* In `Ingress`: using the `spec.rules.http.paths.backend.service.port.number` field (see the [reference](../../../application-load-balancer/k8s-ref/ingress.md#backend)).
* In an `HttpBackendGroup` backend group: using the `spec.backends.service.port.number` field (see the [reference](../../../application-load-balancer/k8s-ref/http-backend-group.md)).
||
|| `name` | `string` | Port name within the service.

You can use this name if you designate a service as a backend:

* In `Ingress`: using the `spec.rules.http.paths.backend.service.port.name` field (see the [reference](../../../application-load-balancer/k8s-ref/ingress.md#backend)).
* In an `HttpBackendGroup` backend group: using the `spec.backends.service.port.name` field (see the [reference](../../../application-load-balancer/k8s-ref/http-backend-group.md)).
||
|| `protocol` | `TCP`   | Network protocol for the port. Only `TCP` ||
|| `nodePort` | `int32` | Number of the port opened on the cluster nodes on which the service is deployed. The load balancer sends traffic to this port, and {{ k8s }} forwards the traffic to the service on its port in the `port` parameter.

Corresponds to the backend port in the {{ alb-name }} [backend group](../../../application-load-balancer/concepts/backend-group.md).
||
|#
