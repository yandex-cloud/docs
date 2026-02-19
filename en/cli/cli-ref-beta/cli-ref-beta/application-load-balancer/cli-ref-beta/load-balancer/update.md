---
editable: false
noIndex: true
---

# yc beta application-load-balancer load-balancer update

Updates the specified application load balancer.

#### Command Usage

Syntax:

`yc beta application-load-balancer load-balancer update <LOAD-BALANCER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--allocation-policy` | `shorthand/json`

New locality settings of the application load balancer. For details about the concept, see documentation. Existing locality settings are completely replaced by the specified settings, so if you just want to add or remove an allocation policy: 1. Get the current settings with a [LoadBalancerService.Get] request. 2. Add or remove a policy in this set. 3. Send the new set in this field.

Shorthand Syntax:

```hcl
{
  locations = [
    {
      disable-traffic = boolean,
      subnet-id = string,
      zonal-shift-active = boolean,
      zonal-traffic-disabled = boolean,
      zone-id = string
    }, ...
  ]
}
```

JSON Syntax:

```json
{
  "locations": [
    {
      "disable-traffic": "boolean",
      "subnet-id": "string",
      "zonal-shift-active": "boolean",
      "zonal-traffic-disabled": "boolean",
      "zone-id": "string"
    }, ...
  ]
}
```

Fields:

```
locations -> ([]struct)
  Availability zones and subnets that the application load balancer resides.
  disable-traffic -> (boolean)
    Disables the load balancer node in the specified availability zone. Backends in the availability zone are not directly affected by this setting. They still may receive traffic from the load balancer nodes in other availability zones, subject to [LoadBalancingConfig.locality_aware_routing_percent] and [LoadBalancingConfig.strict_locality] settings.
  subnet-id -> (string)
    ID of the subnet that the application load balancer belongs to.
  zonal-shift-active -> (boolean)
    Show zonal shift status for the location. Deprecated: use [zonal_traffic_disabled] below to track traffic status.
  zonal-traffic-disabled -> (boolean)
    Computed field: will be set to true if all traffic in zone is disabled either manually by user or automatically by Cloud infrastructure.
  zone-id -> (string)
    ID of the availability zone where the application load balancer resides. Each availability zone can only be specified once.
``` ||
|| `--allow-zonal-shift` | Specifies whether application load balancer is available to zonal shift. ||
|| `--auto-scale-policy` | `shorthand/json`

New scaling settings of the application load balancer. The scaling settings relate to a special internal instance group which facilitates the balancer's work. Instances in this group are called _resource units_. The group is scaled automatically based on incoming load and within limitations specified in these settings. For details about the concept, see documentation.

Shorthand Syntax:

```hcl
{
  max-size = integer,
  min-zone-size = integer
}
```

JSON Syntax:

```json
{
  "max-size": "integer",
  "min-zone-size": "integer"
}
```

Fields:

```
max-size -> (integer)
  Upper limit for the total number of resource units across all availability zones. If a positive value is specified, it must be at least [min_zone_size] multiplied by the size of [AllocationPolicy.locations]. If the value is 0, there is no upper limit.
min-zone-size -> (integer)
  Lower limit for the number of resource units in each availability zone. If not specified previously (using other instruments such as management console), the default value is 2. To revert to it, specify it explicitly. The minimum value is 2.
``` ||
|| `--description` | `string`

New description of the application load balancer. ||
|| `--labels` | `map<string><string>`

New application load balancer labels as 'key:value' pairs. For details about the concept, see documentation. Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: 1. Get the current set of labels with a [LoadBalancerService.Get] request. 2. Add or remove a label in this set. 3. Send the new set in this field. ||
|| `--listener-specs` | `shorthand/json`

New listeners for the application load balancer. For details about the concept, see documentation. Existing list of listeners is completely replaced by the specified list, so if you just want to add, update, or remove a listener, make a [LoadBalancerService.AddListener] request, a [LoadBalancerService.UpdateListener] request, or a [LoadBalancerService.RemoveListener] request.

Shorthand Syntax:

```hcl
[
  {
    endpoint-specs = [
      {
        address-specs = [
          {
            address-spec = external-ipv4-address-spec={
              address = string
            } | external-ipv6-address-spec={
              address = string
            } | internal-ipv4-address-spec={
              address = string,
              subnet-id = string
            }
          }, ...
        ],
        ports = integer,...
      }, ...
    ],
    listener = http={
      handler = {
        http-router-id = string,
        protocol-settings = allow-http10=boolean | http2-options={
          max-concurrent-streams = integer
        },
        rewrite-request-id = boolean
      },
      redirects = {
        http-to-https = boolean
      }
    } | stream={
      handler = {
        backend-group-id = string,
        idle-timeout = duration
      }
    } | tls={
      default-handler = {
        certificate-ids = string,...,
        handler = http-handler={
          http-router-id = string,
          protocol-settings = allow-http10=boolean | http2-options={
            max-concurrent-streams = integer
          },
          rewrite-request-id = boolean
        } | stream-handler={
          backend-group-id = string,
          idle-timeout = duration
        }
      },
      sni-handlers = [
        {
          handler = {
            certificate-ids = string,...,
            handler = http-handler={
              http-router-id = string,
              protocol-settings = allow-http10=boolean | http2-options={
                max-concurrent-streams = integer
              },
              rewrite-request-id = boolean
            } | stream-handler={
              backend-group-id = string,
              idle-timeout = duration
            }
          },
          name = string,
          server-names = string,...
        }, ...
      ]
    },
    name = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "endpoint-specs": [
      {
        "address-specs": [
          {
            "address-spec": {
              "external-ipv4-address-spec": {
                "address": "string"
              },
              "external-ipv6-address-spec": {
                "address": "string"
              },
              "internal-ipv4-address-spec": {
                "address": "string",
                "subnet-id": "string"
              }
            }
          }, ...
        ],
        "ports": [
          "integer", ...
        ]
      }, ...
    ],
    "listener": {
      "http": {
        "handler": {
          "http-router-id": "string",
          "protocol-settings": {
            "allow-http10": "boolean",
            "http2-options": {
              "max-concurrent-streams": "integer"
            }
          },
          "rewrite-request-id": "boolean"
        },
        "redirects": {
          "http-to-https": "boolean"
        }
      },
      "stream": {
        "handler": {
          "backend-group-id": "string",
          "idle-timeout": "duration"
        }
      },
      "tls": {
        "default-handler": {
          "certificate-ids": [
            "string", ...
          ],
          "handler": {
            "http-handler": {
              "http-router-id": "string",
              "protocol-settings": {
                "allow-http10": "boolean",
                "http2-options": {
                  "max-concurrent-streams": "integer"
                }
              },
              "rewrite-request-id": "boolean"
            },
            "stream-handler": {
              "backend-group-id": "string",
              "idle-timeout": "duration"
            }
          }
        },
        "sni-handlers": [
          {
            "handler": {
              "certificate-ids": [
                "string", ...
              ],
              "handler": {
                "http-handler": {
                  "http-router-id": "string",
                  "protocol-settings": {
                    "allow-http10": "boolean",
                    "http2-options": {
                      "max-concurrent-streams": "integer"
                    }
                  },
                  "rewrite-request-id": "boolean"
                },
                "stream-handler": {
                  "backend-group-id": "string",
                  "idle-timeout": "duration"
                }
              }
            },
            "name": "string",
            "server-names": [
              "string", ...
            ]
          }, ...
        ]
      }
    },
    "name": "string"
  }, ...
]
```

Fields:

