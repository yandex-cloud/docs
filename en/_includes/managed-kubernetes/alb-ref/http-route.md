# HTTPRoute resource fields


The `HTTPRoute` resource defines the rules for routing traffic to backends that are {{ k8s }} services ([`Service` resources](../../../application-load-balancer/k8s-ref/service.md)) or redirecting it. `HTTPRoute` receives incoming traffic from the [`Gateway` resources](../../../application-load-balancer/k8s-ref/gateway.md) whose requirements it meets.

`HTTPRoute` is designed for application developers. Cluster operators should use `Gateway`.

`HTTPRoute` is a {{ k8s }} resource specified by the [{{ k8s }} Gateway API project](https://gateway-api.sigs.k8s.io/). This reference describes fields and annotations of the resource that the {{ alb-name }} Gateway API interfaces with. For a complete reference for the resource, see the [{{ k8s }} Gateway AP documentation](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1alpha2.HTTPRoute).

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

      Does not match the route name in {{ alb-name }}.

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

   List of `Gateway` resources (or their listeners from the `spec.listeners` field, see the [reference](../../../application-load-balancer/k8s-ref/gateway.md#spec)), that `HTTPRoute` should be linked to.

   The route should also meet the rules described in the `Gateway` [specification](../../../application-load-balancer/k8s-ref/gateway.md#spec) (the `spec.listeners.allowedRoutes` field).

   * `namespace` (`string`)

      Namespace the `Gateway` resource belongs to (specified in its metadata in the `metadata.namespace` field).

      By default, matches the namespace of the `HTTPRoute` resource (the `metadata.namespace` field).

   * `name` (`string`, required)

      Name of the `Gateway` resource (specified in its metadata in the `metadata.name` field).

   * `sectionName` (`string`)

      Name of the listener specified in the `Gateway` resource (specified in the `spec.listeners.name` field).

* `hostnames` (`[]string`)

   List of domain names (values of the `Host` header for HTTP/1.1 or the `:authority` pseudo-header for HTTP/2) matching the route. For each hostname, virtual hosts will be created in HTTP routers.

   {% include [k8s-ingress-controller-hostnames-wildcard](../../application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %}

* `rules` (`[]HTTPRouteRule`)

   Rules for routing and redirecting requests.

   * `matches` (`[]HTTPRouteMatch`)

      List of conditions at least one of which must be met by a request to apply the rule to it.

      For example, any `POST` request to the `/foo` path and any request to the `/bar` path will meet the list of conditions below:

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

            * `Exact`: The path must _exactly match_ the `rules.matches.path.value` field value.
            * `PathPrefix`: The path must _begin_ with the `rules.matches.path.value` field value.

            Apart from traffic distribution, the type affects the path replacement mechanism used during a redirect. For more information, see [below](#filter).

         * `value` (`string`)

            Path in the incoming request URI (if `Exact`) or its prefix (if `PathPrefix`).

      * `method` (`HTTPMethod`)

         HTTP method of the request.

   * `filters` (`[]HTTPRouteFilter`)

      List of filters describing how request headers are modified when routing a request to any backend or redirecting them. For more information, see [below](#filter).

      You can only set either the `RequestHeaderModifier` filter or the `RequestRedirect` filter, but not both of them at the same time.

   * `backendRefs` (`[]HTTPBackendRef`)

      List of [{{ k8s }} services](../../../managed-kubernetes/concepts/index.md#service) to handle requests as a backend.

      The `Service` resource this field points to must be described as in the [specification](../../../application-load-balancer/k8s-ref/service.md).

      * `name` (`string`)

         {{ k8s }} service name.

      * `namespace` (`string`)

         Namespace the service belongs to.

      * `port` (`int32`)

         Service port number.

         The number must match one of the port numbers specified in the `spec.ports.port` fields of the `Service` resource. For more information, see the [resource specification](../../../application-load-balancer/k8s-ref/service.md).

         The field is designed for the Gateway API operation and does not match any of the {{ alb-name }} resource fields.

      * `weight` (`int32`)

         Relative backend weight. Traffic is distributed to backends in a group as a function of backend weights.

         Weights must be specified either for all backends in a group, or for none. If weights are not specified, traffic is distributed to the backends as if they had identical positive weights.

         If a non-positive weight is specified, a backend will not receive traffic.

      * `filters` (`[]HTTPRouteFilter`)

         Settings for modifying request headers when routing requests to backends. For more information, see [below](#filter).

         You can only set the `RequestHeaderModifier` filter type.


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

   * `RequestHeaderModifier`: Request headers are modified. Specify the settings in the `requestHeaderModifier` field.
   * `RequestRedirect`: Requests are redirected. Specify the settings in the `requestRedirect` field.

* `requestHeaderModifier` (`HTTPRequestHeaderFilter`)

   Settings for modifying request headers for the `RequestHeaderModifier` filter type.

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

         * `ReplaceFullPath`: Full path is replaced. Specify a new path in the `replaceFullPath` field.
         * `ReplacePrefixMatch`: Replacement depending on the path set in the [`HTTPRoute` specification](#spec) (the `spec.rules.matches.path` field): if `Exact`, the full path is replaced and if `PathPrefix`, its prefix only. Specify a new path or its prefix in the `replacePrefixMatch` field.

      * `replaceFullPath` (`string`)

         New path if the `ReplaceFullPath` type is used.

      * `replacePrefixMatch` (`string`)

         New path or its prefix if the `ReplacePrefixMatch` type is used (see the type description above).

   * `port` (`int32`)

      New port in the request URI.

   * `statusCode` (`int`)

      HTTP status code returned in the event of a redirect.