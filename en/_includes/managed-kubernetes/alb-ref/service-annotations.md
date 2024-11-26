# Annotations

Annotations are collections of `key:value` pairs used for assigning metadata to objects. Annotation values are always of the `string` data type. For more on annotations, see the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/).

In {{ alb-name }}, annotations are only used in the `Service` resources to set up Ingress controllers.

You can provide the following annotations for a `ObjectMeta` object:

* **ingress.alb.yc.io/protocol** {#annot-protocol}

   Connection protocol for the load balancer and backends described in `Ingress`:

   * `http`: HTTP/1.1 default
   * `http2`: HTTP/2
   * `grpc`: gRPC

* **ingress.alb.yc.io/transport-security** {#annot-transport-security}

   Connection encryption protocol for the load balancer and backends specified in `Ingress` directly (without `HttpBackendGroup`).

   The acceptable value is `tls`: TLS with no certificate challenge.

   If no annotation is specified, the load balancer connects to the backends with no encryption.

   For backends belonging to groups, the annotation value is ignored. When you encrypt a connection between a load balancer and grouped backends, you configure the encryption via the `spec.backend.tls` field of the `HttpBackendGroup` resource (see the [resource configuration](../../../application-load-balancer/k8s-ref/http-backend-group.md)).

* **ingress.alb.yc.io/health-checks** {#annot-health-checks}

  Parameters for configuring custom application health checks in a cluster.

  * `http-path`: Path to the application's health check endpoint in the request URI. The default value is `/healthz`.

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
   