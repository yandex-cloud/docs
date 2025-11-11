# CORS in {{ cdn-name }}

{{ cdn-full-name }} supports [cross-domain requests](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing) via CORS (cross-origin resource sharing).

In the resource settings, you can:

* Allow CORS requests with any origins (the `Origin` header values): Set the `Access-Control-Allow-Origin` header to `*` or to the `Origin` header’s value in the request.
* Allow CORS requests for specific origins: Set the `Access-Control-Allow-Origin` header to the value of the `Origin` header in the request, but only if it is listed as allowed in the settings.
* Deny CORS requests: Disable adding the `Access-Control-Allow-Origin` header to responses.

CORS settings apply to all files of the resource.

{% include [cors-note](../../_includes/cdn/cors-note.md) %}

{% include [edge-cors-note](../../_includes/cdn/edge-cors-note.md) %}


#### See also {#see-also}

* [CORS configuration guide](../operations/resources/configure-cors.md).