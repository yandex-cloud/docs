# Static website response codes

If a bucket is configured to host static websites, the user trying to access it may get any of the response codes described in the table below.

Code | Description
-----------|---------
`200 OK` | Successful response.
`302 Found`  | If {{ objstorage-name }} receives a request to the `http://{{ s3-web-host }}/bucket/x` resource without `/` at the end, {{ objstorage-name }} will first try to find the `x` object. If this object does not exist but `x/index.html` is set as the website home page, the user will get code 302 and will be redirected to `http://{{ s3-web-host }}/bucket/x/`.
`304 Not Modified` | {{ objstorage-name }} uses the `If-Modified-Since`, `If-Unmodified-Since`, `If-Match`, `If-None-Match` request headers to determine whether an object is modified compared to the one previously cached on the client side. If the object is not modified, the user will get the `304 Not Modified` response.
`403 Forbidden` | This code is returned if the bucket to receive the request has no public access configured.<br/><br/>[{#T}](../../../operations/buckets/bucket-availability.md).
`404 Not Found` | This code is returned if the resource to receive the request does not exist or the bucket containing the requested resource is not configured for hosting static websites.<br/><br/>[{#T}](../../../operations/hosting/setup.md).
`500 Service Error` | Internal error in {{ objstorage-name }}.
`503 Service Unavailable` | The load on the service is too high. You need to reduce your request rate.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}