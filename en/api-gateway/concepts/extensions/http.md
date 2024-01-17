# x-yc-apigateway-integration:http extension

The `x-yc-apigateway-integration:http` extension redirects a request to the specified URL.

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
----|----|----
| `url` | `string` | URL to redirect the invocation to. <br>Parameters are substituted in `url`. |
| `method` | `enum` | This is an optional parameter. HTTP method used for the invocation. If the parameter is omitted, it defaults to the method of request to {{ api-gw-short-name }}. |
| `headers` | `map[string](string \| string[])` | HTTP headers to be sent. By default, the headers of the original request are not sent. <br>Parameters are substituted in `headers`. |
| `query` | `map[string](string \| string[])` | Query parameters to be sent. By default, the query parameters of the original request are not sent. <br>Parameters are substituted in `query`. |
| `timeouts` | `object` | This is an optional parameter. The `read` and `connect` invocation timeouts, in seconds. |
| `omitEmptyHeaders` | `boolean` | This is an optional parameter. If `true`, empty headers are not sent. |
| `omitEmptyQueryParameters` | `boolean` | This is an optional parameter. If `true`, empty query parameters are not sent. |

## Extension specification {#spec}

Example specification:

```yaml
x-yc-apigateway-integration:
  type: http
  url: https://example.com/backend1
  method: POST
  headers:
    Authorization: Basic ZjTqBB3f$IF9gdYAGlMrs2********
  query:
    my_param: myInfo
  timeouts:
    connect: 0.5
    read: 5
```

Extension specifics:
* If the value of a header or query parameter is an array, it is sent as a single line, separated by commas.
* By default, headers other than `User-Agent` and the original request's query parameters are not sent. To send all the original request's headers and query parameters that are not overridden in the specification, add `'*': '*'` to the `query` and `headers` sections. To omit some headers, set them to Null and the `omitEmptyHeaders` field value to `true`. Similarly, you can omit some query parameters by using the `omitEmptyQueryParameters` field.
* The `User-Agent` header is sent by default unless overridden in the specification.
* To redirect all requests, use [greedy parameters](./greedy-parameters.md) and a [generalized HTTP method](./any-method.md).

An example of proxying all requests to `https://example.com` with the `Content-Type` header and the `param` query parameter sent:
```yaml
paths:
  /{path+}:
    x-yc-apigateway-any-method:
      x-yc-apigateway-integration:
        type: http
        url: https://example.com/{path}
        headers:
          Content-Type: '{Content-Type}'
        query:
          param: '{param}'
        timeouts:
          connect: 0.5
          read: 5
      parameters:
      - name: Content-Type
        in: header
        required: false
        schema:
          type: string
      - name: path
        in: path
        required: false
        schema:
          type: string
      - name: param
        in: query
        required: false
        schema:
          type: string
```

An example of proxying all requests to `https://example.com`, where:
* All headers, except `Foo-Header`, and all query parameters, except `foo_param`, are sent.
* The `Bar-Header` header and the `bar_param` query parameter with an array as a value are added.
```yaml
paths:
  /{path+}:
    x-yc-apigateway-any-method:
      x-yc-apigateway-integration:
        type: http
        url: https://example.com/{path}
        query:
          '*': '*'
          foo_param: ""
          bar_param: [ "one", "two" ]
          single_param: three
        headers:
          Host: example.com
          '*': '*'
          Foo-Header: ""
          Bar-Header: [ "one", "two" ]
          Single-header: three
        omitEmptyHeaders: true
        omitEmptyQueryParameters: true
      parameters:
      - name: path
        in: path
        required: false
        schema:
          type: string
```