# Configuring TLS certificates for HTTPS connections between clients and the CDN

To enable clients to request files over HTTPS (e.g., if you use a URI with the `https` scheme or enabled a redirect from HTTP to HTTPS in the [CDN resource](resource.md) settings), you need to configure TLS certificates for all [domain names used for content distribution](resource.md#hostnames) and specified in the resource. You can:

* Issue TLS certificates by Let's Encrypt<sup>®</sup> for each domain name.
* Use a single certificate for all domain names.

Make sure certificates are created or uploaded to {{ certificate-manager-full-name }}. Use either [Let's Encrypt® certificate](../../certificate-manager/concepts/managed-certificate.md) or [user certificate](../../certificate-manager/concepts/imported-certificate.md).

Certificates should be configured when creating a resource. You can change their settings afterwards along with other basic resource settings. For more information, see these guides:

* [{#T}](../operations/resources/create-resource.md)
* [{#T}](../operations/resources/configure-basics.md)

## Checking rights for a domain {#domain-name-challenge}

If you [issued a Let's Encrypt certificate in {{ certificate-manager-name }}](../../certificate-manager/concepts/managed-certificate.md) and use it in a CDN resource, you need to pass the [domain rights check](../../certificate-manager/concepts/challenges.md). {{ cdn-name }} only supports the `DNS` type of check for domain rights using `TXT` or `CNAME` DNS records. The CDN load balancer will return the `404` status code in response to queries to files at paths, such as `/.well-known/acme-challenge/<filenme>`, that are used in `HTTP` domain rights checks.

If you use a certificate of your own uploaded to {{ certificate-manager-name }} in a CDN resource, no domain rights check is required.
