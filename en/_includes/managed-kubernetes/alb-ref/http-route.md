# HTTPRoute resource fields

The `HTTPRoute` resource sets traffic routing rules for {{ k8s }} services ([Service](../../../application-load-balancer/k8s-ref/service-for-gateway.md) resources) operating as backends or redirection rules. `HTTPRoute` receives incoming traffic from those [Gateway resources](../../../application-load-balancer/k8s-ref/gateway.md) whose requirements it meets.

`HTTPRoute` is designed for application developers. Cluster operators should use the `Gateway` resource.

`HTTPRoute` is a [{{ k8s }} Gateway API](https://gateway-api.sigs.k8s.io/) project resource. Below, we describe its fields and annotations used by the {{ alb-name }} Gateway API. For configuration details, see the [{{ k8s }} Gateway API reference](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1.HTTPRoute).

## HTTPRoute {#httproute}

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: <string>
  namespace: <string>
  annotations:
    gateway.alb.yc.io/rules.backends.http.useHTTP2: <bool>
    gateway.alb.yc.io/rules.backends.balancing.mode: <string>
    gateway.alb.yc.io/rules.backends.balancing.localityAwareRouting: <string>
    gateway.alb.yc.io/rules.backends.balancing.strictLocality: <bool>
    gateway.alb.yc.io/rules.backends.balancing.panicThreshold: <string>
    gateway.alb.yc.io/rule.<rule_name>.backends.balancing.mode: <string>
    gateway.alb.yc.io/rules.backends.hc.timeout: <string>
    gateway.alb.yc.io/rules.backends.hc.interval: <string>
    gateway.alb.yc.io/rules.backends.hc.healthyThreshold: <string>
    gateway.alb.yc.io/rules.backends.hc.unhealthyThreshold: <string>
    gateway.alb.yc.io/rules.backends.hc.port: <string>
    gateway.alb.yc.io/rules.backends.hc.http.path: <string>
    gateway.alb.yc.io/rules.backends.hc.http.useHTTP2: <bool>
    gateway.alb.yc.io/rules.backends.hc.http.host: <string>
    gateway.alb.yc.io/rules.backends.hc.grpc.serviceName: "Check"
    gateway.alb.yc.io/rules.backends.hc.stream.send: <string>
    gateway.alb.yc.io/rules.backends.hc.stream.receive: <string>
    gateway.alb.yc.io/rules.sessionAffinity.header.name: <string>
    gateway.alb.yc.io/rules.sessionAffinity.cookie.name: <string>
    gateway.alb.yc.io/rules.sessionAffinity.cookie.ttl: <string>
    gateway.alb.yc.io/rules.sessionAffinity.sourceIP: <bool>
    gateway.alb.yc.io/rules.timeout: <string>
    gateway.alb.yc.io/rules.idleTimeout: <string>
    gateway.alb.yc.io/rule.<rule_name>.timeout: <string>
    gateway.alb.yc.io/rule.<rule_name>.idleTimeout: <string>
    gateway.alb.yc.io/rules.httpUpgradeTypes: <string>
    gateway.alb.yc.io/rules.securityProfileId: <string>
    gateway.alb.yc.io/rules.rbac.action: <string>
    gateway.alb.yc.io/rules.rbac.principals.<group_name>.<principal_name>.header.name: <string>
    gateway.alb.yc.io/rules.rbac.principals.<group_name>.<principal_name>.header.regex: <string>
    gateway.alb.yc.io/rules.rbac.principals.<group_name>.<principal_name>.header.exact: <string>
    gateway.alb.yc.io/rules.rbac.principals.<group_name>.<principal_name>.header.prefix: <string>
    gateway.alb.yc.io/rules.rbac.principals.<group_name>.<principal_name>.ip.remoteIp: <string>
    gateway.alb.yc.io/rules.rbac.principals.<group_name>.<principal_name>.any: <bool>
    gateway.alb.yc.io/hosts.securityProfileId: <string>
    gateway.alb.yc.io/hosts.rbac.action: <string>
spec: <HTTPRouteSpec>
```

Where:

* `apiVersion`: `gateway.networking.k8s.io/v1`
* `kind`: `HTTPRoute`
* `metadata` (`ObjectMeta`; this is a required field)

  Resource metadata.

  * `name` (`string`; this is a required field)

    Resource name. For more information about the format, see [this {{ k8s }} guide](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

    Do not mistake this name for the {{ alb-name }} route name.

  * `namespace` (`string`)

    [Namespace](../../../managed-kubernetes/concepts/index.md#namespace) the resource belongs to. The default value is `default`.

  * `annotations` (`map[string]string`)

    Resource annotations.

    {% note info %}

    You can define the [RoutePolicy](../../../application-load-balancer/k8s-ref/route-policy.md) resource instead of annotations. The `RoutePolicy` resource parameters and `HTTPRoute` annotations are equivalent.

    {% endnote %}

    * `gateway.alb.yc.io/rules.timeout` (`string`)

      Timeout for HTTP connection between the load balancer and backend. The connection is maintained until the specified time expires regardless of any outgoing data transfer. After the timeout expires, the resource returns the `UNAVAILABLE` status.

    * `gateway.alb.yc.io/rules.idleTimeout` (`string`)

      Inactive HTTP connection timeout during which no data is transferred. After the timeout expires, the resource returns the `504 Gateway Timeout` status.
    
    * `gateway.alb.yc.io/rules.securityProfileId` (`string`)
    
      {{ sws-name }} [security profile](../../../smartwebsecurity/concepts/profiles.md) ID for the route.

    * `gateway.alb.yc.io/hosts.securityProfileId` (`string`)
    
      Security profile ID for the host.

    * `gateway.alb.yc.io/rules.backends.http.useHTTP2`

      Use HTTP/2 for connection between the load balancer and backend.

    * `gateway.alb.yc.io/rules.sessionAffinity.header.name`

      HTTP header name for [session affinity](../../../application-load-balancer/concepts/backend-group.md#session-affinity).

    * `gateway.alb.yc.io/rules.sessionAffinity.cookie.name`

      Cookie name for session affinity.

    * `gateway.alb.yc.io/rules.sessionAffinity.cookie.ttl`

      Cookie lifetime for session affinity.

    * `gateway.alb.yc.io/rules.sessionAffinity.sourceIP`

      Indicator of using a client IP address for session affinity.

    * `gateway.alb.yc.io/rules.backends.balancing.mode`

      Load balancing mode. The possible values are `RANDOM`, `ROUND_ROBIN`, and `LEAST_REQUEST`.

    * `gateway.alb.yc.io/rules.backends.balancing.localityAwareRouting`

      Percentage of traffic that goes to the `HTTPRoute` resource's availability zone with `healthy` backends. The remaining traffic is distributed across other availability zones. The parameter is not applied if `strictLocality=true` (see below).

    * `gateway.alb.yc.io/rules.backends.balancing.strictLocality`

      Strictly local routing of traffic to backends (only in the `HTTPRoute` resource's availability zone).

    * `gateway.alb.yc.io/rules.backends.balancing.panicThreshold`

      Panic mode threshold for load balancing in %.

    * `gateway.alb.yc.io/rules.backends.hc.timeout`

      Health check response timeout.

    * `gateway.alb.yc.io/rules.backends.hc.interval`

      Health check interval.

    * `gateway.alb.yc.io/rules.backends.hc.healthyThreshold`

      Number of successful health checks for resource to get the `healthy` status.

    * `gateway.alb.yc.io/rules.backends.hc.unhealthyThreshold`

      Number of failed health checks for resource to get the `unhealthy` status.

    * `gateway.alb.yc.io/rules.backends.hc.port`

      Health check port.

    * `gateway.alb.yc.io/rules.backends.hc.http.path`

      Path for HTTP health checks, e.g., `/health`. It is used for HTTP(S) backends.

    * `gateway.alb.yc.io/rules.backends.hc.http.useHTTP2`

      Use HTTP/2 for health checks. HTTP/1.1 is used by default. It is used for HTTP(S) backends.

    * `gateway.alb.yc.io/rules.backends.hc.http.host`

      Host address for HTTP health checks.

    * `gateway.alb.yc.io/rules.backends.hc.grpc.serviceName`

      gRPC service name for gRPC backend health checks.

    * `gateway.alb.yc.io/rules.backends.hc.stream.send`

      Data to send for a TCP health check. It is used for backends with a TCP interface.

    * `gateway.alb.yc.io/rules.backends.hc.stream.receive`

      Expected response in a TCP health check. It is used for backends with a TCP interface.

    * `gateway.alb.yc.io/rules.timeout`

      Total HTTP connection timeout between the load balancer and backend.

    * `gateway.alb.yc.io/rules.idleTimeout`

      Inactive HTTP connection timeout.

    * `gateway.alb.yc.io/rules.httpUpgradeTypes`

      Supported `HTTP Upgrade` values, e.g., websocket.

    * `gateway.alb.yc.io/rules.securityProfileId`

      {{ sws-name }} security profile ID for the route.

    * `gateway.alb.yc.io/rules.rbac.action`
    
      Action when specified conditions (`ALLOW`/`DENY`) match for backend access control.

    * `gateway.alb.yc.io/rules.rbac.principals.<group_name>.<principal_name>.header.name`

      Header name for RBAC condition checks.

    * `gateway.alb.yc.io/rules.rbac.principals.<group_name>.<principal_name>.header.regex`

      Regular expression for checking header value to manage access to the host over RBAC.

    * `gateway.alb.yc.io/rules.rbac.principals.<group_name>.<principal_name>.header.exact`

      Exact header value to manage access to the host over RBAC.

    * `gateway.alb.yc.io/rules.rbac.principals.<group_name>.<principal_name>.header.prefix`

      Header value prefix to manage access to the host over RBAC.

    * `gateway.alb.yc.io/rules.rbac.principals.<group_name>.<principal_name>.ip.remoteIp`

      IP address or CIDR block to manage access to the host over RBAC.

    * `gateway.alb.yc.io/rules.rbac.principals.<group_name>.<principal_name>.any`

      Any match of specified conditions to manage access to the host over RBAC (`true`/`false`).

    * `gateway.alb.yc.io/hosts.rbac.action`

      Action when specified conditions match (`ALLOW`/`DENY`) to manage access to the host over RBAC.

    * `gateway.alb.yc.io/rule.<rule_name>.backends.balancing.mode`

      Load balancing mode for a given rule. The possible values are `RANDOM`, `ROUND_ROBIN`, and `LEAST_REQUEST`.

    * `gateway.alb.yc.io/rule.<rule_name>.timeout`

      Timeout for a given load balancing rule.

    * `gateway.alb.yc.io/rule.<rule_name>.idleTimeout`

      Inactivity timeout for a given load balancing rule.

* `spec` (`HTTPRouteSpec`; this is a required field)

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

* `parentRefs` (`[]ParentReference`; this is a required field)

  `Gateway` resources or their listeners specified in the `spec.listeners` field associated with `HTTPRoute`. For more information, see [this reference](../../../application-load-balancer/k8s-ref/gateway.md#spec).

  The route must also comply with the rules described in the `Gateway` [configuration](../../../application-load-balancer/k8s-ref/gateway.md#spec) (`spec.listeners.allowedRoutes` field).
  
  * `namespace` (`string`)

    Namespace the `Gateway` resource belongs to (see the `metadata.namespace` field in its metadata).

    By default, it matches the `HTTPRoute` resource namespace (`metadata.namespace` field).

  * `name` (`string`; this is a required field)

    Name of the `Gateway` resource (see the `metadata.name` field in its metadata).

  * `sectionName` (`string`)

    Name of the listener specified in the `Gateway` resource (see the `spec.listeners.name` field in its metadata).

* `hostnames` (`[]string`)

  List of domain names (values of the `Host` header for HTTP/1.1 or the `:authority` pseudo-header for HTTP/2) for the route. The system will create virtual hosts in HTTP routers for each domain name.

  {% include [k8s-ingress-controller-hostnames-wildcard](../../application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %}

* `rules` (`[]HTTPRouteRule`)

  Request routing and redirection rules.

  * `matches` (`[]HTTPRouteMatch`)

    List of conditions for the rule to apply to a request if it meets at least one of them.

    For example, the conditions below allow all `POST` requests to the `/foo` endpoint and any requests to the `/bar` endpoint:

    ```yaml
    matches:
      - path:
          value: /foo
        method: POST
      - path:
          value: /bar
    ```

    You can only use fields listed below. Other fields described in the [Gateway API reference](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1.HTTPRouteMatch), i.e.,`headers` and `queryParams`, are not supported.

    * `path` (`HTTPPathMatch`)

      Reference to the path in the request URI.

      * `type` (`string`)

        Type of reference to the path in the request URI:

        * `Exact`: Path must _match_ `rules.matches.path.value`.
        * `PathPrefix`: Path must _begin_ with `rules.matches.path.value`.

        The selected path type will affect traffic distribution and the path replacement mechanism for redirects. For more information, see [below](#filter).

      * `value` (`string`)

        Incoming request URI full path or its prefix, depending on whether `Exact` or `PathPrefix` is selected, respectively.
 
    * `method` (`HTTPMethod`)

      Request HTTP method.

  * `filters` (`[]HTTPRouteFilter`)

    Filters specifying how request headers are modified when routing a request to any backend or redirecting it. For more information, see [below](#filter).

    You can specify either the `RequestHeaderModifier` or the `RequestRedirect` filter, but not both at the same time.

  * `backendRefs` (`[]HTTPBackendRef`)

    [{{ k8s }} services](../../../managed-kubernetes/concepts/index.md#service) for processing requests as backends.

    You can specify either the [YCStorageBucket](../../../application-load-balancer/k8s-ref/yc-storage-bucket.md) resource ({{ objstorage-name }} bucket) or the [Service](../../../application-load-balancer/k8s-ref/service-for-gateway.md) resource.

     * `name` (`string`)

       Name of {{ k8s }} service or bucket resource.

     * `namespace` (`string`)
  
       Namespace the service or bucket resource belongs to.

     * `group` (`string`)

       Name of the {{ k8s }} API group the bucket resource belongs to, e.g., `gwin.yandex.cloud`. Only for the `YCStorageBucket` resource.

       The default value is an empty string that indicates the root API group.

     * `kind` (`string`)

       Type of the {{ k8s }} resource with a bucket. Only for the `YCStorageBucket` resource. The `YCStorageBucket` value is used.

     * `port` (`int32`)

       Service port number. Only for the `Service` resource.

       This number must match one of the port numbers specified in the `spec.ports.port` fields of the `Service` resource. For more information, see the [resource configuration](../../../application-load-balancer/k8s-ref/service-for-gateway.md).

       This field is designed for the Gateway API and does not match any of the {{ alb-name }} resource fields.

     * `weight` (`int32`)

       Backend weight. Backends in a group receive traffic in proportion to their weights.

       You should either specify weights for all backends in a group, or not specify them at all. If weights are not specified, traffic will be equally distributed across backends.

       A backend with zero or negative weight will not be receiving traffic.

     * `filters` (`[]HTTPRouteFilter`)

       Settings for modifying request headers when routing requests to backends. For more information, see [below](#filter).

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

    Headers to overwrite.

    * `name` (`string`)

      Header name to overwrite.

    * `value` (`string`)

      Value written to the header.

  * `add` (`[]HTTPHeader`)

    Headers to add.

    * `name` (`string`)

      Name of the header to add.

    * `value` (`string`)

      Value of the header to add.
 
  * `remove` (`[]string`)

    Header names to remove.

* `requestRedirect` (`HTTPRequestRedirectFilter`)

    {% include [gateway-filters-support-note](./gateway-filters-support-note.md) %}

  Request redirect settings for the `RequestRedirect` filter type.

  * `scheme` (`string`)

    New request URI scheme, either `http` or `https`. By default, the scheme remains unchanged.

    For redirection to work, an HTTPS traffic listener must be configured for Gateway.

    [Below](#example-scheme-redirect) is an example of request redirection with scheme change.

  * `hostname` (`string`)

    New domain name in the request URI. By default, the domain name remains unchanged.

    [Below](#example-hostname-redirect) is an example of request redirection with domain name change.

  * `path` (`HTTPPathModifier`)

    Settings for replacing the path in the request URI.

    * `type` (`string`)

      Path replacement type:

      * `ReplaceFullPath`: Full path replacement. Specify the new path in the `replaceFullPath` field.
      * `ReplacePrefixMatch`: Full path or prefix replacement based on the [`HTTPRoute`](#spec) `spec.rules.matches.path` value: `Exact` or `PathPrefix`, respectively. Specify the new path or its prefix in the `replacePrefixMatch` field.

    * `replaceFullPath` (`string`)

      New path for the `ReplaceFullPath` replacement type.

    * `replacePrefixMatch` (`string`)

      New path or its prefix for the `ReplacePrefixMatch` replacement type. See the type description above.

  * `port` (`int32`)

    New port in the request URI.

  * `statusCode` (`int`)

    Redirect HTTP status code.

## Examples of manifests for HTTPRoute resources {#examples}

{% include [gateway-filters-support-note](./gateway-filters-support-note.md) %}

### Request redirection with scheme change {#example-scheme-redirect}

In this example, requests arriving at the `http` listener configured for `sample-gateway` are routed. For redirection to work, an HTTPS traffic listener must be configured for Gateway.

All requests to `http://demo.example.com/sample` will be redirected to `https://demo.example.com/sample` with the HTTP code [301 Moved Permanently](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/301).

{% cut "Manifest for HTTPRoute: Request redirection with scheme change" %}

```yaml
apiVersion: gateway.networking.k8s.io/v1beta1
kind: HTTPRoute
metadata:
  name: sample-scheme-redirect
  namespace: sample-namespace
spec:
  parentRefs:
  - name: sample-gateway
    sectionName: http
    namespace: gateways
  hostnames:
    - demo.example.com
  rules:
  - matches:
    - path:
        value: /sample
    filters:
    - type: RequestRedirect
      requestRedirect:
        scheme: https
        statusCode: 301
```

{% endcut %}

### Request redirection with domain name change {#example-hostname-redirect}

In this example, requests arriving at the `http` listener configured for `sample-gateway` are routed.

All requests to `http://demo.example.com/sample` will be redirected to `http://example.org/sample` with the HTTP code [301 Moved Permanently](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/301).

{% cut "Manifest for HTTPRoute: Request redirection with domain name change" %}

```yaml
apiVersion: gateway.networking.k8s.io/v1beta1
kind: HTTPRoute
metadata:
  name: sample-hostname-redirect
  namespace: sample-namespace
spec:
  parentRefs:
  - name: sample-gateway
    sectionName: http
    namespace: gateways
  hostnames:
    - demo.example.com
  rules:
  - matches:
    - path:
        value: /sample
    filters:
    - type: RequestRedirect
      requestRedirect:
        hostname: example.org
        statusCode: 301
```

{% endcut %}