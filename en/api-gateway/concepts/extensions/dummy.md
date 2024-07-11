# x-yc-apigateway-integration:dummy extension

The `x-yc-apigateway-integration:dummy` extension returns fixed content with the specified response code and required headers without any third-party service involved.

{% include [add-extentions-console](../../../_includes/api-gateway/add-extentions-console.md) %}

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
----|----|----
| `http_code` | `int` | HTTP response code. |
| `http_headers` | `map[string](string\|[]string)` | List of headers to be sent in response. Parameters are substituted in `http_headers`. |
| `content` | `map[string]string` | Data to be sent in response. <br>Can be either real content or mapping from the requested `Content-Type` into data. This lets you send errors in the requested format: JSON or XML. The `*` key is used for the default value. Parameters are substituted in `content`. |

## Extension specification {#spec}

Example specification:

```yaml
x-yc-apigateway-integration:
  type: dummy
  http_code: 302
  http_headers:
    Location: "/some/location"
    Set-Cookie: ["a={number}", "b=2"]
  content:
    "application/json": "{ \"message\": \"You've been redirected.\" }"
```

Extension features:
* If the request has the `Accept` header:
   * The best match is selected first.
   * If there is no match, the `*` key is selected.
   * If there is no key, the `415 Media not supported` response is returned.
* If the `Accept` header is missing, an arbitrary response is selected.
* If the content option is selected by the `*` key, the response's `Content-Type` is picked from `http_headers`. If it is not specified there, the actual `Content-Type` is returned.