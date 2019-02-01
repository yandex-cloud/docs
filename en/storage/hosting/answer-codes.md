# Response codes

If a bucket is configured to host static websites, the user trying to access it may get errors described in the table below.

| Error code | Description |
| ----------- | --------- |
| `200 OK` | Successful response. |
| `302 Found` | If [!KEYREF objstorage-name] receives a request to the resource `http: / [!KEYREF s3-web-host]/bucket/x` without `/` at the end, [!KEYREF objstorage-name] will first try finding an `x` object and, if it does not exist, but there is `x/index.html` that is set as the website's home page, the user will get a 302 response and be redirected to `http:/[!KEYREF s3-web-host]/bucket/x/`. |
| `304 Not Modified` | [!KEYREF objstorage-name] uses the `If-Modified-Since`, `If-Unmodified-Since`, `If-Match`, and `If-None-Match` request headers to determine whether an object has been modified as compared to the one previously cached on the client side. If the object has not been modified, the user will get the `304 Not Modified` response. |
| `403 Forbidden` | Returned if the bucket to which the request was sent has no public access configured.<br/><br/>[[!TITLE ../operations/buckets/bucket-availability.md]](../operations/buckets/bucket-availability.md). |
| `404 Not Found` | Returned if the resource to which the request was sent does not exist or the bucket where the requested resource is located is not configured to host static websites.<br/><br/>[How to configure a bucket for static website hosting](bucket-configuration.md). |
| `500 Service Error` | [!KEYREF objstorage-name] internal error. |
| `503 Service Unavailable` | The load on the service is too high. You need to reduce your request rate. |

