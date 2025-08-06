# GRPCRoute resource fields

The `GRPCRoute` resource sets rules for routing between {{ k8s }} services operating as backends ([Service](../../../application-load-balancer/k8s-ref/service-for-gateway.md) resources) or for traffic redirection. `GRPCRoute` receives incoming traffic from those [`Gateway`](../../../application-load-balancer/k8s-ref/gateway.md) resources whose requirements it meets.


`GRPCRoute` is designed for application developers. Cluster operators should use the `Gateway` resource.

`GRPCRoute` is a [{{ k8s }} Gateway API](https://gateway-api.sigs.k8s.io/) project resource. Below, we describe its fields and annotations used by {{ alb-name }} Gateway API. For configuration details, see the [{{ k8s }} Gateway API reference](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io/v1.GRPCRoute).

## GRPCRoute {#grpc-route}

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: GRPCRoute
metadata:
  name: <string>
  namespace: <string>
spec: <GRPCRouteSpec>
```

Where:

* `apiVersion: gateway.networking.k8s.io/v1`
* `kind: GRPCRoute`
* `metadata` (`ObjectMeta`, required)

  Resource metadata.

  * `name` (`string`, required)

    Resource name. For more information about the group name format, see the relevant [{{ k8s }} article](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

    Do not mistake this name for the {{ alb-name }} route name.
 
  * `namespace` (`string`)

    Resource [namespace](../../../managed-kubernetes/concepts/index.md#namespace). The default value is `default`.

* `spec` (`GRPCRouteSpec`, required)

  Resource specification. For more information, see [below](#spec).


{% cut "Example" %}

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: GRPCRoute
metadata:
  name: mosquitoes-grpc-route
  namespace: mosquitoes-ns
spec:
  hostnames:
  - "forest.zoo.com"
  parentRefs:
  - name: gateway-api-test-gateway
    namespace: default
  rules:
  - backendRefs:
    - name: mosquitoes-service
      port: 8080
    matches:
    - method:
        type: "Exact"
        method: "IdentifyA"
```

{% endcut %}

## GRPCRouteSpec {#spec}

```yaml
parentRefs:
  - namespace: <string>
    name: <string>
    sectionName: <string>
  - ...
hostnames:
  - <string>
  - ...
rules:
  - matches:
      - method:
          type: <string>
          service: <string>
          method: <string>
      - ...
    filters:
      - type: <string>
        requestHeaderModifier:
          set:
            - name: <string>
              value: <string>
            - ...
          add:
            - name: <string>
              value: <string>
            - ...
          remove:
            - <string>
            - ...
    backendRefs:
      - name: <string>
        namespace: <string>
        port: <int32>
        weight: <int32>
      - ...
  - ...
```

Where:

* `parentRefs` (`[]ParentReference`, required)

  `Gateway` resources or their listeners specified in the `spec.listeners` field associated with `GRPCRoute`. For more information, see [this reference](../../../application-load-balancer/k8s-ref/gateway.md#spec).

  Routes must also comply with the [`Gateway`configuration](../../../application-load-balancer/k8s-ref/gateway.md#spec) rules specified in the `spec.listeners.allowedRoutes` field.
  
  * `namespace` (`string`)
    
    `Gateway` namespace specified in its `metadata.namespace` field.
  
    By default, it matches the `GRPCRoute` resource namespace (`metadata.namespace` field).

  * `name` (`string`, required)
    
    `Gateway` name specified in its `metadata.name` field.

  * `sectionName` (`string`)
  
    Name of the listener specified in the `Gateway` resource under `spec.listeners.name`.

* `hostnames ([]string)`

  List of domain names (`:authority` pseudoheader values) for the route. The system will create HTTP router virtual hosts for each specified domain.

  {% include [k8s-ingress-controller-hostnames-wildcard](../../application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %}

* `rules` (`[]GRPCRouteRule`)

  Rules for routing and redirecting gRPC calls.

  * `matches` (`[]GRPCRouteMatch`)
  
    List of conditions, where the gRPC call must meet at least one, for the rule to apply.

    For example, all gRPC calls with names that include the `service.example` and the `Login` method as well as calls with names that include the `service.v2.example` and any of that service’s methods will match the following list of conditions:

    ```yaml
    - matches:
      - method:
          service: service.example
          method: Login
      - method:
          service: service.v2.example
    ```

    Only the `method` field is supported. The `headers` field described in the [Gateway API reference](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io/v1.GRPCHeaderMatch) is not supported.

    * `method` (`GRPCMethodMatch`)
      
        Indicate the gRPC service and gRPC method the call name must consist of. Make sure to fill in at least one of these fields.

      * `service`

        Indicates the gRPC service.

      * `method`

        Indicates the gRPC method.

      * `type` (`GRPCMethodMatchType`)

        Specifies how to indicate the method and service in the call name:

        * `Exact`: Method and/or service must match the `rules.matches.method` value.
        * `RegularExpression`: Method and/or service must match the regular expression specified in the `rules.matches.method` field.

  * `filters` (`[]GRPCRouteFilter`)

    Call header modification settings for backend routing.

    * `type` (`string`)
      
      Filter type:

      * `RequestHeaderModifier`: Call header modification. Specify the required settings in the `requestHeaderModifier` field.

    * `requestHeaderModifier` (`HTTPHeaderFilter`)

        Call header modification settings for the `RequestHeaderModifier` filter type.

        * `set` (`[]HTTPHeader`)
        
          Headers that will be overwritten.

          * `name` (`string`)
            
            Overwritable header name.

          * `value` (`string`)
        
            Header new value.

        * `add` (`[]HTTPHeader`)
        
          Headers that will be added to requests.

          * `name` (`string`)
            
            Added header's name.

          * `value` (`string`)
        
            Added header's value.
      
        * `remove` (`[]string`)
        
          Headers to be removed from requests.

  * `backendRefs` (`[]GRPCBackendRef`)

    [{{ k8s }} service](../../../managed-kubernetes/concepts/index.md#service) backends for processing calls.
      
     * `name` (`string`)

       {{ k8s }} service name. The referred `Service` resource must be described per the [standard configuration](../../../application-load-balancer/k8s-ref/service-for-gateway.md). 

     * `namespace` (`string`)
  
       `Service` resource namespace. By default, it matches the `GRPCRoute` resource namespace (`metadata.namespace` field).

     * `port` (`int32`)

       Service port number.

       This number must match one of the port numbers specified in the `spec.ports.port` fields of the `Service` resource. For more information, see the [resource configuration](../../../application-load-balancer/k8s-ref/service-for-gateway.md).
       
     * `weight` (`int32`)

       Backend weight. Backends in a group receive traffic in proportion to their weights.

       You should either specify weights for all backends in a group, or not specify them at all. If weights are not specified, traffic will be equally distributed across backends.
    
       A backend with zero or negative weight will not be receiving traffic.
