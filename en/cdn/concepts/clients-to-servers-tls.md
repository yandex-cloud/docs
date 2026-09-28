# Configuring TLS certificates for HTTPS connections between clients and the CDN

To enable clients to request files over HTTPS (e.g., if you use a URI with the `https` scheme or enabled redirection from HTTP to HTTPS in the [CDN resource](resource.md) settings), you need to configure a TLS certificate for the [domain name used to distribute content](resource.md#hostnames) specified in the resource.

{% include [certificate-usage](../../_includes/cdn/certificate-usage.md) %}

The certificate is configured when creating a resource. You can change it afterwards together with other basic resource settings. For more information, see these guides:

* [{#T}](../operations/resources/create-resource.md)
* [{#T}](../operations/resources/configure-basics.md)

## TLS profiles {#tls-profiles}

{% include [tls-profiles-intro](../../_includes/cdn/tls-profiles-intro.md) %}

{% include [tls-profiles-list](../../_includes/cdn/tls-profiles-list.md) %}

You can perform the setup via the management console and API when [creating](../operations/resources/create-resource.md) or [updating](../operations/resources/configure-tls-profile.md) a CDN resource.


## Domain ownership verification {#domain-name-challenge}

If you [issued a Let's Encrypt certificate in {{ certificate-manager-name }}](../../certificate-manager/concepts/managed-certificate.md) and use it in a CDN resource, you need to pass [domain ownership verification](../../certificate-manager/concepts/challenges.md). For a CDN resource, you can use the `HTTP` and `DNS` verification types. During `HTTP` verification, a CDN load balancer receives HTTP and HTTPS file requests at paths like `/.well-known/acme-challenge/<file_name>` and forwards them to the origin. Make sure the origin returns a verification file with status code `200`.

If you use your own certificate uploaded to {{ certificate-manager-name }} in a CDN resource, no domain ownership verification is required.


## Use cases {#examples}

* [{#T}](../tutorials/migrate-to-yc-cdn.md)
* [{#T}](../tutorials/protected-access-to-content/index.md)
