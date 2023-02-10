# Integration with {{ yandex-cloud }} services

{% if product == "yandex-cloud" %}

You can use {{ certificate-manager-name }} certificates in the following {{ yandex-cloud }} services:
* [{{ objstorage-full-name }}](#os).
* [{{ api-gw-full-name }}](#api-gw).

{% endif %}

{% if product == "cloud-il" %}

You can use {{ certificate-manager-name }} certificates in [{{ objstorage-full-name }}](#os).

{% endif %}

## {{ objstorage-full-name }} {#os}

If you use a bucket to host a static website, [use a {{ certificate-manager-name }} certificate](../../storage/operations/hosting/certificate.md#cert-manager) to access the website over `HTTPS`. When you change a certificate in {{ certificate-manager-name }}, it updates automatically in all the buckets that use it.

{% note warning %}

* `HTTPS` access to a bucket is granted within thirty minutes of selecting the certificate.
* Certificate changes may also take up to half an hour to apply.

{% endnote %}

{% if product == "yandex-cloud" %}

## {{ api-gw-full-name }} {#api-gw}

{{ api-gw-full-name }} lets you merge several microservices into a single product. {% if lang == "ru" %}[Microservices](https://cloud.yandex.ru/blog/posts/2022/03/microservice-architecture){% else %}Microservices{% endif %} can be run on VMs and containers or implemented as functions. You can use the domain to access the {% if lang == "ru" and audience != "internal" %}[API](../../glossary/rest-api.md){% else %}API{% endif %}.

A certificate linked to the domain is used to provide a TLS connection.

{% endif %}

#### See also {#see-also}

* [Static website in {{ objstorage-name }}](../../tutorials/web/static.md)
{% if product == "yandex-cloud" %}
* [{{ api-gw-full-name }}](../../api-gateway/)
{% endif %}