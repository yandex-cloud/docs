# CORS in {{ cdn-name }}

{{ cdn-full-name }} supports [cross-domain requests](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing) via CORS (cross-origin resource sharing).

The CORS setting of a CDN resource controls whether the CDN server adds the `Access-Control-Allow-Origin` header to its client responses and defines the specific header value. If adding the header is enabled, the CDN server will generate it regardless of whether content is served from cache or fetched from the origin. This setting only applies to the CDN server’s response to the client and does not modify the origin configuration.

In the resource settings, you can:

* Allow CORS requests with any origins (the `Origin` header values): Set the `Access-Control-Allow-Origin` header to `*` or to the `Origin` header’s value in the request.
* Allow CORS requests for specific origins: Set the `Access-Control-Allow-Origin` header to the value of the `Origin` header in the request, but only if it is listed as allowed in the settings.
* Deny CORS requests: Disable adding the `Access-Control-Allow-Origin` header to responses.

CORS settings apply to all files of the resource.

{% include [cors-note](../../_includes/cdn/cors-note.md) %}


#### Useful links {#see-also}

* [CORS configuration guide](../operations/resources/configure-cors.md).
