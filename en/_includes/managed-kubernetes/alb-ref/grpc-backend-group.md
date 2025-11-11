# GrpcBackendGroup resource fields

`GrpcBackendGroup` enables you to group backends, i.e., {{ k8s }} services processing gRPC traffic. The [{{ alb-name }} Ingress controller](../../../application-load-balancer/tools/k8s-ingress-controller/index.md) uses these resources to create [backend groups](../../../application-load-balancer/concepts/backend-group.md).

{% include [Gwin](../../application-load-balancer/ingress-to-gwin-tip.md) %}

You need to add a reference to `GrpcBackendGroup` to the [`Ingress`](../../../application-load-balancer/k8s-ref/ingress.md) resource. This `Ingress` resource must have the `ingress.alb.yc.io/protocol: grpc` annotation.

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
* `metadata` (`ObjectMeta`; this is a required field)
  
  Resource metadata.

  * `name` (`string`; this is a required field)

    Resource name. For more information about the format, see [this {{ k8s }} guide](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).
  
    You must specify this name in the `spec.rules.http.paths.backend.resource.name` field of the `Ingress` resource (see [this configuration](../../../application-load-balancer/k8s-ref/ingress.md)).

    Do not mistake this name for the {{ alb-name }} backend group name.

* `spec` (`GrpcBackendGroupSpec`)

  Resource specification.

  * `backends` (`[]GrpcBackend`)
  
    List of backends in the group.
    
    * `name` (`string`; this is a required field)
    
      Backend name.
    
    * `weight` (`int64`)

      Backend weight. Backends in a group receive traffic in proportion to their weights.

      You should either specify weights for all backends in a group, or not specify them at all. If weights are not specified, traffic will be equally distributed across backends.

      A backend with zero or negative weight will not be receiving traffic.

    * `service` (`ServiceBackend`)

      Reference to the [{{ k8s }}](../../../managed-kubernetes/concepts/index.md#service) service to process requests as a backend.

      The referred `Service` resource must be described per the [standard configuration](../../../application-load-balancer/k8s-ref/service-for-ingress.md).

      {% include [k8s-ingress-controller-service-backend](../../application-load-balancer/k8s-ingress-controller-service-backend.md) %}
        
    * `tls` (`BackendTLS`)
    
      TLS connection settings for the load balancer nodes and backend endpoints.
    
      If this field is specified, the load balancer will establish TLS connections to the backend, comparing received certificates with the one specified in the `trustedCa` field. Otherwise, the load balancer will use unencrypted connections to the backend.
        
      * `sni` (`string`)
      
        SNI domain name for TLS connections.
      
      * `trustedCa` (`string`)
      
        Contents of the X.509 certificate issued by a certificate authority in PEM format.

    * `healthChecks` (`[]HealthChecks`)

      Custom [health checks](../../../application-load-balancer/concepts/backend-group.md#health-checks) settings for {{ managed-k8s-name }} cluster applications.

      By default, the {{ alb-name }} Ingress controller receives L7 load balancer health check requests on TCP port `10501`. Then it checks [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/) pods on each cluster node. Given that kube-proxy is healthy, the process is as follows: if an application does not respond in a particular pod, {{ k8s }} redirects traffic to a different pod or node.
      
      You can use `healthChecks` settings to [customize application health checks](../../../managed-kubernetes/tutorials/custom-health-checks.md).

      * `grpc` (`GrpcBackend`)

        Specifies gRPC as the health check protocol.

        * `serviceName` (`string`)

          Name of the service you want to check.

      * `port` (`int32`)

        Cluster node port for checking application availability. This port should match the `spec.ports.nodePort` value of the `NodePort` [Service](../../../application-load-balancer/k8s-ref/service-for-ingress.md) resource.

        The application will be available for health checks at `http://<node_IP_address>:<port>/<path>`.

      * `healthyThreshold` (`int32`)

        Number of consecutive successful checks required to consider the application endpoint healthy.

      * `unhealthyThreshold` (`int32`)

        Number of consecutive failed checks required to consider the application endpoint unhealthy.

      * `timeout` (`string`)

        Response timeout in seconds. You can specify values between `1s` and `60s`.

      * `interval` (`string`)

        Health check request interval in seconds.

        You can specify values between `1s` and `60s`. `interval` must exceed `timeout` by at least one second.

      {% include [alb-custom-hc-enabling](../../../_includes/managed-kubernetes/alb-custom-hc-enabling.md) %}