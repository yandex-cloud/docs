---
editable: false
noIndex: true
---

# yc beta application-load-balancer virtual-host update-route

Updates the specified route of the specified virtual host.

#### Command Usage

Syntax:

`yc beta application-load-balancer virtual-host update-route <HTTP-ROUTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--disable-security-profile` | Whether set to 'true' disable security profile for the route. ||
|| `--http-router-id` | `string`

ID of the HTTP router to update a route in. To get the HTTP router ID, make a [HttpRouterService.List] request. ||
|| `--route-name` | `string`

Name of the route to update. To get the route name, make a [VirtualHostService.Get] request. ||
|| `--route-options` | `shorthand/json`

New route options for the route.

Shorthand Syntax:

```hcl
{
  modify-request-headers = [
    {
      name = string,
      operation = append=string | remove=boolean | rename=string | replace=string
    }, ...
  ],
  modify-response-headers = [
    {
      name = string,
      operation = append=string | remove=boolean | rename=string | replace=string
    }, ...
  ],
  rbac = {
    action = ALLOW|DENY,
    principals = [
      {
        and-principals = [
          {
            identifier = any=boolean | header={
              name = string,
              value = {
                match = exact-match=string | prefix-match=string | regex-match=string
              }
            } | remote-ip=string
          }, ...
        ]
      }, ...
    ]
  },
  security-profile-id = string
}
```

JSON Syntax:

```json
{
  "modify-request-headers": [
    {
      "name": "string",
      "operation": {
        "append": "string",
        "remove": "boolean",
        "rename": "string",
        "replace": "string"
      }
    }, ...
  ],
  "modify-response-headers": [
    {
      "name": "string",
      "operation": {
        "append": "string",
        "remove": "boolean",
        "rename": "string",
        "replace": "string"
      }
    }, ...
  ],
  "rbac": {
    "action": "ALLOW|DENY",
    "principals": [
      {
        "and-principals": [
          {
            "identifier": {
              "any": "boolean",
              "header": {
                "name": "string",
                "value": {
                  "match": {
                    "exact-match": "string",
                    "prefix-match": "string",
                    "regex-match": "string"
                  }
                }
              },
              "remote-ip": "string"
            }
          }, ...
        ]
      }, ...
    ]
  },
  "security-profile-id": "string"
}
```

Fields:

```
modify-request-headers -> ([]struct)
  Apply the following modifications to the request headers.
  name -> (string)
    Name of the header.
  operation -> (oneof<append|remove|rename|replace>)
    Oneof operation field
    append -> (string)
      Appends the specified string to the header value. Variables defined for Envoy proxy are supported.
    replace -> (string)
      Replaces the value of the header with the specified string. Variables defined for Envoy proxy are supported.
    remove -> (boolean)
      Removes the header.
    rename -> (string)
      Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.
modify-response-headers -> ([]struct)
  Apply the following modifications to the response headers.
  name -> (string)
    Name of the header.
  operation -> (oneof<append|remove|rename|replace>)
    Oneof operation field
    append -> (string)
      Appends the specified string to the header value. Variables defined for Envoy proxy are supported.
    replace -> (string)
      Replaces the value of the header with the specified string. Variables defined for Envoy proxy are supported.
    remove -> (boolean)
      Removes the header.
    rename -> (string)
      Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts.
rbac -> (struct)
  action -> (struct)
    The action to take if a principal matches. Every action either allows or denies a request.
  principals -> ([]struct)
    Required. A match occurs when at least one matches the request.
    and-principals -> ([]struct)
      Required. A match occurs when all principals match the request.
      identifier -> (oneof<any|header|remote-ip>)
        Oneof identifier field
        header -> (struct)
          A header (or pseudo-header such as :path or :method) of the incoming HTTP request.
          name -> (string)
            Specifies the name of the header in the request.
          value -> (struct)
            Specifies how the header match will be performed to route the request. In the absence of value a request that has specified header name will match, regardless of the header's value.
            match -> (oneof<exact-match|prefix-match|regex-match>)
              Oneof match field
              exact-match -> (string)
                Exact match string.
              prefix-match -> (string)
                Prefix match string.
              regex-match -> (string)
                Regular expression match string.
        remote-ip -> (string)
          A CIDR block or IP that describes the request remote/origin address, e.g. ''192.0.0.0/24'' or''192.0.0.4'' .
        any -> (boolean)
          When any is set, it matches any request.
security-profile-id -> (string)
  Security profile that will take effect to all requests routed via particular virtual host.
``` ||
|| `--virtual-host-name` | `string`

Name of the virtual host to update a route in. To get the virtual host name, make a [VirtualHostService.List] request. ||
|| `--http` | `shorthand/json`

New settings of the HTTP route.

