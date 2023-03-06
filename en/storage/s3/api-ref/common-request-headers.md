# Common request headers

| Header | Description |
----- | -----
| `Authorization` | Any request to Yandex {{ objstorage-name }} must be authorized.<br/><br/>This header must be used with either the `Date` or `X-Amz-Date` header.<br/><br/>Learn about authorization methods in the corresponding sections of the guide. |
| `Cache-Control` | A set of directives for caching data according to [RFC 2616](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9). |
| `Content-Disposition` | The name {{ objstorage-name }} suggests saving an object as a file under when it's downloaded. Compliant with [RFC 2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec19.html#sec19.5.1). |
| `Content-Encoding` | Defines the content encoding according to [RFC 2616](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.11). |
| `Content-Length` | Length of the request body (without headers) in compliance with [RFC 2616](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.13).<br/><br/>This header is required for all requests that send to {{ objstorage-name }} any data, for example, when uploading an object. |
| `Content-Type` | Data type in a request. For example, `text/html`. For more information about data types, see the [Media type](https://en.wikipedia.org/wiki/Media_type) Wikipedia article.<br/><br/>The default type is `binary/octet-stream`. |
| `Content-MD5` | 128-bit MD5 hash value of the request body, `base64` encoded.<br/><br/>Compliant with [RFC 1864](http://www.ietf.org/rfc/rfc1864.txt).<br/><br/>{{ objstorage-name }} uses a header to make sure the sent data matches the received data.<br/><br/>If the bucket uses [default locks of object versions](../../concepts/object-lock.md#default), the `Content-MD5` header is required for uploading or copying an object version. |
| `Date` | The date and time a request is sent.<br/><br/>Format: `Thu, 18 Jan 2018 09:57:35 GMT`.<br/><br/>When `X-Amz-Date` is set, {{ objstorage-name }} ignores the `Date` header. |
| `Expect` | Expected `100-continue` code.<br/><br/>When uploading data to {{ objstorage-name }}, an app can use the following logic:<br/>- Send a request without a body, but with the Expect: 100-continue header set.<br/>- Send a request with a body after getting the `100-continue` response. This request must not have the `Expect` header. |
| `Expires` | Response expiration date. Compliant with [RFC 2616](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.21). |
| `Host` | Request recipient host.<br/><br/>This header is required for HTTP/1.1, but optional for HTTP/1.0 requests. |
| `X-Amz-Date` | The date and time at the request source.<br/><br/>Format: `20211102T145822Z`.<br/><br/>When `X-Amz-Date` is set, {{ objstorage-name }} ignores the `Date` header. |

If a cross-domain ([CORS](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing)) request is sent, it may contain [headers](object/options.md#request-headers) of the `options` preflight request.
