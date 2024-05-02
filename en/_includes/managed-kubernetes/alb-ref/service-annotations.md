# Annotations

Annotations are collections of `key:value` pairs used for assigning metadata to objects. Annotation values are always of the `string` data type. For more on annotations, see the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/).

In {{ alb-name }}, annotations are used in the `Service` resources for Ingress controller configuration only.

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

   For backends belonging to groups, the annotation value is ignored. To encrypt connections between a load balancer and grouped backends, the `spec.backend.tls` field of the `HttpBackendGroup` resource is used (see the [resource configuration](../../../application-load-balancer/k8s-ref/http-backend-group.md)).
