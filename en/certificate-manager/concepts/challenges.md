# Domain rights check

To get and renew a Let's Encrypt certificate, check the rights for each domain specified in the certificate. In {{ certificate-manager-name }}, there are two types of checks available: `HTTP` and `DNS`. When you create a certificate, you can choose any type of check. A domain rights check may take time.

{% note info %}

You only need to check domain rights for Let's Encrypt certificates. {{ certificate-manager-name }} does not check domain rights for imported user certificates.

{% endnote %}

{{ certificate-manager-name }} waits for each domain from the certificate to pass the check (all checks have the `Valid` status). After that, Let's Encrypt will issue a certificate. Then the certificate changes its status to `Issued` and you can use it in services integrated with {{ certificate-manager-name }}.

If you fail to pass the check within one week, the certificate status will become `Invalid` (if you are obtaining the certificate) or `Renewal_failed` (if you are renewing the certificate). To obtain a certificate after that, request another certificate from Let's Encrypt.

## Certificate challenge statuses {#status}

Certificate checks can have the following statuses:
* `Pending`: Awaiting completion. {{ certificate-manager-name }} determines whether the check is complete.
* `Validating`: Pending approval from Let's Encrypt.
* `Valid`: Complete.
* `Invalid`: Checking the rights for a specific domain failed or the one-week period allocated for the procedure expired.
* `Renewal_failed`: Checking the rights upon certificate renewal failed or the one-week period allocated for the procedure expired.
* `Issued`: Certificate is issued.

## HTTP {#http}

{% note info %}

You cannot use the `HTTP` check type for [Wildcard certificates](https://en.wikipedia.org/wiki/Wildcard_certificate).

{% endnote %}

To check the rights for the `example.com` domain:

1. In the [management console]({{ link-console-main }}), select the folder the certificate was added to.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}** and click the name of the certificate you need.
1. Prepare a file that will allow the Let's Encrypt certificate authority (CA) to verify your ownership of the domain specified in the certificate:

    1. Use your hosting control panel to create a file on the server with the name and path matching the value of the **{{ ui-key.yacloud.certificate-manager.overview.challenge_label_http-url }}** field under **HTTP record**. For example:

        * `/.well-known/acme-challenge/`: Path to the file.
        * `di2o3VRsbS6H_eUntKnW3Xcefw_1DOSpZ1B********`: File name.

    1. Insert into the file you created the value of the **{{ ui-key.yacloud.certificate-manager.overview.challenge_label_http-content }}** field from **HTTP record**. Here is an example:

        > di2o3VRsbS6H_eUntKnW3Xcefw_1DOSpZ1BLW0QUDbE._TYLpfPMbwHQZ1aEmsdpidY5bPUnVyDvqSO********

    As a result, on your web server, you should have a file named `http://example.com/.well-known/acme-challenge/di2o3VRsbS6H_eUntKnW3Xcefw_1DOSpZ1B********` with this text inside it: `di2o3VRsbS6H_eUntKnW3Xcefw_1DOSpZ1BLW0QUDbE._TYLpfPMbwHQZ1aEmsdpidY5bPUnVyDvqSO********`.

1. Wait for the Let's Encrypt CA to issue a certificate and its status to change to `Issued`.
1. Delete the file created for certificate verification from your web server.

## DNS {#dns}

