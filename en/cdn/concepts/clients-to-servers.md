# Configuring data exchange between clients and the CDN

When a client requests through your service a file published via {{ cdn-name }}, an HTTP or HTTPS connection is established between the client and the CDN load balancer, depending on the URI scheme: `http://cdn.example.com/styles/common.css` or `https://cdn.example.com/styles/common.css`.

Only a CDN resource with the `Active` status can distribute the content available to users. For more information, see [{#T}](../concepts/resource.md#status).

For connections between clients and the CDN, you can configure:

* A client's redirect from HTTP to HTTPS or vice versa (see the [instructions](../operations/resources/configure-basics.md)).
* [Using certificates](clients-to-servers-tls.md) for HTTPS connections.
* HTTP headers in CDN server responses to clients (see [instructions](../operations/resources/configure-headers.md)).
* CORS [processing of cross-domain requests](cors.md).
* HTTP methods that clients are allowed to use in their CDN requests (see the [instructions](../operations/resources/configure-http.md)).
* [Sending of compressed content](compression.md) using the `Content-Encoding: gzip` HTTP header.

{% include [edge-center-features-note](../../_includes/cdn/edge-center-features-note.md) %}
