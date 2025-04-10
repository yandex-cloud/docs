# Configuring TLS certificates for HTTPS connections between clients and the CDN

To enable clients to request files over HTTPS (e.g., if you use a URI with the `https` scheme or enabled redirection from HTTP to HTTPS in the [CDN resource](resource.md) settings), you need to configure a TLS certificate for the [domain name used to distribute content](resource.md#hostnames) specified in the resource.

{% include [lets-encrypt-over](../../_includes/cdn/lets-encrypt-over.md) %}

{% include [certificate-usage](../../_includes/cdn/certificate-usage.md) %}

The certificate is configured when creating a resource. You can change it afterwards together with other basic resource settings. For more information, see these guides:

* [{#T}](../operations/resources/create-resource.md)
* [{#T}](../operations/resources/configure-basics.md)


## Domain rights check {#domain-name-challenge}

If you [issued a Let's Encrypt certificate in {{ certificate-manager-name }}](../../certificate-manager/concepts/managed-certificate.md) and use it in a CDN resource, you need to pass the [domain rights check](../../certificate-manager/concepts/challenges.md). {{ cdn-name }} only supports the `DNS` type domain rights check using a `TXT` or `CNAME` DNS record. The CDN load balancer will return the `404` status code in response to file requests over paths formatted as `/.well-known/acme-challenge/<file_name>` that are used for `HTTP` domain rights checks.

If you use a certificate of your own uploaded to {{ certificate-manager-name }} in a CDN resource, no domain rights check is required.


## Use cases {#examples}

* [{#T}](../tutorials/migrate-to-yc-cdn.md)
* [{#T}](../tutorials/protected-access-to-content/index.md)