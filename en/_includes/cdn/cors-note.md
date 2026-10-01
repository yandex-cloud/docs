{% note info %}

The CORS setting for a CDN resource only manages the `Access-Control-Allow-Origin` header in CDN server responses. It does not add other CORS headers and does not generate a response to the preflight `OPTIONS` request on behalf of the origin.

If the browser sends a preflight request, [allow](../../cdn/operations/resources/configure-http.md) the `OPTIONS` method in the CDN resource settings and configure the origin to correctly process this request and return the required CORS headers, e.g., `Access-Control-Allow-Methods` and `Access-Control-Allow-Headers`. For an [{{ objstorage-name }} bucket](../../storage/operations/buckets/cors.md), configure CORS in the bucket settings.

{% endnote %}
