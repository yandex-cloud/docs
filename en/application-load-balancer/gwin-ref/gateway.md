# Gateway

Gateway represents an instance of a service-traffic handling infrastructure by binding Listeners to a set of IP addresses. Gwin use these rules to create [Load balancer](https://yandex.cloud/en/docs/application-load-balancer/concepts/application-load-balancer).

Gateway is a [Kubernetes Gateway API](https://gateway-api.sigs.k8s.io/) project resource. Below, we describe its fields and annotations used by Application Load Balancer Gateway API. For configuration details, see the [Kubernetes Gateway API reference](https://gateway-api.sigs.k8s.io/reference/spec/#gateway).

* [Cheatsheet](#cheatsheet)
* [GatewayMeta](#gatewaymeta)
  * [Annotations cheatsheet](#annotations-cheatsheet)
  * [Annotations reference](#annotations-reference)
* [GatewaySpec](#gatewayspec)
  * [Listener](#listener)
  * [GatewayTlsConfig](#gatewaytlsconfig)
  * [SecretObjectReference](#secretobjectreference)
  * [AllowedRoutes](#allowedroutes)
  * [RouteNamespaces](#routenamespaces)
  * [LabelSelector](#labelselector)
  * [LabelSelectorRequirement](#labelselectorrequirement)
  * [GatewayAddress](#gatewayaddress)

## Cheatsheet

{% note info %}

Specification provided below is not valid configuration.

It's just demonstration of all `Gateway` fields.

{% endnote %}

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: my-gateway
  namespace: my-ns
  annotations: ...  # see annotations example below
spec:
  gatewayClassName: gwin-default  # Make Gwin to manage this gateway
  listeners:
    - name: http  # listener identifier
      hostname: "*.example.com"  # accept requests for this domain
      port: 80  # listen on this port
      protocol: HTTP  # protocol type
      allowedRoutes:  # which routes can use this listener
        namespaces:
          from: Selector  # select by labels (Any or Same can be used as alternative)
          selector:
            matchLabels:
              app: my-app  # routes in namespaces with this label
            matchExpressions:
              - key: app
                operator: In
                values:
                  - my-app  # alternative label matching
      tls:
        mode: Terminate  # decrypt TLS at load balancer
        certificateRefs:
          - group: gwin.yandex.cloud
            kind: YCCertificate  # Yandex Cloud certificate
            name: some-certificate
            namespace: some-ns
          - kind: Secret  # Kubernetes secret certificate
            name: some-secret
            namespace: some-ns
  addresses:
    - type: IPAddress
      value: <IP> # ipv4 address preallocated with vpc
    - type: gwin.yandex.cloud/autoIPv4 # Automatic external ipv4 address.
      value: auto
    - type: gwin.yandex.cloud/internalIPv4 # Address in vpc subnet.
      value: <subnet-id>/<ip> # You can use "auto" in <ip>.
```

| Field | Description |
|-------|-------------|
| metadata | **[GatewayMeta](#gatewaymeta)** <br> Name, namespace and annotations. |
| spec | **[GatewaySpec](#gatewayspec)** <br> Resource specification. |

## GatewayMeta

| Field | Description |
|-------|-------------|
| name | **string** <br> Name of the Gateway. |
| namespace | **string** <br> Namespace of the Gateway. |
| annotations | **map[string]string** <br> Annotations of the Gateway. |

### Annotations cheatsheet

{% note info %}

You can also set policy parameters using [GatewayPolicy](./gatewaypolicy.md) resource. The GatewayPolicy resource parameters and Gateway annotations are equivalent.

{% endnote %}

Specification provided below is not valid configuration.
It's just demonstration of all `Gateway` annotations.

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: some-gateway
  annotations:
    gwin.yandex.cloud/subnets: "subnet-id-1,subnet-id-2"  # where to place balancer
    gwin.yandex.cloud/securityGroups: "sg-id-1,sg-id-2"  # network access control
    gwin.yandex.cloud/allowZonalShift: "true"  # enable failover between zones

    # Cloud logging
    gwin.yandex.cloud/logs.logGroupID: "log-group-id-1"  # where to send logs
    gwin.yandex.cloud/logs.disable: "true"  # turn off logging
    gwin.yandex.cloud/logs.discardRule.some-rule.httpCodes: "404,500"  # skip these status codes
    gwin.yandex.cloud/logs.discardRule.some-rule.httpCodeIntervals: "HTTP_4XX,HTTP_5XX"  # skip error ranges
    gwin.yandex.cloud/logs.discardRule.some-rule.grpcCodes: "INTERNAL,UNIMPLEMENTED"  # skip gRPC errors
    gwin.yandex.cloud/logs.discardRule.some-rule.discardPercent: "10"  # drop 10% of logs

    # Autoscaling
    gwin.yandex.cloud/autoScale.minZoneSize: "2"  # min instances per zone
    gwin.yandex.cloud/autoScale.maxSize: "10"  # max total instances

    # Zone traffic control
    gwin.yandex.cloud/zone.ru-central1-a.receiveTraffic: "false"  # disable this zone
    gwin.yandex.cloud/zone.ru-central1-b.receiveTraffic: "true"  # enable this zone

    # HTTPRouter configuration
    gwin.yandex.cloud/listeners.rbac.action: "ALLOW"  # access control policy

    # Listener configuration
    ## HTTP specific
    gwin.yandex.cloud/listeners.http.protocolSettings.allowHTTP10: "true"  # support old HTTP
    gwin.yandex.cloud/listeners.http.protocolSettings.http2Options.maxConcurrentStreams: "100"  # limit connections
    ## Stream specific
    gwin.yandex.cloud/listeners.stream.idleTimeout: "300s"  # stream backend idle timeout

    # Specific listener configuration
    gwin.yandex.cloud/listener.http-listener.http.protocolSettings.allowHTTP10: "true"  # per-listener HTTP setting
    gwin.yandex.cloud/listener.stream-listener.stream.idleTimeout: "300s"  # per-listener timeout
    ...
```

### Annotations reference

#### Basic Gateway сonfiguration

| Annotation and description |
|------------|
| `gwin.yandex.cloud/subnets` <br> _(comma separated strings)_ <br> [Subnets](https://yandex.cloud/en/docs/vpc/concepts/network#subnet) of the zones where load balancer will be instantiated. <br> By default, the balancer is placed in the mk8s cluster subnets. You can override this behavior by configuring `controller.defaultBalancerSubnets` in the Helm chart values. <br> Example: `subnet-id-1,subnet-id-2` |
| `gwin.yandex.cloud/securityGroups` <br> _(comma separated strings)_ <br> [Security groups](https://yandex.cloud/en/docs/vpc/concepts/security-groups) of load balancer. <br> By default, the balancer network’s default security group is used. <br> Example: `sg-id-1,sg-id-2` |
| `gwin.yandex.cloud/allowZonalShift` <br> _(boolean)_ <br> Specifies whether application load balancer is available to zonal shift. Read more about concept [here](https://yandex.cloud/en/docs/application-load-balancer/operations/manage-zone/allow-and-deny-shift). <br> Example: `true` |

#### Cloud Logging

For `discardRule` annotations you can set up any name. It does not affect ALB configuration in any way.

| Annotation and description |
|------------|
| `gwin.yandex.cloud/logs.logGroupID` <br> _(string)_ <br> [Cloud Logging](https://yandex.cloud/en/docs/logging/) log group ID to store [access logs](https://yandex.cloud/en/docs/application-load-balancer/logs-ref). <br> Example: `log-group-id-1` |
| `gwin.yandex.cloud/logs.disable` <br> _(boolean)_ <br> Disable sending logs to [Cloud Logging](https://yandex.cloud/en/docs/logging/). <br> Example: `true` |
| `gwin.yandex.cloud/logs.discardRule.{name}.httpCodes` <br> _(comma separated numbers)_ <br> HTTP status codes to discard from logs. <br> Example: `404,500` |
| `gwin.yandex.cloud/logs.discardRule.{name}.httpCodeIntervals` <br> _(comma separated strings)_ <br> HTTP code intervals to discard. <br> Example: `HTTP_4XX,HTTP_5XX` |
| `gwin.yandex.cloud/logs.discardRule.{name}.grpcCodes` <br> _(comma separated strings)_ <br> gRPC codes to discard from logs. <br> Example: `INTERNAL,UNIMPLEMENTED` |
| `gwin.yandex.cloud/logs.discardRule.{name}.discardPercent` <br> _(number)_ <br> Percentage of matching logs to discard (0-100). <br> Example: `10` |

#### Autoscaling

| Annotation and description |
|------------|
| `gwin.yandex.cloud/autoScale.minZoneSize` <br> _(number)_ <br> Minimum [resource units](https://yandex.cloud/en/docs/application-load-balancer/concepts/application-load-balancer#lcu-scaling) per zone (must be ≥2). <br> Example: `2` |
| `gwin.yandex.cloud/autoScale.maxSize` <br> _(number)_ <br> Maximum total [resource units](https://yandex.cloud/en/docs/application-load-balancer/concepts/application-load-balancer#lcu-scaling) (0 = no limit). <br> Example: `10` |

#### Zone traffic control

`<zone>` is a zone id, e.g. `ru-central1-a`.

| Annotation and description |
|------------|
| `gwin.yandex.cloud/zone.{zone}.receiveTraffic` <br> _(boolean)_ <br> Disable traffic to load balancer nodes in specified [availability zone](https://yandex.cloud/en/docs/overview/concepts/geo-scope). <br> Example: `false` |

#### Listener configuration

{% note info %}

Any `listeners` option can be applied to a specific listener by prefixing with `listener.{listener-name}`.

For example: `gwin.yandex.cloud/listener.http-listener.http.protocolSettings.allowHTTP10: "true"`.

{% endnote %}

| Annotation and description |
|------------|
| `gwin.yandex.cloud/listeners.http.protocolSettings.allowHTTP10` <br> _(boolean)_ <br> Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. Applies to all HTTP listeners. <br> Example: `true` |
| `gwin.yandex.cloud/listeners.http.protocolSettings.http2Options.maxConcurrentStreams` <br> _(number)_ <br> Maximum number of concurrent HTTP/2 streams in a connection. Applies to all HTTP listeners. <br> Example: `100` |
| `gwin.yandex.cloud/listeners.stream.idleTimeout` <br> _(duration)_ <br> The idle timeout is duration during which no data is transmitted or received on either the upstream or downstream connection. Applies to all stream listeners. <br> Example: `300s` |

#### HTTP router configuration

{% note info %}

Any `listeners` router option can be applied to a specific listener by prefixing with `listener.{listener-name}`.

For example: `gwin.yandex.cloud/listener.http-listener.rbac.action: "ALLOW"`.

{% endnote %}


| Annotation and description |
|------------|
| `gwin.yandex.cloud/listeners.rbac.action` <br> _(string)_ <br> RBAC action (ALLOW/DENY) for HTTP router access control for all listeners. <br> Example: `ALLOW` |

For detailed RBAC configuration patterns, see: [RBAC Configuration](#rbac-configuration)

#### RBAC configuration

RBAC allows controlling access to listeners, routes or hosts based on request attributes.

Annotations follow the pattern:

`gwin.yandex.cloud/{resource}.rbac.principals.{principal-group}.{principal}.{rule-type}`

Where:
* `{resource}` — resource type (`listeners`, `rules`, `hosts`);
* `{principal-group}` — logical group of checks (e.g. `admin`);
* `{principal}` — specific principal identifier (e.g. `check-token`);
* `{rule-type}` — matching rule type (`header`, `ip`, etc.).

##### Combination Rules

* All checks within the same principal group are combined with AND logic.
* Different principal groups are combined with OR logic.

##### Principal Types

| Annotation pattern and description |
|--------------------|
| `gwin.yandex.cloud/{resource}.rbac.action` <br> _(string)_ <br> Action when principals match (ALLOW/DENY). <br> Example: `ALLOW` |
| `gwin.yandex.cloud/{resource}.rbac.principals.{principal-group}.{principal}.header.name` <br> _(string)_ <br> Header name to match. <br> Example: `X-Api-Token` |
| `gwin.yandex.cloud/{resource}.rbac.principals.{principal-group}.{principal}.header.exact` <br> _(string)_ <br> Exact header value match. <br> Example: `admin123` |
| `gwin.yandex.cloud/{resource}.rbac.principals.{principal-group}.{principal}.header.regex` <br> _(string)_ <br> Regular expression header value match. <br> Example: `^admin.*` |
| `gwin.yandex.cloud/{resource}.rbac.principals.{principal-group}.{principal}.header.prefix` <br> _(string)_ <br> Prefix header value match. <br> Example: `Bearer ` |
| `gwin.yandex.cloud/{resource}.rbac.principals.{principal-group}.{principal}.ip.remoteIp` <br> _(string)_ <br> IP/CIDR to match. <br> Example: `10.0.0.0/8` |
| `gwin.yandex.cloud/{resource}.rbac.principals.{principal-group}.{principal}.any` <br> _(boolean)_ <br> Match any request. <br> Example: `true` |

## GatewaySpec

Gateway specification.

Default name for default `GatewayClass` is `"gwin-default"`. So use this to attach gateways to Gwin.

*Appears in*: [Gateway](#gateway)

| Field | Description |
|-------|-------------|
| gatewayClassName | **string** <br> Gateway class name. <br> Example: `gwin-default` |
| listeners | **[[]Listener](#listener)** <br> Gateway listeners. |
| addresses | **[[]GatewayAddress](#gatewayaddress)** <br> Load balancer public IP settings. |

### Listener

Gateway listener configuration.

*Appears in*: [GatewaySpec](#gatewayspec)

| Field | Description |
|-------|-------------|
| name | **string** <br> Listener internal name. This name is only used by Kubernetes. Do not mistake it for the ALB listener name. The internal name should be in domain format, i.e., match the following regular expression: `[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*`. For example, `example`, `example.com`, and `foo.example.com` are valid internal names, while `example.com/bar` and `-example.` are not. The name can be up to 63 characters long. <br> Example: `http`, `example.com`. |
| hostname | **string** <br> Listener domain name. The listener will only process routes, i.e., HTTPRoute, GRPCRoute and TLSRoute resources, with domain names, i.e `spec.hostnames` fields, matching the value specified in this setting. <br> Example: `*.example.com` |
| port | **int32** <br> Listener incoming traffic port. <br> Example: `80`, `443`. |
| protocol | **string** <br> Listener incoming traffic protocol: `HTTP`, `HTTPS` or `TLS`. <br> Example: `HTTP`, `HTTPS`, `TLS`. |
| tls | **[GatewayTlsConfig](#gatewaytlsconfig)** <br> TLS settings for incoming HTTPS and TLS traffic. |
| allowedRoutes | **[AllowedRoutes](#allowedroutes)** <br> Rules for selection of listener routes, i.e., HTTPRoute, GRPCRoute and TLSRoute resources. To ensure route selection, these resources must have `Gateway` specified in their `spec.parentRefs` fields. The system will use these routes to create backend groups you can link to the listener. The system will automatically create HTTP routers for `HTTPRoute` resources. |

### GatewayTlsConfig

TLS settings for HTTPS and TLS traffic termination.

*Appears in*: [Listener](#listener)

| Field | Description |
|-------|-------------|
| mode | **string** <br> TLS connections termination mode. You can only use the default `Terminate` setting, where incoming traffic is decrypted using certificates from `certificateRefs` and then routed to backends. `Passthrough` mode without connection termination is not supported yet. <br> Example: `Terminate` |
| certificateRefs | **[[]SecretObjectReference](#secretobjectreference)** <br> Kubernetes resources containing TLS certificates. You can only use this setting if `protocol` is specified as `HTTPS` or `TLS`. The list must contain at least one certificate. |

### SecretObjectReference

Reference to Kubernetes resource containing TLS certificate.

You can specify a certificate from Certificate Manager (the [YCCertificate](./yccertificate.md) resource) or from `Secret` resource (certificate in Certificate Manager will be created automatically).

```bash
kubectl create secret tls <secret_name> \
  --namespace <namespace_name> \
  --cert <certificate_file_path> \
  --key <path_to_file_with_certificate_private_key>
```

If `Secret` is used, Cloud Certificate will be created.
The secret must have the following fields (see [k8s docs](https://kubernetes.io/docs/concepts/configuration/secret/#tls-secrets)):
* `tls.crt` — TLS certificate;
* `tls.key` — TLS private key.

For `YCCertificate` details, see: [YCCertificate](./yccertificate.md)

*Appears in*: [GatewayTlsConfig](#gatewaytlsconfig)

| Field | Description |
|-------|-------------|
| group | **string** <br> Name of the Kubernetes API group associated with the certificate resource, e.g., `networking.k8s.io`. The default value is empty, indicating the root API group. <br> Example: `gwin.yandex.cloud` |
| kind | **string** <br> Type of the Kubernetes certificate storage resource. The default value is `Secret`. For a certificate from Certificate Manager, use the `YCCertificate` value. <br> Example: `Secret`, `YCCertificate`. |
| name | **string** <br> Name of the Kubernetes certificate storage resource. <br> Example: `some-certificate` |
| namespace | **string** <br> Certificate resource namespace. <br> Example: `some-ns` |

### AllowedRoutes

Rules for selecting which routes can use this listener.

*Appears in*: [Listener](#listener)

| Field | Description |
|-------|-------------|
| namespaces | **[RouteNamespaces](#routenamespaces)** <br> Namespace selection rule for HTTPRoute and TLSRoute resources. |

### RouteNamespaces

Namespace selection rules for HTTPRoute and TLSRoute resources.

*Appears in*: [AllowedRoutes](#allowedroutes)

| Field | Description |
|-------|-------------|
| from | **string** <br> Rule type:<br> `All` - All namespaces are available for resource selection;<br> `Same` - Only the Gateway resource namespace specified in the `metadata.namespace` field is available for selection;<br> `Selector` - Only namespaces meeting criteria specified in the `selector` field are available for selection. <br> Example: `All`, `Same`, `Selector`. |
| selector | **[LabelSelector](#labelselector)** <br> Namespace selection requirements. To be selected, a namespace must meet all criteria specified in `matchExpressions` and `matchLabels` fields. For more information, see the Kubernetes API reference. If you specify a value other than `Selector` in the `from` field, the `selector` field will be ignored. |

### LabelSelector

Label-based selection criteria for namespaces.

*Appears in*: [RouteNamespaces](#routenamespaces)

| Field | Description |
|-------|-------------|
| matchLabels | **map[string]string** <br> Simple label matching requirements. <br> Example: `app: my-app` |
| matchExpressions | **[[]LabelSelectorRequirement](#labelselectorrequirement)** <br> Advanced label matching expressions. |

### LabelSelectorRequirement

Advanced label matching expression with operator and values.

*Appears in*: [LabelSelector](#labelselector)

| Field | Description |
|-------|-------------|
| key | **string** <br> Label key to match. <br> Example: `app` |
| operator | **string** <br> Matching operator. <br> Example: `In`, `NotIn`, `Exists`. |
| values | **[]string** <br> Values to match against. <br> Example: `["my-app"]` |

### GatewayAddress

Load balancer public IP settings.

Types and values:

```yaml
- type: IPAddress
  value: <IP> # ipv4 address preallocated with vpc
- type: gwin.yandex.cloud/autoIPv4 # Automatic external ipv4 address.
  value: auto
- type: gwin.yandex.cloud/internalIPv4 # Address in vpc subnet.
  value: <subnet-id>/<ip> # You can use "auto" in <ip>.
```

*Appears in*: [GatewaySpec](#gatewayspec)

| Field | Description |
|-------|-------------|
| type | **string** <br> Address type: `IPAddress` for standard IP addresses, `gwin.yandex.cloud/autoIPv4` for automatic external IPv4 address, `gwin.yandex.cloud/internalIPv4` for address in VPC subnet. <br> Example: `IPAddress`,`gwin.yandex.cloud/autoIPv4`,`gwin.yandex.cloud/internalIPv4`. |
| value | **string** <br> Load balancer public IP address. To use a public IP address, first, you need to [reserve it](https://yandex.cloud/en/docs/vpc/operations/get-static-ip) in VPC. For `gwin.yandex.cloud/autoIPv4` use `auto`. For `gwin.yandex.cloud/internalIPv4` use `<subnet-id>/<ip>` format where you can use `auto` for IP. <br> Example: `5.4.3.2`, `auto`, `subnet-123/10.0.0.1`. |
