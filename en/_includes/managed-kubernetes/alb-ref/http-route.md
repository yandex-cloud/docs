# HTTPRoute resource fields

The `HTTPRoute` resource contains traffic routing and redirection rules for {{ k8s }} service backends, i.e., [Service](../../../application-load-balancer/k8s-ref/service-for-gateway.md) resources. `HTTPRoute` receives incoming traffic from [`Gateway` resources](../../../application-load-balancer/k8s-ref/gateway.md) whose requirements it meets.

The `HTTPRoute` resource is designed for application developers. Cluster operators should use the `Gateway` resource.

`HTTPRoute` is a [{{ k8s }} Gateway API](https://gateway-api.sigs.k8s.io/) project resource. Below, we describe its fields and annotations used by {{ alb-name }} Gateway API. For configuration details, see the [{{ k8s }} Gateway API reference](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1alpha2.HTTPRoute).

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

    Resource name. For more information about the name format, see the relevant [{{ k8s }} guides](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

    Do not mistake this name for the {{ alb-name }} route name.
 
  * `namespace` (`string`)

    Resource [namespace](../../../managed-kubernetes/concepts/index.md#namespace). The default value is `default`.

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

  `Gateway` resources or their listeners specified in the `spec.listeners` field associated with `HTTPRoute`. For more information, see [this reference](../../../application-load-balancer/k8s-ref/gateway.md#spec).

  Routes must also comply with the [Gateway configuration](../../../application-load-balancer/k8s-ref/gateway.md#spec) rules specified in the `spec.listeners.allowedRoutes` field.
  
  * `namespace` (`string`)
    
    `Gateway` namespace specified in its `metadata.namespace` field.
  
    By default, it matches the `HTTPRoute` namespace specified in its `metadata.namespace` field.

  * `name` (`string`, required)
    
    `Gateway` name specified in its `metadata.name` field.

  * `sectionName` (`string`)
  
    `Gateway` listener specified in its `spec.listeners.name` field.

* `hostnames` (`[]string`)

  HTTP/1.1 `Host` (HTTP/2 `:authority`) header domains for this route. The system will create HTTP router virtual hosts for each specified domain.

  {% include [k8s-ingress-controller-hostnames-wildcard](../../application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %}

* `rules` (`[]HTTPRouteRule`)

  Request routing and redirection rules.

  * `matches` (`[]HTTPRouteMatch`)
  
    List of conditions, where the request must meet at least one, for the rule to apply.
  
    For example, the conditions below allow `POST` requests to the `/foo` endpoint and any requests to the `/bar` endpoint:
  
    ```yaml
    matches:
      - path:
          value: /foo
        method: POST
      - path:
          value: /bar
    ```
    
    You can only use fields listed below. Other fields described in the [Gateway API reference](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1beta1.HTTPRouteMatch), e.g.,`headers` and `queryParams`, are not supported.

    * `path` (`HTTPPathMatch`)
  
      Request URI path.

      * `type` (`string`)
        
        Request URI path type:

        * `Exact`: Path must _match_ `rules.matches.path.value`.
        * `PathPrefix`: Path must _begin_ with `rules.matches.path.value`.

        The selected path type will affect traffic distribution and the path replacement mechanism for redirects. For more information, see [below](#filter).

      * `value` (`string`)

        Incoming request URI full path or its prefix, depending on whether the `Exact` or `PathPrefix` option is selected, respectively.
 
    * `method` (`HTTPMethod`)
  
      Request HTTP method.

  * `filters` (`[]HTTPRouteFilter`)
    
    Filters specifying request header modifications for backend routing and redirection. For more information, see [below](#filter).
  
    You can specify either the `RequestHeaderModifier` or the `RequestRedirect` filter, but not both at the same time.

  * `backendRefs` (`[]HTTPBackendRef`)

    [{{ k8s }} service](../../../managed-kubernetes/concepts/index.md#service) backends for processing requests.

    The referred `Service` resource must be described per the [standard configuration](../../../application-load-balancer/k8s-ref/service-for-gateway.md).
  
     * `name` (`string`)

       {{ k8s }} service name.

     * `namespace` (`string`)
  
       Service namespace.

     * `port` (`int32`)

       Service port number.

       The port number must match one of the `Service` resource `spec.ports.port` field values. For more information, see the [resource configuration](../../../application-load-balancer/k8s-ref/service-for-gateway.md).

       This field is designed for the Gateway API and has no equivalents in {{ alb-name }}.
       
     * `weight` (`int32`)

       Backend weight. Backends in a group receive traffic in proportion to their weights.

       You should either specify weights for all backends in a group, or not specify them at all. If weights are not specified, traffic will be equally distributed across backends.
    
       A backend with zero or negative weight will not be receiving traffic.

     * `filters` (`[]HTTPRouteFilter`)

       Request header modification settings for backend routing. For more information, see this [example](#filter).
  
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

  * `RequestHeaderModifier`: Request header modification. Specify the required settings in the `requestHeaderModifier` field.
  * `RequestRedirect`: Request redirection. Specify the required settings in the `requestRedirect` field.

* `requestHeaderModifier` (`HTTPRequestHeaderFilter`)

  Request header modification settings for the `RequestHeaderModifier` filter type.

  * `set` (`[]HTTPHeader`)
  
    Headers that will be overwritten.

    * `name` (`string`)
      
      Header name.

    * `value` (`string`)
  
      Header new value.

  * `add` (`[]HTTPHeader`)
  
    Headers that will be added to requests.

    * `name` (`string`)
      
      Header name.

    * `value` (`string`)
  
      Header value.
 
  * `remove` (`[]string`)
  
    Headers to be removed from requests.

* `requestRedirect` (`HTTPRequestRedirectFilter`)

  Request redirect settings for the `RequestRedirect` filter type.

  * `scheme` (`string`)
    
    New request URI scheme, e.g., `http` or `https`. By default, the scheme remains unchanged.

  * `hostname` (`string`)
    
    New request URI hostname. By default, the hostname remains unchanged.

  * `path` (`HTTPPathModifier`)
  
    Request URI path replacement settings.

    * `type` (`string`)
      
      Path replacement type:
  
      * `ReplaceFullPath`: Full path replacement. Specify the new path in the `replaceFullPath` field.
      * `ReplacePrefixMatch`: Full path or prefix replacement based on the [`HTTPRoute`](#spec) `spec.rules.matches.path` value: `Exact` or `PathPrefix`, respectively. Specify the new path or its prefix in the `replacePrefixMatch` field.

    * `replaceFullPath` (`string`)
      
      New path for the `ReplaceFullPath` replacement type.

    * `replacePrefixMatch` (`string`)
  
      New path or its prefix for the `ReplacePrefixMatch` replacement type.

  * `port` (`int32`)
    
    New request URI port.
    
  * `statusCode` (`int`)
  
    Redirect HTTP status code.