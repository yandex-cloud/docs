# HTTPRoute resource fields

The `HTTPRoute` resource sets traffic routing rules for {{ k8s }} service backends ([Service](../../../application-load-balancer/k8s-ref/service-for-gateway.md) resources) or redirection rules. `HTTPRoute` receives incoming traffic from the [Gateway resources](../../../application-load-balancer/k8s-ref/gateway.md) whose requirements it satisfies.

`HTTPRoute` is designed for application developers. Cluster operators should use the `Gateway` resource.

`HTTPRoute` is a [{{ k8s }} Gateway API](https://gateway-api.sigs.k8s.io/) project resource. Below, we describe its fields and annotations used by {{ alb-name }} Gateway API. For configuration details, see the [{{ k8s }} Gateway API reference](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1.HTTPRoute).

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
* `metadata` (`ObjectMeta`, required)

  Resource metadata.

  * `name` (`string`, required)

    Resource name. For more information about the group name format, see the relevant [{{ k8s }} article](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

    Do not mistake this name for the {{ alb-name }} route name.
 
  * `namespace` (`string`)

    Resource [namespace](../../../managed-kubernetes/concepts/index.md#namespace). The default value is `default`.

  * `annotations` (`map[string]string`)

    Resource annotations.

    {% note info %}

    You can define the [RoutePolicy](../../../application-load-balancer/k8s-ref/route-policy.md) resource instead of annotations. The `RoutePolicy` resource parameters and `HTTPRoute` annotations are equivalent.

    {% endnote %}

    * `gateway.alb.yc.io/rules.timeout` (`string`)

      Timeout for HTTP connection between load balancer and backend. The connection is maintained until the specified time expires, whether or not the transfer is ongoing. When the timeout is reached, the resource returns the `UNAVAILABLE` status.

    * `gateway.alb.yc.io/rules.idleTimeout` (`string`)

      Inactive HTTP connection timeout during which no data transfer is taking place. After the timeout expires, returns the `504 Gateway Timeout` status.
    
    * `gateway.alb.yc.io/rules.securityProfileId` (`string`)
    
      {{ sws-name }} [security profile](../../../smartwebsecurity/concepts/profiles.md) ID for route.

    * `gateway.alb.yc.io/hosts.securityProfileId` (`string`)
    
      Security profile ID for host.

    * `gateway.alb.yc.io/rules.backends.http.useHTTP2`

      Use HTTP/2 for connection between load balancer and backend.

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

      Percentage of traffic that goes to the `HTTPRoute` resource's availability zone with `healthy` backends. The remaining traffic is distributed between other availability zones. The parameter is not applied if `strictLocality=true` (see below).

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

      Path for HTTP health checks. Example: `/health`. Used for HTTP(S) backends.

    * `gateway.alb.yc.io/rules.backends.hc.http.useHTTP2`

      Use HTTP/2 for health checks. HTTP/1.1 is used by default. Used for HTTP(S) backends.

    * `gateway.alb.yc.io/rules.backends.hc.http.host`

      Host address for HTTP health checks.

    * `gateway.alb.yc.io/rules.backends.hc.grpc.serviceName`

      gRPC service name for gRPC backend health checks.

    * `gateway.alb.yc.io/rules.backends.hc.stream.send`

      Data to send for a TCP health check. Used for backends with a TCP interface.

    * `gateway.alb.yc.io/rules.backends.hc.stream.receive`

      Expected response in a TCP health check. Used for backends with a TCP interface.

    * `gateway.alb.yc.io/rules.timeout`

      Total HTTP connection timeout between load balancer and backend.

    * `gateway.alb.yc.io/rules.idleTimeout`

      Inactive HTTP connection timeout.

    * `gateway.alb.yc.io/rules.httpUpgradeTypes`

      Supported `HTTP Upgrade` values, e.g., websocket.

    * `gateway.alb.yc.io/rules.securityProfileId`

      {{ sws-name }} security profile ID for route.

    * `gateway.alb.yc.io/rules.rbac.action`
    
      Action when specified conditions (`ALLOW`/`DENY`) match for backend access control.

    * `gateway.alb.yc.io/rules.rbac.principals.<group_name>.<principal_name>.header.name`

      Header name for RBAC condition checks.

    * `gateway.alb.yc.io/rules.rbac.principals.<group_name>.<principal_name>.header.regex`

      Regular expression for checking header value to manage access to host over RBAC.

    * `gateway.alb.yc.io/rules.rbac.principals.<group_name>.<principal_name>.header.exact`

      Exact header value to manage access to host over RBAC.

    * `gateway.alb.yc.io/rules.rbac.principals.<group_name>.<principal_name>.header.prefix`

      Header value prefix to manage access to host over RBAC.

    * `gateway.alb.yc.io/rules.rbac.principals.<group_name>.<principal_name>.ip.remoteIp`

      IP address or CIDR block to manage access to host over RBAC.

    * `gateway.alb.yc.io/rules.rbac.principals.<group_name>.<principal_name>.any`

      Any match of specified conditions to manage access to host over RBAC (`true`/`false`).

    * `gateway.alb.yc.io/hosts.rbac.action`

      Action when specified conditions match (`ALLOW`/`DENY`) to manage access to host over RBAC.

    * `gateway.alb.yc.io/rule.<rule_name>.backends.balancing.mode`

      Load balancing mode for a given rule. The possible values are `RANDOM`, `ROUND_ROBIN`, and `LEAST_REQUEST`.

    * `gateway.alb.yc.io/rule.<rule_name>.timeout`

      Timeout for a given load balancing rule.

    * `gateway.alb.yc.io/rule.<rule_name>.idleTimeout`

      Inactivity timeout for a given load balancing rule.

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

    By default, it matches the `HTTPRoute` resource namespace (`metadata.namespace` field).

  * `name` (`string`, required)

    `Gateway` name specified in its `metadata.name` field.

  * `sectionName` (`string`)

    Name of the listener specified in the `Gateway` resource (specified in the `spec.listeners.name` field).

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

    You can only use fields listed below. Other fields described in the [Gateway API reference](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1.HTTPRouteMatch), e.g.,`headers` and `queryParams`, are not supported.

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

    You can specify either the [YCStorageBucket](../../../application-load-balancer/k8s-ref/yc-storage-bucket.md) resource ({{ objstorage-name }} bucket) or the [Service](../../../application-load-balancer/k8s-ref/service-for-gateway.md) resource.

     * `name` (`string`)

       Name of {{ k8s }} service or bucket resource.

     * `namespace` (`string`)
  
       Namespace comprising the service or bucket resource.

     * `group` (`string`)

       Name of the {{ k8s }} API group the bucket resource belongs to, e.g., `gwin.yandex.cloud`. Only for the `YCStorageBucket` resource.

       The default value is empty, indicating the root API group.

     * `kind` (`string`)

       Type of the {{ k8s }} resource with bucket. Only for the `YCStorageBucket` resource. The `YCStorageBucket` value is used.

     * `port` (`int32`)

       Service port number. Only for the `Service` resource.

       This number must match one of the port numbers specified in the `spec.ports.port` fields of the `Service` resource. For more information, see the [resource configuration](../../../application-load-balancer/k8s-ref/service-for-gateway.md).

       This field is designed for the Gateway API and has no equivalents in {{ alb-name }}.

     * `weight` (`int32`)

       Backend weight. Backends in a group receive traffic in proportion to their weights.

       You should either specify weights for all backends in a group, or not specify them at all. If weights are not specified, traffic will be equally distributed across backends.

       A backend with zero or negative weight will not be receiving traffic.

     * `filters` (`[]HTTPRouteFilter`)

       Request header modification settings for backend routing. For more information, see [below](#filter).

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