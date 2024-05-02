# ServicePort

```yaml
port: <int32>
name: <string>
protocol: <protocol>
nodePort: <int32>
```

#|
|| **Field** | **Value or type** | **Description** ||
|| `port`    | `int32`           | **Required**.
Number of port where the service is available.

You can use this number if you designate a service as a backend:

* In `Ingress`: using the `spec.rules.http.paths.backend.service.port.number` field (see the [configuration](../../../application-load-balancer/k8s-ref/ingress.md#backend)).
* In an `HttpBackendGroup` backend group: using the `spec.backends.service.port.number` field (see the [configuration](../../../application-load-balancer/k8s-ref/http-backend-group.md)).
||
|| `name` | `string` | Port name within the service.

You can use this name if you designate a service as a backend:

* In `Ingress`: using the `spec.rules.http.paths.backend.service.port.name` field (see the [configuration](../../../application-load-balancer/k8s-ref/ingress.md#backend)).
* In an `HttpBackendGroup` backend group: using the `spec.backends.service.port.name` field (see the [configuration](../../../application-load-balancer/k8s-ref/http-backend-group.md)).
||
|| `protocol` | `TCP` | Network protocol for the port. `TCP` only. ||
|| `nodePort` | `int32` | Number of the port opened on the cluster nodes on which the service is deployed. The load balancer sends traffic to this port, and {{ k8s }} forwards the traffic to the service on its port in the `port` parameter.

Corresponds to the backend port in the {{ alb-name }} [backend group](../../../application-load-balancer/concepts/backend-group.md).
||
|#
