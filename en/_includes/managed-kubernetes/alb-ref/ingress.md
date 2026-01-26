# Ingress resource fields and annotations

The `Ingress` resource defines rules for incoming traffic distribution across {{ k8s }} services. The [{{ alb-name }} ingress controller](../../../application-load-balancer/tools/k8s-ingress-controller/index.md) uses these rules to create a [load balancer](../../../application-load-balancer/concepts/application-load-balancer.md), its listeners, and [HTTP routers](../../../application-load-balancer/concepts/http-router.md). You can specify {{ alb-name }} backend [services](../../../application-load-balancer/k8s-ref/service-for-ingress.md) in `Ingress` directly or as part of [`HttpBackendGroup` backend groups](../../../application-load-balancer/k8s-ref/http-backend-group.md).

{% include [Gwin](../../application-load-balancer/ingress-to-gwin-tip.md) %}

`Ingress` is a standard {{ k8s }} resource. Below, we describe its fields and annotations used by the {{ alb-name }} ingress controller. For resource configuration details, see [this {{ k8s }} guide](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/ingress-v1/).

## Ingress {#ingress}

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata: <ObjectMeta>
spec: <IngressSpec>
```

#|
|| **Field**     | **Value / Type**   | **Description**                    ||
|| `apiVersion` | `networking.k8s.io/v1` | **This is a required field**.
                                           Kubernetes API version.          ||
|| `kind`       | `Ingress`              | Resource type.                    ||
|| `metadata`   | `ObjectMeta`           | **This is a required field**.
                                          [Resource metadata](#metadata). ||
|| `spec`       | `IngressSpec`          | **This is a required field**.
                                          [Resource specification](#spec).   ||
|#

{% cut "Example" %}

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: alb-demo-tls
  annotations:
    ingress.alb.yc.io/subnets: <list_of_subnet_IDs>
    ingress.alb.yc.io/security-groups: <list_of_security_group_IDs>
    ingress.alb.yc.io/external-ipv4-address: <auto_or_static_IP_address>
    ingress.alb.yc.io/group-name: my-ingress-group
spec:
  tls:
    - hosts:
        - <domain_name>
      secretName: yc-certmgr-cert-id-<TLS_certificate_ID>
  rules:
    - host: <domain_name>
      http:
        paths:
          - path: /app1
            pathType: Prefix
            backend:
              service:
                name: alb-demo-1
                port:
                  number: 80
          - path: /app2
            pathType: Prefix
            backend:
              service:
                name: alb-demo-2
                port:
                  number: 80
          - pathType: Prefix
            path: "/"
            backend:
              service:
                name: alb-demo-2
                port:
                  name: http
```

{% endcut %}

## ObjectMeta {#metadata}

```yaml
name: <string>
annotations:
  ingress.alb.yc.io/group-name: <string>
  ingress.alb.yc.io/subnets: <string>
  ingress.alb.yc.io/security-groups: <string>
  ingress.alb.yc.io/external-ipv4-address: <string>
  ingress.alb.yc.io/internal-ipv4-address: <string>
  ingress.alb.yc.io/internal-alb-subnet: <string>
  ingress.alb.yc.io/protocol: <string>
  ingress.alb.yc.io/group-settings-name: <string>
  ingress.alb.yc.io/group-order: <string>
  ingress.alb.yc.io/transport-security: <string> # Only for versions up to but not including 0.2.0.
  ingress.alb.yc.io/prefix-rewrite: <string>
  ingress.alb.yc.io/upgrade-types: <string>
  ingress.alb.yc.io/request-timeout: <string>
  ingress.alb.yc.io/idle-timeout: <string>
  ingress.alb.yc.io/modify-header-response-append: <string>
  ingress.alb.yc.io/modify-header-response-replace: <string>
  ingress.alb.yc.io/modify-header-response-rename: <string>
  ingress.alb.yc.io/modify-header-response-remove: <string>
  ingress.alb.yc.io/modify-header-request-append: <string>
  ingress.alb.yc.io/modify-header-request-replace: <string>
  ingress.alb.yc.io/modify-header-request-rename: <string>
  ingress.alb.yc.io/modify-header-request-remove: <string>
  ingress.alb.yc.io/security-profile-id: <string>
  ingress.alb.yc.io/use-regex: <string>
  ingress.alb.yc.io/balancing-panic-threshold: <string>
  ingress.alb.yc.io/balancing-locality-aware-routing: <string>
  ingress.alb.yc.io/autoscale-max-size: <string>
  ingress.alb.yc.io/autoscale-min-zone-size: <string>
  ingress.alb.yc.io/session-affinity-header: <string>
  ingress.alb.yc.io/session-affinity-cookie: <string>
  ingress.alb.yc.io/session-affinity-connection: <string>
```

