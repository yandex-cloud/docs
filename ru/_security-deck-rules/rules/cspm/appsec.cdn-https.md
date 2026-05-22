### В Yandex Cloud CDN используется HTTPS и собственный SSL-сертификат {#cdn-https}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | appsec.cdn-https ||
|#

#### Описание

{% note tip "**Автоматическая проверка**" %}

Данный контроль автоматически проверяет настройки HTTPS и SSL-сертификатов на ресурсах CDN.

{% endnote %}

[Cloud CDN](https://yandex.cloud/ru/docs/cdn) поддерживает безопасное подключение по протоколу HTTPS к источникам. Также вы можете загрузить собственный сертификат безопасности для доступа к вашему [CDN-ресурсу](https://yandex.cloud/ru/docs/cdn/concepts/resource) по протоколу HTTPS.

#### Инструкции и решения по выполнению

* [Подключите сертификат и HTTPS согласно инструкции](https://yandex.cloud/ru/docs/cdn/operations/resources/configure-basics)