Shorthand Syntax:

```hcl
{
  action = direct-response={
    body = {
      payload = text=string
    },
    status = integer
  } | redirect={
    path = replace-path=string | replace-prefix=string,
    remove-query = boolean,
    replace-host = string,
    replace-port = integer,
    replace-scheme = string,
    response-code = MOVED_PERMANENTLY|FOUND|SEE_OTHER|TEMPORARY_REDIRECT|PERMANENT_REDIRECT
  } | route={
    backend-group-id = string,
    host-rewrite-specifier = auto-host-rewrite=boolean | host-rewrite=string,
    idle-timeout = duration,
    prefix-rewrite = string,
    rate-limit = {
      all-requests = {
        rate = per-minute=integer | per-second=integer
      },
      requests-per-ip = {
        rate = per-minute=integer | per-second=integer
      }
    },
    regex-rewrite = {
      regex = string,
      substitute = string
    },
    timeout = duration,
    upgrade-types = string,...
  },
  match = {
    headers = [
      {
        name = string,
        value = {
          match = exact-match=string | prefix-match=string | regex-match=string
        }
      }, ...
    ],
    http-method = string,...,
    path = {
      match = exact-match=string | prefix-match=string | regex-match=string
    },
    query-parameters = [
      {
        name = string,
        value = {
          match = exact-match=string | prefix-match=string | regex-match=string
        }
      }, ...
    ]
  }
}
```

JSON Syntax:

```json
{
  "action": {
    "direct-response": {
      "body": {
        "payload": {
          "text": "string"
        }
      },
      "status": "integer"
    },
    "redirect": {
      "path": {
        "replace-path": "string",
        "replace-prefix": "string"
      },
      "remove-query": "boolean",
      "replace-host": "string",
      "replace-port": "integer",
      "replace-scheme": "string",
      "response-code": "MOVED_PERMANENTLY|FOUND|SEE_OTHER|TEMPORARY_REDIRECT|PERMANENT_REDIRECT"
    },
    "route": {
      "backend-group-id": "string",
      "host-rewrite-specifier": {
        "auto-host-rewrite": "boolean",
        "host-rewrite": "string"
      },
      "idle-timeout": "duration",
      "prefix-rewrite": "string",
      "rate-limit": {
        "all-requests": {
          "rate": {
            "per-minute": "integer",
            "per-second": "integer"
          }
        },
        "requests-per-ip": {
          "rate": {
            "per-minute": "integer",
            "per-second": "integer"
          }
        }
      },
      "regex-rewrite": {
        "regex": "string",
        "substitute": "string"
      },
      "timeout": "duration",
      "upgrade-types": [
        "string", ...
      ]
    }
  },
  "match": {
    "headers": [
      {
        "name": "string",
        "value": {
          "match": {
            "exact-match": "string",
            "prefix-match": "string",
            "regex-match": "string"
          }
        }
      }, ...
    ],
    "http-method": [
      "string", ...
    ],
    "path": {
      "match": {
        "exact-match": "string",
        "prefix-match": "string",
        "regex-match": "string"
      }
    },
    "query-parameters": [
      {
        "name": "string",
        "value": {
          "match": {
            "exact-match": "string",
            "prefix-match": "string",
            "regex-match": "string"
          }
        }
      }, ...
    ]
  }
}
```

Fields:

