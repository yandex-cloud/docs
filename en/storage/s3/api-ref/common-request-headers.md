# Common request headers

| Header name | Description |
| ----- | ----- |
| `Authorization` | Any request to Yandex Object Storage must be authorized.<br/><br/>This header must be used with either the `Date` or `x-amz-date` header.<br/><br/>Read about authorization methods in the corresponding sections of the guide. |
| `Cache-Control` | A set of directives for caching data according to [RFC 2616](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9). |
| `Content-Disposition` | The name under which Object Storage suggests saving an object as a file when downloading it. Compliant with [RFC 2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec19.html#sec19.5.1). |
| `Content-Encoding` | Defines the content encoding according to [RFC 2616](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.11). |
| `Content-Length` | Length of the request body (without headers) according to RFC 2616.<br/><br/>This header is required for all requests that send any data to Object Storage, for example, when uploading an object. |
| `Content-Type` | Data type in a request. For example, `text/plain`.<br/><br/>The default value is `binary/octet-stream`. |
| `Content-MD5` | 128-bit MD5 hash value of the request body, `base64` encoded.<br/><br/>Compliant with [RFC 1864](http://www.ietf.org/rfc/rfc1864.txt).<br/><br/>Object Storage uses this header to verify that the sent data matches the received data. |
| `Date` | Request sending date and time.<br/><br/>Format: `Thu, 18 Jan 2018 09:57:35 GMT`.<br/><br/>When `x-amz-date` is set, Object Storage ignores the `Date` header. |
| `Expect` | Expected `100-continue` code.<br/><br/>When uploading data to Object Storage, an app can use the following logic:<br/>- Send a request without a body, but with the Expect: 100-continue header set.<br/>- Send a request with a body after getting the `100-continue` response. This request must not have the `Expect` header. |
| `Expires` | Response expiration date. Compliant with [RFC 2616](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.21). |
| `Host` | Request recipient host.<br/><br/>This header is required for HTTP/1.1, but optional for HTTP/1.0 requests. |
| `x-amz-date` | Date and time set at the request source.<br/><br/>Format: `Thu, 18 Jan 2018 09:57:35 GMT`.<br/><br/>When `x-amz-date` is set, Object Storage ignores the `Date` header. |

If a cross-domain (CORS) request is sent, it may contain the [headers](object/options.md#request-headers) of the `OPTIONS` preflight request.

