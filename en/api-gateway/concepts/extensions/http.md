# x-yc-apigateway-integration:http extension

The `x-yc-apigateway-integration:http` extension redirects a request to the relevant URL.

{% include [add-extentions-console](../../../_includes/api-gateway/add-extentions-console.md) %}

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Parameter | Type | Description 
----|----|----
`url`|`string`| URL to redirect the invocation to. It must be accessible from the internet or the [user network](../networking.md#user-network) specified in the API gateway settings. <br>The parameters are subsituted into `url`.
`method`|`enum`| This is an optional parameter. It sets the HTTP method for invocation. If it is not specified, the method to send a request to {{ api-gw-short-name }} will be used.
`headers`|`map[string](string \| string[])`| HTTP headers to provide. By default, headers of the original request are not provided. <br>The parameters are subsituted into `headers`.
`query`|`map[string](string \| string[])`| Query parameters to provide. By default, query parameters of the original request are not provided. <br>The parameters are subsituted into `query`.
`timeouts`|`object`| This is an optional parameter that defines the `read` and `connect` invocation timeouts in seconds.
`omitEmptyHeaders`|`boolean`| This is an optional parameter. If set to `true`, empty headers are not provided.
`omitEmptyQueryParameters`|`boolean`| This is an optional parameter. If set to `true`, empty query parameters are not provided.
`serviceAccountId` | `string` | Service account ID. It is used for authorization when accessing the specified URL. The `serviceAccountId` [top-level parameter](index.md#top-level) value is ignored.

## Extension specification {#spec}

Specification example:

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

Extension features:
* If the value of a header or query parameter is an array, it is provided as a single string separated by commas.
* By default, headers other than `User-Agent` and query parameters of the original request are not provided. To provide all the original request's headers and query parameters that are not overridden in the specification, add the string containing `'*': '*'` to the `query` and `headers` sections. To leave out some headers, give them empty values and set the `omitEmptyHeaders` field to `true`. Similarly, you can leave out some query parameters by using the `omitEmptyQueryParameters` field.
* The `User-Agent` header is provided by default unless it is overridden in the specification.
* To redirect all requests, use [greedy parameters](./greedy-parameters.md) and the [generic HTTP method](./any-method.md).

Here is an example of proxying all requests to `https://example.com`, where the `Content-Type` header and the `param` query parameter are provided:
```yaml
openapi: 3.0.0
info:
  title: Sample API
  version: 1.0.0
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

Here is an example of proxying all requests to `https://example.com`, where:
* All headers except `Foo-Header` and all query parameters except `foo_param` are provided.
* The `Bar-Header` header and the `bar_param` query parameter are added whose values are an array.
```yaml
openapi: 3.0.0
info:
  title: Sample API
  version: 1.0.0
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

## Use cases {#examples}

* [{#T}](../../tutorials/jwt-authorizer-firebase.md)