#|
|| **Field**      | **Value / Type** | **Description** ||
|| `name`        | `string`             | **This is a required field**.
                                          [Resource name](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).
                                          Do not mistake this name for the {{ alb-name }} load balancer name. ||
|| `annotations` | `map[string]string`  | **This is a required field**.
                                          [Resource annotations](#annotations). ||
|#

### Metadata.annotations {#annotations}

Annotations are collections of `key:value` pairs for assigning metadata to objects. Annotation values have the `string` data type.

You can specify the annotation value as a comma-separated list of multiple `<key>=<value>` pairs:

  ```yaml
  annotation: <key>=<value>,<key>=<value>,<key>=<value>
  ```

You can map one key to multiple values. For example, to add an `X-Robots` response header with the `noarchive,nofollow,noindex` value, write the annotation as follows:

  ```yaml
  ingress.alb.yc.io/modify-header-response-replace: X-Robots-Tag=noarchive,X-Robots-Tag=nofollow,X-Robots-Tag=noindex
  ```

For more information on annotations, see [this {{ k8s }} guide](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/).

You can add the following annotations to `ObjectMeta`:

* **ingress.alb.yc.io/group-name** {#annot-group-name}

  `Ingress` resource group name. The system will create a separate load balancer for each group. You can group multiple `Ingress` resources to avoid creating load balancers for each individual resource. For more information about the format, see [this {{ k8s }} guide](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

  This is a required field even for one `Ingress` resource in a group.

* **ingress.alb.yc.io/subnets** {#annot-subnets}

  {{ vpc-name }} [subnets](../../../vpc/concepts/network.md#subnet) where the load balancer [resides](../../../application-load-balancer/concepts/application-load-balancer.md#lb-location). This is a comma-separated list of subnet IDs, e.g.:

  ```yaml
  ingress.alb.yc.io/subnets: b0c2kotoidco********,e2lnhhdj9a0a********,e9bud5itjnl8********
  ```

  This field is required for at least one `Ingress` in a group, i.e., the [ingress.alb.yc.io/group-name](#annot-group-name) annotation, to create one load balancer. The load balancer will use all subnets specified in the relevant `Ingress` resources.

  All subnets of a single load balancer must be in the same network. You cannot specify more than one network per [availability zone](../../../overview/concepts/geo-scope.md).

* **ingress.alb.yc.io/security-groups** {#annot-security-groups}

  List of {{ vpc-name }} [security groups](../../../vpc/concepts/security-groups.md) for a load balancer. This is a comma separated list of group IDs, e.g.:

  ```yaml
  ingress.alb.yc.io/security-groups: b0c2kotoidco********,e2lnhhdj9a0a********,e9bud5itjnl8********
  ```

  A load balancer created for a group of `Ingress` resources, i.e., the [ingress.alb.yc.io/group-name](#annot-group-name) annotation, uses all security groups specified in these resources.

  For the proper load balancer and Ingress controller operation, make sure to configure security groups as specified in [{#T}](../../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md).

* **ingress.alb.yc.io/external-ipv4-address** {#annot-external-ipv4-address}

  Configuring the load balancer external IP address.

  To use a [reserved IP address](../../../vpc/operations/get-static-ip.md), put it in the annotation value. To enable automatic IP assignment for the load balancer, specify `auto`.

  If you set `auto`, deleting the ingress controller will also remove its associated IP address from the cloud. To avoid this, use a reserved IP address.

  A load balancer must be configured with either an external or internal IP address, i.e., the [ingress.alb.yc.io/internal-ipv4-address](#annot-internal-ipv4-address) annotation, but not both.

* **ingress.alb.yc.io/internal-ipv4-address** {#annot-internal-ipv4-address}

  Configuring the load balancer internal IP address.

  The IP address must belong to the subnet specified in the [ingress.alb.yc.io/internal-alb-subnet](#annot-internal-alb-subnet) annotation. To use an IP address from this subnet, specify it in the annotation. To enable automatic IP assignment for the load balancer, specify `auto`.

  A load balancer must be configured with either an internal or external IP address, i.e., the [ingress.alb.yc.io/external-ipv4-address](#annot-external-ipv4-address) annotation, but not both.

* **ingress.alb.yc.io/internal-alb-subnet** {#annot-internal-alb-subnet}

  Subnet ID of the load balancer internal IP address.

  This field is required if you configure your load balancer with an internal IP address, i.e., the [ingress.alb.yc.io/internal-ipv4-address](#annot-internal-ipv4-address) annotation.

* **ingress.alb.yc.io/protocol** {#annot-protocol}

  Protocol for connections between the load balancer and backends defined in `Ingress`:

  * `http`: HTTP/1.1. This is a default value.
  * `http2`: HTTP/2.
  * `grpc`: gRPC.

* **ingress.alb.yc.io/group-settings-name** {#annot-group-settings-name}

  Name for the `Ingress` [resource group](#annot-group-name) settings.

  To specify the settings, create an additional [IngressGroupSettings](#groupsettings) resource.

* **ingress.alb.yc.io/group-order** {#annot-group-order}

  `Ingress` resource sequence number. `Ingress` [group](#annot-group-name) resource sequence numbers will define the order in which internal traffic routes will be added. `Ingress` resources are sorted in non-decreasing order.

  This annotation does not apply to routes specified in a single `Ingress` resource.

  Specify an integer value for this annotation. The default value is `0`.

* **ingress.alb.yc.io/transport-security** {#annot-transport-security}

  {% note warning %}

  In [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) version 0.2.0 or later, you can only use this annotation in the [Service](../../../application-load-balancer/k8s-ref/service-for-ingress.md#metadata) object.

  Annotations specified in `Ingress` resources sharing a single service with the same backend group settings apply correctly. However, this feature is deprecated and will be discontinued.

  {% endnote %}

  Encryption protocol for connections between the load balancer and backends specified in `Ingress` directly, without using `HttpBackendGroup`.

  The acceptable value is `tls`: TLS without certificate validation.

  If this annotation is not specified, the load balancer will connect to the backends without encryption.

  This annotation is ignored for grouped backends. To configure encryption for connections between the load balancer and grouped backends, use the `spec.backend.tls` field of the `HttpBackendGroup` resource. For more information, see [this article](../../../application-load-balancer/k8s-ref/http-backend-group.md).

* **ingress.alb.yc.io/prefix-rewrite** {#annot-prefix-rewrite}

  URI path / gRPC call name replacements applied when routing requests to backends. The relevant paths and names are listed in the [`Ingress` specification](#spec) under `rules.http.paths`.

  The system will overwrite the entire path / name or its prefix based on the `pathType` value: `pathType: Exact` or `pathType: Prefix`, respectively.

  {% cut "Example" %}

  Specify the replacement instructing the load balancer to route incoming requests to backends with specific API versions:

  ```yaml
  ...
  metadata:
    annotations:
      ingress.alb.yc.io/prefix-rewrite: /api/v4/
  ...
  spec:
    rules:
      - host: <domain_name>
        http:
          paths:
            - path: /api/
              pathType: Prefix
              ...
  ```

  {% endcut %}

  {{ alb-name }} will apply this replacement rule to all [HTTP routers](../../../application-load-balancer/concepts/http-router.md) created for the `Ingress` resource.
  
* **ingress.alb.yc.io/upgrade-types** {#annot-upgrade-types}

  `Upgrade` HTTP header values of incoming requests supported by the load balancer. Specify these values as a comma-separated list.

  > For example, you can use this annotation to enable [WebSocket](https://{{ lang }}.wikipedia.org/wiki/WebSocket) support:
  > 
  > ```yaml
  > ingress.alb.yc.io/upgrade-types: WebSocket
  > ```

  {{ alb-name }} will apply the `Upgrade` values to all HTTP routers created for the `Ingress` resource.

* **ingress.alb.yc.io/request-timeout** {#annot-request-timeout}

  Maximum duration for a connection between a load balancer node and a backend. Once this timeout expires, the load balancer will respond to the client with `504 Gateway Timeout`.

  The default value is `60s`.

  {{ alb-name }} will apply this timeout to all HTTP routers created for the `Ingress` resource.

* **ingress.alb.yc.io/idle-timeout** {#annot-idle-timeout}

  Maximum inactivity time for a connection between a load balancer node and a backend. Once this timeout expires, the load balancer will respond to the client with `504 Gateway Timeout`.

  If this annotation is omitted, a connection can remain idle for any length of time before the timeout, i.e., the [ingress.alb.yc.io/request-timeout](#annot-request-timeout) annotation.

  {{ alb-name }} will apply this timeout to all HTTP routers created for the `Ingress` resource.

* **ingress.alb.yc.io/modify-header-response-append** {#annot-modify-header-response-append}

  Appends a string to the response header value. To specify the header and string, use this format:

  ```yaml
  ingress.alb.yc.io/modify-header-response-append: <key>=<value>
  ```

  Where:

    * `<key>`: Name of the header to modify.
    * `<value>`: String to append to the header value.

* **ingress.alb.yc.io/modify-header-response-replace** {#annot-modify-header-response-replace}

  Replaces the response header value. To specify the header and its new value, use this format:

  ```yaml
  ingress.alb.yc.io/modify-header-response-replace: <key>=<value>
  ```

  Where:

    * `<key>`: Name of the header to modify.
    * `<value>`: New header value.

* **ingress.alb.yc.io/modify-header-response-rename** {#annot-modify-header-response-rename}

  Renames the response header. To specify the header and its new name, use this format:

  ```yaml
  ingress.alb.yc.io/modify-header-response-rename: <key>=<value>
  ```

  Where:

    * `<key>`: Name of the header to modify.
    * `<value>`: New header name.

* **ingress.alb.yc.io/modify-header-response-remove** {#annot-modify-header-response-remove}

  Removes the response header. To specify the header to remove, use this format:

  ```yaml
  ingress.alb.yc.io/modify-header-response-remove: <key>=true
  ```

  Where `<key>` is the name of the header to remove.

* **ingress.alb.yc.io/modify-header-request-append** {#annot-modify-header-request-append}

  Appends a string to the request header value. To specify the header and string, use this format:

  ```yaml
  ingress.alb.yc.io/modify-header-request-append: <key>=<value>
  ```

  Where:

    * `<key>`: Name of the header to modify.
    * `<value>`: String to append to the header value.

* **ingress.alb.yc.io/modify-header-request-replace** {#annot-modify-header-request-replace}

  Replaces the request header value. To specify the header and its new value, use this format:

  ```yaml
  ingress.alb.yc.io/modify-header-request-replace: <key>=<value>
  ```

  Where:

    * `<key>`: Name of the header to modify.
    * `<value>`: New header value.

* **ingress.alb.yc.io/modify-header-request-rename** {#annot-modify-header-request-rename}

  Renames the request header. To specify the header and its new name, use this format:

  ```yaml
  ingress.alb.yc.io/modify-header-request-rename: <key>=<value>
  ```

  Where:

    * `<key>`: Name of the header to modify.
    * `<value>`: New header name.

* **ingress.alb.yc.io/modify-header-request-remove** {#annot-modify-header-request-remove}

  Removes the request header. To specify the header to remove, use this format:

  ```yaml
  ingress.alb.yc.io/modify-header-request-remove: <key>=true
  ```

  Where `<key>` is the name of the header to remove.

* **ingress.alb.yc.io/security-profile-id** {#annot-security-profile-id}

  Enables support for [{{ sws-full-name }}](../../../smartwebsecurity/concepts/index.md), including DDoS protection, [WAF](../../../smartwebsecurity/concepts/waf.md), and [resource overload protection](../../../smartwebsecurity/concepts/arl.md).

  {% include [sws-editor-role](sws-editor-role.md) %}

  {% include [annot-description](annot-security-profile-id.md) %}

* **ingress.alb.yc.io/use-regex** {#annot-use-regex}

  Enables support for [RE2](https://github.com/google/re2/wiki/Syntax) regular expressions when matching the request path if the `true` string is provided. This setting only applies when `pathType` is set to `Exact`.

* **ingress.alb.yc.io/balancing-panic-threshold** {#annot-panic-threshold}

  Specifies the [panic mode](../../../application-load-balancer/concepts/backend-group.md#panic-mode) threshold. If the percentage of healthy endpoints falls below the specified threshold, it will trigger the panic mode.

  The default value is `0`, which means the panic mode will never be activated.

* **ingress.alb.yc.io/balancing-locality-aware-routing** {#annot-locality}

   Percentage of incoming traffic the load balancer forwards to its availability zone backends. The remaining traffic is evenly distributed across other availability zones.

   The default value is `0`.

   For more information on locality-aware routing, see [this guide](../../../application-load-balancer/concepts/backend-group.md#locality).

* **ingress.alb.yc.io/autoscale-max-size** {#annot-autoscale-max-size}

  Maximum total number of resource units. By default, it is unlimited. Make sure this value is no less than the number of load balancer availability zones multiplied by the minimum number of resource units per zone. 
  
  Learn more about the autoscaling settings [here](../../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling-settings).

* **ingress.alb.yc.io/autoscale-min-zone-size** {#annot-autoscale-min-zone-size}

  Minimum number of resource units per availability zone. The minimum and default value is `2`.
  
  Learn more about the autoscaling settings [here](../../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling-settings).

* **ingress.alb.yc.io/session-affinity-header** {#annot-session-affinity-header}

  HTTP header for [session affinity](../../../application-load-balancer/concepts/backend-group.md#session-affinity).

  * `name`: HTTP header name.

* **ingress.alb.yc.io/session-affinity-cookie** {#annot-session-affinity-cookie}

  Cookie parameters for session affinity.

  * `name`: Cookie name.

  * `ttl`: Cookie lifetime. The value must be specified with units of measurement, e.g., `300ms` or `1.5h`. Acceptable units of measurement include:
    * `ns`, nanoseconds
    * `us`, microseconds
    * `ms`, milliseconds
    * `s`, seconds
    * `m`, minutes
    * `h`, hours

  The parameters are given as a comma-separated list. Here is an example:

  ```
  ...
  annotations:
    ingress.alb.yc.io/session-affinity-cookie: name=X-Example,ttl=30m
    ...
  ```

* **ingress.alb.yc.io/session-affinity-connection** {#annot-session-affinity-connection}

  Indicator of using a client IP address for session affinity.

  * `source-ip`: `true` or `false`.

## IngressSpec {#spec}

```yaml
ingressClassName: <string>
tls:
  - <IngressTLS>
  - ...
rules:
  - <IngressRule>
  - ...
defaultBackend:
  - <IngressBackend>
  - ...
```

#|
|| **Field**           | **Value / Type** | **Description** ||
|| `ingressClassName` | `string`             | Name of the [IngressClass](../../../application-load-balancer/k8s-ref/ingress-class.md) resource associated with the `Ingress` resource.

When using multiple ingress controllers within a single application, the `IngressClass` determines which controller processes the requests. If you use multiple ingress controllers without specifying `ingressClassName` in your Ingress resources, you should create a default `IngressClass` resource. ||
|| `tls`              | `[]IngressTLS`       | **This is a required field**.
[Incoming HTTPS traffic settings](#tls), i.e., domain name collections and their associated TLS certificates.

If this field is specified, the system will create two types of load balancer [listeners](../../../application-load-balancer/concepts/application-load-balancer.md#listener): HTTPS listeners to serve traffic on port 443, and HTTP listeners redirecting requests on port 80 to port 443. If multiple `Ingress` rules apply to the same domain, rules without `tls`, i.e., HTTP-only, will take priority over HTTP-to-HTTPS redirects.

If this field is not specified, the system will only create listeners processing HTTP traffic on port 80.
||

|| `rules` | `[]IngressRule`  | [Rules](#rule) for routing incoming traffic to backends, matching domain names and requested resources specified in `host` and `http.paths` fields, respectively.

In {{ alb-name }}, these routing rules map to HTTP router [virtual hosts](../../../application-load-balancer/concepts/http-router.md#virtual-host).

If no routing rules are specified, you must configure a [default backend](#default-backend) to process all the traffic.
||
|#

### IngressTLS {#tls}

```yaml
- hosts:
    - <string>
    - ...
  secretName: <string>
```

#|
|| **Field** | **Value / Type** | **Description** ||

|| `hosts`    | `[]string`        | **This is a required field**.
Domain names covered by the `secretName` TLS certificate.

The load balancer will create a dedicated listener for each domain name specified in the Server Name Indication (SNI) TLS extension.

{% include [k8s-ingress-controller-hostnames-wildcard](../../application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %}
||

|| `secretName` | `string`  | **This is a required field**.
{{ certificate-manager-full-name }} TLS certificate in `yc-certmgr-cert-id-<certificate ID>` format. You can use this name to access the certificate [secret](https://kubernetes.io/docs/concepts/configuration/secret/) in {{ managed-k8s-name }}.

In {{ certificate-manager-name }}, you can either [issue a Let's Encrypt<sup>®</sup> certificate](../../../certificate-manager/operations/managed/cert-create.md) or [upload your own custom certificate](../../../certificate-manager/operations/import/cert-create.md).

{% include [k8s-ingress-controller-secret-name](../../application-load-balancer/k8s-ingress-controller-secret-name.md) %}
||
|#

### IngressRule {#rule}

```yaml
- host: <string>
  http:
    paths:
      - path: <string>
        pathType: <string>
        backend: <IngressBackend>
```

Pre-0.2.0 [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) versions map each backend group to a distinct combination of `host`, `http.paths.path`, and `http.paths.pathType` values. ALB Ingress Controller 0.2.0 and later maps backend groups directly to the `backend.service` configuration, i.e., [IngressBackend](#backend). This may cause collisions when upgrading the controller. To avoid them, check the [upgrade restrictions](../../../application-load-balancer/operations/k8s-ingress-controller-upgrade.md) for your infrastructure.

#|
|| **Field** | **Value / Type** | **Description** ||

|| `host`    | `string`        | **This is a required field**.
Domain name, i.e., the HTTP/1.1 `Host` or HTTP/2 `:authority` header value, to which this rule applies.

{% include [k8s-ingress-controller-hostnames-wildcard](../../application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %}

||

|| `http` | `HTTPIngressRuleValue`  | **This is a required field**.
Rule that distributes incoming requests based on the domain name specified in the `host` field and the requested resource path.

||

|| `http.paths` | `[]HTTPIngressPath`  | **This is a required field**.
Requested resource paths and their associated backends for this rule.

The order of paths matters because only the first path matching the incoming request will be used for routing. Therefore, we recommend listing your most specific paths first. This behavior differs from the [{{ k8s }}](https://kubernetes.io/docs/concepts/services-networking/ingress/#multiple-matches) standard path prioritization logic, where longer paths, i.e., the `rules.http.paths.path` field, take precedence.

{% note warning %}

When multiple `Ingress` resources (with the same [ingress.alb.yc.io/group-name](#annot-group-name) annotation value) share the same load balancer and define rules for the same domain name, route ordering is only enforced within individual `Ingress` resources, not <q>across</q> them.

{% endnote %}

||

|| `http.paths.path` | `string`  | **This is a required field**.
Requested resource path:

* For HTTP protocol, it is incoming request URI or its prefix for `Exact` or `Prefix` path types, respectively.
* For gRPC protocol, i.e., the `grpc` [ingress.alb.yc.io/protocol](#annot-protocol) annotation value, it is the full gRPC method name or its prefix for `Exact` or `Prefix` path types, respectively, e.g., `/my.custom.server.Service/Method`.

In both cases, the path must begin with `/`.

||

|| `http.paths.pathType` | `string`  | **This is a required field**.
Requested resource path type:

* `Exact`: Request URI path or gRPC method name must _match_ the `rules.http.paths.path` field value.
* `Prefix`: Request URI path or gRPC method name must _begin_ with the `rules.http.paths.path` field value.

The selected path type will affect traffic distribution and the path replacement mechanism for backend requests if it is configured using the [ingress.alb.yc.io/prefix-rewrite](#annot-prefix-rewrite) annotation.

||

|| `http.paths.backend` | `IngressBackend`  | **This is a required field**.
[Backend or group of backends](#backend) to process requests with the specified domain name and URI path or gRPC call name.

|#

#### IngressBackend {#backend}

```yaml
service:
  name: <string>
  port:
    name: <string>
    number: <int32>
resource:
  kind: HttpBackendGroup
  name: <string>
  apiGroup: alb.yc.io
```

#|
|| **Field** | **Value / Type** | **Description** ||

|| `service`    | `IngressServiceBackend`        | **This is a required field**.
Reference to the [{{ k8s }} service](../../../managed-kubernetes/concepts/index.md#service) to process requests as a backend.

The referred `Service` resource must be described per the [standard configuration](../../../application-load-balancer/k8s-ref/service-for-ingress.md).

Each `spec.rules.http.paths` entry must be either a service backend or a backend group, i.e., `resource`, but not both.

{% include [k8s-ingress-controller-service-backend](../../application-load-balancer/k8s-ingress-controller-service-backend.md) %}

||

|| `resource` | `TypedLocalObjectReference`  | **This is a required field**.
Backend group for processing requests.

The Ingress controller implements the `HttpBackendGroup` resource this field points to as a [custom resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/). The referenced resource must comply with the [standard configuration](../../../application-load-balancer/k8s-ref/http-backend-group.md) requirements.

Each `spec.rules.http.paths` entry must be either a backend group or a service backend, i.e., `service` resource, but not both.

* `kind`: `HttpBackendGroup`
* `name` (`string`): Backend group name

    This name must match the `metadata.name` value of the `HttpBackendGroup` resource. For more information, see the [resource configuration](../../../application-load-balancer/k8s-ref/http-backend-group.md).

* `apiGroup`: `alb.yc.io`

||
|#

### DefaultBackend {#default-backend}

Default backend for requests if no incoming traffic distribution [rules](#rule) are specified. If the `spec.rules` field is not specified in the `Ingress` description, the `spec.defaultBackend` field becomes mandatory.

The default backend handles requests if the domain name and requested resource do not match the ones set in the rules.

The `spec.defaultBackend` field defines either a service backend, i.e., `service`, or a backend group, i.e., `resource`. Specify this field the same way as [IngressBackend](#backend).

{% cut "`spec.defaultBackend.service` example" %}

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: testapp-ingress-with-default-backend
  namespace: testapp-ns
  annotations:
    ...
spec:
  defaultBackend:
    service:
      name: testapp-service
      port:
        name: http
```

{% endcut %}

{% cut "`spec.defaultBackend.resource` example" %}

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-1
  annotations:
    ...
spec:
  defaultBackend:
    resource:
      apiGroup: alb.yc.io
      kind: HttpBackendGroup
      name: bg-with-bucket
```

{% endcut %}

{% note warning %}

You can only specify one default backend for a single `Ingress` resource group, i.e., with the same [ingress.alb.yc.io/group-name](#annot-group-name) annotation value.

{% endnote %}

## IngressGroupSettings {#groupsettings}

```yaml
apiVersion: alb.yc.io/v1alpha1
kind: IngressGroupSettings
metadata:
  name: non-default-settings
logOptions:
  logGroupID: <log_group_ID>
  discardRules:
    - discardPercent: 50
      grpcCodes:
        - OK
        - CANCELLED
        - UNKNOWN
    - discardPercent: 67
      httpCodeIntervals:
        - HTTP_1XX
    - discardPercent: 20
      httpCodes:
        - 200
        - 404
```

Specify the log group ID and [log discard rule](../../../application-load-balancer/concepts/application-load-balancer.md#discard-logs-rules) settings:

* `httpCodes`: HTTP codes.
* `httpCodeIntervals`: HTTP code classes.
* `grpcCodes`: gRPC codes.
* `discardPercent`: Log discard rate.
