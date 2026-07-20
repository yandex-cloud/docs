# Configuring data exchange between clients and the CDN

When a client uses your service to request a file published via {{ cdn-name }}, an HTTP or HTTPS connection is established between the client and the CDN load balancer, depending on the URI scheme: `http://cdn.example.com/styles/common.css` or `https://cdn.example.com/styles/common.css`.

Only a CDN resource with the `Active` status can distribute the content available to users. For more information, see [{#T}](../concepts/resource.md#status).

For connections between clients and the CDN, you can configure:

* Client redirect from HTTP to HTTPS or vice versa as per this [guide](../operations/resources/configure-basics.md).
* [certificates](clients-to-servers-tls.md) for HTTPS connections.
* HTTP headers in CDN server responses to clients as per this [guide](../operations/resources/configure-headers.md).
* CORS [processing of cross-domain requests](cors.md).
* HTTP methods allowed to clients in CDN requests as per this [guide](../operations/resources/configure-http.md).

  {% include [post-method](../../_includes/cdn/http-post-method.md) %}

* [Sending compressed content](compression.md) using the `Content-Encoding: gzip` HTTP header.
