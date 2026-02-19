---
editable: false
noIndex: true
---

# yc beta application-load-balancer load-balancer update-sni-match

Updates the specified SNI handler of the specified listener.
This request does not allow to update [TlsListener.default_handler]. Make an [UpdateListener] request instead.

#### Command Usage

Syntax:

`yc beta application-load-balancer load-balancer update-sni-match <LOAD-BALANCER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--handler` | `shorthand/json`

New settings for handling requests with Server Name Indication (SNI) matching one of [server_names] values.

Shorthand Syntax:

```hcl
{
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
}
```

JSON Syntax:

```json
{
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
}
```

Fields:

```
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
``` ||
|| `--listener-name` | `string`

Name of the listener to update the SNI handler in. ||
|| `--load-balancer-id` | `string`

ID of the application load balancer to update the SNI handler in. ||
|| `--name` | `string`

Name of the SNI handler to update. ||
|| `--server-names` | `[]string`

New server names that are matched by the SNI handler. Existing set of server names is completely replaced by the provided set, so if you just want to add or remove a server name: 1. Get the current set of server names with a [LoadBalancerService.Get] request. 2. Add or remove a server name in this set. 3. Send the new set in this field. ||
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