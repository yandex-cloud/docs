# Fields and annotations of the Service resource

The `Service` resource defines the [{{ k8s }} service](../../managed-kubernetes/concepts/index.md#service). For {{ alb-name }} tools for {{ managed-k8s-name }}, such as the [Ingress controller](../tools/k8s-ingress-controller/index.md) and [Gateway API](../tools/k8s-gateway-api/index.md), the services are backends between which the incoming traffic is distributed. The services acting as {{ alb-name }} backends may be specified in the [`Ingress` resource](ingress.md) either directly or as part of [`HttpBackendGroup` backend groups](http-backend-group.md). When using the Gateway API, backend services are specified in the [`HTTPRoute` resource](http-route.md).

`Service` is a standard {{ k8s }} resource. This reference describes the fields and the annotations of the resource the {{ alb-name }} tools for {{ managed-k8s-name }} interface with. For a complete reference on the resource, please see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/service-v1/).

## Service {#service}

```yaml
apiVersion: v1
kind: Service
metadata: <ObjectMeta>
spec: <ServiceSpec>
```

#|
|| **Field**    | **Value or type**      | **Description**                  ||
|| `apiVersion` | `v1` | **Required**
                                          Kubernetes API version            ||
|| `kind`       | `Service`              | Resource type                    ||
|| `metadata`   | `ObjectMeta`           | **Required**
                                          [Resource metadata](#metadata)    ||
|| `spec`       | `ServiceSpec`          | **Required**
                                          [Resource specification](#spec)   ||
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
```

#|
|| **Field**      | **Value or type** | **Description** ||
|| `name`         | `string`          | **Required**
                                        [Resource name](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names)
                                        Does not match the load balancer name in Application Load Balancer ||
|#

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

{% include [k8s-ingress-controller-nodeport-note](../../_includes/application-load-balancer/k8s-ingress-controller-nodeport-note.md) %}
||
|| `ports`    | `[]ServicePort`      | **Required**
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

* In `Ingress`: using the `spec.rules.http.paths.backend.service.port.number` field (see [reference](ingress.md#backend)).
* In an `HttpBackendGroup` backend group: using the `spec.backends.service.port.number` field (see [reference](http-backend-group.md)).
||
|| `name` | `string` | Port name within the service.

You can use this name if you designate a service as a backend:

* In `Ingress`: using the `spec.rules.http.paths.backend.service.port.name` field (see [reference](ingress.md#backend)).
* In an `HttpBackendGroup` backend group: using the `spec.backends.service.port.name` field (see [reference](http-backend-group.md)).
||
|| `protocol` | `TCP` | Network protocol for the port. Only `TCP` ||
|| `nodePort` | `int32` | Number of the port opened on the cluster nodes on which the service is deployed. The load balancer sends traffic to this port, and {{ k8s }} forwards the traffic to the service on its port in the `port` parameter.

Corresponds to the backend port in the {{ alb-name }} [backend group](../concepts/backend-group.md).
||
|#
