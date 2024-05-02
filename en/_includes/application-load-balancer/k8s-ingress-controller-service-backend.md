* `name` (`string`, required)

   {{ k8s }} service name.

* `port` (`ServiceBackendPort`, required)

   Port of the service `Ingress` will access.

   The field is designed for Ingress controller operation and does not match any of the {{ alb-name }} resource fields.

   * `name` (`string`)

      Service port name.

      The name must match one of the port names specified in the `spec.ports.name` fields of the `Service` resource. For more information, see the [resource specification](../../application-load-balancer/k8s-ref/service-for-ingress.md).

      Either a name or a `number` must be specified for the service port but not both.

   * `number` (`int32`)

      Service port number.

      The number must match one of the port numbers specified in the `spec.ports.port` fields of the `Service` resource. For more information, see the [resource specification](../../application-load-balancer/k8s-ref/service-for-ingress.md).

      Either a number or a `name` must be specified for the service port but not both.