# Ingress resource fields and annotations


The `Ingress` resource defines the rules for distributing incoming traffic between {{ k8s }} services. The [{{ alb-name }} Ingress controller](../../../application-load-balancer/tools/k8s-ingress-controller/index.md) uses these rules to create a [load balancer](../../../application-load-balancer/concepts/application-load-balancer.md) with the requisite listeners and [HTTP routers](../../../application-load-balancer/concepts/http-router.md). The [services](../../../application-load-balancer/k8s-ref/service.md) acting as {{ alb-name }} backends may be specified in `Ingress` directly or as part of [`HttpBackendGroup` backend groups](../../../application-load-balancer/k8s-ref/http-backend-group.md).

`Ingress` is a {{ k8s }} standard resource. This reference describes the resource's fields and annotations the {{ alb-name }} Ingress controller interfaces with. For a complete reference for the resource, please see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/ingress-v1/).

## Ingress {#ingress}

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata: <ObjectMeta>
spec: <IngressSpec>
```

#|
|| **Field**    | **Value or type**      | **Description**                  ||
|| `apiVersion` | `networking.k8s.io/v1` | **Required**
                                            Kubernetes API version          ||
|| `kind`       | `Ingress`              | Resource type                    ||
|| `metadata`   | `ObjectMeta`           | **Required**
                                          [Resource metadata](#metadata)    ||
|| `spec`       | `IngressSpec`          | **Required**
                                          [Resource specification](#spec)   ||
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
  ingress.alb.yc.io/transport-security: <string> # Only up to but excluding version 0.2.0.
  ingress.alb.yc.io/prefix-rewrite: <string>
  ingress.alb.yc.io/upgrade-types: <string>
  ingress.alb.yc.io/request-timeout: <string>
  ingress.alb.yc.io/idle-timeout: <string>
  ingress.alb.yc.io/modify-header-response-append: <string>
  ingress.alb.yc.io/modify-header-response-replace: <string>
  ingress.alb.yc.io/modify-header-response-rename: <string>
  ingress.alb.yc.io/modify-header-response-remove: <string>
  ingress.alb.yc.io/use-regex: <string>
```

#|
|| **Field**      | **Value or type**   | **Description**          ||
|| `name`         | `string`            | **Required**
[Resource name](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names)
Does not match the load balancer name in Application Load Balancer ||
|| `annotations`  | `map[string]string` | **Required**
[Resource annotations](#annotations)                               ||
|#

### Annotations (metadata.annotations) {#annotations}

Annotations are collections of `key:value` pairs used for assigning metadata to objects. Annotation values are always of the `string` data type. For more on annotations, see the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/).

You can provide the following annotations for the `ObjectMeta` object:

