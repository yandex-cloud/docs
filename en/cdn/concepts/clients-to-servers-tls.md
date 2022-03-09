# Configuring TLS certificates for HTTPS connections between clients and the CDN

To enable clients to request files over HTTPS (for example, if you use a URI with the `https` scheme or enabled a redirect from HTTP to HTTPS in the [CDN resource](resource.md) settings), you need to configure TLS certificates for all [domain names used for content distribution](resource.md#hostnames) and specified in the resource. You can:

* Issue TLS certificates from Let's Encrypt<sup>®</sup> for each domain name. {{ cdn-name }} automatically issues certificates after saving the resource settings. This may take up to 30 minutes.
* Use a single certificate that is created or uploaded to {{ certificate-manager-full-name }} for all domain names.

Certificates are configured when creating a resource. You can change their settings afterwards along with other basic resource settings. For more information, see the instructions:

* [{#T}](../operations/resources/create-resource.md)
* [{#T}](../operations/resources/configure-basics.md)
