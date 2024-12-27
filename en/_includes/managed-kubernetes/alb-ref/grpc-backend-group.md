# GrpcBackendGroup resource fields


`GrpcBackendGroup` enables you to combine backends that are {{ k8s }} services and that gRPC traffic is distributed to, into a group. The [{{ alb-name }} Ingress controller](../../../application-load-balancer/tools/k8s-ingress-controller/index.md) uses these resources to create [backend groups](../../../application-load-balancer/concepts/backend-group.md).

You need to add a reference to `GrpcBackendGroup` to the [`Ingress`](../../../application-load-balancer/k8s-ref/ingress.md) resource. This `Ingress` must have the `ingress.alb.yc.io/protocol: grpc` annotation.

{% cut "Example" %}

```yaml
---
apiVersion: alb.yc.io/v1alpha1
kind: GrpcBackendGroup
metadata:
  namespace: testapp-ns
  name: grpc-bg
spec:
  backends:
    - name: ying
      weight: 50
      service:
        name: grpc-testapp-service
        port:
          number: 8080

    - name: yang
      weight: 50
      service:
        name: grpc-testapp-service2
        port:
          number: 8080
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: testapp-ingress-with-grpc-bg
  namespace: testapp-ns
  annotations:
    ingress.alb.yc.io/group-name: default
    ingress.alb.yc.io/protocol: grpc
spec:
  rules:
    - host: grpc-first-server.info
      http:
        paths:
          - path: /helloworld.Greeter/SayHello
            pathType: Prefix
            backend:
              resource:
                apiGroup: alb.yc.io
                kind: GrpcBackendGroup
                name: grpc-bg
```                
{% endcut %}

`GrpcBackendGroup` is a [custom resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) from the `alb.yc.io` API group provided by an Ingress controller.

## GrpcBackendGroup {#grpc-backend-group}

```yaml
apiVersion: alb.yc.io/v1alpha1
kind: GrpcBackendGroup
metadata:
  name: <string>
spec:
  backends:
    - name: <string>
      weight: <int64>
      service:
         name: <int64>
         port:
           name: <string>
           number: <int32>
      tls:
        sni: <string>
        trustedCa: <string>
      healthChecks:
        - grpc:
            serviceName: <string>
          port: <int32>
          healthyThreshold: <int32>
          unhealthyThreshold: <int32>
          timeout: <string>
          interval: <string>
    - ...
```

Where:

* `apiVersion`: `alb.yc.io/v1alpha1`
* `kind`: `GrpcBackendGroup`
* `metadata` (`ObjectMeta`, required)
  
  Resource metadata.

  * `name` (`string`, required)

    Resource name. For more information about the format, please see the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).
  
    You must specify this name in the `spec.rules.http.paths.backend.resource.name` field of the `Ingress` resource (see the [relevant configuration](../../../application-load-balancer/k8s-ref/ingress.md)).

    This name is not the backend group name in {{ alb-name }}.

* `spec` (`GrpcBackendGroupSpec`)

  Resource specification.

  * `backends` (`[]GrpcBackend`)
  
    List of backends in the group.
    
    * `name` (`string`, required)
    
      Backend name.
    
    * `weight` (`int64`)

      Relative backend weight. Traffic is distributed to backends in a group as a function of backend weights.

      Weights must be specified either for all backends in a group, or for none. If weights are not specified, traffic is distributed to the backends as if they had identical positive weights.

      If a non-positive weight is specified, a backend will not receive traffic.

    * `service` (`ServiceBackend`)

      Reference to the [{{ k8s }}](../../../managed-kubernetes/concepts/index.md#service) service expected to process requests as a backend.

      The `Service` resource this field refers to must be described in line with the [standard configuration](../../../application-load-balancer/k8s-ref/service-for-ingress.md).

      {% include [k8s-ingress-controller-service-backend](../../application-load-balancer/k8s-ingress-controller-service-backend.md) %}
        
    * `tls` (`BackendTLS`)
    
      TLS connection settings for the load balancer nodes and backend endpoints.
    
      If the field is specified, the load balancer establishes TLS connections with the backend and compares the certificates it gets with the certificate specified in the `trustedCa` field. If the field is not specified, the load balancer will make unencrypted connections to the backend.
        
      * `sni` (`string`)
      
        Domain name specified as the value for the Server Name Indication (SNI) TLS extension.
      
      * `trustedCa` (`string`)
      
        Contents of the X.509 certificate issued by a certificate authority in PEM format.  

    * `healthChecks` (`[]HealthChecks`)

      Settings for custom [health checks](../../../application-load-balancer/concepts/backend-group.md#health-checks) of applications in a {{ managed-k8s-name }} cluster.

      By default, the {{ alb-name }} Ingress controller receives health check requests from the L7 load balancer on TCP port `10501` and health checks the [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/) pods on each cluster node. If kube-proxy is healthy, then, even if an application in a particular pod does not respond, {{ k8s }} will redirect traffic to a different pod with that application or to a different node.
      
      You can use the `healthChecks` parameters to [customize application health checks](../../../managed-kubernetes/tutorials/custom-health-checks.md).

      * `grpc` (`GrpcBackend`)

        Sets gRPC as the protocol to use for the health check.

        * `serviceName` (`string`)

          Name of the service checked.

      * `port` (`int32`)

        Port on the cluster nodes used to check the application's availability. The same port is specified in the `NodePort` type [Service](../../../application-load-balancer/k8s-ref/service-for-ingress.md) resource, in the `spec.ports.nodePort` parameter.

        The application will be available for health checks at `http://<node_IP_address>:<port>/<path>`.

      * `healthyThreshold` (`int32`)

        Number of consecutive successful checks to consider the application endpoint healthy.

      * `unhealthyThreshold` (`int32`)

        Number of consecutive failed checks to consider the application endpoint unhealthy.

      * `timeout` (`string`)

        Response timeout in seconds. The values range from `1s` to `60s`.

      * `interval` (`string`)

        Interval between health check requests in seconds.

        The values range from `1s` to `60s`. The `interval` value must be larger than `timeout` by at least one second.

      {% include [alb-custom-hc-enabling](../../../_includes/managed-kubernetes/alb-custom-hc-enabling.md) %}