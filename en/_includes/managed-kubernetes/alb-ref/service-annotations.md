# Annotations

Annotations are collections of `key:value` pairs for assigning metadata to objects. Annotation values are always of the `string` data type. For more information on annotations, see the relevant [{{ k8s }} article](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/).

In {{ alb-name }}, annotations are only used in the `Service` resources to set up ingress controllers.

You can add the following annotations to `ObjectMeta`:

* **ingress.alb.yc.io/protocol** {#annot-protocol}

   Protocol for connections between the load balancer and `Ingress`-defined backends:

   * `http`: HTTP/1.1. This is a default value.
   * `http2`: HTTP/2.
   * `grpc`: gRPC.

* **ingress.alb.yc.io/transport-security** {#annot-transport-security}

   Encryption protocol for connections between the load balancer and backends specified in `Ingress` directly, as opposed to the `HttpBackendGroup`.

   The acceptable annotation value is `tls`: TLS without certificate validation.

   If annotation is not specified, the load balancer will connect to the backends without encryption.

   This annotation is ignored for grouped backends. When you encrypt a connection between a load balancer and grouped backends, you configure the encryption via the `spec.backend.tls` field of the `HttpBackendGroup` resource (see the [resource configuration](../../../application-load-balancer/k8s-ref/http-backend-group.md)).

* **ingress.alb.yc.io/health-checks** {#annot-health-checks}

  Parameters for configuring custom application health checks in a cluster. We recommend configuring [health checks](../../../application-load-balancer/concepts/backend-group.md#health-checks) for all backends.

  * `http-path`: Path to the application endpoint in the request URI for health checks (only for `http` or `http2` connections to backends). The default value is `/healthz`.

  * `grpc-service-name`: Application gRPC service name for health checks (only for `grpc` connections to backends). If not specified, the entire backend will be health-checked.

  * `port`: Port on the cluster nodes used to check the application's availability. The application will be available for health checks at `http://<node_IP_address>:<port>/<path>`.

  * `healthy-threshold`: Number of consecutive successful checks to consider the application endpoint healthy. The default value is `1`.

  * `unhealthy-threshold`: Number of consecutive failed checks to consider the application endpoint unhealthy. The default value is `1`.

  * `timeout`: Response timeout in seconds. The values range from `1s` to `60s`. The default value is `2s`.

  * `interval`: Interval between health check requests in seconds. The values range from `1s` to `60s`. The default value is `5s`. The `interval` value must be larger than `timeout` by at least one second.

  `port` is a required parameter. If you omit the other parameters, they will be set to their default values.

  The parameters are given as a comma-separated list. Here is an example:

     ```
     ...
     annotations:
       ingress.alb.yc.io/health-checks: port=30103,http-path=/health-1,timeout=10s,interval=20s,healthy-threshold=3,unhealthy-threshold=2
     ...
     ```
   