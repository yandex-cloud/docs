# Static website response codes

If a bucket is configured to host static websites, the user trying to access it may get any of the response codes described in the table below.

| Code | Description |
-----------|---------
| `200 OK` | Successful response. |
| `302 Found` | If {{ objstorage-name }} receives a request to the resource `http://{{ s3-web-host }}/bucket/x` without a `/` at the end, {{ objstorage-name }} first tries to find object `x`. If this object doesn't exist, but `x/index.html` is set as the website homepage, the user receives a 302 response and is redirected to the resource `http://{{ s3-web-host }}/bucket/x/`. |
| `304 Not Modified` | {{ objstorage-name }} uses the `If-Modified-Since`, `If-Unmodified-Since`, `If-Match`, and `If-None-Match` request headers to determine whether an object was modified when compared to the one previously cached on the client side. If the object wasn't modified, the user gets the `304 Not Modified` response. |
| `403 Forbidden` | Returned if public access wasn't configured for the bucket that the request was sent to.<br/><br/>[{#T}](../../../operations/buckets/bucket-availability.md). |
| `404 Not Found` | Returned if the resource that the request was sent to doesn't exist or the bucket where the requested resource is located isn't configured for hosting static websites.<br/><br/>[{#T}](../../../operations/hosting/setup.md). |
| `500 Service Error` | Internal error in {{ objstorage-name }}. |
| `503 Service Unavailable` | The load on the service is too high. You need to reduce your request rate. |

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}