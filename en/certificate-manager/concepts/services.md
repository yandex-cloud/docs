# Integration with services from {{ yandex-cloud }}

You can use {{ certificate-manager-name }} certificates in the following {{ yandex-cloud }} services:

* [{{ objstorage-full-name }}](#os).

## {{ objstorage-full-name }} {#os}

If a bucket is used for hosting a static website, [use a certificate](../../storage/operations/hosting/certificate.md#cert-manager) from {{ certificate-manager-name }} to access the website over `HTTPS`. When you change a certificate in {{ certificate-manager-name }}, it updates automatically in all the buckets that use it.

{% note warning %}

* `HTTPS` access to a bucket is granted within thirty minutes of selecting the certificate.
* Certificate changes may also take up to half an hour to apply.

{% endnote %}

## {{ api-gw-full-name }} {#api-gw}

{{ api-gw-full-name }} lets you merge several microservices into a single product. Microservices can be run on VMs, containers or implemented as functions. You can use the domain to access the API.

A certificate linked to the domain is used to provide a TLS connection.

#### See also {#see-also}

- [Static website in {{ objstorage-name }}](../../solutions/web/static.md)
- [{{ api-gw-full-name }}](../../api-gateway/index.yaml)

