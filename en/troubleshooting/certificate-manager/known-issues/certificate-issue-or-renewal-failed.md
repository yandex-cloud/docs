# Fixing issues with obtaining and renewing Let's Encrypt certificates



## Issue description {#issue-description}

* When trying to issue a new or renew an existing Let's Encrypt certificate in the {{ certificate-manager-name }} interface, the domain ownership verification fails.
* When trying to issue a new or renew an existing Let's Encrypt certificate in the {{ certificate-manager-name }} interface, the certificate switches to one of the following statuses:

    * `INVALID`
    * `RENEWAL_FAILED`

* The certificate remains `VALIDATING` for a long time (from a few hours up to a few days).
* {{ certificate-manager-name }} does not perform automatic renewal of previously created certificates.

## Solution {#issue-resolution}

Domain ownership verification for a new certificate may be completed within 24 hours of its creation. The service periodically checks for the [relevant `cname` or `txt` DNS records](../../../certificate-manager/concepts/challenges.md#dns), or for [files with a certain name and contents on your domain's web server](../../../certificate-manager/concepts/challenges.md#http).

If repeated verification attempts fail over a week, the status will change to `INVALID` for new certificates or `RENEWAL_FAILED` for those being renewed.

In this case, you need to [create a new certificate request](../../../certificate-manager/operations/managed/cert-create.md).

{% note alert %}

Make sure your DNS registrar settings include only one resource record type, `cname` or `txt`. Trying to use both record types will result in domain validation conflict.

{% endnote %}
