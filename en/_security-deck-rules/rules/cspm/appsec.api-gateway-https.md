### Yandex API Gateway uses HTTPS and its own domain {#api-gateway-https}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | appsec.api-gateway-https ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for HTTPS configuration and custom domain setup on API Gateways.

{% endnote %}

[API Gateway](https://yandex.cloud/en/docs/api-gateway) supports secure connections over HTTPS. You can link your own domain and upload your own security certificate to access your [API gateway](https://yandex.cloud/en/docs/api-gateway/concepts/) over HTTPS.

#### Guides and solutions

Guides and solutions to use:

* In the management console, select the cloud or folder to enable domains and certificates in.
* In the list of services, select **API Gateway → Gateway settings → Domains**.
* Enable the domains and certificates.