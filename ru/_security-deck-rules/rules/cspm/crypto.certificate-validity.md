### Срок действия сертификата Yandex Certificate Manager составляет как минимум 30 дней {#certificate-validity}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | crypto.certificate-validity ||
|#

#### Описание

{% note tip "**Автоматическая проверка**" %}

Данный контроль автоматически проверяет сроки действия сертификатов в Yandex Certificate Manager.

{% endnote %}

Сервис Yandex Certificate Manager позволяет управлять TLS-сертификатами для API-шлюзов сервиса API Gateway, а также для сайтов и бакетов в Object Storage. Сервис Application Load Balancer интегрирован с Certificate Manager для хранения и установки сертификатов. Рекомендуется использовать Certificate Manager для получения и автоматической ротации сертификатов.

При работе с TLS в приложении рекомендуется ограничивать список доверенных корневых сертификатов (root CA).

При использовании технологий certificate pinning следует учитывать, что сервис Let's Encrypt выдает сертификаты со сроком действия в [90 дней](https://letsencrypt.org/docs/faq/#what-is-the-lifetime-for-let-s-encrypt-certificates-for-how-long-are-they-valid).

#### Инструкции и решения по выполнению

* Обновите сертификат либо настройте автоматическое обновление.
* [Рекомендуется заблаговременно обновлять сертификат, если вы не используете автоматическое обновление](https://yandex.cloud/ru/docs/certificate-manager/concepts/challenges#auto)