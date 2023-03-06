# CORS in {{ cdn-name }}

{{ cdn-full-name }} [supports cross-domain requests](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing) through CORS (cross-origin resource sharing).

In the resource settings, you can:

* Allow CORS requests with any origins (the `Origin` header values): Select for the `Access-Control-Allow-Origin` header, the `*` value or use the same value as in the `Origin` header in the request.
* Allow CORS requests for specific origins: Select for the `Access-Control-Allow-Origin` header the same value as in the `Origin` header in the request, but only if it's listed as allowed in the settings.
* Prohibit CORS requests: Disable adding the `Access-Control-Allow-Origin` header to the responses.

CORS settings apply to all files of the resource.

#### See also {#see-also}

* [Instructions for configuring CORS](../operations/resources/configure-cors.md).