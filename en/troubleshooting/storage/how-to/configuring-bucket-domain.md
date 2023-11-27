# How to connect your own domain to a bucket



## Scenario description {#case-description}

You need to connect a custom domain to the bucket.

## Solution {#case-resolution}

To connect a custom domain to the bucket, do the following:

1. Create a bucket with the domain name.
2. [Set up the bucket as a host](../../../storage/operations/hosting/setup)
3. Configure DNS: [Add a CNAME record](../../../storage/operations/hosting/own-domain)
4. [Add a custom certificate to {{ certificate-manager-full-name }}](../../../certificate-manager/operations)
5. [Attach the certificate to the bucket to enable HTTPS](../../../storage/operations/hosting/certificate).

{% note info %}

In paragraph **4,** you can replace your certificate with a free Let's Encrypt certificate issued [with {{ certificate-manager-full-name }}](../../../certificate-manager/operations/managed/cert-create).

{% endnote %}

After successfully completing all the steps, you can access your files via such links: `<domain_name>/[filekey]`.
