# options method

Checks whether a [CORS request](../../../concepts/cors.md) to an object can be made.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
OPTIONS /{bucket}/{key} HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.
`key` | Object key. which is the ID the object is saved with in {{ objstorage-name }}.

### Headers {#request-headers}

Header | Description
--------- | --------
`Origin` | Request source domain.<br/><br/>For example, `http://www.example.com`.<br/><br/>Required.
`Access-Control-Request-Method` | HTTP method to use when sending a request to a resource.<br/><br/>Required.
`Access-Control-Request-Headers` | List of headers to send in a subsequent request to the object. Headers are separated by commas.<br/><br/>Optional.

Make sure to also use the required [common headers](../common-request-headers.md).

## Response {#response}

### Headers {#response-headers}

In addition to [common headers](../common-response-headers.md), responses may contain:

Header | Description
--------- | --------
`Access-Control-Allow-Origin` | Domain provided in the `Origin` request header.<br/><br/>If the [CORS configuration](../cors/upload.md#request-scheme) has the `AllowedOrigin` element set to `*`, the `Access-Control-Allow-Origin` header value will also be `*`.<br/><br/>If access from the domain is denied, {{ objstorage-name }} will return error 403 and there will be no `Access-Control-*` headers.
`Access-Control-Max-Age` | Allowed response caching time, in seconds.
`Access-Control-Allow-Methods` | Allowed request methods. If there are no allowed methods, {{ objstorage-name }} will return error 403 and there will be no `Access-Control-*` headers present.
`Access-Control-Allow-Headers` | List of HTTP headers that can be used in a subsequent request to the object. If there are no headers allowed, this header is not included in a response.
`Access-Control-Expose-Headers` | List of HTTP headers the JavaScript client will receive.

### Response codes {#response-codes}

The method returns the following:

- 200: If requests to the object are allowed.
- 403: If requests to the object are not allowed.

For a detailed description of response codes, see [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}