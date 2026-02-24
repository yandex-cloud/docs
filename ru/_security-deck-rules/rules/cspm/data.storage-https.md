### В Yandex Object Storage включено HTTPS для хостинга статического сайта {#storage-https}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | data.storage-https ||
|#

#### Описание

{% note tip "**Автоматическая проверка**" %}

Данный контроль автоматически проверяет настройки HTTPS на статических сайтах Object Storage.

{% endnote %}

[Object Storage](https://yandex.cloud/ru/docs/storage) поддерживает безопасное подключение по протоколу HTTPS. Вы можете загрузить собственный сертификат безопасности, если к сайту в Object Storage требуется доступ по протоколу HTTPS. Также доступна интеграция с сервисом [Certificate Manager](https://yandex.cloud/ru/docs/certificate-manager). См. инструкции в документации Object Storage:

* [Настройка HTTPS](https://yandex.cloud/ru/docs/storage/operations/hosting/certificate)
* [Бакет](https://yandex.cloud/ru/docs/storage/concepts/bucket)

При работе с сервисом [Object Storage](https://yandex.cloud/ru/docs/storage) необходимо убедиться, что в клиенте отключена поддержка протоколов TLS ниже версии 1.2. При помощи политики (bucket policy) [aws:securetransport](https://yandex.cloud/ru/docs/storage/s3/api-ref/policy/conditions) необходимо проверить, что для бакета настроен запрет на работу без протокола TLS.

#### Инструкции и решения по выполнению

* Включите доступ по HTTPS, если бакет используется для хостинга статического сайта: https://yandex.cloud/ru/docs/storage/operations/hosting/certificate