```
match -> (struct)
  Condition (predicate) used to select the route.
  headers -> ([]struct)
    Headers specify HTTP request header matchers. Multiple match values are ANDed together, meaning, a request must match all the specified headers to select the route. Headers must be unique.
    name -> (string)
      Name of the HTTP Header to be matched.
    value -> (struct)
      Value of HTTP Header to be matched.
      match -> (oneof<exact-match|prefix-match|regex-match>)
        Oneof match field
        exact-match -> (string)
          Exact match string.
        prefix-match -> (string)
          Prefix match string.
        regex-match -> (string)
          Regular expression match string.
  http-method -> ([]string)
    HTTP method specified in the request.
  path -> (struct)
    Match settings for the path specified in the request. If not specified, the route matches all paths.
    match -> (oneof<exact-match|prefix-match|regex-match>)
      Oneof match field
      exact-match -> (string)
        Exact match string.
      prefix-match -> (string)
        Prefix match string.
      regex-match -> (string)
        Regular expression match string.
  query-parameters -> ([]struct)
    Query Parameters specify HTTP query parameter matchers. Multiple match values are ANDed together, meaning, a request must match all the specified query parameters to select the route. Query parameters must be unique.
    name -> (string)
      Name of the HTTP query parameter to be matched.
    value -> (struct)
      Value of HTTP query parameter to be matched.
      match -> (oneof<exact-match|prefix-match|regex-match>)
        Oneof match field
        exact-match -> (string)
          Exact match string.
        prefix-match -> (string)
          Prefix match string.
        regex-match -> (string)
          Regular expression match string.
action -> (oneof<direct-response|redirect|route>)
  Oneof action field
  route -> (struct)
    Forwards the request to a backend group for processing as configured.
    backend-group-id -> (string)
      Backend group to forward requests to. Stream (TCP) backend groups are not supported.
    idle-timeout -> (duration)
      Idle timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it. Specifying meaningful values for both [timeout] and 'idle_timeout' is useful for implementing server-push mechanisms such as long polling, server-sent events ('EventSource' interface) etc. If a connection times out, the load balancer responds to the client with a '504 Gateway Timeout' status code. If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see [timeout]).
    prefix-rewrite -> (string)
      Replacement for the path prefix matched by [StringMatch]. For instance, if [StringMatch.prefix_match] value is '/foo' and 'prefix_rewrite' value is '/bar', a request with '/foobaz' path is forwarded with '/barbaz' path. For [StringMatch.exact_match], the whole path is replaced. If not specified, the path is not changed. Only one of regex_rewrite, or prefix_rewrite may be specified.
    rate-limit -> (struct)
      RateLimit is a rate limit configuration applied for route.
      all-requests -> (struct)
        AllRequests is a rate limit configuration applied to all incoming requests.
        rate -> (oneof<per-minute|per-second>)
          Oneof rate field
          per-second -> (integer)
            PerSecond is a limit value specified with per second time unit.
          per-minute -> (integer)
            PerMinute is a limit value specified with per minute time unit.
      requests-per-ip -> (struct)
        RequestsPerIp is a rate limit configuration applied separately for each set of requests grouped by client IP address.
        rate -> (oneof<per-minute|per-second>)
          Oneof rate field
          per-second -> (integer)
            PerSecond is a limit value specified with per second time unit.
          per-minute -> (integer)
            PerMinute is a limit value specified with per minute time unit.
    regex-rewrite -> (struct)
      Replacement for portions of the path that match the pattern should be rewritten, even allowing the substitution of capture groups from the pattern into the new path as specified by the rewrite substitution string. Only one of regex_rewrite, or prefix_rewrite may be specified. Examples of using: - The path pattern ^/service/([^/]+)(/.*)$ paired with a substitution string of \2/instance/\1 would transform /service/foo/v1/api into /v1/api/instance/foo. - The pattern one paired with a substitution string of two would transform /xxx/one/yyy/one/zzz into /xxx/two/yyy/two/zzz. - The pattern ^(.*?)one(.*)$ paired with a substitution string of \1two\2 would replace only the first occurrence of one, transforming path /xxx/one/yyy/one/zzz into /xxx/two/yyy/one/zzz. - The pattern (?i)/xxx/ paired with a substitution string of /yyy/ would do a case-insensitive match and transform path /aaa/XxX/bbb to /aaa/yyy/bbb.
      regex -> (string)
        The regular expression used to find portions of a string that should be replaced.
      substitute -> (string)
        The string that should be substituted into matching portions of the subject string during a substitution operation to produce a new string.
    timeout -> (duration)
      Overall timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it. If a connection times out, the load balancer responds to the client with a '504 Gateway Timeout' status code. Default value: '60'.
    upgrade-types -> ([]string)
      Supported values for HTTP 'Upgrade' header. E.g. 'websocket'.
    host-rewrite-specifier -> (oneof<auto-host-rewrite|host-rewrite>)
      Oneof host-rewrite-specifier field
      host-rewrite -> (string)
        Host replacement.
      auto-host-rewrite -> (boolean)
        Automatically replaces the host with that of the target.
  redirect -> (struct)
    Redirects the request as configured.
    remove-query -> (boolean)
      Removes URI query.
    replace-host -> (string)
      URI host replacement. If not specified, the original host is used.
    replace-port -> (integer)
      URI host replacement. If not specified, the original host is used.
    replace-scheme -> (string)
      URI scheme replacement. If 'http' or 'https' scheme is to be replaced and '80' or '443' port is specified in the original URI, the port is also removed. If not specified, the original scheme and port are used.
    response-code -> (struct)
      HTTP status code to use in redirect responses.
    path -> (oneof<replace-path|replace-prefix>)
      Oneof path field
      replace-path -> (string)
        Replacement for the whole path.
      replace-prefix -> (string)
        Replacement for the path prefix matched by [StringMatch]. For instance, if [StringMatch.prefix_match] value is '/foo' and 'replace_prefix' value is '/bar', a request with 'https://example.com/foobaz' URI is redirected to 'https://example.com/barbaz'. For [StringMatch.exact_match], the whole path is replaced.
  direct-response -> (struct)
    Instructs the load balancer to respond directly as configured.
    body -> (struct)
      Response body.
      payload -> (oneof<text>)
        Oneof payload field
        text -> (string)
          Payload text.
    status -> (integer)
      HTTP status code to use in responses.
``` ||
|| `--grpc` | `shorthand/json`

