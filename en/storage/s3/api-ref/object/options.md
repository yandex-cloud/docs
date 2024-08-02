# options method

Checks whether a [CORS request](../../../concepts/cors.md) to an object can be made.

## Request {#request}

```
OPTIONS /{bucket}/{key} HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |
| `key` | Object key. ID for saving the object in {{ objstorage-name }}. |

### Headers {#request-headers}

| Header | Description |
--------- | --------
| `Origin` | Request source domain.<br/><br/>For instance, `http://www.example.com`.<br/><br/>Mandatory. |
| `Access-Control-Request-Method` | HTTP method to be used to send a request to a resource.<br/><br/>Mandatory. |
| `Access-Control-Request-Headers` | List of headers to be sent in a subsequent request to the object. Headers are separated by commas.<br/><br/>Optional. |

You should also use the necessary [common request headers](../common-request-headers.md)

## Response {#response}

### Headers {#response-headers}

In addition to [common response headers](../common-response-headers.md), responses may contain:

| Header | Description |
--------- | --------
| `Access-Control-Allow-Origin` | The domain that was passed in the `Origin` request header.<br/><br/>If the [CORS configuration](../cors/upload.md#request-scheme) has the `AllowedOrigin` element set to `*`, then the `Access-Control-Allow-Origin` header value will also be `*`.<br/><br/>If access from the domain is not allowed, {{ objstorage-name }} returns error 403 and all `Access-Control-*` headers are missing. |
| `Access-Control-Max-Age` | Allowed response caching time (in seconds). |
| `Access-Control-Allow-Methods` | Allowed request methods. If there aren't any allowed methods, {{ objstorage-name }} returns a 403 error and all `Access-Control-*` headers are missing. |
| `Access-Control-Allow-Headers` | List of HTTP headers that can be used in a subsequent request to the object. If there are no headers allowed, this header is not included in a response. |
| `Access-Control-Expose-Headers` | List of HTTP headers that the JavaScript client receives. |

### Response codes {#response-codes}

The method returns the following:

- 200: if requests to the object are allowed.
- 403: if requests to the object are not allowed.

For a detailed description of response codes, see [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}