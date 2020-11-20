# Check rights for domain

To get and renew a Let's Encrypt<sup>®</sup> certificate, check the rights for each domain specified in the certificate. You can use two types of checks in {{ certificate-manager-name }}: `HTTP` and `DNS`. When you create a certificate, you can choose any type of check. Checking rights for domains may take a long time.

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

If you don't have access to the web server or need to get a [Wildcard certificate](https://en.wikipedia.org/wiki/Wildcard_certificate) with masks for subdomains like `*.example.com`, use the `DNS` check type.

To pass a check, you need to add a special DNS record of the `TXT` or `CNAME` type:

* In case of a TXT record, when the certificate is renewed automatically after 60 days, you'll have to pass the check again and add a new value for the TXT record.
* When adding a CNAME record, you only need to pass the check once. You can delegate to {{ certificate-manager-name }} the right of response in the domain's DNS zone used for checks. In this case, checks are performed automatically when certificates are issued and then renewed.

### Adding a CNAME record {#cname}

To check the rights for the `example.com` domain automatically:

1. In the [management console]({{ link-console-main }}), select the folder where the certificate was created.

1. In the list of services, select **{{ certificate-manager-name }}**.

1. Under **Check rights for domains**, see the value for the domain in the **Value** field.

1. With your DNS provider or on your own DNS server, host a `CNAME` record for delegating the management rights to the DNS zone used for checks:

    ```
    _acme-challenge.example.com CNAME <certificate ID>.cm.yandexcloud.net.
    ```

### Adding a TXT record {#txt}

To check the rights for the `example.com` domain:

1. In the [management console]({{ link-console-main }}), select the folder where the certificate was created.

1. In the list of services, select **{{ certificate-manager-name }}**.

1. Under **Check rights for domains**, see the value for the domain in the **Value** field.

1. With your DNS provider or on your own DNS server, host a `TXT` record:

    ```
    _acme-challenge.example.com. IN TXT <Value>
    ```

1. After the certificate status changes to `Issued`, delete the `TXT` record you added from the DNS server.

## Checking rights automatically {#auto}

In some cases, domain rights checks require no interaction from the user.

### A CNAME record for a zone {#auto-cname}

A check is performed automatically if the following conditions are met:

* The certificate status is `Renewing`: it is being [renewed](managed-certificate.md#renew).

* A DNS record is configured for each certificate domain:

    ```
    _acme-challenge.example.com CNAME <certificate ID>.cm.yandexcloud.net.
    ```

### Redirecting a static website {{ objstorage-name }} {#auto-s3}

A check is performed automatically if the following conditions are met:

* The certificate status is `Renewing`: it is being [renewed](managed-certificate.md#renew).
* The certificate is used in the [HTTPS configuration](../../storage/operations/hosting/certificate#cert-manager) of a static website in [{{ objstorage-name }}](../../solutions/web/static.md).
* For each certificate domain, the following is configured:
    * [An alias](../../storage/operations/hosting/own-domain.md) for the static website bucket where the certificate is used.
    * Or a [redirect](../../storage/operations/hosting/multiple-domains.md) to the domain with the alias for the bucket.
* The certificate is not a [Wildcard certificate](https://en.wikipedia.org/wiki/Wildcard_certificate): it doesn't contain masks for subdomains.

### Redirecting to a validation server in a web server {#auto-vs}

A check is performed automatically if the following conditions are met:

* The certificate status is `Renewing`: it is being [renewed](managed-certificate.md#renew).
* The certificate is not a [Wildcard certificate](https://en.wikipedia.org/wiki/Wildcard_certificate): it doesn't contain masks for subdomains.
* For each certificate domain in the web server, a redirect is configured from

    ```
    http://<Domain>/.well-known/acme-challenge/*
    ```

    to

    ```
    https://validation.certificate-manager.api.cloud.yandex.net/<Certificate ID>/*
    ```

Example of setting up a redirect in the nginx configuration:

```
   server {
        location ~ ^/.well-known/acme-challenge/([a-zA-Z0-9-_]+)$ {
                return 301 https://validation.certificate-manager.api.cloud.yandex.net/<certificate ID>/$1.
        }
   }
```

#### See also {#see-also}

- [Let's Encrypt documentation. Types of checks](https://letsencrypt.org/docs/challenge-types/)

