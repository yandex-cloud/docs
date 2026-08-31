[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник (англ.)](../../../../index.md) > [smartwebsecurity](../../index.md) > [load-balancer](../index.md) > [load-balancer](index.md) > create

# yc smartwebsecurity load-balancer load-balancer create

Creates a load balancer in the specified folder.

#### Command Usage

Syntax:

`yc smartwebsecurity load-balancer load-balancer create <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--folder-id` | `string`

ID of the folder to create the load balancer in. ||
|| `--labels` | `map<string><string>`

Resource labels as 'key:value' pairs. ||
|| `--name` | `string`

Name of the load balancer. ||
|| `--description` | `string`

Description of the load balancer. ||
|| `--domains` | `shorthand/json`

Domains served by the load balancer.

{% cut "Description" %}

> - name (string)\
Unique name of domain within the balancer. Will be used for monitoring naming and error messages.
> - server-name (string)\
Server name or wildcard to be matched against SNI in a TLS connection and authority(host) header. Wildcards are in the form of "*.s.o.m.e". Allowed: "example.com", "*.example.com". Not allowed: "*.*.example.com", "*-sub.example.com".
> - description (string)\
Domain description.
> - security-profile-id (string)\
Security Profile ID of SmartWebSecurity service.
> - http-backend (structure)\
Backend settings.
>> - targets ([]structure)\
List of targets.
>>> - ip-address (string)\
IPv4 address.
>>> - description (string)\
Target description.
>>> - port (integer)\
Target port.
>> - use-http2 (boolean)\
Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default.
>> - use-tls (boolean)\
Enable TLS for upstream requests.
>> - sni (string)\
SNI string for TLS connections. Applicable only if use_tls enabled.
>> - trusted-ca-bytes (string)\
Trusted certificate authority certificates bundle (PEM text). Applicable only if use_tls enabled.
>> - timeout (duration)\
Backend timeout. If not set, default is 300 seconds.
>> - idle-timeout (duration)\
Specifies the idle timeout for the route. If not specified, there is no per-route idle timeout.
>> - session-affinity (structure)\
Session affinity.
>>> - session-affinity (oneof)\
Oneof session-affinity field
>>>> - connection (structure)\
Session affinity based on source IP address.
>>>>> - source-ip (boolean)\
IP address.
>>>> - header (structure)\
Session affinity based on an HTTP header.
>>>>> - header-name (string)\
Header name.
>>>> - cookie (structure)\
Session affinity based on a cookie.
>>>>> - name (string)\
Cookie name.
>>>>> - ttl (duration)\
If not set, session cookie will be used (not persisted between browser restarts).
>>>>> - path (string)\
Optional cookie path.
> - tls-listener (structure)\
Optional TLS listener settings.
>> - enabled (boolean)\
Enable TLS listener.
>> - certificate-id (string)\
Certificate ID in the Certificate Manager.
>> - port (integer)\
Listener port. If value is not set, used 443 by default.
>> - enable-http1 (boolean)\
Enables HTTP/1.0 and HTTP/1.1 support and disables HTTP/2.
> - http-listener (structure)\
Optional plaintext listener settings.
>> - enabled (boolean)\
Enable http (plaintext) listener.
>> - redirect-to-https (boolean)\
Automatically redirect from HTTP to HTTPS. If TlsListener's port is 443 or not set, redirect URL will be "https://&lt;host&gt;&lt;path&gt;" and "https://&lt;host&gt;:&lt;port&gt;&lt;path&gt;" in other case.
>> - port (integer)\
Listener port. If value is not set, used 80 by default.
> - solid-waf-settings (structure)\
Optional Solid WAF settings.
>> - solid-waf-profile-id (string)\
ID of the Solid WAF profile.
>> - session-affinity (structure)\
Session affinity to analyzers. If not set, ConnectionSessionAffinity will be used.
>>> - session-affinity (oneof)\
Oneof session-affinity field
>>>> - connection (structure)\
Session affinity based on source IP address.
>>>>> - source-ip (boolean)\
IP address.
>>>> - header (structure)\
Session affinity based on an HTTP header.
>>>>> - header-name (string)\
Header name.
>>>> - cookie (structure)\
Session affinity based on a cookie.
>>>>> - name (string)\
Cookie name.
>>>>> - ttl (duration)\
If not set, session cookie will be used (not persisted between browser restarts).
>>>>> - path (string)\
Optional cookie path.
>> - web-app-id (string)\
ID of the Solid WAF web app.
> - rate-limit (structure)\
Optional rate limit settings.
>> - all-requests-per-second (integer)\
Rate limit for all requests. Defaults: - with SolidWaf enabled: 20000 RPS - without SolidWaf enabled: unlimited
>> - requests-per-ip-per-second (integer)\
Rate limit for individual IP addresses. Defaults: - with SolidWaf enabled: 1000 RPS - without SolidWaf enabled: unlimited

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
[
  {
    description = string,
    http-backend = {
      idle-timeout = duration,
      session-affinity = {
        session-affinity = connection={
          source-ip = boolean
        } | cookie={
          name = string,
          path = string,
          ttl = duration
        } | header={
          header-name = string
        }
      },
      sni = string,
      targets = [
        {
          description = string,
          ip-address = string,
          port = integer
        }, ...
      ],
      timeout = duration,
      trusted-ca-bytes = string,
      use-http2 = boolean,
      use-tls = boolean
    },
    http-listener = {
      enabled = boolean,
      port = integer,
      redirect-to-https = boolean
    },
    name = string,
    rate-limit = {
      all-requests-per-second = integer,
      requests-per-ip-per-second = integer
    },
    security-profile-id = string,
    server-name = string,
    solid-waf-settings = {
      session-affinity = {
        session-affinity = connection={
          source-ip = boolean
        } | cookie={
          name = string,
          path = string,
          ttl = duration
        } | header={
          header-name = string
        }
      },
      solid-waf-profile-id = string,
      web-app-id = string
    },
    tls-listener = {
      certificate-id = string,
      enable-http1 = boolean,
      enabled = boolean,
      port = integer
    }
  }, ...
]
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
[
  {
    "description": "string",
    "http-backend": {
      "idle-timeout": "duration",
      "session-affinity": {
        "session-affinity": {
          "connection": {
            "source-ip": "boolean"
          },
          "cookie": {
            "name": "string",
            "path": "string",
            "ttl": "duration"
          },
          "header": {
            "header-name": "string"
          }
        }
      },
      "sni": "string",
      "targets": [
        {
          "description": "string",
          "ip-address": "string",
          "port": "integer"
        }, ...
      ],
      "timeout": "duration",
      "trusted-ca-bytes": "string",
      "use-http2": "boolean",
      "use-tls": "boolean"
    },
    "http-listener": {
      "enabled": "boolean",
      "port": "integer",
      "redirect-to-https": "boolean"
    },
    "name": "string",
    "rate-limit": {
      "all-requests-per-second": "integer",
      "requests-per-ip-per-second": "integer"
    },
    "security-profile-id": "string",
    "server-name": "string",
    "solid-waf-settings": {
      "session-affinity": {
        "session-affinity": {
          "connection": {
            "source-ip": "boolean"
          },
          "cookie": {
            "name": "string",
            "path": "string",
            "ttl": "duration"
          },
          "header": {
            "header-name": "string"
          }
        }
      },
      "solid-waf-profile-id": "string",
      "web-app-id": "string"
    },
    "tls-listener": {
      "certificate-id": "string",
      "enable-http1": "boolean",
      "enabled": "boolean",
      "port": "integer"
    }
  }, ...
]
```

{% endcut %} ||
|| `--service-account-id` | `string`

ID of the service account used to access dependent resources. ||
|| `--region-id` | `string`

ID of the region where the load balancer is located. ||
|| `--deletion-protection` | Protects the load balancer from accidental deletion. ||
|| `--log-options` | `shorthand/json`

Cloud Logging settings.

{% cut "Description" %}

> - log-group-id (string)\
ID of Cloud Logging log group. Keep empty to use default log group.
> - disable (boolean)\
Do not send logs to Cloud Logging log group.
> - discard-rules ([]structure)\
Ordered list of rules, first matching rule applies.
>> - http-codes ([]integer)\
HTTP codes that should be discarded.
>> - http-code-intervals ([]structure)\
Groups of HTTP codes like 4xx that should be discarded.
>> - discard-percent (integer)\
Percent of logs to be discarded: 0 - keep all, 100 or unset - discard all.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
{
  disable = boolean,
  discard-rules = [
    {
      discard-percent = integer,
      http-code-intervals = [
        HTTP_1XX|HTTP_2XX|HTTP_3XX|HTTP_4XX|HTTP_5XX|HTTP_ALL, ...
      ],
      http-codes = integer,...
    }, ...
  ],
  log-group-id = string
}
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
{
  "disable": "boolean",
  "discard-rules": [
    {
      "discard-percent": "integer",
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

{% endcut %} ||
|| `--resource-units` | `int`

Number of initially allocated resource units. ||
|| `--route-options` | `shorthand/json`

Options that apply to all domains.

{% cut "Description" %}

> - modify-request-headers ([]structure)\
Apply the following modifications to the request headers.
>> - name (string)\
Name of the header.
>> - operation (oneof)\
Oneof operation field
>>> - append (string)\
Append string to the header value.
>>> - replace (string)\
New value for a header.
>>> - remove (boolean)\
Remove the header.
>>> - rename (string)\
New name for a header.
> - modify-response-headers ([]structure)\
Apply the following modifications to the response headers.
>> - name (string)\
Name of the header.
>> - operation (oneof)\
Oneof operation field
>>> - append (string)\
Append string to the header value.
>>> - replace (string)\
New value for a header.
>>> - remove (boolean)\
Remove the header.
>>> - rename (string)\
New name for a header.

{% endcut %}

{% cut "Shorthand Syntax" %}

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
  ]
}
```

{% endcut %}

{% cut "JSON Syntax" %}

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
  ]
}
```

{% endcut %} ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request. ||
|| `-e`, `--example-yaml` | Generates a YAML template of the request.

The template can be customized and used as input for the command.

Usage example:

1. Generate template:
yc smartwebsecurity load-balancer load-balancer create --example-json > request.json
or
yc smartwebsecurity load-balancer load-balancer create --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc smartwebsecurity load-balancer load-balancer create -r request.json
or
yc smartwebsecurity load-balancer load-balancer create -r request.yaml ||
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
|| `--no-pager` | Do not pipe help output through a pager. ||
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
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#