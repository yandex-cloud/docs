# Integration with Yandex.Cloud services

You can use {{ certificate-manager-name }} certificates for the following Yandex.Cloud services:

* [{{ objstorage-full-name }}](#os).

## {{ objstorage-full-name }} {#os}

If you use a bucket to host a static website, use a {{ certificate-manager-name }} certificate to access the website over `HTTPS`. When you change a certificate in {{ certificate-manager-name }}, it updates automatically in all the buckets that use it.

{% note warning %}

* `HTTPS` access to a bucket is granted within thirty minutes of selecting the certificate.
* Certificate changes may also take up to half an hour to apply.

{% endnote %}

#### See also {#see-also}

- [Static website in {{ objstorage-name }}](../../solutions/web/static.md)

