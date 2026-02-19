---
editable: false
noIndex: true
---

# yc beta application-load-balancer load-balancer add-listener

Adds a listener to the specified application load balancer.

#### Command Usage

Syntax:

`yc beta application-load-balancer load-balancer add-listener <LOAD-BALANCER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--listener-spec` | `shorthand/json`

Listener to add to the application load balancer.

Shorthand Syntax:

```hcl
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
}
```

JSON Syntax:

```json
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
}
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

ID of the application load balancer to add a listener to. ||
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