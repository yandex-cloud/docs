# ServicePort

```yaml
port: <int32>
name: <string>
protocol: <protocol>
nodePort: <int32>
```

#|
|| **Field** | **Value / Type** | **Description** ||
|| `port`    | `int32`           | **This is a required field**.
Number of the port the service is available on.

You can use this number if you designate a service as a backend:

* In `Ingress`, in the `spec.rules.http.paths.backend.service.port.number` field (see the [configuration](../../../application-load-balancer/k8s-ref/ingress.md#backend)).
* In `HttpBackendGroup`, in the `spec.backends.service.port.number` field (see the [configuration](../../../application-load-balancer/k8s-ref/http-backend-group.md)).
||
|| `name` | `string` | Service port name.

You can use this name if you designate a service as a backend:

* In `Ingress`, in the `spec.rules.http.paths.backend.service.port.name` field (see the [configuration](../../../application-load-balancer/k8s-ref/ingress.md#backend)).
* In `HttpBackendGroup`, in the `spec.backends.service.port.name` field (see the [configuration](../../../application-load-balancer/k8s-ref/http-backend-group.md)).
||
|| `protocol` | `TCP` | Port network protocol; `TCP` only. ||
|| `nodePort` | `int32` | Number of the port opened on the cluster nodes where the service is deployed. The load balancer routes traffic to this port, and {{ k8s }} forwards the traffic to the service on its port in the `port` parameter.

The value matches the backend port in the {{ alb-name }} [backend group](../../../application-load-balancer/concepts/backend-group.md).
||
|#
