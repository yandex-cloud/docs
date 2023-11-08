# Configuring data exchange between CDN servers and origins

{% include [ipv4-note](../../_includes/cdn/ipv4-note.md) %}

You can select a protocol for communication between CDN servers and origins: always HTTP, always HTTPS, or the protocol used by the [CDN server to communicate with the client](clients-to-servers.md).

To enable CDN servers to establish HTTPS connections with origins, you need to configure the domain names of the origins yourself, including issuing TLS certificates for them. For instance, you can use {{ certificate-manager-full-name }}: [issue a certificate from Let's Encrypt<sup>®</sup>](../../certificate-manager/operations/managed/cert-create.md) and [get its contents](../../certificate-manager/operations/managed/cert-get-content.md).

For a resource, you can also configure:

* The value of the HTTP `Host` header for CDN server requests to origins: the primary [domain name used for content distribution](resource.md#hostnames), echoing the value from the client's request, or an arbitrary value.
* Other HTTP headers in CDN server requests to origins (see [instructions](../operations/resources/configure-headers.md)).
* Receiving of files by CDN servers from origins in parts: [content segmentation](slicing.md).

{% include [edge-center-features-note](../../_includes/cdn/edge-center-features-note.md) %}

Your resource and origins must be configured so that requests from CDN servers are allowed, processed correctly, and not redirected.

> For example, if origins redirect requests from a URI with the `http` scheme to a URI with the `https` scheme, you must select the HTTPS protocol for the resource, and vice versa.