If you do not have access to the web server or you need to get a [Wildcard certificate](https://en.wikipedia.org/wiki/Wildcard_certificate) with masks for subdomains in `*.example.com` format, use the `DNS` check type.

To pass the check, you need to add a special DNS record of one of the following two types: `TXT` or `CNAME`.

{% note alert %}

Add only one record. If you add both records, the caching servers will come into conflict.

{% endnote %}

When using a TXT record, you will have to pass the check every 60 days as part of the automatic certificate renewal.

Using a CNAME record enables you to undergo a check only once. To do this, you need to delegate to {{ certificate-manager-name }} the right to respond in the domain's DNS zone used for the check. This will pass the check.

### Adding a CNAME record {#cname}

To automatically check the rights for the `example.com` domain:
1. In the [management console]({{ link-console-main }}), select the folder the certificate was added to.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
1. In the certificate list, select the certificate to check.
1. Further steps to follow will depend on whether your domain is managed by {{ dns-full-name }} or a third-party DNS provider.

    {% include [creating-cname](../../_includes/certificate-manager/creating-cname.md) %}

    {% include [checking-domain-rights](../../_includes/certificate-manager/checking-domain-rights.md) %}


### Adding a TXT record {#txt}

To check rights for the `example.com` domain, follow these steps:
1. In the [management console]({{ link-console-main }}), select the folder the certificate was added to.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
1. In the certificate list, select the certificate to check.
1. Further steps to follow will depend on whether your domain is managed by {{ dns-full-name }} or a third-party DNS provider.

    {% list tabs group=instructions %}

    - {{ dns-full-name }} {#dns}

       Under **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}**, in the `TXT` record type section, click **{{ ui-key.yacloud.dns.button_record-set-create }}** in the **{{ ui-key.yacloud.certificate-manager.overview.challenge_label_dns-record-set }}** field. In the window that opens:

      1. If the current folder contains an appropriate DNS zone, it will be automatically inserted into the **{{ ui-key.yacloud.dns.label_zone }}** field. If there is no appropriate DNS zone, click **{{ ui-key.yacloud.dns.button_zone-create }}** and set its parameters to [create](../../dns/operations/zone-create-public.md) a new zone.
      1. Click **{{ ui-key.yacloud.common.create }}**.

    - Third-party DNS provider {#third-party-dns-server}

      1. Under **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}**, in the `TXT` record type section, check out the record value for the domain in the **{{ ui-key.yacloud.certificate-manager.overview.challenge_label_value }}** field.
      1. Add a `TXT` record to your DNS provider or to your own DNS server:

          ```
          _acme-challenge.example.com. IN TXT <value>
          ```

    {% endlist %}

    {% include [checking-domain-rights](../../_includes/certificate-manager/checking-domain-rights.md) %}

1. After the certificate status changes to `Issued`, delete the `TXT` record you added from the DNS server.

## Validating rights automatically {#auto}

In some cases, the domain rights check requires no user input.

### CNAME record applicable to a zone {#auto-cname}

A check is performed automatically if the following conditions are met:
* The certificate’s status is `Renewing`, which means it is being [renewed](managed-certificate.md#renew).
* There is a DNS record configured for each certificate domain:

    ```
    _acme-challenge.example.com CNAME <certificate_ID>.cm.yandexcloud.net.
    ```

### Redirecting a static {{ objstorage-name }} website {#auto-s3}

A check is performed automatically if the following conditions are met:
* The certificate’s status is `Renewing`, which means it is being [renewed](managed-certificate.md#renew).
* The certificate is used in the [HTTPS configuration](../../storage/operations/hosting/certificate#cert-manager) of a static website in [{{ objstorage-name }}](../../tutorials/web/static/index.md).
* For each certificate domain, the following is configured:
    * An [alias](../../storage/operations/hosting/own-domain.md) for the static website bucket where the certificate is used.
    * Or a [redirect](../../storage/operations/hosting/multiple-domains.md) to the domain with the alias for the bucket.
* The certificate is not a [Wildcard certificate](https://en.wikipedia.org/wiki/Wildcard_certificate): it does not contain masks for subdomains.

### Redirecting to a validation server on a web server {#auto-vs}

A check is performed automatically if the following conditions are met:
* The certificate’s status is `Renewing`, which means it is being [renewed](managed-certificate.md#renew).
* The certificate is not a [Wildcard certificate](https://en.wikipedia.org/wiki/Wildcard_certificate): it does not contain masks for subdomains.
* For each certificate domain in the web server, a redirect is configured from
    ```
    http://<domain>/.well-known/acme-challenge/*
    ```
    to
    ```
    https://{{ api-host-certmanager-validation }}/<certificate_ID>/*
    ```
    This endpoint is only available over IPv6.

Example of setting up a redirect in the nginx configuration:
```
server {
  location ~ ^/.well-known/acme-challenge/([a-zA-Z0-9-_]+)$ {
    return 301 https://{{ api-host-certmanager-validation }}/<certificate_ID>/$1;
  }
}
```

#### See also {#see-also}

* [Let's Encrypt documentation: Types of challenges](https://letsencrypt.org/docs/challenge-types/)
