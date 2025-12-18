# How to connect your own domain to a bucket



## Case description {#case-description}

You need to connect a custom domain to the bucket.

## Solution {#case-resolution}

To connect a custom domain to the bucket, do the following:

1. Create a bucket with the domain name.
1. [Set up the bucket as a host](../../../storage/operations/hosting/setup.md).
1. Configure DNS: [Add a CNAME record](../../../storage/operations/hosting/own-domain.md).
1. [Add a custom certificate to {{ certificate-manager-name }}](../../../certificate-manager/operations/index.md).
1. [Attach the certificate to the bucket to enable HTTPS](../../../storage/operations/hosting/certificate.md).

{% note info %}

For step 4, you can replace your certificate with a free Let's Encrypt certificate issued [with {{ certificate-manager-name }}](../../../certificate-manager/operations/managed/cert-create.md).

{% endnote %}

After successfully completing all steps, you can access your files through the links in `<domain_name>/[filekey]` format.