New settings of the gRPC route.

Shorthand Syntax:

```hcl
{
  action = route={
    backend-group-id = string,
    host-rewrite-specifier = auto-host-rewrite=boolean | host-rewrite=string,
    idle-timeout = duration,
    max-timeout = duration,
    rate-limit = {
      all-requests = {
        rate = per-minute=integer | per-second=integer
      },
      requests-per-ip = {
        rate = per-minute=integer | per-second=integer
      }
    }
  } | status-response={
    status = OK|INVALID_ARGUMENT|NOT_FOUND|PERMISSION_DENIED|UNAUTHENTICATED|UNIMPLEMENTED|INTERNAL|UNAVAILABLE
  },
  match = {
    fqmn = {
      match = exact-match=string | prefix-match=string | regex-match=string
    }
  }
}
```

JSON Syntax:

```json
{
  "action": {
    "route": {
      "backend-group-id": "string",
      "host-rewrite-specifier": {
        "auto-host-rewrite": "boolean",
        "host-rewrite": "string"
      },
      "idle-timeout": "duration",
      "max-timeout": "duration",
      "rate-limit": {
        "all-requests": {
          "rate": {
            "per-minute": "integer",
            "per-second": "integer"
          }
        },
        "requests-per-ip": {
          "rate": {
            "per-minute": "integer",
            "per-second": "integer"
          }
        }
      }
    },
    "status-response": {
      "status": "OK|INVALID_ARGUMENT|NOT_FOUND|PERMISSION_DENIED|UNAUTHENTICATED|UNIMPLEMENTED|INTERNAL|UNAVAILABLE"
    }
  },
  "match": {
    "fqmn": {
      "match": {
        "exact-match": "string",
        "prefix-match": "string",
        "regex-match": "string"
      }
    }
  }
}
```

Fields:

```
match -> (struct)
  Condition (predicate) used to select the route.
  fqmn -> (struct)
    Match settings for gRPC service method called in the request. A match string must be a fully qualified method name, e.g. 'foo.bar.v1.BazService/Get', or a prefix of such. If not specified, the route matches all methods.
    match -> (oneof<exact-match|prefix-match|regex-match>)
      Oneof match field
      exact-match -> (string)
        Exact match string.
      prefix-match -> (string)
        Prefix match string.
      regex-match -> (string)
        Regular expression match string.
action -> (oneof<route|status-response>)
  Oneof action field
  route -> (struct)
    Forwards the request to a backend group for processing as configured.
    backend-group-id -> (string)
      Backend group to forward requests to.
    idle-timeout -> (duration)
      Idle timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it. Specifying meaningful values for both [max_timeout] and 'idle_timeout' is useful for implementing server-push mechanisms such as long polling, server-sent events etc. If a connection times out, the load balancer responds to the client with an 'UNAVAILABLE' status code. If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see [max_timeout]).
    max-timeout -> (duration)
      Overall timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it. If a client specifies a lower timeout in HTTP 'grpc-timeout' header, the 'max_timeout' value is ignored. If a connection times out, the load balancer responds to the client with an 'UNAVAILABLE' status code. Default value: '60'.
    rate-limit -> (struct)
      RateLimit is a rate limit configuration applied for route.
      all-requests -> (struct)
        AllRequests is a rate limit configuration applied to all incoming requests.
        rate -> (oneof<per-minute|per-second>)
          Oneof rate field
          per-second -> (integer)
            PerSecond is a limit value specified with per second time unit.
          per-minute -> (integer)
            PerMinute is a limit value specified with per minute time unit.
      requests-per-ip -> (struct)
        RequestsPerIp is a rate limit configuration applied separately for each set of requests grouped by client IP address.
        rate -> (oneof<per-minute|per-second>)
          Oneof rate field
          per-second -> (integer)
            PerSecond is a limit value specified with per second time unit.
          per-minute -> (integer)
            PerMinute is a limit value specified with per minute time unit.
    host-rewrite-specifier -> (oneof<auto-host-rewrite|host-rewrite>)
      Oneof host-rewrite-specifier field
      host-rewrite -> (string)
        Host replacement.
      auto-host-rewrite -> (boolean)
        Automatically replaces the host with that of the target.
  status-response -> (struct)
    Instructs the load balancer to respond directly with a specified status.
    status -> (struct)
      gRPC status code to use in responses.
``` ||
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