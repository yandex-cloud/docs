### In Yandex Application Load Balancer, HTTPS is used {#alb-https}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | appsec.alb-https ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for HTTPS listener settings on Application Load Balancer.

{% endnote %}

[Application Load Balancer service](https://yandex.cloud/en/docs/application-load-balancer) supports an HTTPS listener with loading a [certificate](https://yandex.cloud/en/docs/certificate-manager/concepts/imported-certificate) from Certificate Manager. See the [listener configuration description](https://yandex.cloud/en/docs/application-load-balancer/concepts/application-load-balancer#listener) in the Yandex Application Load Balancer documentation.

#### Guides and solutions

* [Enable the HTTPS listener according to the instructions](https://yandex.cloud/en/docs/application-load-balancer/tutorials/tls-termination/)