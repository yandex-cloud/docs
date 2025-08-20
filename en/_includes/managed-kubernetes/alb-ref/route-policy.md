# RoutePolicy resource fields

The `RoutePolicy` resource enables setting cloud-specific policies for `HTTPRoute` resources and other routes in {{ alb-name }}. Policies apply to routes based on either selectors or explicit references.

{% note info %}

You can also set policy parameters using `HTTPRoute` resource annotations. `RoutePolicy` resource parameters and `HTTPRoute` annotations are equivalent.

{% endnote %}

Here is an example of the `RoutePolicy` resource definition (intended solely to demonstrate all the parameters):

```yaml
apiVersion: gateway.alb.yc.io/v1
kind: RoutePolicy
metadata:
  name: my-route-policy
spec:
  targetRefs:
    - name: some-http-route
      kind: HTTPRoute
      group: gateway.networking.k8s.io
  selector:
    matchLabels:
      app: my-app

  policy:
    rules:
      timeout: "60s"                           
      idleTimeout: "300s"                      
      securityProfileId: "security-profile-1"
    
      http:
        upgradeTypes: ["websocket"]

      backends:
        balancing:
          mode: "ROUND_ROBIN"
          panicThreshold: 50
          localityAwareRouting: 90
          strictLocality: false

        sessionAffinity:
          header:
            name: "X-Session-ID"
          cookie: 
            name: "session"
            ttl: "1h"
          connection:
            sourceIP: true

        hc:
          timeout: "2s"
          interval: "5s"
          healthyThreshold: 3
          unhealthyThreshold: 5
          port: 30030 

          http:
            path: "/health"
            host: "example.com"
            useHTTP2: true

          grpc:
            serviceName: "health"

          stream:
            send: "PING"
            receive: "PONG"

        tls:
          sni: "example.com"
          trustedCA:
            id: "certificate-id"
            bytes: | 
              -----BEGIN CERTIFICATE-----
              ...
              -----END CERTIFICATE-----

      rbac:
        action: "ALLOW"
        principals:
          admin:
            token-check:
              header:
                name: "X-Auth-Token"
                exact: "admin-token"
            ip-check:
              ip:
                remoteIp: "10.0.0.0/8"
            any: true

  hosts:
    securityProfileId: "security-profile-1"
    rbac:
      ...

  rule:
    api-route: 
      timeout: "30s"
      ...

  host:
    api.example.com: 
      securityProfileId: "api-profile"
      ...
```

## RoutePolicy {#routepolicy}

```yaml
apiVersion: gateway.alb.yc.io/v1
kind: RoutePolicy
metadata:
  name: <string>
  namespace: <string>
spec:
  targetRefs:
    - name: <string>
      kind: <string>
      group: <string>
  selector:
    matchLabels:
      <key>: <value>
  policy:
    rules: <RouteRule>
    rule:
      <rule_name>: <RouteRule>
    hosts: <VirtualHost>
    host:
      <host_name>: <VirtualHost>
```

Where:

