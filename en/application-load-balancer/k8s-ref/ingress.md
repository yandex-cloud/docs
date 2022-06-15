# Ingress fields and annotations

The `Ingress` resource defines the rules for distributing incoming traffic to {{ k8s }} services. The [{{ alb-name }} Ingress controller](../tools/k8s-ingress-controller/index.md) uses these rules to create a [load balancer](../concepts/application-load-balancer.md) with the requisite listeners and [HTTP routers](../concepts/http-router.md). The [services](service.md) acting as {{ alb-name }} backends may be specified in `Ingress` directly or as part of [`HttpBackendGroup` backend groups](http-backend-group.md).

`Ingress` is a {{ k8s }} standard resource. This reference describes the fields and the annotations of the resource that a {{ alb-name }} Ingress controller interfaces with. For a complete reference on the resource, please see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/ingress-v1/).

## Ingress {#ingress}

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: <string>
  annotations:
    ...
spec: <IngressSpec>
```

* `apiVersion`: `networking.k8s.io/v1`
* `kind`: `Ingress`
* `metadata` (`ObjectMeta`, required)

   Resource metadata.

   * `name` (`string`, required)

      Resource name. For more information about format, please see the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

      Does not match the balancer name in {{ alb-name }}.

   * `annotations` (`map[string]string`, required)

      Resource annotation. For more detail, please see [below](#annotations).

* `spec` (`IngressSpec`, required)

   Resource specification. For more detail, please see [below](#spec).

## Annotations (metadata.annotations) {#annotations}

```yaml
metadata:
  annotations:
    ingress.alb.yc.io/group-name: <string>
    ingress.alb.yc.io/subnets: <string>
    ingress.alb.yc.io/security-groups: <string>
    ingress.alb.yc.io/external-ipv4-address: <string>
    ingress.alb.yc.io/internal-ipv4-address: <string>
    ingress.alb.yc.io/internal-alb-subnet: <string>
    ingress.alb.yc.io/protocol: <string>
    ingress.alb.yc.io/transport-security: <string>
    ingress.alb.yc.io/prefix-rewrite: <string>
    ingress.alb.yc.io/upgrade-types: <string>
    ingress.alb.yc.io/request-timeout: <string>
    ingress.alb.yc.io/idle-timeout: <string>
