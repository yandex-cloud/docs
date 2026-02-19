---
editable: false
noIndex: true
---

# yc beta cdn resource-rules create

Create new resource rule with specified unique name and rule patter.

#### Command Usage

Syntax:

`yc beta cdn resource-rules create <RESOURCE-ID>`

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
|| `--name` | `string`

Name of created resource rule. ||
|| `--options` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  allowed-http-methods = {
    enabled = boolean,
    value = string,...
  },
  browser-cache-settings = {
    enabled = boolean,
    value = integer
  },
  cache-http-headers = {
    enabled = boolean,
    value = string,...
  },
  compression-options = {
    compression-variant = brotli-compression={
      enabled = boolean,
      value = string,...
    } | fetch-compressed={
      enabled = boolean,
      value = boolean
    } | gzip-on={
      enabled = boolean,
      value = boolean
    }
  },
  cors = {
    enabled = boolean,
    value = string,...
  },
  custom-server-name = {
    enabled = boolean,
    value = string
  },
  disable-cache = {
    enabled = boolean,
    value = boolean
  },
  disable-proxy-force-ranges = {
    enabled = boolean,
    value = boolean
  },
  edge-cache-settings = {
    enabled = boolean,
    values-variant = default-value=integer | value={
      custom-values = {key=integer, key=...},
      simple-value = integer
    }
  },
  follow-redirects = {
    codes = integer,...,
    enabled = boolean,
    use-custom-host = boolean
  },
  geo-acl = {
    countries = string,...,
    enabled = boolean,
    mode = MODE_ALLOW|MODE_DENY
  },
  header-filter = {
    enabled = boolean,
    headers = string,...
  },
  host-options = {
    host-variant = forward-host-header={
      enabled = boolean,
      value = boolean
    } | host={
      enabled = boolean,
      value = string
    }
  },
  ignore-cookie = {
    enabled = boolean,
    value = boolean
  },
  ip-address-acl = {
    enabled = boolean,
    excepted-values = string,...,
    policy-type = POLICY_TYPE_ALLOW|POLICY_TYPE_DENY
  },
  proxy-cache-methods-set = {
    enabled = boolean,
    value = boolean
  },
  query-params-options = {
    query-params-variant = ignore-query-string={
      enabled = boolean,
      value = boolean
    } | query-params-blacklist={
      enabled = boolean,
      value = string,...
    } | query-params-whitelist={
      enabled = boolean,
      value = string,...
    }
  },
  redirect-options = {
    redirect-variant = redirect-http-to-https={
      enabled = boolean,
      value = boolean
    } | redirect-https-to-http={
      enabled = boolean,
      value = boolean
    }
  },
  referrer-acl = {
    enabled = boolean,
    mode = MODE_ALLOW|MODE_DENY,
    referrers = string,...
  },
  rewrite = {
    body = string,
    enabled = boolean,
    flag = LAST|BREAK|REDIRECT|PERMANENT
  },
  secure-key = {
    enabled = boolean,
    key = string,
    type = ENABLE_IP_SIGNING|DISABLE_IP_SIGNING
  },
  slice = {
    enabled = boolean,
    value = boolean
  },
  stale = {
    enabled = boolean,
    value = string,...
  },
  static-headers = {
    enabled = boolean,
    value = {key=string, key=...}
  },
  static-request-headers = {
    enabled = boolean,
    value = {key=string, key=...}
  },
  static-response = {
    code = integer,
    content = string,
    enabled = boolean
  },
  websockets = {
    enabled = boolean
  }
}
```

JSON Syntax:

```json
{
  "allowed-http-methods": {
    "enabled": "boolean",
    "value": [
      "string", ...
    ]
  },
  "browser-cache-settings": {
    "enabled": "boolean",
    "value": "integer"
  },
  "cache-http-headers": {
    "enabled": "boolean",
    "value": [
      "string", ...
    ]
  },
  "compression-options": {
    "compression-variant": {
      "brotli-compression": {
        "enabled": "boolean",
        "value": [
          "string", ...
        ]
      },
      "fetch-compressed": {
        "enabled": "boolean",
        "value": "boolean"
      },
      "gzip-on": {
        "enabled": "boolean",
        "value": "boolean"
      }
    }
  },
  "cors": {
    "enabled": "boolean",
    "value": [
      "string", ...
    ]
  },
  "custom-server-name": {
    "enabled": "boolean",
    "value": "string"
  },
  "disable-cache": {
    "enabled": "boolean",
    "value": "boolean"
  },
  "disable-proxy-force-ranges": {
    "enabled": "boolean",
    "value": "boolean"
  },
  "edge-cache-settings": {
    "enabled": "boolean",
    "values-variant": {
      "default-value": "integer",
      "value": {
        "custom-values": {
          "<key>": "integer", ...
        },
        "simple-value": "integer"
      }
    }
  },
  "follow-redirects": {
    "codes": [
      "integer", ...
    ],
    "enabled": "boolean",
    "use-custom-host": "boolean"
  },
  "geo-acl": {
    "countries": [
      "string", ...
    ],
    "enabled": "boolean",
    "mode": "MODE_ALLOW|MODE_DENY"
  },
  "header-filter": {
    "enabled": "boolean",
    "headers": [
      "string", ...
    ]
  },
  "host-options": {
    "host-variant": {
      "forward-host-header": {
        "enabled": "boolean",
        "value": "boolean"
      },
      "host": {
        "enabled": "boolean",
        "value": "string"
      }
    }
  },
  "ignore-cookie": {
    "enabled": "boolean",
    "value": "boolean"
  },
  "ip-address-acl": {
    "enabled": "boolean",
    "excepted-values": [
      "string", ...
    ],
    "policy-type": "POLICY_TYPE_ALLOW|POLICY_TYPE_DENY"
  },
  "proxy-cache-methods-set": {
    "enabled": "boolean",
    "value": "boolean"
  },
  "query-params-options": {
    "query-params-variant": {
      "ignore-query-string": {
        "enabled": "boolean",
        "value": "boolean"
      },
      "query-params-blacklist": {
        "enabled": "boolean",
        "value": [
          "string", ...
        ]
      },
      "query-params-whitelist": {
        "enabled": "boolean",
        "value": [
          "string", ...
        ]
      }
    }
  },
  "redirect-options": {
    "redirect-variant": {
      "redirect-http-to-https": {
        "enabled": "boolean",
        "value": "boolean"
      },
      "redirect-https-to-http": {
        "enabled": "boolean",
        "value": "boolean"
      }
    }
  },
  "referrer-acl": {
    "enabled": "boolean",
    "mode": "MODE_ALLOW|MODE_DENY",
    "referrers": [
      "string", ...
    ]
  },
  "rewrite": {
    "body": "string",
    "enabled": "boolean",
    "flag": "LAST|BREAK|REDIRECT|PERMANENT"
  },
  "secure-key": {
    "enabled": "boolean",
    "key": "string",
    "type": "ENABLE_IP_SIGNING|DISABLE_IP_SIGNING"
  },
  "slice": {
    "enabled": "boolean",
    "value": "boolean"
  },
  "stale": {
    "enabled": "boolean",
    "value": [
      "string", ...
    ]
  },
  "static-headers": {
    "enabled": "boolean",
    "value": {
      "<key>": "string", ...
    }
  },
  "static-request-headers": {
    "enabled": "boolean",
    "value": {
      "<key>": "string", ...
    }
  },
  "static-response": {
    "code": "integer",
    "content": "string",
    "enabled": "boolean"
  },
  "websockets": {
    "enabled": "boolean"
  }
}
```

Fields:

```
allowed-http-methods -> (struct)
  HTTP methods for your CDN content. By default the following methods are allowed: GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS. In case some methods are not allowed to the user, they will get the 405 (Method Not Allowed) response. If the method is not supported, the user gets the 501 (Not Implemented) response.
  enabled -> (boolean)
    True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
  value -> ([]string)
    Value of the option.
