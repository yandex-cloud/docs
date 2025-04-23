* `name` (`string`, required):

  {{ k8s }} service name.

* `port` (`ServiceBackendPort`, required):

  Service port to which `Ingress` will direct traffic.

  The field is designed for ingress controller operation and has no equivalents in {{ alb-name }}.

  * `name` (`string`):

    Service port name.

    This name must match one of the `Service` resource `spec.ports.name` values. For more information, see the [resource specification](../../application-load-balancer/k8s-ref/service-for-ingress.md).

    You must specify either the service port name or its `number`, but not both.

  * `number` (`int32`):

    Service port number.

    This number must match one of the `Service` resource `spec.ports.port` values. For more information, see the [resource specification](../../application-load-balancer/k8s-ref/service-for-ingress.md).

    You must specify either the service port `name` or its number, but not both.