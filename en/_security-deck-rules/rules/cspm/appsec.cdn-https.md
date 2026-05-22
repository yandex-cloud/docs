### Yandex Cloud CDN uses HTTPS and its own SSL certificate {#cdn-https}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | appsec.cdn-https ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for HTTPS configuration and SSL certificates on CDN resources.

{% endnote %}

[Cloud CDN](https://yandex.cloud/en/docs/cdn) supports secure connections to origins over HTTPS. You can also upload your own security certificate to access your [CDN resource](https://yandex.cloud/en/docs/cdn/concepts/resource) over HTTPS.

#### Guides and solutions

Guides and solutions to use:

* [Enable a certificate and HTTPS using the instructions](https://yandex.cloud/en/docs/cdn/operations/resources/configure-basics)