browser-cache-settings -> (struct)
  Using [Int64Option]. Set up a cache period for the end-users browser. Content will be cached due to origin settings. If there are no cache settings on your origin, the content will not be cached. The list of HTTP response codes that can be cached in browsers: 200, 201, 204, 206, 301, 302, 303, 304, 307, 308. Other response codes will not be cached. The default value is 4 days.
  enabled -> (boolean)
    True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
  value -> (integer)
    Value of the option.
cache-http-headers -> (struct)
  List HTTP headers that must be included in responses to clients.
  enabled -> (boolean)
    True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
  value -> ([]string)
    Value of the option.
compression-options -> (struct)
  Set up compression variant.
  compression-variant -> (oneof<brotli-compression|fetch-compressed|gzip-on>)
    Oneof compression-variant field
    fetch-compressed -> (struct)
      The Fetch compressed option helps you to reduce the bandwidth between origin and CDN servers. Also, content delivery speed becomes higher because of reducing the time for compressing files in a CDN.
      enabled -> (boolean)
        True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
      value -> (boolean)
        Value of the option.
    gzip-on -> (struct)
      Using [BoolOption]. GZip compression at CDN servers reduces file size by 70% and can be as high as 90%.
      enabled -> (boolean)
        True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
      value -> (boolean)
        Value of the option.
    brotli-compression -> (struct)
      The option allows to compress content with brotli on the CDN's end. Compression is performed on the Origin Shielding. If a pre-cache server doesn't active for a resource, compression does not occur even if the option is enabled. Specify the content-type for each type of content you wish to have compressed. CDN servers will request only uncompressed content from the origin.
      enabled -> (boolean)
        True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
      value -> ([]string)
        Value of the option.
