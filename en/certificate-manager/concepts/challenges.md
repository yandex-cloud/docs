# Check rights for domain

To get and renew a Let's Encrypt certificate, check the rights for each domain specified in the certificate. You can use two types of checks in {{ certificate-manager-name }}: `HTTP` and `DNS`. When you create a certificate, you can choose any type of check. Checking rights for domains may take a long time.

{% note info %}

You only need to check rights for domains for Let's Encrypt certificates. {{ certificate-manager-name }} doesn't check domain rights for imported user certificates.

{% endnote %}

{{ certificate-manager-name }} waits for each domain from the certificate to pass the check (all checks have the `Valid` status). After that, Let's Encrypt issues the certificate. Then the certificate changes its status to `Issued` and you can use it in services integrated with {{ certificate-manager-name }}.

If the check is not passed within one week, the certificate status becomes `Invalid` (if you are obtaining the certificate) or `Renewal_failed` (if you are renewing the certificate). To obtain a certificate after that, request another certificate from Let's Encrypt.

## Certificate challenge statuses {#status}

Certificate checks can have the following statuses:
* `Pending`: The check is waiting to be completed. {{ certificate-manager-name }} determines whether the check is complete.
* `Processing`: The check is awaiting approval from Let's Encrypt.
* `Valid`: The check is complete.
* `Invalid`: The rights check for a specific domain failed or the one-week period allocated for the check expired.

## HTTP {#http}

{% note info %}

You can't use the `HTTP` challenge type for [Wildcard certificates](https://en.wikipedia.org/wiki/Wildcard_certificate).

{% endnote %}

To check the rights for the `example.com` domain:

1. In the [management console]({{ link-console-main }}), select the folder where the certificate was created.
1. In the list of services, select **{{ certificate-manager-name }}** and click on the name of the desired certificate.
1. Create an `.html` file:

   1. Copy text from the **Context** field under **Check rights for domains** on the certificate page and paste it into the file:

      > 6Z4R7LftFH8qGa6JiRzSGDNdrSQKvj0Ag_edlHjLXF8.sifhsdf778s98asAsa897da98sda

   1. Save the file using the name from the link part specified in the **Link for hosting file** field:
      * `http://example.com/.well-known/acme-challenge/`: File hosting path.
      * `6Z4R7LftFH8qGa6JiRzSGDNdrSQKvj0Ag_edlHjLXF8`: File name.

   The resulting file is `6Z4R7LftFH8qGa6JiRzSGDNdrSQKvj0Ag_edlHjLXF8.html` containing `6Z4R7LftFH8qGa6JiRzSGDNdrSQKvj0Ag_edlHjLXF8.sifhsdf778s98asAsa897da98sda`.

1. Host the file on your web server in the `.well-known/acme-challenge/` directory:

   > http://example.com/.well-known/acme-challenge/6Z4R7LftFH8qGa6JiRzSGDNdrSQKvj0Ag_edlHjLXF8

1. Once the certificate status changes to `Issued`, delete the file from the web server.

## DNS {#dns}

If you don't have access to the web server or you need to get a [Wildcard certificate](https://en.wikipedia.org/wiki/Wildcard_certificate) with masks for subdomains like `*.example.com`, use `DNS` as the challenge type.

To pass the check, you need to add a special DNS record of one of the following two types: `TXT` or `CNAME`.

{% note alert %}

Add only one record. If you add both records, the caching servers will come into conflict.

{% endnote %}

When using a TXT record, you will have to pass the check every 60 days as part of the automatic certificate renewal.

Using a CNAME record enables you to undergo a check only once. To do this, you need to delegate to {{ certificate-manager-name }} the right to respond in the domain's DNS zone used for the check. This will pass the check.

### Adding a CNAME record {#cname}

To check the rights for the domain `example.com` automatically:
1. In the [management console]({{ link-console-main }}), select the folder where the certificate was created.
1. In the list of services, select **{{ certificate-manager-name }}**.
1. In the certificate list, please select the certificate that is involved in the check.
1. Under **Check rights for domains**, look at the value for the domain in the **Value** field.
1. Have your DNS provider or your own DNS server host a `CNAME` record to delegate management privileges to the DNS zone used for the check:

   ```
   _acme-challenge.example.com CNAME <Value>
   ```
The `<Value>` string is created using the following template: `<Certificate ID>.cm.yandexcloud.net.`

### Adding a TXT record {#txt}

To check the rights for the `example.com` domain:
1. In the [management console]({{ link-console-main }}), select the folder where the certificate was created.
1. In the list of services, select **{{ certificate-manager-name }}**.
1. In the certificate list, please select the certificate that is involved in the check.
1. Under **Check rights for domains**, look at the value for the domain in the **Value** field.
1. With your DNS provider or on your own DNS server, host a `TXT` record:

   ```
   _acme-challenge.example.com. IN TXT <Value>
   ```
1. After the certificate status changes to `Issued`, delete the `TXT` record you added from the DNS server.

## Validating rights automatically {#auto}

In some cases, domain rights checks require no interaction from the user.

### CNAME record applicable to a zone {#auto-cname}

A check is performed automatically if the following conditions are met:
* The certificate status is `Renewing`: it is being [renewed](managed-certificate.md#renew).
* A DNS record is configured for each certificate domain:

   ```
   _acme-challenge.example.com CNAME <certificate ID>.cm.yandexcloud.net.
   ```

### Redirecting a static {{ objstorage-name }} website {#auto-s3}

A check is performed automatically if the following conditions are met:
* The certificate status is `Renewing`: it is being [renewed](managed-certificate.md#renew).
* The certificate is used in the [HTTPS configuration](../../storage/operations/hosting/certificate#cert-manager) of a static website in [{{ objstorage-name }}](../../tutorials/web/static.md).
* For each certificate domain, the following is configured:
   * An [alias](../../storage/operations/hosting/own-domain.md) for the static website bucket where the certificate is used.
   * Or a [redirect](../../storage/operations/hosting/multiple-domains.md) to the domain with the alias for the bucket.
* The certificate is not a [Wildcard certificate](https://en.wikipedia.org/wiki/Wildcard_certificate): it doesn't contain masks for subdomains.

### Redirecting to a validation server on a web server {#auto-vs}

A check is performed automatically if the following conditions are met:
* The certificate status is `Renewing`: it is being [renewed](managed-certificate.md#renew).
* The certificate is not a [Wildcard certificate](https://en.wikipedia.org/wiki/Wildcard_certificate): it doesn't contain masks for subdomains.
* For each certificate domain in the web server, a redirect is configured from
   ```
   http://<Domain>/.well-known/acme-challenge/*
   ```
   to
   ```
   https://{{ api-host-certmanager-validation }}/<Certificate ID>/*
   ```

Example of setting up a redirect in the nginx configuration:
```
server {
  location ~ ^/.well-known/acme-challenge/([a-zA-Z0-9-_]+)$ {
    return 301 https://{{ api-host-certmanager-validation }}/<Certificate ID>/$1;
  }
}
```

#### See also {#see-also}

* [Let's Encrypt documentation. Types of challenges]{% if lang == "ru" %}(https://letsencrypt.org/ru/docs/challenge-types/){% else %}(https://letsencrypt.org/docs/challenge-types/){% endif %}