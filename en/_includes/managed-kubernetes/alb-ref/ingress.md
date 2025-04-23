# Ingress resource fields and annotations

The `Ingress` resource defines rules for incoming traffic distribution between {{ k8s }} services. The [{{ alb-name }} Ingress controller](../../../application-load-balancer/tools/k8s-ingress-controller/index.md) uses these rules to create a [load balancer](../../../application-load-balancer/concepts/application-load-balancer.md), its listeners, and [HTTP routers](../../../application-load-balancer/concepts/http-router.md). You can specify {{ alb-name }} backend [services](../../../application-load-balancer/k8s-ref/service-for-ingress.md) in `Ingress` directly or as part of [`HttpBackendGroup` backend groups](../../../application-load-balancer/k8s-ref/http-backend-group.md).

`Ingress` is a standard {{ k8s }} resource. Below, we describe its fields and annotations used by the {{ alb-name }} Ingress controller. For resource configuration details, see the relevant [{{ k8s }} article](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/ingress-v1/).

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
|| `kind`       | `Ingress`              | Resource type                    ||
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
```

#|
|| **Field**      | **Value / Type** | **Description** ||
|| `name`        | `string`             | **This is a required field**.
                                          [Resource name](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).
                                          Do not mistake it for the {{ alb-name }} load balancer name. ||
|| `annotations` | `map[string]string`  | **This is a required field**.
                                          [Resource annotations](#annotations). ||
|#

### Metadata.annotations {#annotations}

Annotations are collections of `key:value` pairs for assigning metadata to objects. Annotation values have `string` data type. 

You can specify the annotation value as a comma separated list of multiple `<key>=<value>` pairs.

  ```yaml
  annotation: <key>=<value>,<key>=<value>,<key>=<value>
  ```

You can map one key to multiple values. For example, to add a `noarchive,nofollow,noindex` `X-Robots` response header, write the annotation as follows:

  ```yaml
  ingress.alb.yc.io/modify-header-response-replace: X-Robots-Tag=noarchive,X-Robots-Tag=nofollow,X-Robots-Tag=noindex
  ```

For more information on annotations, see the relevant [{{ k8s }} article](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/).

You can add the following annotations to `ObjectMeta`:

* **ingress.alb.yc.io/group-name** {#annot-group-name}

  `Ingress` resource group name. The system will create a separate load balancer for each group. You can combine `Ingress` resources into a group to avoid creating load balancers for each individual resource. For more information about the group name format, see the relevant [{{ k8s }} article](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

  This is a required field even for one `Ingress` resource in a group.

* **ingress.alb.yc.io/subnets** {#annot-subnets}

  {{ vpc-name }} [subnets](../../../vpc/concepts/network.md#subnet) where the load balancer [resides](../../../application-load-balancer/concepts/application-load-balancer.md#lb-location). This is a comma separated list of subnet IDs, e.g.:

  ```yaml
  ingress.alb.yc.io/subnets: b0c2kotoidco********,e2lnhhdj9a0a********,e9bud5itjnl8********
  ```

  This field is required for at least one `Ingress` in a group, i.e., [ingress.alb.yc.io/group-name](#annot-group-name) annotation, to create one load balancer. The load balancer will use all subnets specified in the relevant `Ingress` resources.

  A load balancer’s subnets must all be in the same network. You cannot specify more than one network per [availability zone](../../../overview/concepts/geo-scope.md).

* **ingress.alb.yc.io/security-groups** {#annot-security-groups}

  Load balancer {{ vpc-name }} [security groups](../../../vpc/concepts/security-groups.md). This is a comma separated list of group IDs, e.g.:

  ```yaml
  ingress.alb.yc.io/security-groups: b0c2kotoidco********,e2lnhhdj9a0a********,e9bud5itjnl8********
  ```

  A load balancer created for a group of `Ingress` resources, i.e., [ingress.alb.yc.io/group-name](#annot-group-name), uses all security groups specified in their annotations.

  For the proper load balancer and Ingress controller operation, make sure to configure security groups as specified in [{#T}](../../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md).

* **ingress.alb.yc.io/external-ipv4-address** {#annot-external-ipv4-address}

  Specifying the load balancer public IP address.

  To use your [reserved IP address](../../../vpc/operations/get-static-ip.md), specify it in the load balancer annotation. To enable automatic IP assignment for the load balancer, specify `auto`.

  With `auto` setting, deleting the Ingress controller will also remove its associated IP address from the cloud. To avoid this, use a reserved IP address.

  A load balancer must be configured with either an external or internal IP address, i.e., [ingress.alb.yc.io/internal-ipv4-address](#annot-internal-ipv4-address) annotation, but not both.

* **ingress.alb.yc.io/internal-ipv4-address** {#annot-internal-ipv4-address}

  Configuring a load balancer with an internal IP address.

  The IP address must belong to the subnet specified in the [ingress.alb.yc.io/internal-alb-subnet](#annot-internal-alb-subnet) annotation. To use an IP address from this subnet, specify it in the annotation. To enable automatic IP assignment for the load balancer, specify `auto`.

  A load balancer must be configured with either an internal or external IP address, i.e., [ingress.alb.yc.io/external-ipv4-address](#annot-external-ipv4-address) annotation, but not both.

* **ingress.alb.yc.io/internal-alb-subnet** {#annot-internal-alb-subnet}

  Load balancer IP subnet ID.

  This field is required if you configure your load balancer with an internal IP address, i.e., [ingress.alb.yc.io/internal-ipv4-address](#annot-internal-ipv4-address) annotation.

* **ingress.alb.yc.io/protocol** {#annot-protocol}

  Protocol for connections between the load balancer and `Ingress`-defined backends:

  * `http`: HTTP/1.1. Default.
  * `http2`: HTTP/2.
  * `grpc`: gRPC.

* **ingress.alb.yc.io/group-settings-name** {#annot-group-settings-name}

  Name for the `Ingress` [resource group](#annot-group-name) settings.

  To specify these settings, create the [IngressGroupSettings](#groupsettings) resource.

* **ingress.alb.yc.io/group-order** {#annot-group-order}

  `Ingress` resource number. `Ingress` [group](#annot-group-name) resource numbers will define the order in which internal traffic routes will be added. `Ingress` resources are sorted in non-decreasing order.

  This annotation does not apply to routes specified in a single `Ingress` resource.

  Specify an integer value for this annotation. The default value is `0`.

* **ingress.alb.yc.io/transport-security** {#annot-transport-security}

  {% note warning %}

  For [ALB Ingress Controllers](/marketplace/products/yc/alb-ingress-controller) v0.2.0 or later, you can only use this annotation in the [Service](../../../application-load-balancer/k8s-ref/service-for-ingress.md#metadata) object.

  Annotations applied to `Ingress` resources sharing the same service and backend group settings will be processed correctly. However, this mechanism is obsolete and will not be supported going forward.

  {% endnote %}

  Encryption protocol for connections between the load balancer and backends specified in `Ingress` directly, as opposed to the `HttpBackendGroup`.

  The acceptable annotation value is `tls`: TLS without certificate validation.

  If this annotation is omitted, the load balancer will connect to the backends without encryption.

  This annotation is ignored for grouped backends. To configure encryption for connections between a load balancer and grouped backends, use `spec.backend.tls` field of the `HttpBackendGroup` resource. For more information, see the [`HttpBackendGroup` resource reference](../../../application-load-balancer/k8s-ref/http-backend-group.md).

* **ingress.alb.yc.io/prefix-rewrite** {#annot-prefix-rewrite}

  URI path / gRPC method name replacements applied when routing requests to backends. The relevant paths and names are listed in the [`Ingress`](#spec) `rules.http.paths` field.

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

  The `Upgrade` HTTP header values of incoming requests supported by the load balancer. Specify them as a comma-separated list.

  > For example, you can use this annotation to enable [WebSocket](https://{{ lang }}.wikipedia.org/wiki/WebSocket) support:
  > 
  > ```yaml
  > ingress.alb.yc.io/upgrade-types: WebSocket
  > ```

  {{ alb-name }} will apply the `Upgrade` configuration to all HTTP routers created for the `Ingress` resource.

* **ingress.alb.yc.io/request-timeout** {#annot-request-timeout}

  Maximum duration for a connection between a load balancer node and a backend. Once this time expires, the load balancer will respond to the client with `504 Gateway Timeout`.

  The default value is `60s`.

  {{ alb-name }} will apply this timeout configuration to all HTTP routers created for the `Ingress` resource.

* **ingress.alb.yc.io/idle-timeout** {#annot-idle-timeout}

  Maximum inactivity time for a connection between a load balancer node and a backend. Once this time expires, the load balancer will respond to the client with `504 Gateway Timeout`.

  If this annotation is omitted, a connection can remain idle for any length of time before the timeout, i.e., [ingress.alb.yc.io/request-timeout](#annot-request-timeout) annotation.

  {{ alb-name }} will apply this timeout configuration to all HTTP routers created for the `Ingress` resource.

* **ingress.alb.yc.io/modify-header-response-append** {#annot-modify-header-response-append}

  Appends a string value to the response header. Specify the target header and the string to append in the following format:

  ```yaml
  ingress.alb.yc.io/modify-header-response-append: <key>=<value>
  ```

  Where:

    * `<key>`: Response header.
    * `<value>`: String to append.

* **ingress.alb.yc.io/modify-header-response-replace** {#annot-modify-header-response-replace}

  Overwrites the response header value. Specify the target header and its replacement value in the following format:

  ```yaml
  ingress.alb.yc.io/modify-header-response-replace: <key>=<value>
  ```

  Where:

    * `<key>`: Response header.
    * `<value>`: New header value.

* **ingress.alb.yc.io/modify-header-response-rename** {#annot-modify-header-response-rename}

  Renames the response header. Specify the target header and its new name in the following format:

  ```yaml
  ingress.alb.yc.io/modify-header-response-rename: <key>=<value>
  ```

  Where:

    * `<key>`: Response header.
    * `<value>`: New header name.

* **ingress.alb.yc.io/modify-header-response-remove** {#annot-modify-header-response-remove}

  Removes the response header. Specify the header to be removed in the following format:

  ```yaml
  ingress.alb.yc.io/modify-header-response-remove: <key>=true
  ```

  Where `<key>` is the name of the header to be removed.

* **ingress.alb.yc.io/modify-header-request-append** {#annot-modify-header-request-append}

  Appends a string value to the request header. Specify the target header and the string to append in the following format:

  ```yaml
  ingress.alb.yc.io/modify-header-request-append: <key>=<value>
  ```

  Where:

    * `<key>`: Response header.
    * `<value>`: String to append.

* **ingress.alb.yc.io/modify-header-request-replace** {#annot-modify-header-request-replace}

  Replaces the request header value. Specify the target header and its replacement value in the following format:

  ```yaml
  ingress.alb.yc.io/modify-header-request-replace: <key>=<value>
  ```

  Where:

    * `<key>`: Response header.
    * `<value>`: New header value.

* **ingress.alb.yc.io/modify-header-request-rename** {#annot-modify-header-request-rename}

  Renames the request header. Specify the target header and its new name in the following format:

  ```yaml
  ingress.alb.yc.io/modify-header-request-rename: <key>=<value>
  ```

  Where:

    * `<key>`: Response header.
    * `<value>`: New header name.

* **ingress.alb.yc.io/modify-header-request-remove** {#annot-modify-header-request-remove}

  Removes the request header. Specify the header to be removed in the following format:

  ```yaml
  ingress.alb.yc.io/modify-header-request-remove: <key>=true
  ```

  Where `<key>` is the name of the header to be removed.

* **ingress.alb.yc.io/security-profile-id** {#annot-security-profile-id}

  Enables support for [{{ sws-full-name }}](../../../smartwebsecurity/concepts/index.md), including DDoS protection, [WAF](../../../smartwebsecurity/concepts/waf.md), and [resource overload protection](../../../smartwebsecurity/concepts/arl.md).

  {% include [sws-editor-role](sws-editor-role.md) %}

  {% include [annot-description](annot-security-profile-id.md) %}

* **ingress.alb.yc.io/use-regex** {#annot-use-regex}

  If set to `true`, enables [RE2](https://github.com/google/re2/wiki/Syntax) regular expression support for matching the request path. This setting only works when the `pathType` is set to `Exact`.

* **ingress.alb.yc.io/balancing-panic-threshold** {#annot-panic-threshold}

  Specifies the [panic mode](../../../application-load-balancer/concepts/backend-group.md#panic-mode) threshold. If the percentage of healthy endpoints falls below the specified threshold, it will trigger the panic mode.

  The default value is `0`, meaning the panic mode will never be activated.

* **ingress.alb.yc.io/balancing-locality-aware-routing** {#annot-locality}

   Share of incoming traffic the load balancer will forward to its availability zone backends. The remaining traffic will be evenly distributed across other availability zones.

   The default value is `0`.

   Read more about locality-aware routing [here](../../../application-load-balancer/concepts/backend-group.md#locality).

* **ingress.alb.yc.io/autoscale-max-size** {#annot-autoscale-max-size}

  Resource unit maximum total. By default, it is unlimited. Make sure this value is no less than (number of load balancer availability zones) × (minimum number of resource units per zone). 
  
  [Learn more about the autoscaling settings here](../../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling-settings).

* **ingress.alb.yc.io/autoscale-min-zone-size** {#annot-autoscale-min-zone-size}

  Resource unit minimum per availability zone. The minimum and default value is `2`. 
  
  [Learn more about the autoscaling settings here](../../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling-settings).

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

When using multiple ingress controllers within a single application, the `IngressClass` determines which controller processes the requests. If you deploy multiple ingress controllers without specifying `ingressClassName` in your Ingress resources, you should create a default `IngressClass` to ensure proper request handling. ||
|| `tls`              | `[]IngressTLS`       | **This is a required field**.
[Incoming HTTPS traffic settings](#tls): Domain name collections and their associated TLS certificates.

When this field is configured, the system will create two types of load balancer [listeners](../../../application-load-balancer/concepts/application-load-balancer.md#listener): HTTPS listeners to serve encrypted traffic on port 443, and HTTP listeners redirecting requests on port 80 to port 443. If multiple `Ingress` rules apply to the same domain, rules without `tls`, i.e., HTTP-only, will take priority over HTTP-to-HTTPS redirects.

If this field omitted, the system will only create HTTP listeners processing unencrypted traffic on port 80.
||

|| `rules` | `[]IngressRule`  | [Rules](#rule) for routing incoming traffic to backends, matching domain names and requested resources specified in `host` and `http.paths` fields, respectively.

In {{ alb-name }}, these routing rules map to HTTP router [virtual hosts](../../../application-load-balancer/concepts/http-router.md#virtual-host).

If no routing rules are specified, you must configure a [default backend](#default-backend) to handle all unmatched traffic.
||
|#

### IngressTLS {#tls}

```yaml
hosts:
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