```
endpoint-specs -> ([]struct)
  Endpoints of the listener. Endpoints are defined by their IP addresses and ports.
  address-specs -> ([]struct)
    Endpoint public (external) and internal addresses.
    address-spec -> (oneof<external-ipv4-address-spec|external-ipv6-address-spec|internal-ipv4-address-spec>)
      Oneof address-spec field
      external-ipv4-address-spec -> (struct)
        Public IPv4 endpoint address.
        address -> (string)
          IPv4 address.
      internal-ipv4-address-spec -> (struct)
        Internal IPv4 endpoint address. To enable the use of listeners with internal addresses, documentation.
        address -> (string)
          IPv4 address.
        subnet-id -> (string)
          ID of the subnet that the address belongs to.
      external-ipv6-address-spec -> (struct)
        Public IPv6 endpoint address.
        address -> (string)
          IPv6 address.
  ports -> ([]integer)
    Endpoint ports.
name -> (string)
  Name of the listener. The name is unique within the application load balancer.
listener -> (oneof<http|stream|tls>)
  Oneof listener field
  http -> (struct)
    Unencrypted HTTP listener settings.
    handler -> (struct)
      Settings for handling HTTP requests. Only one of 'handler' and [redirects] can be specified.
      http-router-id -> (string)
        ID of the HTTP router processing requests. For details about the concept, see documentation. To get the list of all available HTTP routers, make a [HttpRouterService.List] request.
      rewrite-request-id -> (boolean)
        When unset, will preserve the incoming x-request-id header, otherwise would rewrite it with a new value.
      protocol-settings -> (oneof<allow-http10|http2-options>)
        Oneof protocol-settings field
        http2-options -> (struct)
          HTTP/2 settings. If specified, incoming HTTP/2 requests are supported by the listener.
          max-concurrent-streams -> (integer)
            Maximum number of concurrent HTTP/2 streams in a connection.
        allow-http10 -> (boolean)
          Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.
    redirects -> (struct)
      Redirects settings. Only one of 'redirects' and [handler] can be specified.
      http-to-https -> (boolean)
        Redirects all unencrypted HTTP requests to the same URI with scheme changed to 'https'. The setting has the same effect as a single, catch-all [HttpRoute] with [RedirectAction.replace_scheme] set to 'https'.
  tls -> (struct)
    TLS-encrypted HTTP or TCP stream listener settings. All handlers within a listener ([TlsListener.default_handler] and [TlsListener.sni_handlers]) must be of one type, [HttpHandler] or [StreamHandler]. Mixing HTTP and TCP stream traffic in a TLS-encrypted listener is not supported.
    default-handler -> (struct)
      Settings for handling requests by default, with Server Name Indication (SNI) not matching any of the [sni_handlers].
      certificate-ids -> ([]string)
        ID's of the TLS server certificates from documentation. RSA and ECDSA certificates are supported, and only the first certificate of each type is used.
      handler -> (oneof<http-handler|stream-handler>)
        Oneof handler field
        http-handler -> (struct)
          HTTP handler.
          http-router-id -> (string)
            ID of the HTTP router processing requests. For details about the concept, see documentation. To get the list of all available HTTP routers, make a [HttpRouterService.List] request.
          rewrite-request-id -> (boolean)
            When unset, will preserve the incoming x-request-id header, otherwise would rewrite it with a new value.
          protocol-settings -> (oneof<allow-http10|http2-options>)
            Oneof protocol-settings field
            http2-options -> (struct)
              HTTP/2 settings. If specified, incoming HTTP/2 requests are supported by the listener.
              max-concurrent-streams -> (integer)
                Maximum number of concurrent HTTP/2 streams in a connection.
            allow-http10 -> (boolean)
              Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.
        stream-handler -> (struct)
          Stream (TCP) handler.
          backend-group-id -> (string)
            ID of the backend group processing requests. For details about the concept, see documentation. The backend group type, specified via [BackendGroup.backend], must be 'stream'. To get the list of all available backend groups, make a [BackendGroupService.List] request.
          idle-timeout -> (duration)
            The idle timeout is duration during which no data is transmitted or received on either the upstream or downstream connection. If not configured, the default idle timeout is 1 hour. Setting it to 0 disables the timeout.
    sni-handlers -> ([]struct)
      Settings for handling requests with Server Name Indication (SNI) matching one of [SniMatch.server_names] values.
      handler -> (struct)
        Settings for handling requests with Server Name Indication (SNI) matching one of [server_names] values.
        certificate-ids -> ([]string)
          ID's of the TLS server certificates from documentation. RSA and ECDSA certificates are supported, and only the first certificate of each type is used.
        handler -> (oneof<http-handler|stream-handler>)
          Oneof handler field
          http-handler -> (struct)
            HTTP handler.
            http-router-id -> (string)
              ID of the HTTP router processing requests. For details about the concept, see documentation. To get the list of all available HTTP routers, make a [HttpRouterService.List] request.
            rewrite-request-id -> (boolean)
              When unset, will preserve the incoming x-request-id header, otherwise would rewrite it with a new value.
            protocol-settings -> (oneof<allow-http10|http2-options>)
              Oneof protocol-settings field
              http2-options -> (struct)
                HTTP/2 settings. If specified, incoming HTTP/2 requests are supported by the listener.
                max-concurrent-streams -> (integer)
                  Maximum number of concurrent HTTP/2 streams in a connection.
              allow-http10 -> (boolean)
                Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.
          stream-handler -> (struct)
            Stream (TCP) handler.
            backend-group-id -> (string)
              ID of the backend group processing requests. For details about the concept, see documentation. The backend group type, specified via [BackendGroup.backend], must be 'stream'. To get the list of all available backend groups, make a [BackendGroupService.List] request.
            idle-timeout -> (duration)
              The idle timeout is duration during which no data is transmitted or received on either the upstream or downstream connection. If not configured, the default idle timeout is 1 hour. Setting it to 0 disables the timeout.
      name -> (string)
        Name of the SNI handler.
      server-names -> ([]string)
        Server names that are matched by the SNI handler.
  stream -> (struct)
    Unencrypted stream (TCP) listener settings.
    handler -> (struct)
      Settings for handling stream (TCP) requests.
      backend-group-id -> (string)
        ID of the backend group processing requests. For details about the concept, see documentation. The backend group type, specified via [BackendGroup.backend], must be 'stream'. To get the list of all available backend groups, make a [BackendGroupService.List] request.
      idle-timeout -> (duration)
        The idle timeout is duration during which no data is transmitted or received on either the upstream or downstream connection. If not configured, the default idle timeout is 1 hour. Setting it to 0 disables the timeout.
``` ||
|| `--load-balancer-id` | `string`

