### The Yandex Certificate Manager certificate is valid for at least 30 days {#certificate-validity}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | crypto.certificate-validity ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks certificate validity periods in Yandex Certificate Manager.

{% endnote %}

You can use Yandex Certificate Manager to manage TLS certificates for your API gateways in the API Gateway, as well as your websites and buckets in Object Storage. Application Load Balancer is integrated with Certificate Manager for storing and installing certificates. We recommend that you use Certificate Manager to obtain your certificates and rotate them automatically.

When using TLS in your application, we recommend that you limit the list of your trusted root certificate authorities (root CA).

When using certificate pinning, keep in mind that Let's Encrypt certificates are valid for [90 days](https://letsencrypt.org/docs/faq/#what-is-the-lifetime-for-let-s-encrypt-certificates-for-how-long-are-they-valid).

#### Guides and solutions

* Update the certificate or setup auto updates.
* [We recommend that you update certificates in advance if they are not updated automatically](https://yandex.cloud/en/docs/certificate-manager/concepts/challenges#auto)