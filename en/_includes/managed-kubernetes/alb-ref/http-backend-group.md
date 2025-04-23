# `HttpBackendGroup` resource fields

`HttpBackendGroup` enables you to combine {{ k8s }} service backends into a group. The [{{ alb-name }} Ingress controller](../../../application-load-balancer/tools/k8s-ingress-controller/index.md) uses these resources to create [backend groups](../../../application-load-balancer/concepts/backend-group.md).

You need to add a reference to `HttpBackendGroup` to the [`Ingress` resource](../../../application-load-balancer/k8s-ref/ingress.md).

{% include [k8s-ingress-controller-backend-group-features](../../application-load-balancer/k8s-ingress-controller-backend-group-features.md) %}

`HttpBackendGroup` is a [custom resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) from the `alb.yc.io` API group provided by an Ingress controller.

## HttpBackendGroup {#http-backend-group}

```yaml
apiVersion: alb.yc.io/v1alpha1
kind: HttpBackendGroup
metadata:
  name: <string>
spec:
  backends:
    - name: <string>
      weight: <int64>
      useHttp2: <bool>
      service:
         name: <int64>
         port:
           name: <string>
           number: <int32>
      storageBucket:
        name: <string>
      tls:
        sni: <string>
        trustedCa: <string>
      healthChecks:
        - http:
            path: <string>
          port: <int32>
          healthyThreshold: <int32>
          unhealthyThreshold: <int32>
          timeout: <string>
          interval: <string>
      loadBalancingConfig:
        balancerMode: <string>
        panicThreshold: <int64>
        localityAwareRouting: <int64>
    - ...
```

Where:

* `apiVersion`: `alb.yc.io/v1alpha1`
* `kind`: `HttpBackendGroup`
* `metadata` (`ObjectMeta`, required)
  
  Resource metadata.

  * `name` (`string`, required)

    Resource name. For more information about the name format, see the relevant [{{ k8s }} guides](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).
  
    You must specify this name in the `spec.rules.http.paths.backend.resource.name` field of the `Ingress` resource. For more information, see the [relevant configuration](../../../application-load-balancer/k8s-ref/ingress.md).

    Do not mistake this name for the {{ alb-name }} backend group name.

* `spec` (`HttpBackendGroupSpec`)

  Resource specification.
  
  * `backends` (`[]HttpBackend`)
  
    Group backends.
    
    * `name` (`string`, required)
    
      Backend name.
    
    * `weight` (`int64`)

      Backend weight. Backends in a group receive traffic in proportion to their weights.

      You should either specify weights for all backends in a group, or not specify them at all. If weights are not specified, traffic will be equally distributed across backends.

      A backend with zero or negative weight will not be receiving traffic.
    
    * `useHttp2` (`bool`)
    
      Enables HTTP/2 connections between load balancer nodes and backend endpoints.

      The default value is `false`, which means only HTTP/1.1 connections are allowed.

    * `service` (`ServiceBackend`)

      [{{ k8s }} service](../../../managed-kubernetes/concepts/index.md#service) backend for processing requests.

      The referred `Service` resource must be described per the [standard configuration](../../../application-load-balancer/k8s-ref/service-for-ingress.md).

      You must specify a service or an {{ objstorage-name }} bucket, i.e.,`storageBucket`, for the backend. You cannot specify both at the same time.

      {% include [k8s-ingress-controller-service-backend](../../application-load-balancer/k8s-ingress-controller-service-backend.md) %}
        
    * `storageBucket` (`StorageBucketBackend`)

      [{{ objstorage-full-name }} bucket](../../../storage/concepts/bucket.md) backend for processing requests. To learn more about using a bucket as a backend, see [{#T}](../../../application-load-balancer/concepts/backend-group.md#types).

      {% include [bucket-availability-note](../../../application-load-balancer/_includes_service/bucket-availability-note.md) %}

      You must specify a bucket or {{ k8s }} `service` for the backend. You cannot specify both at the same time.
      
      * `name` (`string`, required)
      
        Bucket name.
        
    * `tls` (`BackendTLS`)
    
      TLS connection settings for the load balancer nodes and backend endpoints.
    
      If this field is specified, the load balancer will establish TLS connections to the backend, comparing received certificates with the one specified in the `trustedCa` field. Otherwise, the load balancer will use unencrypted connections to the backend.
        
      * `sni` (`string`)
      
        SNI domain name for TLS connections.
      
      * `trustedCa` (`string`)
      
        X.509 certificate in PEM format.

    * `healthChecks` (`[]HealthChecks`)

      Custom [health checks](../../../application-load-balancer/concepts/backend-group.md#health-checks) settings for {{ managed-k8s-name }} cluster applications.

      By default, the {{ alb-name }} Ingress controller receives L7 load balancer health check requests on TCP port `10501`. Then it checks [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/) pods on each cluster node. Given that kube-proxy is healthy, the process is as follows: if an application does not respond in a particular pod, {{ k8s }} redirects traffic to a different pod or node.
      
      You can use `healthChecks` settings to [customize application health checks](../../../managed-kubernetes/tutorials/custom-health-checks.md).

      * `http` (`HttpBackend`)

        Specifies HTTP as the health check protocol.

        * `path` (`string`)

          Application endpoint URI path for health check requests, e.g. `/health`.

      * `port` (`int32`)

        Cluster node port for checking application availability. This port should match the `spec.ports.nodePort` value of the `NodePort` [Service](../../../application-load-balancer/k8s-ref/service-for-ingress.md) resource.

        The application will listen for health check requests on `http://<node_IP_address>:<port>/<path>`.

      * `healthyThreshold` (`int32`)

        Number of consecutive successful checks required before considering the application endpoint healthy.

      * `unhealthyThreshold` (`int32`)

        Number of consecutive failed checks required before considering the application endpoint unhealthy.

      * `timeout` (`string`)

        Response timeout in seconds. You can specify values between `1s` and `60s`.

      * `interval` (`string`)

        Health check request interval in seconds.

        You can specify values between `1s` and `60s`. `interval` must exceed `timeout` by at least one second.

      {% include [alb-custom-hc-enabling](../../../_includes/managed-kubernetes/alb-custom-hc-enabling.md) %}

    * `loadBalancingConfig` (`LoadBalancingConfig`)

      Load balancing settings.

      * `balancerMode` (`string`)

        Traffic distribution mode. It is an algorithm according to which the load balancer distributes traffic across backend endpoints. Possible values: `ROUND_ROBIN`, `RANDOM`, `LEAST_REQUEST`, and `MAGLEV_HASH`. [Learn more about each mode](../../../application-load-balancer/concepts/backend-group.md#balancing-mode).

      * `panicThreshold` (`int64`)

        Minimum percentage of healthy endpoints. If the percentage of healthy endpoints falls below the specified value, it will trigger the [panic mode](../../../application-load-balancer/concepts/backend-group.md#panic-mode).

        The default value is `0`, which means the panic mode will never be activated.

      * `localityAwareRouting` (`int64`)

        Share of incoming traffic the load balancer will forward to its availability zone backends. The remaining traffic will be evenly distributed across other availability zones. [More on locality-aware routing](../../../application-load-balancer/concepts/backend-group.md#locality).

        The default value is `0`.