```

* `ingress.alb.yc.io/group-name` (`string`, required)

   Name of an `Ingress` resource group combined in a single load balancer. For more information about format, please see the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

   The field is required even if the load balancer uses a single `Ingress`.

* `ingress.alb.yc.io/subnets` (`string`)

   List of {{ vpc-name }} [subnets](../../vpc/concepts/network.md#subnet) the [load balancer is located on](../concepts/application-load-balancer.md#lb-location). Subnet IDs are provided as a comma-separated list, such as:

   ```
   ingress.alb.yc.io/subnets: b0c2kotoidcoh6haf8cu,e2lnhhdj9a0aqmr78d36,e9bud5itjnl8mkjj7td1
   ```

   The field is required for at least a single `Ingress` in a group (`ingress.alb.yc.io/group-name` annotation) to create one load balancer. A balancer uses all the subnets specified in the relevant `Ingress` resources.

   All the subnets of a single load balancer must belong to the same network with no more than one network specified in each [availability zone](../../overview/concepts/geo-scope.md).

* `ingress.alb.yc.io/security-groups` (`string`)

   {% include [security-groups-note](../_includes_service/security-groups-note.md) %}

   List of {{ vpc-name }} [security groups](../../vpc/concepts/security-groups.md) for a load balancer. Group IDs are provided in a comma-separated list, such as:

   ```
   ingress.alb.yc.io/security-groups: b0c2kotoidcoh6haf8cu,e2lnhhdj9a0aqmr78d36,e9bud5itjnl8mkjj7td1
   ```

   A load balancer created for a group of several `Ingress` resources (`ingress.alb.yc.io/group-name` annotation) uses all the security groups specified in these `Ingress` resources.

   For proper load balancer and Ingress controller operation, the security groups must be configured as specified in [{#T}](../tools/k8s-ingress-controller/security-groups.md).

* `ingress.alb.yc.io/external-ipv4-address` (`string`)

   Configuring a load balancer's public IP.

   To use a [reserved IP](../../vpc/operations/get-static-ip.md), put it in the annotation value. For the load balancer to get its IP automatically, specify `auto`.

   A load balancer must be configured with either a public or a private IP (`ingress.alb.yc.io/internal-ipv4-address` annotation) but not both.

* `ingress.alb.yc.io/internal-ipv4-address` (`string`)

   Configuring a load balancer with a private IP.

   The IP address must belong to the subnet specified in the `ingress.alb.yc.io/internal-alb-subnet` annotation. To use a specific IP from the subnet in question, put it in the annotation. For the load balancer to get its IP automatically, specify `auto`.

   A load balancer must be configured with either a private or a public IP (`ingress.alb.yc.io/external-ipv4-address` annotation) but not both.

* `ingress.alb.yc.io/internal-alb-subnet` (`string`)

   Load balancer private IP subnet ID.

   The field is required if a load balancer is configured with a private IP address (`ingress.alb.yc.io/internal-ipv4-address` annotation).

* `ingress.alb.yc.io/protocol` (`string`)

   Connection protocol for load balancer and backends described in `Ingress`:

   * `http`: HTTP/1.1. Default value.
   * `http2`: HTTP/2.
   * `grpc`: gRPC.

* `ingress.alb.yc.io/transport-security` (`string`)

   Connection encryption protocol for load balancer and backends specified in `Ingress` directly (no `HttpBackendGroup`):

   * `tls`: TLS with no certificate challenge.

   If no annotation is specified, the load balancer connects to the backends with no encryption.

   For backends belonging to groups, the annotation value is ignored. When you encrypt a connection between a load balancer and grouped backends, you configure the encryption via the `spec.backend.tls` field of the `HttpBackendGroup` resource (see the [resource reference](http-backend-group.md)).

* `ingress.alb.yc.io/prefix-rewrite` (`string`)

   Substitution for URI paths or gRPC call names listed in the [`Ingress` specification](#spec) (`rules.http.paths` field) when routing requests to backends.

   The substitution depends on path or name type: for `pathType: Exact`, the entire path or name is replaced, for `pathType: Prefix`, only the specified initial portion is replaced.

   > For example, to have the load balancer route backend requests to a specific version when handling all incoming API calls, configure the following substitution:
   >
   > ```yaml
   > ...
   > metadata:
   >   annotations:
   >     ingress.alb.yc.io/prefix-rewrite: /api/v4/
   > ...
   > spec:
   >   rules:
   >     - host: <domain name>
   >       http:
   >         paths:
   >           - path: /api/
   >             pathType: Prefix
   >             ...
   > ```

   In {{ alb-name }}, the substitution will be configured on all [HTTP routers](../concepts/http-router.md) created for the `Ingress` resource.

* `ingress.alb.yc.io/upgrade-types` (`string`)

   Value of the HTTP `Upgrade` header in all incoming requests supported by the load balancer. The values are given as a comma-separated list.

   > You can use this annotation, for instance, to enable [WebSocket](https://{{ lang }}.wikipedia.org/wiki/WebSocket) support:
   >
   > ```yaml
   > ingress.alb.yc.io/upgrade-types: WebSocket
   > ```

   In {{ alb-name }}, `Upgrade` will be configured on all the HTTP routers created for the `Ingress` resource.

* `ingress.alb.yc.io/request-timeout` (`string`)

   Maximum load balancer node/backend connection timeout. Once the timeout expires, the load balancer responds to client with `504 Gateway Timeout`.

   Default: `60s`.

   In {{ alb-name }}, the timeout will be configured on all HTTP routers created for the `Ingress` resource.

* `ingress.alb.yc.io/idle-timeout` (`string`)

   Maximum load balancer node/backend connection idle timeout. Once the timeout expires, the load balancer responds to client with `504 Gateway Timeout`.

   Unless an annotation is specified, a connection can remain idle for any length of time until the overall timeout expires (`ingress.alb.yc.io/request-timeout` annotation).

   In {{ alb-name }}, the timeout will be configured on all HTTP routers created for the `Ingress` resource.

## IngressSpec {#spec}

```yaml
spec:
  tls:
    - hosts:
        - <string>
        - ...
      secretName: <string>
    - ...
  rules:
    - host: <string>
      http:
        paths:
          - path: <string>
            pathType: <string>
            backend: <IngressBackend>
    - ...