In {{ certificate-manager-name }}, you can either use a [Let's Encrypt<sup>®</sup>](../../../certificate-manager/operations/managed/cert-create.md) certificate or [upload](../../../certificate-manager/operations/import/cert-create.md) your own custom certificate.

{% include [k8s-ingress-controller-secret-name](../../application-load-balancer/k8s-ingress-controller-secret-name.md) %}
||
|#

### IngressRule {#rule}

```yaml
host: <string>
http:
  paths:
    - path: <string>
      pathType: <string>
      backend: <IngressBackend>
```

Pre-0.2.0 [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) versions map each backend group to a distinct combination of `host`, `http.paths.path`, and `http.paths.pathType` values. ALB Ingress Controllers v0.2.0 and later map backend groups directly to the `backend.service` configuration, i.e., [IngressBackend](#backend). This may cause collisions when upgrading the ALB Ingress Controller. To avoid them, check the [upgrade restrictions](../../../application-load-balancer/operations/k8s-ingress-controller-upgrade.md) applying to your infrastructure.

#|
|| **Field** | **Value / Type** | **Description** ||

|| `host`    | `string`        | **This is a required field**.
Domain name, i.e., HTTP/1.1 `Host` or HTTP/2 `:authority` header value, to which this rule applies.

{% include [k8s-ingress-controller-hostnames-wildcard](../../application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %}

||

|| `http` | `HTTPIngressRuleValue`  | **This is a required field**.
Routing rule that distributes incoming requests based on the domain name specified in the `host` field and the requested resource path.

||

|| `http.paths` | `[]HTTPIngressPath`  | **This is a required field**.
Resource paths and their associated backends for this rule.

The order of paths matters because only the first path matching the incoming request will be used for routing. Therefore, we recommend to list your most specific paths first, followed by more general ones. This behavior differs from [{{ k8s }}](https://kubernetes.io/docs/concepts/services-networking/ingress/#multiple-matches) standard path prioritization logic, where longer paths, i.e., `rules.http.paths.path` values, take precedence regardless of their order in the list.

{% note warning %}

When multiple `Ingress` resources (with the same [ingress.alb.yc.io/group-name](#annot-group-name) annotation value) share the same load balancer and define rules for the same domain name, route ordering is only enforced within individual `Ingress` resources, not <q>across</q> them.

{% endnote %}

||

|| `http.paths.path` | `string`  | **This is a required field**.
Requested resource path:

* For HTTP protocol, it is incoming request URI or its prefix for `Exact` or `Prefix` path types, respectively.
* For gRPC protocol, i.e., `grpc` [ingress.alb.yc.io/protocol](#annot-protocol) annotation value, it is the full gRPC method name or its prefix for `Exact` or `Prefix` path types, respectively. Example: `/my.custom.server.Service/Method`.

In both cases, the path must begin with `/`.

||

|| `http.paths.pathType` | `string`  | **This is a required field**.
Requested resource path type:

* `Exact`: Request URI path or gRPC method name must _match_ the `rules.http.paths.path` field value.
* `Prefix`: Request URI path or gRPC method name must _begin_ with the `rules.http.paths.path` field value.

The selected path type will affect traffic distribution and the path replacement mechanism for backend requests if it is configured using the [ingress.alb.yc.io/prefix-rewrite](#annot-prefix-rewrite) annotation.

||

|| `http.paths.backend` | `IngressBackend`  | **This is a required field**.
[backend or group of backends](#backend) that will process requests with domain names and resource paths, i.e., HTTP URI paths or gRPC method names, specified in this Ingress rule.

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
[{{ k8s }} service](../../../managed-kubernetes/concepts/index.md#service) backend for processing requests.

The referred `Service` resource must be described per the [standard configuration](../../../application-load-balancer/k8s-ref/service-for-ingress.md).

Each `spec.rules.http.paths` entry must be either a service backend or a backend group, i.e., `resource`, but not both.

{% include [k8s-ingress-controller-service-backend](../../application-load-balancer/k8s-ingress-controller-service-backend.md) %}

||

|| `resource` | `TypedLocalObjectReference`  | **This is a required field**.
Backend group for processing requests.

The Ingress controller implements this field through the  `HttpBackendGroup` [custom resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/). The referenced resource must comply with [standard configuration](../../../application-load-balancer/k8s-ref/http-backend-group.md) requirements.

Each `spec.rules.http.paths` entry must be either a backend group or a service backend, i.e., `service` resource, but not both.

* `kind`: `HttpBackendGroup`
* `name` (`string`): Backend group name

    This name must match the `metadata.name` value of the `HttpBackendGroup` resource. For more information, see the `HttpBackendGroup` [resource configuration](../../../application-load-balancer/k8s-ref/http-backend-group.md).

* `apiGroup`: `alb.yc.io`

||
|#

### DefaultBackend {#default-backend}

Default backend for requests that do not match any ingress traffic [rules](#rule). If the `spec.rules` field is undefined in the `Ingress` description, the `spec.defaultBackend` field becomes mandatory to ensure all traffic has a valid destination.

The default backend handles requests when no rules are defined in the Ingress or the request’s domain/path matches no existing rules.

The `spec.defaultBackend` field defines either a service backend, i.e.,`service`, or a backend group, i.e., `resource`. Configure this field using the same schema as [IngressBackend](#backend).

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

You can only specify one default backend for a single `Ingress` resource group, i.e., [ingress.alb.yc.io/group-name](#annot-group-name) annotation.

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