* `apiVersion`: `gateway.alb.yc.io/v1`
* `kind`: `RoutePolicy`
* `metadata` (`ObjectMeta`, required)

  Resource metadata.

  * `name` (`string`, required)

    Resource name. For more information about the group name format, see the relevant [{{ k8s }} article](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

    Do not mistake this name for the {{ alb-name }} load balancer name.
  
  * `namespace` (`string`)
  
    Resource [namespace](../../../managed-kubernetes/concepts/index.md#namespace). The default value is `default`.

* `spec` (`RoutePolicySpec`, required):

  * `targetRefs` (`[]LocalObjectReference`): List of references to resources targeted by the policy.

  * `selector` (`LabelSelector`): Selector for selecting resources by labels.

  * `policy` (`Route`, required): Cloud-specific route configuration. For more information, see [below](#route).

## Route {#route}

```yaml
rules: <RouteRule>
rule:
  <rule_name>: <RouteRule>
hosts:
  securityProfileId: <string>
  rbac: <RBAC>
host:
  <host_name>:
    securityProfileId: <string>
    rbac: <RBAC>
```

Where:

* `rules` (`RouteRule`)

  Settings shared by all route rules. For more information, see [RouteRule](#routerule).

* `rule` (`map[string]RouteRule`)

  Settings for specific rules (by name).

* `hosts` (`VirtualHost`)

  Settings shared by all virtual hosts.

  * `securityProfileId` (`string`)
  
    Host's {{ sws-name }} [profile](../../../smartwebsecurity/concepts/profiles.md) ID.

  * `rbac` (`RBAC`)
  
    [RBAC settings](#rbac) for host access.

* `host` (`map[string]VirtualHost`)

  Settings for specific hosts (by name).

## RouteRule {#routerule}

```yaml
backends: <Backend>
sessionAffinity: <SessionAffinity>
securityProfileId: <string>
rbac: <RBAC>
timeout: <string>
idleTimeout: <string>
http:
  upgradeTypes: [<string>, ...]
```

* `backends` (`Backend`)

  Backend group settings. For more information, see [Backend](#backend).

* `sessionAffinity` (`SessionAffinity`)

  [Session affinity](../../../application-load-balancer/concepts/backend-group.md#session-affinity) settings. For more information, see [SessionAffinity](#sessionaffinity).

* `securityProfileId` (`string`)

  {{ sws-name }} security profile ID.

* `rbac` (`RBAC`)

  RBAC settings. For more information, see [RBAC](#rbac).

* `timeout` (`string`)

  Total connection timeout, e.g., `"60s"`.

* `idleTimeout` (`string`)

  Inactive connection timeout.

* `http` (`RouteALBHTTP`)

  HTTP-specific options.

  * `upgradeTypes` (`[]string`)
  
    Supported `HTTP Upgrade` values, e.g., `websocket`.

## Backend {#backend}

```yaml
http:
  useHTTP2: <bool>
stream:
  enableProxy: <bool>
balancing:
  mode: <string>
  panicThreshold: <int>
  localityAwareRouting: <int>
  strictLocality: <bool>
hc: <HealthCheck>
tls: <BackendTLS>
```

Where:

* `http` (`HTTPBackend`)

  Backend HTTP settings.

  * `useHTTP2` (`bool`): Specifies whether to use HTTP/2 for backend connections. HTTP/1.1 is used by default.

* `stream` (`StreamBackend`)

  Backend TCP settings.

  * `enableProxy` (`bool`)
  
    Enable proxy protocol for the TCP backend.

* `balancing` (`LoadBalancingConfig`)

  Load balancing settings.

  * `mode` (`string`)
  
    Balancing mode. The possible values are `RANDOM`, `ROUND_ROBIN`, and `LEAST_REQUEST`.

  * `panicThreshold` (`int`)
  
    Panic mode threshold in %.

  * `localityAwareRouting` (`int`)
  
    Percentage of traffic sent to the local zone.

  * `strictLocality` (`bool`)
  
    Indicator of strictly local routing: traffic is routed only to the load balancer node's availability zone.

* `hc` (`HealthCheck`)

  Health check parameters. For more information, see [HealthCheck](#healthcheck).

* `tls` (`BackendTLS`)

  TLS settings for backend connection. For more information, see [BackendTLS](#backendtls).

## HealthCheck {#healthcheck}

```yaml
timeout: <string>
interval: <string>
healthyThreshold: <int>
unhealthyThreshold: <int>
port: <int>
http:
  host: <string>
  path: <string>
  useHTTP2: <bool>
grpc:
  serviceName: <string>
stream:
  send: <string>
  receive: <string>
```

Where:

* `timeout` (`string`)

  Health check response timeout.

* `interval` (`string`)

  Health check interval.

* `healthyThreshold` (`int`)

  Number of successful health checks to set the status to `healthy`.

* `unhealthyThreshold` (`int`)

  Number of unsuccessful health checks to set the status to `unhealthy`.

* `port` (`int`)
  
  Health check port.

* `http` (`HealthcheckHTTP`)

  HTTP health check.

  * `host` (`string`): Host header for the health check.
  * `path` (`string`): HTTP health check path.
  * `useHTTP2` (`bool`): Specifies whether to use HTTP/2 for the health check.

* `grpc` (`HealthcheckGRPC`)

  gRPC health check.

  * `serviceName` (`string`): Name of the gRPC service for the health check.

* `stream` (`HealthcheckStream`)

  TCP health check.

  * `send` (`string`): Data to send during the TCP health check.
  * `receive` (`string`): Expected response.

## BackendTLS {#backendtls}

```yaml
sni: <string>
trustedCA:
  id: <string>
  bytes: <string>
```

Where:

* `sni` (`string`)

  TLS SNI.

* `trustedCA`

  Trusted CA:

  * `id` (`string`): Certificate ID.
  * `bytes` (`string`): PEM-encoded certificate content.

## SessionAffinity {#sessionaffinity}

```yaml
connection:
  sourceIP: <bool>
cookie:
  name: <string>
  ttl: <string>
header:
  name: <string>
```

Where:

* `connection.sourceIP` (`bool`)

  Indicator of using the client IP address for session affinity.

* `cookie.name` (`string`)

  Cookie name for session affinity.

* `cookie.ttl` (`string`)

  Cookie TTL.

* `header.name` (`string`)

  HTTP header name for session affinity.

## RBAC {#rbac}

RBAC manages route and host access by checking request attributes.

RBAC rules apply to _groups_ and _principals_:

* Group: Logical group of checks, e.g., `admin`.
* Principal: Name for checking conditions, e.g., `check-token`.

Each rule is defined by types of conditions to check, e.g., `header` and `ip`.

All checks within a single group work together based on the `AND` logic. Checks in different groups use the `OR` logic.

```yaml
action: <string>
principals:
  <group_name>:
    <principal_name>:
      header:
        name: <string>
        regex: <string>
        exact: <string>
        prefix: <string>
      ip:
        remoteIp: <string>
      any: <bool>
```

Where:

* `action` (`string`)

  Action when rules trigger, `ALLOW`/`DENY`.

* `principals`

  Condition groups:

  * `header`: Condition to check if the header value matches the specified value.
  * `ip.remoteIp`: Condition to check if the client request's IP address or CIDR block matches the specified value.
  * `any`: Check applies to all requests.
