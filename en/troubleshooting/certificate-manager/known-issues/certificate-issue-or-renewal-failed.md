# Resolving issues with obtaining and renewing certificates from Let's Encrypt

## Issue description {#issue-description}

* When trying to issue a new or update an existing certificate from Let's Encrypt in the Certificate Manager interface, the domain rights verification process fails.
* When trying to issue a new or update an existing certificate from Let's Encrypt in the Certificate Manager interface, the certificate switches to one of the following statuses:

   * `Invalid`
   * `Renewal_failed`

* The certificate remains in the `Validating` status for a long time (from several hours to several days).
* Certificate Manager does not support automatic renewal of previously created certificates.

## Solution {#issue-resolution}

Verification of domain rights when issuing a new certificate can take up to one day from the date of creation of the certificate. The service periodically checks for the relevant [DNS records of the CNAME or TXT](../../../certificate-manager/concepts/challenges.md#dns) type or the presence of [files with a certain name and contents on your domain's web server](../../../certificate-manager/concepts/challenges.md#http).

If the repeat checks do not complete successfully within one week, the certificate will change to the `Invalid` status when issuing a new certificate or to the `Renewal_failed` status when updating an existing certificate.

In this case, you need to [create a new certificate request](../../../certificate-manager/operations/managed/cert-create.md).

{% note alert %}

Make sure that only one of the resource records, `cname` or `txt`, is specified in the DNS registrar settings. Trying to use both record types will result in domain validation conflict.

{% endnote %}
