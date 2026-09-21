---
editable: false
---

# Smart Web Security Load Balancer API, gRPC: LoadBalancerService.Get

Returns the specified load balancer.

## gRPC request

**rpc Get ([GetLoadBalancerRequest](#yandex.cloud.smartwebsecurity.v1.load_balancer.GetLoadBalancerRequest)) returns ([LoadBalancer](#yandex.cloud.smartwebsecurity.v1.load_balancer.LoadBalancer))**

## GetLoadBalancerRequest {#yandex.cloud.smartwebsecurity.v1.load_balancer.GetLoadBalancerRequest}

```json
{
  "load_balancer_id": "string"
}
```

#|
||Field | Description ||
|| load_balancer_id | **string**

Required field. ID of the load balancer to return. ||
|#

## LoadBalancer {#yandex.cloud.smartwebsecurity.v1.load_balancer.LoadBalancer}

```json
{
  "id": "string",
  "folder_id": "string",
  "cloud_id": "string",
  "labels": "map<string, string>",
  "name": "string",
  "description": "string",
  "domains": [
    {
      "name": "string",
      "server_name": "string",
      "description": "string",
      "security_profile_id": "string",
      "http_backend": {
        "targets": [
          {
            "ip_address": "string",
            "description": "string",
            "port": "int64"
          }
        ],
        "use_http2": "bool",
        "use_tls": "bool",
        "sni": "string",
        "trusted_ca_bytes": "string",
        "timeout": "google.protobuf.Duration",
        "idle_timeout": "google.protobuf.Duration",
        "session_affinity": {
          // Includes only one of the fields `connection`, `header`, `cookie`
          "connection": {
            "source_ip": "bool"
          },
          "header": {
            "header_name": "string"
          },
          "cookie": {
            "name": "string",
            "ttl": "google.protobuf.Duration",
            "path": "string"
          }
          // end of the list of possible fields
        }
      },
      "tls_listener": {
        "enabled": "bool",
        "certificate_id": "string",
        "port": "int64",
        "enable_http1": "bool"
      },
      "http_listener": {
        "enabled": "bool",
        "redirect_to_https": "bool",
        "port": "int64"
      },
      "solid_waf_settings": {
        "solid_waf_profile_id": "string",
        "session_affinity": {
          // Includes only one of the fields `connection`, `header`, `cookie`
          "connection": {
            "source_ip": "bool"
          },
          "header": {
            "header_name": "string"
          },
          "cookie": {
            "name": "string",
            "ttl": "google.protobuf.Duration",
            "path": "string"
          }
          // end of the list of possible fields
        },
        "web_app_id": "string"
      },
      "rate_limit": {
        "all_requests_per_second": "int64",
        "requests_per_ip_per_second": "int64"
      }
    }
  ],
  "created_at": "google.protobuf.Timestamp",
  "updated_at": "google.protobuf.Timestamp",
  "service_account_id": "string",
  "status": "Status",
  "log_options": {
    "log_group_id": "string",
    "disable": "bool",
    "discard_rules": [
      {
        "http_codes": [
          "int64"
        ],
        "http_code_intervals": [
          "HttpCodeInterval"
        ],
        "discard_percent": "google.protobuf.Int64Value"
      }
    ]
  },
  "region_id": "string",
  "deletion_protection": "bool",
  "ip_address": "string",
  "resource_units": "int64",
  "ddos_protection_provider": "string",
  "log_group_id": "string",
  "route_options": {
    "modify_request_headers": [
      {
        "name": "string",
        // Includes only one of the fields `append`, `replace`, `remove`, `rename`
        "append": "string",
        "replace": "string",
        "remove": "bool",
        "rename": "string"
        // end of the list of possible fields
      }
    ],
    "modify_response_headers": [
      {
        "name": "string",
        // Includes only one of the fields `append`, `replace`, `remove`, `rename`
        "append": "string",
        "replace": "string",
        "remove": "bool",
        "rename": "string"
        // end of the list of possible fields
      }
    ]
  }
}
```

A Smart Web Security load balancer resource.

#|
||Field | Description ||
|| id | **string**

ID of the load balancer. ||
|| folder_id | **string**

ID of the folder that the load balancer belongs to. ||
|| cloud_id | **string**

ID of the cloud that the load balancer belongs to. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| name | **string**

Required field. Name of the load balancer.

The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `. ||
|| description | **string**

Description of the load balancer.

The maximum string length in characters is 512. ||
|| domains[] | **[Domain](#yandex.cloud.smartwebsecurity.v1.load_balancer.Domain)**

Domains served by the load balancer.

The number of elements must be in the range 0-500. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation time. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Last time when the load balancer was modified. ||
|| service_account_id | **string**

Required field. Service account for access to certificate, securityProfile and logGroup. ||
|| status | enum **Status**

Status of the load balancer.

- `CREATING`: The load balancer is being created.
- `ACTIVE`: The load balancer is active.
- `DELETING`: The load balancer is being deleted.
- `UPDATING`: The load balancer is being updated or started.
- `STOPPING`: The load balancer is being stopped.
- `STOPPED`: The load balancer is stopped and doesn't send traffic to the targets. ||
|| log_options | **[LogOptions](#yandex.cloud.smartwebsecurity.v1.load_balancer.LogOptions)**

Cloud logging settings. ||
|| region_id | **string**

Required field. "ru-central1", "kz1", etc. ||
|| deletion_protection | **bool**

Forbids Delete() calls.
NOTE: Deletion in status CREATING still allow even if deletion_protection is set. ||
|| ip_address | **string**

IP address of resulting balancer. ||
|| resource_units | **int64**

Number of initially allocated resource units.
Zero means the minimum configured for the service installation. ||
|| ddos_protection_provider | **string**

L3-L4 DDoS protection provider. Currently supported: "" or "qrator". ||
|| log_group_id | **string**

Cloud logging log group ID.
If empty string was passed to log options, this field will contain ID of default log group.
If logs are disabled, this field will contain empty string. ||
|| route_options | **[RouteOptions](#yandex.cloud.smartwebsecurity.v1.load_balancer.RouteOptions)**

Options that apply to all domains. ||
|#

## Domain {#yandex.cloud.smartwebsecurity.v1.load_balancer.Domain}

A domain served by a Smart Web Security load balancer.

#|
||Field | Description ||
|| name | **string**

Unique name of domain within the balancer.
Will be used for monitoring naming and error messages.

Value must match the regular expression ` [a-z][-a-z0-9]{1,56}[a-z0-9] `. ||
|| server_name | **string**

Required field. Server name or wildcard to be matched against SNI in a TLS connection and authority(host) header.
Wildcards are in the form of "*.s.o.m.e".
Allowed: "example.com", "*.example.com".
Not allowed: "*.*.example.com", "*-sub.example.com".

The string length in characters must be 1-255. Value must match the regular expression ` ([*][.])?([a-z0-9]([-a-z0-9]*[a-z0-9])?[.])+[-a-z0-9]{2,} `. ||
|| description | **string**

Domain description.

The maximum string length in characters is 512. ||
|| security_profile_id | **string**

Security Profile ID of SmartWebSecurity service. ||
|| http_backend | **[HttpBackend](#yandex.cloud.smartwebsecurity.v1.load_balancer.HttpBackend)**

Backend settings. ||
|| tls_listener | **[TlsListener](#yandex.cloud.smartwebsecurity.v1.load_balancer.TlsListener)**

Optional TLS listener settings. ||
|| http_listener | **[HttpListener](#yandex.cloud.smartwebsecurity.v1.load_balancer.HttpListener)**

Optional plaintext listener settings. ||
|| solid_waf_settings | **[SolidWafSettings](#yandex.cloud.smartwebsecurity.v1.load_balancer.SolidWafSettings)**

Optional Solid WAF settings. ||
|| rate_limit | **[RateLimit](#yandex.cloud.smartwebsecurity.v1.load_balancer.RateLimit)**

Optional rate limit settings. ||
|#

## HttpBackend {#yandex.cloud.smartwebsecurity.v1.load_balancer.HttpBackend}

#|
||Field | Description ||
|| targets[] | **[Target](#yandex.cloud.smartwebsecurity.v1.load_balancer.Target)**

List of targets.

The number of elements must be in the range 1-20. ||
|| use_http2 | **bool**

Enables HTTP2 for upstream requests.
If not set, HTTP 1.1 will be used by default. ||
|| use_tls | **bool**

Enable TLS for upstream requests. ||
|| sni | **string**

SNI string for TLS connections.
Applicable only if use_tls enabled.

The maximum string length in characters is 255. Value must match the regular expression ` [-.a-z0-9]* `. ||
|| trusted_ca_bytes | **string**

Trusted certificate authority certificates bundle (PEM text).
Applicable only if use_tls enabled. ||
|| timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Backend timeout. If not set, default is 300 seconds. ||
|| idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Specifies the idle timeout for the route. If not specified, there is no per-route idle timeout. ||
|| session_affinity | **[SessionAffinity](#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity)**

Session affinity. ||
|#

## Target {#yandex.cloud.smartwebsecurity.v1.load_balancer.Target}

#|
||Field | Description ||
|| ip_address | **string**

IPv4 address.

The string length in characters must be 1-40. ||
|| description | **string**

Target description.

The maximum string length in characters is 128. ||
|| port | **int64**

Target port.

Acceptable values are 1 to 65535, inclusive. ||
|#

## SessionAffinity {#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity}

#|
||Field | Description ||
|| connection | **[ConnectionSessionAffinity](#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity.ConnectionSessionAffinity)**

Session affinity based on source IP address.

Includes only one of the fields `connection`, `header`, `cookie`. ||
|| header | **[HeaderSessionAffinity](#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity.HeaderSessionAffinity)**

Session affinity based on an HTTP header.

Includes only one of the fields `connection`, `header`, `cookie`. ||
|| cookie | **[CookieSessionAffinity](#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity.CookieSessionAffinity)**

Session affinity based on a cookie.

Includes only one of the fields `connection`, `header`, `cookie`. ||
|#

## ConnectionSessionAffinity {#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity.ConnectionSessionAffinity}

#|
||Field | Description ||
|| source_ip | **bool**

IP address. ||
|#

## HeaderSessionAffinity {#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity.HeaderSessionAffinity}

#|
||Field | Description ||
|| header_name | **string**

Header name.

The string length in characters must be 1-256. ||
|#

## CookieSessionAffinity {#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity.CookieSessionAffinity}

#|
||Field | Description ||
|| name | **string**

Cookie name.

The string length in characters must be 1-256. ||
|| ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

If not set, session cookie will be used (not persisted between browser restarts). ||
|| path | **string**

Optional cookie path.

The string length in characters must be 0-256. ||
|#

## TlsListener {#yandex.cloud.smartwebsecurity.v1.load_balancer.TlsListener}

#|
||Field | Description ||
|| enabled | **bool**

Enable TLS listener. ||
|| certificate_id | **string**

Certificate ID in the Certificate Manager. ||
|| port | **int64**

Listener port. If value is not set, used 443 by default.

Acceptable values are 0 to 65535, inclusive. ||
|| enable_http1 | **bool**

Enables HTTP/1.0 and HTTP/1.1 support and disables HTTP/2. ||
|#

## HttpListener {#yandex.cloud.smartwebsecurity.v1.load_balancer.HttpListener}

#|
||Field | Description ||
|| enabled | **bool**

Enable http (plaintext) listener. ||
|| redirect_to_https | **bool**

Automatically redirect from HTTP to HTTPS.
If TlsListener's port is 443 or not set, redirect URL will be "https://&lt;host&gt;&lt;path&gt;" and "https://&lt;host&gt;:&lt;port&gt;&lt;path&gt;" in other case. ||
|| port | **int64**

Listener port. If value is not set, used 80 by default.

Acceptable values are 0 to 65535, inclusive. ||
|#

## SolidWafSettings {#yandex.cloud.smartwebsecurity.v1.load_balancer.SolidWafSettings}

#|
||Field | Description ||
|| solid_waf_profile_id | **string**

ID of the Solid WAF profile. ||
|| session_affinity | **[SessionAffinity](#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity)**

Session affinity to analyzers. If not set, ConnectionSessionAffinity will be used. ||
|| web_app_id | **string**

ID of the Solid WAF web app. ||
|#

## RateLimit {#yandex.cloud.smartwebsecurity.v1.load_balancer.RateLimit}

#|
||Field | Description ||
|| all_requests_per_second | **int64**

Rate limit for all requests.
Defaults:
- with SolidWaf enabled: 20000 RPS
- without SolidWaf enabled: unlimited

The minimum value is 0. ||
|| requests_per_ip_per_second | **int64**

Rate limit for individual IP addresses.
Defaults:
- with SolidWaf enabled: 1000 RPS
- without SolidWaf enabled: unlimited

The minimum value is 0. ||
|#

## LogOptions {#yandex.cloud.smartwebsecurity.v1.load_balancer.LogOptions}

#|
||Field | Description ||
|| log_group_id | **string**

ID of Cloud Logging log group.
Keep empty to use default log group.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `. ||
|| disable | **bool**

Do not send logs to Cloud Logging log group. ||
|| discard_rules[] | **[LogDiscardRule](#yandex.cloud.smartwebsecurity.v1.load_balancer.LogDiscardRule)**

Ordered list of rules, first matching rule applies.

The maximum number of elements is 30. ||
|#

## LogDiscardRule {#yandex.cloud.smartwebsecurity.v1.load_balancer.LogDiscardRule}

LogDiscardRule discards a fraction of logs with certain codes.
If neither codes or intervals are provided, rule applies to all logs.

#|
||Field | Description ||
|| http_codes[] | **int64**

HTTP codes that should be discarded.

The maximum number of elements is 500. Acceptable values are 100 to 599, inclusive. ||
|| http_code_intervals[] | enum **HttpCodeInterval**

Groups of HTTP codes like 4xx that should be discarded.

The maximum number of elements is 10.

- `HTTP_1XX`: Informational responses (100-199).
- `HTTP_2XX`: Successful responses (200-299).
- `HTTP_3XX`: Redirection messages (300-399).
- `HTTP_4XX`: Client error responses (400-499).
- `HTTP_5XX`: Server error responses (500-599).
- `HTTP_ALL`: All HTTP response status codes. ||
|| discard_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Percent of logs to be discarded: 0 - keep all, 100 or unset - discard all.

Acceptable values are 0 to 100, inclusive. ||
|#

## RouteOptions {#yandex.cloud.smartwebsecurity.v1.load_balancer.RouteOptions}

#|
||Field | Description ||
|| modify_request_headers[] | **[HeaderModification](#yandex.cloud.smartwebsecurity.v1.load_balancer.HeaderModification)**

Apply the following modifications to the request headers. ||
|| modify_response_headers[] | **[HeaderModification](#yandex.cloud.smartwebsecurity.v1.load_balancer.HeaderModification)**

Apply the following modifications to the response headers. ||
|#

## HeaderModification {#yandex.cloud.smartwebsecurity.v1.load_balancer.HeaderModification}

This is similar to the proposal for Envoy API v3, see
https://github.com/envoyproxy/envoy/issues/8947#issuecomment-551973469

#|
||Field | Description ||
|| name | **string**

Required field. Name of the header. ||
|| append | **string**

Append string to the header value.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Header values support the following formatters:
https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers ||
|| replace | **string**

New value for a header.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Header values support the following formatters:
https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers ||
|| remove | **bool**

Remove the header.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Header values support the following formatters:
https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers ||
|| rename | **string**

New name for a header.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Header values support the following formatters:
https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers ||
|#