# Let's Encrypt<sup>®</sup> certificate

You can use {{ certificate-manager-name }} to create Let's Encrypt certificates. Request a certificate and pass the domain rights check. After that, {{ certificate-manager-name }} manages your certificates by interacting with Let's Encrypt on your behalf.

Let's Encrypt provides Domain Validation TLS certificates with a 90-day validity period. If you need Organization Validation or Extended Validation certificates, use a third-party certificate authority to get the certificate, and then upload it to {{ certificate-manager-name }}. For more information, see [User certificate](imported-certificate.md).

## Get a certificate {#request}

1. Specify the list of domains you need to issue a certificate for.

1. Select the type of domain rights check: `HTTP` or `DNS`.

    When the request is created, the certificate status becomes `Validating`.

1. To issue a certificate, check the rights for the domains you specified in the previous step.

    Depending on the type of check selected, put the file on the web server or add a `TXT` record with the desired value on the DNS. To learn more about the types of checks and ways to pass them, see [{#T}](challenges.md).

1. When the domain rights are checked, the certificate is issued and its status becomes `Issued`. You can use the certificate in services that are integrated with {{ certificate-manager-name }}.

{% note warning %}

If you fail to pass the domain rights check within a week, the certificate isn't issued and its status becomes `Invalid`.

{% endnote %}

## Renew a certificate {#renew}

{% note warning %}

To renew a certificate, follow the steps below. Keep track of the lifecycle of your certificates to renew them on time.

{% endnote %}

1. {{ certificate-manager-name }} initiates the certificate renewal procedure 30 days before it expires.

    After the renewal starts, the certificate status changes to `Renewing`.

1. Check the rights for the domains.

    Depending on the type of check you selected, update the file on the web server or update the `TXT` record on the DNS to the new value. For more information, see [Check rights for domain](challenges.md).

    {% note info %}

    If the certificate is used for a [static website in {{ objstorage-name }}](../../tutorials/web/static.md) and doesn't contain [masked domains](https://en.wikipedia.org/wiki/Wildcard_certificate), the rights can be checked automatically. For more information, see [Checking rights automatically](challenges.md#auto).

    {% endnote %}

1. After you check the rights for the domains, the certificate renews and its status becomes `Issued`. All the resources that use the certificate will get its new version.

The certificate isn't renewed if the domain rights check fails for at least one domain. The certificate status changes to `Renewal_failed`. However, the certificate stays valid until it expires.
Some time after the failed renewal, a new attempt is made to update the certificate.

To avoid issues accessing resources that use the certificate with the `Renewal_failed` status:

1. Before the certificate expires, [create a new Let's Encrypt certificate](../operations/managed/cert-create.md).
1. [Check the rights for the domains](../operations/managed/cert-validate.md).
1. Use the new certificate in your resources.

#### See also {#see-also}

- [Check rights for domain](challenges.md)
- [Services integrated with {{ certificate-manager-name }}](services.md)

