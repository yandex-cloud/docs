# Service resource fields

The `Service` resource defines the [{{ k8s }} service](../../managed-kubernetes/concepts/index.md#service). To the [{{ alb-name }} Ingress controller](../tools/k8s-ingress-controller/index.md), services are backends that traffic is distributed to. You can reference a service as a backend:

* Directly in the [`Ingress` resource](ingress.md).
* Or as part of a backend group in the [`HttpBackendGroup` resource](http-backend-group.md).

`Service` is a standard {{ k8s }} resource. This reference describes the fields and the annotations of the resource that a {{ alb-name }} Ingress controller interfaces with. For a complete reference on the resource, please see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/service-v1/).

## Service {#service}

```yaml
apiVersion: v1
kind: Service
metadata:
  name: <string>
spec:
  type: NodePort
  ports:
    - name: <string>
      port: <int32>
      protocol: TCP
      nodePort: <int32>
    - ...
```

Where:

* `apiVersion`: `v1`
* `kind`: `Service`
* `metadata` (`ObjectMeta`, required)

   Resource metadata.

   * `name` (`string`, required)

      Resource name. For more information about format, please see the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

* `spec` (`ServiceSpec`)

   Resource specification.

   * `type`: `NodePort`

      {% include [k8s-ingress-controller-nodeport-note](../../_includes/application-load-balancer/k8s-ingress-controller-nodeport-note.md) %}

   * `ports` (`[]ServicePort`)

      List of ports where the service is available.

      * `port` (`int32`, required)

         Number of port where the service is available.

         You can use this number if you designate a service as a backend:

         * In `Ingress`: using the `spec.rules.http.paths.backend.service.port.number` field (see [reference](ingress.md)).
         * In an `HttpBackendGroup` backend group: using the `spec.backends.service.port.number` field (see [reference](http-backend-group.md)).

      * `name` (`string`)

         Port name internal to a service.

         You can use this name if you designate a service as a backend:

         * In `Ingress`: using the `spec.rules.http.paths.backend.service.port.name` field (see [reference](ingress.md)).
         * In an `HttpBackendGroup` backend group: using the `spec.backends.service.port.name` field (see [reference](http-backend-group.md)).

      * `protocol`: `TCP`
      * `nodePort` (`int32`)

         Number of port exposed on the cluster nodes where the service is deployed. The load balancer forwards traffic to this port, whereas {{ k8s }} redirects the traffic to the service to its `port`.

         Corresponds to the backend port in the {{ alb-name }} [backend group](../concepts/backend-group.md).