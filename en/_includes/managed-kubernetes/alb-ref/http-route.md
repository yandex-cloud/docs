# HTTPRoute resource fields

The `HTTPRoute` resource sets forth the rules for traffic routing across backends represented by {{ k8s }} services ([Service](../../../application-load-balancer/k8s-ref/service-for-gateway.md) resources) or traffic redirection. `HTTPRoute` receives incoming traffic from those [`Gateway` resources](../../../application-load-balancer/k8s-ref/gateway.md) whose requirements it satisfies.

`HTTPRoute` is designed for application developers. Cluster operators should use `Gateway`.

`HTTPRoute` is a {{ k8s }} resource specified by the [{{ k8s }} Gateway API project](https://gateway-api.sigs.k8s.io/). Below, you can find the descriptions of the resource fields and annotations {{ alb-name }} Gateway API interfaces with. For a full description of the resource configuration, see the [{{ k8s }} Gateway API documentation](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1alpha2.HTTPRoute).

## HTTPRoute {#httproute}

```yaml
apiVersion: gateway.networking.k8s.io/v1alpha2
kind: HTTPRoute
metadata:
  name: <string>
  namespace: <string>
spec: <HTTPRouteSpec>
```

Where:

* `apiVersion`: `gateway.networking.k8s.io/v1alpha2`
* `kind`: `HTTPRoute`
* `metadata` (`ObjectMeta`, required)

  Resource metadata.

  * `name` (`string`, required)

    Resource name. For more information about the format, please see the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

    This name is not the route name in {{ alb-name }}.
 
  * `namespace` (`string`)

    [Namespace](../../../managed-kubernetes/concepts/index.md#namespace) the resource belongs to. The default value is `default`.

* `spec` (`HTTPRouteSpec`, required)

  Resource specification. For more information, see [below](#spec).


## HTTPRouteSpec {#spec}

```yaml
parentRefs:
  - group: <string>
    kind: <string>
    namespace: <string>
    name: <string>
    sectionName: <string>
  - ...
hostnames:
  - <string>
  - ...
rules:
  - matches:
      - path:
          type: <string>
          value: <string>
        method: <string>
      - ...
    filters:
      - <HTTPRouteFilter>
      - ...
    backendRefs:
      - group: <string>
        kind: <string>
        name: <string>
        namespace: <string>
        port: <int32>
        weight: <int32>
        filters:
          - <HTTPRouteFilter>
          - ...
      - ...
  - ...
```

Where:

* `parentRefs` (`[]ParentReference`, required)

  List of the `Gateway` resources (or their listeners from the `spec.listeners` field; see [this reference](../../../application-load-balancer/k8s-ref/gateway.md#spec)) `HTTPRoute` must be linked to.

  The route must also comply with the rules described in the [`Gateway configuration](../../../application-load-balancer/k8s-ref/gateway.md#spec) (the `spec.listeners.allowedRoutes` field).
  
  * `namespace` (`string`)
    
    Namespace the `Gateway` resource belongs to (specified in its metadata in the `metadata.namespace` field).
  
    By default, it matches the namespace of the `HTTPRoute` resource (the `metadata.namespace` field).

  * `name` (`string`, required)
    
    Name of the `Gateway` resource (specified in its metadata in the `metadata.name` field).

  * `sectionName` (`string`)
  
    Name of the listener specified in the `Gateway` resource (specified in the `spec.listeners.name` field).

* `hostnames` (`[]string`)

  List of domain names (values of the `Host` header for HTTP/1.1 or the `:authority` pseudo-header for HTTP/2) for the route. For each hostname, virtual hosts will be created in HTTP routers.

  {% include [k8s-ingress-controller-hostnames-wildcard](../../application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %}

* `rules` (`[]HTTPRouteRule`)

  Rules for routing and redirecting requests.

  * `matches` (`[]HTTPRouteMatch`)
  
    List of conditions at least one of which must be met by the request for the rule to apply.
  
    For example, all `POST` requests to the `/foo` path and all requests to the `/bar` path will meet the conditions listed below:
  
    ```yaml
    matches:
      - path:
          value: /foo
        method: POST
      - path:
          value: /bar
    ```
    
    Only the fields listed below are supported. Other fields described in the [Gateway API reference](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1beta1.HTTPRouteMatch) (`headers` and `queryParams`) are not supported.

    * `path` (`HTTPPathMatch`)
  
      Reference to the path in the request URI.

      * `type` (`string`)
        
        Type of reference to the path in the request URI:

        * `Exact`: The path must _match_ the `rules.matches.path.value` field.
        * `PathPrefix`: The path must _begin_ with the `rules.matches.path.value` field value.

        Apart from traffic distribution, the type affects the path replacement mechanism used during a redirect. For more information, see [below](#filter).

      * `value` (`string`)

        Incoming request URI path (if `Exact`) or its prefix (if `PathPrefix`).
 
    * `method` (`HTTPMethod`)
  
      HTTP method of the request.

  * `filters` (`[]HTTPRouteFilter`)
    
    List of filters describing how request headers are modified when routing a request to any backend or redirecting them. For more information, see [below](#filter).
  
    You can specify either the `RequestHeaderModifier` or the `RequestRedirect` filter, but not both at the same time.

  * `backendRefs` (`[]HTTPBackendRef`)

    List of [{{ k8s }} services](../../../managed-kubernetes/concepts/index.md#service) to handle requests as a backend.

    The `Service` resource this field refers to must be described in line with the [standard configuration](../../../application-load-balancer/k8s-ref/service-for-gateway.md).
  
     * `name` (`string`)

       {{ k8s }} service name.

     * `namespace` (`string`)
  
       Namespace the service belongs to.

     * `port` (`int32`)

       Service port number.

       The number must match one of the port numbers specified in the `spec.ports.port` fields of the `Service` resource. For more information, see the [resource configuration](../../../application-load-balancer/k8s-ref/service-for-gateway.md).

       The field is designed for the Gateway API operation and does not match any of the {{ alb-name }} resource fields.
       
     * `weight` (`int32`)

       Relative backend weight. Traffic is distributed to backends in a group as a function of backend weights.

       Weights must be specified either for all backends in a group, or for none. If weights are not specified, traffic is distributed to the backends as if they had identical positive weights.
    
       If a non-positive weight is specified, a backend will not receive traffic.

     * `filters` (`[]HTTPRouteFilter`)

       Request header modification settings when routing to backend. For more information, see [below](#filter).
  
       You can only specify the `RequestHeaderModifier` filter.


## HTTPRouteFilter {#filter}

```yaml
type: <string>
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
requestRedirect:
  scheme: <string>
  hostname: <string>
  path:
    type: <string>
    replaceFullPath: <string>
    replacePrefixMatch: <string>
  port: <int32>
  statusCode: <int>
```

Where:

* `type` (`string`)
  
  Filter type:

  * `RequestHeaderModifier`: Modifying request headers. Specify the settings in the `requestHeaderModifier` field.
  * `RequestRedirect`: Request redirection. Specify the settings in the `requestRedirect` field.

* `requestHeaderModifier` (`HTTPRequestHeaderFilter`)

  Request header modification settings for the `RequestHeaderModifier` filter type.

  * `set` (`[]HTTPHeader`)
  
    List of headers to be overwritten.

    * `name` (`string`)
      
      Overwritable header name.

    * `value` (`string`)
  
      Value written to the header.

  * `add` (`[]HTTPHeader`)
  
    List of added headers.

    * `name` (`string`)
      
      Added header's name.

    * `value` (`string`)
  
      Added header's value.
 
  * `remove` (`[]string`)
  
    List of headers to be removed.

* `requestRedirect` (`HTTPRequestRedirectFilter`)

  Request redirect settings for the `RequestRedirect` filter type.

  * `scheme` (`string`)
    
    New schema in the request URI: `http` or `https`. By default, the schema remains unchanged.

  * `hostname` (`string`)
    
    New hostname in the request URI. By default, the hostname remains unchanged.

  * `path` (`HTTPPathModifier`)
  
    Settings for replacing the path in the request URI.

    * `type` (`string`)
      
      Path replacement type:
  
      * `ReplaceFullPath`: Replacing full path. Specify a new path in the `replaceFullPath` field.
      * `ReplacePrefixMatch`: Replacement depending on the [`HTTPRoute` specification](#spec) path (the `spec.rules.matches.path` field): if `Exact`, the full path is replaced; if `PathPrefix`, only the prefix is replaced. Specify a new path or its prefix in the `replacePrefixMatch` field.

    * `replaceFullPath` (`string`)
      
      New path if the `ReplaceFullPath` type is used.

    * `replacePrefixMatch` (`string`)
  
      New path or its prefix if the `ReplacePrefixMatch` type is used (see the type description above).

  * `port` (`int32`)
    
    New port in the request URI.
    
  * `statusCode` (`int`)
  
    HTTP status code returned in the event of a redirect.