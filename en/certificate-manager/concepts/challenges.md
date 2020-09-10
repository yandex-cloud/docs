# Check rights for domain

To get and renew a Let's Encrypt<sup>®</sup> certificate, check the rights for each domain specified in the certificate. You can use two types of checks in {{ certificate-manager-name }}: `HTTP` and `DNS`. When you create a certificate, you can choose any type of check.

{% note info %}

You only need to check rights for domains for Let's Encrypt certificates. {{ certificate-manager-name }} doesn't check domain rights for imported user certificates.

{% endnote %}

{{ certificate-manager-name }} waits for each domain from the certificate to pass the check (all checks have the `Valid` status). After that, Let's Encrypt issues the certificate. Then the certificate changes its status to `Issued` and you can use it in services integrated with {{ certificate-manager-name }}.

If the check is not passed within one week, the certificate status becomes `Invalid` (if you are obtaining the certificate) or `Renewal_failed` (if you are renewing the certificate). To obtain a certificate after that, request another certificate from Let's Encrypt.

## Certificate check statuses {#status}

Certificate checks can have the following statuses:

* `Pending`: The check is waiting to be completed. {{ certificate-manager-name }} determines whether the check is complete.
* `Processing`: The check is awaiting approval from Let's Encrypt.
* `Valid`: The check is complete.
* `Invalid`: The rights check for a specific domain failed or the one-week period allocated for the check expired.

## HTTP {#http}

{% note info %}

You can't use the `HTTP` check type for [Wildcard certificates](https://en.wikipedia.org/wiki/Wildcard_certificate).

{% endnote %}

To check the rights for the `example.com` domain:

1. Create a file with the name and contents specified under **Check rights for domains** on the certificate details page:
    1. Copy the link from the **Link for hosting file** field:
        * The part of the link like `http://example.com/.well-known/acme-challenge/` is the path to host your file at.
        * The second part of the link, `rG1Mm1bJ...`, is the file name that you should use.

1. Put the file on the web server to make it available at the path:

    ```
    http://<domain name>/.well-known/acme-challenge/<file name>
    ```

1. After the certificate status changes to `Issued`, delete the file hosted on the web server.

## DNS {#dns}

If you don't have access to the web server or need to get a [Wildcard certificate](https://en.wikipedia.org/wiki/Wildcard_certificate), use the `DNS` check type.

To check the rights for the `example.com` domain:

1. At your DNS provider or your own DNS server, host a `TXT` record in a special format:

    The domain value is specified on the certificate details page (**Value** field under **Check rights for domains**).

    ```
    _acme-challenge.example.com. IN TXT <value>
    ```

1. After the certificate status changes to `Issued`, delete the `TXT` record you added from the DNS server.

#### See also {#see-also}

- [Let's Encrypt documentation. Types of checks](https://letsencrypt.org/docs/challenge-types/)