ID of the application load balancer to update. To get the application load balancer ID, make a [LoadBalancerService.List] request. ||
|| `--log-options` | `shorthand/json`

Cloud logging settings of the application load balancer.

Shorthand Syntax:

```hcl
{
  disable = boolean,
  discard-rules = [
    {
      discard-percent = integer,
      grpc-codes = [
        OK|CANCELLED|UNKNOWN|INVALID_ARGUMENT|DEADLINE_EXCEEDED|NOT_FOUND|ALREADY_EXISTS|PERMISSION_DENIED|UNAUTHENTICATED|RESOURCE_EXHAUSTED|FAILED_PRECONDITION|ABORTED|OUT_OF_RANGE|UNIMPLEMENTED|INTERNAL|UNAVAILABLE|DATA_LOSS, ...
      ],
      http-code-intervals = [
        HTTP_1XX|HTTP_2XX|HTTP_3XX|HTTP_4XX|HTTP_5XX|HTTP_ALL, ...
      ],
      http-codes = integer,...
    }, ...
  ],
  log-group-id = string
}
```

JSON Syntax:

```json
{
  "disable": "boolean",
  "discard-rules": [
    {
      "discard-percent": "integer",
      "grpc-codes": [
        "OK|CANCELLED|UNKNOWN|INVALID_ARGUMENT|DEADLINE_EXCEEDED|NOT_FOUND|ALREADY_EXISTS|PERMISSION_DENIED|UNAUTHENTICATED|RESOURCE_EXHAUSTED|FAILED_PRECONDITION|ABORTED|OUT_OF_RANGE|UNIMPLEMENTED|INTERNAL|UNAVAILABLE|DATA_LOSS", ...
      ],
      "http-code-intervals": [
        "HTTP_1XX|HTTP_2XX|HTTP_3XX|HTTP_4XX|HTTP_5XX|HTTP_ALL", ...
      ],
      "http-codes": [
        "integer", ...
      ]
    }, ...
  ],
  "log-group-id": "string"
}
```

Fields:

```
disable -> (boolean)
  Do not send logs to Cloud Logging log group.
discard-rules -> ([]struct)
  ordered list of rules, first matching rule applies
  discard-percent -> (integer)
    Percent of logs to be discarded: 0 - keep all, 100 or unset - discard all
  grpc-codes -> ([]struct)
    GRPC codes that should be discarded
  http-code-intervals -> ([]struct)
    Groups of HTTP codes like 4xx that should be discarded.
  http-codes -> ([]integer)
    HTTP codes that should be discarded.
log-group-id -> (string)
  Cloud Logging log group ID to store access logs. If not set then logs will be stored in default log group for the folder where load balancer located.
``` ||
|| `--name` | `string`

New name for the application load balancer. The name must be unique within the folder. ||
|| `--security-group-ids` | `[]string`

ID's of new security groups attributed to the application load balancer. For details about the concept, see documentation. Existing list of security groups is completely replaced by the specified list, so if you just want to add or remove an allocation policy: 1. Get the current set of security groups with a [LoadBalancerService.Get] request. 2. Add or remove a group in this set. 3. Send the new set in this field. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#