```

* `tls` (`[]IngressTLS`)

   Incoming HTTPS traffic settings: domain name collections and the relevant TLS certificates.

   If the field is specified, two types of [listeners](../concepts/application-load-balancer.md#listener) will be created for the load balancer: some will be receiving HTTPS traffic on port 443, others will redirect HTTP requests (port 80) to HTTPS. At the same time, the traffic distribution rules for the same domain names, if explicitly specified in other `Ingress` resources lacking the `tls` field will be given priority with respect to HTTP-to-HTTPS redirects.

   If the field is not specified, only HTTP listeners will be created for the load balancer to handle traffic on port 80.

   * `hosts` (`[]string`, required)

      Domain names that the `secretName` TLS certificate corresponds to.

      The load balancer will create a dedicated listener for each domain name serving as a value for the Server Name Indication (SNI) TLS extension.

      {% include [k8s-ingress-controller-hostnames-wildcard](../../_includes/application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %}

   * `secretName` (`string`, required)

      A reference to a TLS certificate from {{ certificate-manager-full-name }} as `yc-certmgr-cert-id-<certificate ID>`. This is the name a [secret](https://kubernetes.io/docs/concepts/configuration/secret/) with a certificate is available as in {{ managed-k8s-name }}.

      In {{ certificate-manager-name }}, you can have [a certificate issued by Let's Encrypt<sup>®</sup>](../../certificate-manager/operations/managed/cert-create.md) or [load one of your own](../../certificate-manager/operations/import/cert-create.md).

      {% include [k8s-ingress-controller-secret-name](../../_includes/application-load-balancer/k8s-ingress-controller-secret-name.md) %}

* `rules` (`[]IngressRule`, required)

   A list of rules for distributing incoming traffic to the backends as a function of the domain names (`host` field) and the resource being requested (`http.paths` field).

   In {{ alb-name }}, the rules correspond to HTTP router [virtual hosts](../concepts/http-router.md#virtual-host).

   * `host` (`string`, required)

      Domain name (value of `Host` header for HTTP/1.1 or `:authority` pseudo-header for HTTP/2), to which a rule applies.

      {% include [k8s-ingress-controller-hostnames-wildcard](../../_includes/application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %}

   * `http` (`HTTPIngressRuleValue`, required)

      Rule for routing incoming requests with the domain name specified in the `rules.host` field as a function of the resource being requested.

      * `paths` (`[]HTTPIngressPath`, required)

         List of routes: the resources being requested, subject to a rule and the corresponding backends.

         The sequence of routes on the list is important: they are matched against an incoming request in turn, and the first match is used for routing. Therefore, it is recommended that you place the most specific routes at the top of the list. This logic is different from what is described in the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/#multiple-matches) which prioritizes routes with the longest paths (`rules.http.paths.path` field).

         {% note warning %}

         If you create a load balancer for several `Ingress` resources (with the same `ingress.alb.yc.io/group-name` annotation value), and they include rules for the same domain name, the route processing sequence is only guaranteed within each of the `Ingress` resources but not <q>across</q> them.

         {% endnote %}

         * `pathType` (`string`, required)

            Type of reference to the requested resource:

            * `Exact`: path in the request URI or gRPC call name must _match_ the value in the `rules.http.paths.path` field.
            * `Prefix`: path in request URI or gRPC call name must _begin_ with the value in the `rules.http.paths.path` field.

            In addition to distributing traffic, the type also affects the path or call name substitution mechanism in backend requests if the substitution is configured via the `ingress.alb.yc.io/prefix-rewrite` [annotation](#annotations).

         * `path` (`string`, required)

            Reference to the resource being requested:

            * For simple HTTP: path in the incoming request URI (if `Exact`) or its front portion (if `Prefix`).
            * For gRPC (with the `ingress.alb.yc.io/protocol` [annotation](#annotations) value equal to `grpc`): full gRPC call name (for `Exact`) or its front portion (for `Prefix`). Example: `/my.custom.server.Service/Method`.

            In both cases, the value must begin with `/`.

         * `backend` (`IngressBackend`, required)

            Reference to a backend or a group of backends to process requests with the specified domain name or URI path or gRPC call name. For more detail, please see [below](#backend).

## IngressBackend {#backend}

```yaml
spec:
  rules:
    - http:
        paths:
          - backend:
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

* `service` (`IngressServiceBackend`)

   Reference to the [{{ k8s }} service](../../managed-kubernetes/concepts/index.md#service) expected to be the backend to process the requests.

   The `Service` resource this field points to must be described as in the [specification](service.md).

   For the `spec.rules.http.paths` list element, you must specify either a service backend or a backend group (`resource`) but not both.

   {% include [k8s-ingress-controller-service-backend](../../_includes/application-load-balancer/k8s-ingress-controller-service-backend.md) %}

* `resource` (`TypedLocalObjectReference`)

   Reference to a backend group to process requests.

   The Ingress controller implements the `HttpBackendGroup` resource that this field points to as a [custom resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/). It must be described as in the [specification](http-backend-group.md).

   For the `spec.rules.http.paths` list element, you must specify either a backend group or a service backend (`service`) but not both.

   * `kind`: `HttpBackendGroup`
   * `name` (`string`)

      Backend group name.

      The name must match the value specified in the `metadata.name` field of the `HttpBackendGroup` resource. For more detail, please see the [resource specification](http-backend-group.md).

   * `apiGroup`: `alb.yc.io`
