### В Yandex Object Storage включено HTTPS для хостинга статического сайта {#storage-https}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | data.storage-https ||
|#

#### Описание

[Object Storage](https://yandex.cloud/ru/docs/storage) поддерживает безопасное подключение по протоколу HTTPS. Вы можете загрузить собственный сертификат безопасности, если к сайту в Object Storage требуется доступ по протоколу HTTPS. Также доступна интеграция с сервисом [Certificate Manager](https://yandex.cloud/ru/docs/certificate-manager). См. инструкции в документации Object Storage:

* [Настройка HTTPS](https://yandex.cloud/ru/docs/storage/operations/hosting/certificate)
* [Бакет](https://yandex.cloud/ru/docs/storage/concepts/bucket)

При работе с сервисом [Object Storage](https://yandex.cloud/ru/docs/storage) необходимо убедиться, что в клиенте отключена поддержка протоколов TLS ниже версии 1.2. При помощи политики (bucket policy) [`aws:securetransport`](https://yandex.cloud/ru/docs/storage/s3/api-ref/policy/conditions) необходимо проверить, что для бакета настроен запрет на работу без протокола TLS.

**Риски при невыполнении правила:** Без HTTPS данные, передаваемые между пользователями и статическим сайтом, отправляются в открытом виде, что делает их уязвимыми для перехвата и атак типа «человек посередине». Чувствительный контент, токены сессий или данные форм могут быть перехвачены сетевыми злоумышленниками. Современные браузеры также предупреждают пользователей о сайтах, работающих только по HTTP, или блокируют их, снижая доверие и доступность.

#### Инструкции и решения по выполнению

[Включите](https://yandex.cloud/ru/docs/storage/operations/hosting/certificate) доступ по HTTPS, если бакет используется для хостинга статического сайта.