cors -> (struct)
  Parameter that lets browsers get access to selected resources from a domain different to a domain from which the request is received. documentation.
  enabled -> (boolean)
    True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
  value -> ([]string)
    Value of the option.
custom-server-name -> (struct)
  Wildcard additional CNAME. If a resource has a wildcard additional CNAME, you can use your own certificate for content delivery via HTTPS. Read-only.
  enabled -> (boolean)
    True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
  value -> (string)
    Value of the option.
disable-cache -> (struct)
  Set up a cache status.
  enabled -> (boolean)
    True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
  value -> (boolean)
    Value of the option.
disable-proxy-force-ranges -> (struct)
  Disabling proxy force ranges.
  enabled -> (boolean)
    True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
  value -> (boolean)
    Value of the option.
edge-cache-settings -> (struct)
  Set up [EdgeCacheSettings].
  enabled -> (boolean)
    True - the option is enabled and its 'values_variant' is applied to the resource. False - the option is disabled and its default value is used for the resource.
  values-variant -> (oneof<default-value|value>)
    Oneof values-variant field
    value -> (struct)
      Value of the option.
      custom-values -> (map[string,integer])
        Caching time for a response with specific codes. These settings have a higher priority than the value field. Response code ('304', '404' for example). Use 'any' to specify caching time for all response codes. Caching time in seconds ('0s', '600s' for example). Use '0s' to disable caching for a specific response code.
      simple-value -> (integer)
        Caching time for a response with codes 200, 206, 301, 302. Responses with codes 4xx, 5xx will not be cached. Use '0s' disable to caching. Use [custom_values] field to specify a custom caching time for a response with specific codes.
    default-value -> (integer)
      Content will be cached according to origin cache settings. The value applies for a response with codes 200, 201, 204, 206, 301, 302, 303, 304, 307, 308 if an origin server does not have caching HTTP headers. Responses with other codes will not be cached.
follow-redirects -> (struct)
  Manage the state of the Redirection from origin option. If the source returns a redirect, the option lets CDN pull the requested content from the source that was returned in the redirect. This option works only when origin shielding is activated.
  codes -> ([]integer)
    Add the redirect HTTP status codes that the source returns.
  enabled -> (boolean)
    True - the option is enabled and its [flag] is applied to the resource. False - the option is disabled and its default value of the [flag] is used for the resource.
  use-custom-host -> (boolean)
    Use the redirect target domain as a Host header, or leave it the same as the value of the Change Host header option.
geo-acl -> (struct)
  Configuration for geographic access control.
  countries -> ([]string)
    List of country codes (ISO 3166, uppercase).
  enabled -> (boolean)
    Enables or disables the Geo ACL option.
  mode -> (struct)
    Mode of the Geo ACL.
header-filter -> (struct)
  Configuration for HTTP response header filtering. This feature allows controlling which headers from the origin are passed to end users.
  enabled -> (boolean)
    Enables or disables feature.
  headers -> ([]string)
    Whitelist of headers.
host-options -> (struct)
  Set up host parameters.
  host-variant -> (oneof<forward-host-header|host>)
    Oneof host-variant field
    host -> (struct)
      Custom value for the Host header. Your server must be able to process requests with the chosen header. Default value (if [StringOption.enabled] is 'false') is [Resource.cname].
      enabled -> (boolean)
        True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
      value -> (string)
        Value of the option.
    forward-host-header -> (struct)
      Using [BoolOption]. Choose the Forward Host header option if is important to send in the request to the Origin the same Host header as was sent in the request to CDN server.
      enabled -> (boolean)
        True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
      value -> (boolean)
        Value of the option.
ignore-cookie -> (struct)
  Using [BoolOption] for ignoring cookie.
  enabled -> (boolean)
    True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
  value -> (boolean)
    Value of the option.
ip-address-acl -> (struct)
  Manage the state of the IP access policy option. The option controls access to content from the specified IP addresses.
  enabled -> (boolean)
    True - the option is enabled and its [flag] is applied to the resource. False - the option is disabled and its default value of the [flag] is used for the resource.
  excepted-values -> ([]string)
    The list of IP addresses to be allowed or denied.
  policy-type -> (struct)
    The policy type. One of allow or deny value.
proxy-cache-methods-set -> (struct)
  Allows caching for GET, HEAD and POST requests.
  enabled -> (boolean)
    True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
  value -> (boolean)
    Value of the option.
