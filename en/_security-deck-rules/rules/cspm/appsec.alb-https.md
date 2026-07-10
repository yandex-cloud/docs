### Yandex Application Load Balancer uses HTTPS {#alb-https}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | appsec.alb-https ||
|#

#### Description

[Application Load Balancer](https://yandex.cloud/en/docs/application-load-balancer) supports an HTTPS listener with a [certificate](https://yandex.cloud/en/docs/certificate-manager/concepts/imported-certificate) uploaded from Certificate Manager. See [listener setup description](https://yandex.cloud/en/docs/application-load-balancer/concepts/application-load-balancer#listener) in the Yandex Application Load Balancer documentation.

#### Instructions and solutions

Enable an HTTPS listener using [this guide](https://yandex.cloud/en/docs/application-load-balancer/tutorials/tls-termination/).