* **ingress.alb.yc.io/group-name** {#annot-group-name}

   Name of an `Ingress` resource group combined in a single load balancer. For more information about the format, please see the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

   The field is required even if the load balancer uses a single `Ingress`.

* **ingress.alb.yc.io/subnets** {#annot-subnets}

   List of {{ vpc-name }} [subnets](../../../vpc/concepts/network.md#subnet) the [load balancer resides in](../../../application-load-balancer/concepts/application-load-balancer.md#lb-location). Subnet IDs are provided in a comma-separated list, e.g.:

   ```yaml
   ingress.alb.yc.io/subnets: b0c2kotoidco********,e2lnhhdj9a0a********,e9bud5itjnl8********
   ```

   The field is required for at least a single `Ingress` in a group ([ingress.alb.yc.io/group-name](#annot-group-name) annotation) to create one load balancer. A balancer uses all the subnets specified in the relevant `Ingress` resources.

   All the subnets of a single load balancer must belong to the same network with no more than one network specified in each [availability zone](../../../overview/concepts/geo-scope.md).

* **ingress.alb.yc.io/security-groups** {#annot-security-groups}

   List of {{ vpc-name }} [security groups](../../../vpc/concepts/security-groups.md) for a load balancer. Group IDs are provided in a comma-separated list, e.g.:

   ```yaml
   ingress.alb.yc.io/security-groups: b0c2kotoidco********,e2lnhhdj9a0a********,e9bud5itjnl8********
   ```

   A load balancer created for a group of several `Ingress` resources ([ingress.alb.yc.io/group-name](#annot-group-name) annotation) uses all the security groups specified in these `Ingress` resources.

   For the proper load balancer and Ingress controller operation, security groups must be configured as specified in [{#T}](../../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md).

* **ingress.alb.yc.io/external-ipv4-address** {#annot-external-ipv4-address}

   Configuring a load balancer's public IP

   To use a [reserved IP](../../../vpc/operations/get-static-ip.md), put it in the annotation value. For the load balancer to get its IP automatically, specify `auto`.

   If you set `auto`, deleting the Ingress controller will also delete the IP address from the cloud. To avoid this, use an existing reserved IP address.

   A load balancer must be configured with either a public or a private IP ([ingress.alb.yc.io/internal-ipv4-address](#annot-internal-ipv4-address) annotation), but not both.

* **ingress.alb.yc.io/internal-ipv4-address** {#annot-internal-ipv4-address}

   Configuring a load balancer with a private IP.

   The IP address must belong to the subnet specified in the [ingress.alb.yc.io/internal-alb-subnet](#annot-internal-alb-subnet) annotation. To use a specific IP from the subnet in question, specify it in the annotation. For the load balancer to get its IP automatically, specify `auto`.

   A load balancer must be configured with either a private or a public IP ([ingress.alb.yc.io/external-ipv4-address](#annot-external-ipv4-address) annotation) but not both.

* **ingress.alb.yc.io/internal-alb-subnet** {#annot-internal-alb-subnet}

   Subnet ID of the load balancer's private IP address.

   The field is required if a load balancer is configured with a private IP address ([ingress.alb.yc.io/internal-ipv4-address](#annot-internal-ipv4-address) annotation).

* **ingress.alb.yc.io/protocol** {#annot-protocol}

   Connection protocol for the load balancer and backends described in `Ingress`:

   * `http`: HTTP/1.1; default value
   * `http2`: HTTP/2
   * `grpc`: gRPC

* **ingress.alb.yc.io/group-settings-name** {#annot-group-settings-name}

   Name for the Ingress group settings combined in a single load balancer.

   To specify the settings, create an additional resource named [IngressGroupSettings](#groupsettings).

* **ingress.alb.yc.io/transport-security** {#annot-transport-security}

   {% note warning %}

   In [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) version 0.2.0 and later, use annotation only in the [Service](../../../application-load-balancer/k8s-ref/service.md#metadata) object.

   If you specify an annotation in the `Ingress` resources that use a single service with the same settings for backend groups, such annotation will apply correctly. However, this mechanism is obsolete and will not be supported going forward.

   {% endnote %}

   Connection encryption protocol for the load balancer and backends specified in `Ingress` directly (without `HttpBackendGroup`):

   The acceptable value is `tls`: TLS with no certificate challenge.

   If no annotation is specified, the load balancer connects to the backends with no encryption.

   For backends belonging to groups, the annotation value is ignored. When you encrypt a connection between a load balancer and grouped backends, you configure the encryption via the `spec.backend.tls` field of the `HttpBackendGroup` resource (see the [resource reference](../../../application-load-balancer/k8s-ref/http-backend-group.md)).

* **ingress.alb.yc.io/prefix-rewrite** {#annot-prefix-rewrite}

   Substitution for URI paths or gRPC call names listed in the [`Ingress` specification](#spec) (`rules.http.paths` field) when routing requests to backends.

   The substitution depends on the path or name type: for `pathType: Exact`, the entire path or name is replaced, for `pathType: Prefix`, only the specified initial portion is replaced.

   {% cut "Example" %}

   For the load balancer to send backend requests to a particular version for all incoming requests to your API, set up the following substitution:

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

   In {{ alb-name }}, the substitution will be configured on all [HTTP routers](../../../application-load-balancer/concepts/http-router.md) created for the `Ingress` resource.

* **ingress.alb.yc.io/upgrade-types** {#annot-upgrade-types}

   HTTP `Upgrade` header values supported by the load balancer in incoming requests. The values are given as a comma-separated list.

   > You can use this annotation, for instance, to enable [WebSocket](https://{{ lang }}.wikipedia.org/wiki/WebSocket) support:
   >
   > ```yaml
   > ingress.alb.yc.io/upgrade-types: WebSocket
   > ```

   In {{ alb-name }}, `Upgrade` will be configured on all the HTTP routers created for the `Ingress` resource.

* **ingress.alb.yc.io/request-timeout** {#annot-request-timeout}

   Maximum load balancer node/backend connection timeout. Once the timeout expires, the load balancer responds to the client with `504 Gateway Timeout`.

   The default value is `60s`.

   In {{ alb-name }}, the timeout will be configured on all HTTP routers created for the `Ingress` resource.

* **ingress.alb.yc.io/idle-timeout** {#annot-idle-timeout}

   Maximum load balancer node/backend connection idle timeout. Once the timeout expires, the load balancer responds to the client with `504 Gateway Timeout`.

   Unless an annotation is specified, a connection can remain idle for any length of time until the overall timeout expires ([ingress.alb.yc.io/request-timeout](#annot-request-timeout) annotation).

   In {{ alb-name }}, the timeout will be configured on all HTTP routers created for the `Ingress` resource.

* **ingress.alb.yc.io/modify-header-response-append** {#annot-modify-header-response-append}

   Adds a string to the response header value. The header and string should be specified in the following format:

   ```yaml
   ingress.alb.yc.io/modify-header-response-append: <key>=<value>
   ```

   Where:

   * `<key>`: Name of the header to be modified.
   * `value`: String to be added to the header value.

* **ingress.alb.yc.io/modify-header-response-replace** {#annot-modify-header-response-replace}

   It replaces the response header value. The header and its new value should be specified in the following format:

   ```yaml
   ingress.alb.yc.io/modify-header-response-replace: <key>=<value>
   ```

   Where:

   * `<key>`: Name of the header to be modified.
   * `<value>`: New header value.

* **ingress.alb.yc.io/modify-header-response-rename** {#annot-modify-header-response-rename}

   It renames the response header. The header and its new name should be specified in the following format:

   ```yaml
   ingress.alb.yc.io/modify-header-response-rename: <key>=<value>
   ```

   Where:

   * `<key>`: Name of the header to be modified.
   * `<value>`: New header name.

* **ingress.alb.yc.io/modify-header-response-remove** {#annot-modify-header-response-remove}

   It removes the response header. The header to remove should be specified in the following format:

   ```yaml
   ingress.alb.yc.io/modify-header-response-remove: <key>=true
   ```

   Where `<key>` is the name of the header to remove.

* **ingress.alb.yc.io/use-regex** {#annot-use-regex}

   Enables support for [RE2](https://github.com/google/re2/wiki/Syntax) regular expressions when matching the request path if the `true` string is provided. Only applies if the `pathType` parameter is set to `Exact`.

## IngressSpec {#spec}

```yaml
tls:
  - <IngressTLS>
  - ...
rules:
  - <IngressRule>
  - ...
```

#|
|| **Field** | **Value or type**     | **Description** ||

|| `tls`     | `[]IngressTLS`        | **Required**
[Incoming HTTPS traffic settings](#tls): domain name collections and the relevant TLS certificates.

If the filed is specified, two types of [listeners](../../../application-load-balancer/concepts/application-load-balancer.md#listener) will be created for the load balancer: some will be receiving HTTPS traffic on port 443, others will redirect HTTP requests (port 80) to HTTPS. At the same time, the traffic distribution rules for the same domain names, if explicitly specified in other `Ingress` resources without the `tls` field, will be prioritized over HTTP-to-HTTPS redirects.

If the field is not specified, only HTTP listeners will be created for the load balancer to handle traffic on port 80.
||

|| `rules`  | `[]IngressRule`        | **Required**
[List of rules](#rule) for distribution of incoming traffic among the backends depending on the domain name (`host` field) and requested resource (`http.paths` field).

In {{ alb-name }}, the rules correspond to HTTP router [virtual hosts](../../../application-load-balancer/concepts/http-router.md#virtual-host).
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
|| **Field**   | **Value or type** | **Description** ||

|| `hosts`     | `[]string`        | **Required**
Domain names covered by the `secretName` TLS certificate.

The load balancer will create a dedicated listener for each domain name used as a value for the Server Name Indication (SNI) TLS extension.

{% include [k8s-ingress-controller-hostnames-wildcard](../../application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %}
||

|| `secretName` | `string`         | **Required**
Reference to a TLS certificate from {{ certificate-manager-full-name }} in `yc-certmgr-cert-id-<certificate ID>` format. This is the name a [secret](https://kubernetes.io/docs/concepts/configuration/secret/) with a certificate is available under in {{ managed-k8s-name }}.

In {{ certificate-manager-name }}, you can have [a certificate from Let's Encrypt<sup>®</sup>](../../../certificate-manager/operations/managed/cert-create.md) or [load one of your own](../../../certificate-manager/operations/import/cert-create.md).

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

In [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) versions prior to 0.2.0, each backend group corresponds to a bundle of `host`, `http.paths.path`, and `http.paths.pathType` parameters. In versions 0.2.0 and later, the backend group corresponds to the `backend.service` ([IngressBackend](#backend)) parameter. This may cause collisions when updating the ALB Ingress Controller. To avoid them, [find out whether upgrade restrictions apply](../../../application-load-balancer/operations/k8s-ingress-controller-upgrade.md) to your infrastructure.

#|
|| **Field** | **Value or type**      | **Description** ||

|| `host`    | `string`               | **Required**
Domain name (value of the `Host` header for HTTP/1.1 or the `:authority` pseudo-header for HTTP/2) covered by the rule.

{% include [k8s-ingress-controller-hostnames-wildcard](../../application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %}

||

|| `http`   | `HTTPIngressRuleValue`   | **Required**
Rule for distribution of incoming requests with the domain name specified in the `host` field depending on the requested resource.

||

|| `http.paths` | `[]HTTPIngressPath`  | **Required**
List of routes: requested resources covered by the rule and the corresponding backends.

The sequence of routes on the list is important: they are matched against an incoming request in turn, and the first match is used for routing. Therefore, we recommend placing the most specific routes at the top of the list. This logic is different from what is described in the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/#multiple-matches) which prioritizes routes with the longest paths (`rules.http.paths.path` field).

{% note warning %}

If you create a load balancer for several `Ingress` resources (with the same [ingress.alb.yc.io/group-name](#annot-group-name) annotation value), and they include rules for the same domain name, the route processing sequence is only guaranteed within each of the `Ingress` resources but not across them.

{% endnote %}

||

|| `http.paths.path` | `string`  | **Required**
Reference to the requested resource:

* For simple HTTP: path in the incoming request URI (if `Exact`) or its prefix (if `Prefix`).
* For gRPC (with the [ingress.alb.yc.io/protocol](#annot-protocol) annotation value equal to `grpc`): full gRPC call name (for `Exact`) or its prefix (for `Prefix`). Example: `/my.custom.server.Service/Method`.

In both cases, the value must begin with `/`.

||

|| `http.paths.pathType` | `string`  | **Required**
Type of reference to the requested resource:

* `Exact`: Path in the request URI or gRPC call name must _match_ the value in the `rules.http.paths.path` field.
* `Prefix`: Path in the request URI or gRPC call name must _begin_ with the value in the `rules.http.paths.path` field.

In addition to distributing traffic, the type also affects the path or call name substitution mechanism in backend requests if the substitution is configured via the [ingress.alb.yc.io/prefix-rewrite](#annot-prefix-rewrite) annotation.

||

|| `http.paths.backend` | `IngressBackend`  | **Required**
Reference to a [backend or a group of backends](#backend) to process requests with the specified domain name and URI path or gRPC call name.

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
|| **Field**    | **Value or type**              | **Description** ||

|| `service`    | `IngressServiceBackend`        | **Required**
Reference to the [{{ k8s }} service](../../../managed-kubernetes/concepts/index.md#service) expected to process requests as a backend.

The `Service` resource this field points to must be described as in the [specification](../../../application-load-balancer/k8s-ref/service.md).

For the `spec.rules.http.paths` list element, you must specify either a service backend or a backend group (`resource`) but not both.

{% include [k8s-ingress-controller-service-backend](../../application-load-balancer/k8s-ingress-controller-service-backend.md) %}

||

|| `resource`   | `TypedLocalObjectReference`     | **Required**
Reference to a backend group to process requests.

The Ingress controller implements the `HttpBackendGroup` resource that this field points to as a [custom resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/). It must be described as in the [specification](../../../application-load-balancer/k8s-ref/http-backend-group.md).

For the `spec.rules.http.paths` list element, you must specify either a backend group or a service backend (`service`) but not both.

* `kind`: `HttpBackendGroup`
* `name` (`string`): Backend group name

   The name must match the value specified in the `metadata.name` field of the `HttpBackendGroup` resource. For more information, see the [resource specification](../../../application-load-balancer/k8s-ref/http-backend-group.md).

* `apiGroup`: `alb.yc.io`

||
|#

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

Specify the log group ID and parameters of the [rules for discarding logs](../../../application-load-balancer/concepts/application-load-balancer.md#discard-logs-rules):

* `httpCodes`: HTTP status codes.
* `httpCodeIntervals`: Classes of HTTP status codes.
* `grpcCodes`: gRPC codes.
* `discardPercent`: Percentage of logs to discard.