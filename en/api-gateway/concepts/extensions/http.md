# x-yc-apigateway-integration:http extension

The `x-yc-apigateway-integration:http` extension redirects a request to the specified URL. The request is sent in the form it was received in from the client.

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
| ---- | ---- | ---- |
| `url` | `string` | URL to redirect the invocation to (must be accessible from the internet). <br>Parameters are substituted in `url`. |
| `method` | `enum` | Optional parameter. HTTP method used for the invocation. If the parameter is omitted, it defaults to the method of request to {{ api-gw-short-name }}. |
| `headers` | `map[string]string` | HTTP headers to be passed in addition to the original request headers. <br>Parameters are substituted in `headers`. |
| `timeouts` | `object` | Optional parameter. The `read` and `connect` invocation timeouts, in seconds. |

## Extension specification {#spec}

Sample specification:

```(json)
x-yc-apigateway-integration:
  type: http
  url: https://example.com/backend1
  method: POST
  headers:
    Authorization: Basic ZjTqBB3f$IF9gdYAGlMrs2fuINjHsz
  timeouts:
    connect: 0.5
    read: 5
```

Extension specifics:

* By default, the original request headers are not passed, but this can be done through parameter substitution. In this case, you should provide the `default` parameter header.