query-params-options -> (struct)
  Set up [QueryParamsOptions].
  query-params-variant -> (oneof<ignore-query-string|query-params-blacklist|query-params-whitelist>)
    Oneof query-params-variant field
    ignore-query-string -> (struct)
      Using [BoolOption]. Selected by default. Files with different query parameters are cached as objects with the same key regardless of the parameter value.
      enabled -> (boolean)
        True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
      value -> (boolean)
        Value of the option.
    query-params-whitelist -> (struct)
      Ignore All Except. Files with the specified query parameters are cached as objects with different keys, files with other parameters are cached as objects with the same key.
      enabled -> (boolean)
        True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
      value -> ([]string)
        Value of the option.
    query-params-blacklist -> (struct)
      Ignore only. Files with the specified query parameters are cached as objects with the same key, files with other parameters are cached as objects with different keys.
      enabled -> (boolean)
        True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
      value -> ([]string)
        Value of the option.
redirect-options -> (struct)
  Set up redirects.
  redirect-variant -> (oneof<redirect-http-to-https|redirect-https-to-http>)
    Oneof redirect-variant field
    redirect-http-to-https -> (struct)
      Using [BoolOption]. Set up a redirect from HTTPS to HTTP.
      enabled -> (boolean)
        True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
      value -> (boolean)
        Value of the option.
    redirect-https-to-http -> (struct)
      Using [BoolOption]. Set up a redirect from HTTP to HTTPS. Deprecated: Use of redirect_https_to_http is deprecated.
      enabled -> (boolean)
        True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
      value -> (boolean)
        Value of the option.
referrer-acl -> (struct)
  Configuration for referrer-based access control.
  enabled -> (boolean)
    Enables or disables feature.
  mode -> (struct)
    Access mode for the referrer list.
  referrers -> ([]string)
    List of referer patterns. Supports three types of values: 1. Domain without scheme with or without query, e.g. "google.com", "ya.ru/abc" 2. Wildcard pattern with dot separator, e.g. "*.hello.com", "staging.*" Note: dot must be present before or after '*' (so "*abc.com" is NOT valid) 3. Regular expression starting with '~', e.g. "~^prod\..*\.company.org/abc"
rewrite -> (struct)
  Changing or redirecting query paths.
  body -> (string)
    Pattern for rewrite. The value must have the following format: '<source path> <destination path>', where both paths are regular expressions which use at least one group. E.g., '/foo/(.*) /bar/$1'.
  enabled -> (boolean)
    True - the option is enabled and its [flag] is applied to the resource. False - the option is disabled and its default value of the [flag] is used for the resource.
  flag -> (struct)
    Break flag is applied to the option by default. It is not shown in the field.
secure-key -> (struct)
  Secure token to protect contect and limit access by IP addresses and time limits.
  enabled -> (boolean)
    True - the option is enabled and its [flag] is applied to the resource. False - the option is disabled and its default value of the [flag] is used for the resource.
  key -> (string)
    The key for the URL signing.
  type -> (struct)
    The type of the URL signing. The URL could be available for all IP addresses or for the only one IP.
slice -> (struct)
  Files larger than 10 MB will be requested and cached in parts (no larger than 10 MB each part). It reduces time to first byte. The origin must support HTTP Range requests. By default the option is disabled.
  enabled -> (boolean)
    True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
  value -> (boolean)
    Value of the option.
stale -> (struct)
  List of errors which instruct CDN servers to serve stale content to clients. Possible values: 'error', 'http_403', 'http_404', 'http_429', 'http_500', 'http_502', 'http_503', 'http_504', 'invalid_header', 'timeout', 'updating'.
  enabled -> (boolean)
    True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
  value -> ([]string)
    Value of the option.
static-headers -> (struct)
  Set up static headers that CDN servers send in responses to clients.
  enabled -> (boolean)
    True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
  value -> (map[string,string])
    Value of the option.
static-request-headers -> (struct)
  Set up custom headers that CDN servers send in requests to origins. The Header name field can contain letters (A-Z, a-z), numbers (0-9), dashes (-) and underscores (_). The Value field can contain letters (A-Z, a-z), numbers (0-9), dashes (-), underscores (_), slashes (/), colons (:), equal (=), dots (.), and spaces.
  enabled -> (boolean)
    True - the option is enabled and its [value] is applied to the resource. False - the option is disabled and its default value is used for the resource.
  value -> (map[string,string])
    Value of the option.
static-response -> (struct)
  Configuration for serving a static HTTP response instead of fetching from origin.
  code -> (integer)
    HTTP status code.
  content -> (string)
    A string containing the response content. For 3xx - Location header For other codes - body
  enabled -> (boolean)
    Enables or disables feature.
websockets -> (struct)
  Configuration for WebSocket protocol support.
  enabled -> (boolean)
    Enables or disables feature.
``` ||
|| `--resource-id` | `string`

ID of resource. ||
|| `--rule-pattern` | `string`

Resource rule pattern. ||
|| `--weight` | `int`

Rules are ordered by weight in ascending order (lower weights execute first) Weight must be between 0 and 9999 inclusive ||
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