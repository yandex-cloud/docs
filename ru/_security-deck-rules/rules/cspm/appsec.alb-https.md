### В Yandex Application Load Balancer используется HTTPS {#alb-https}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | appsec.alb-https ||
|#

#### Описание

{% note tip "**Автоматическая проверка**" %}

Данный контроль автоматически проверяет настройки HTTPS-обработчика на Application Load Balancer.

{% endnote %}

[Сервис Application Load Balancer](https://yandex.cloud/ru/docs/application-load-balancer) поддерживает HTTPS-обработчик с загрузкой [сертификата](https://yandex.cloud/ru/docs/certificate-manager/concepts/imported-certificate) из Certificate Manager. См. [описание настройки обработчика](https://yandex.cloud/ru/docs/application-load-balancer/concepts/application-load-balancer#listener) в документации Yandex Application Load Balancer.

#### Инструкции и решения по выполнению

* [Включите HTTPS обработчик согласно инструкции](https://yandex.cloud/ru/docs/application-load-balancer/tutorials/tls-termination/)