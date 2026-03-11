# Настройка TLS-сертификатов для HTTPS-соединений между клиентами и CDN

Чтобы клиенты могли запрашивать файлы по HTTPS (например, если вы используете в сервисе URI со схемой `https` или включили переадресацию с HTTP на HTTPS в настройках [CDN-ресурса](resource.md)), для [доменного имени для раздачи контента](resource.md#hostnames), указанного в ресурсе, нужно настроить TLS-сертификат.

{% include [certificate-usage](../../_includes/cdn/certificate-usage.md) %}

Сертификат настраивается при создании ресурса. После этого сертификат можно изменить вместе с другими основными настройками ресурса. Подробнее см. в инструкциях:

* [{#T}](../operations/resources/create-resource.md)
* [{#T}](../operations/resources/configure-basics.md)

## Профили безопасности TLS {#tls-profiles}

{% include [tls-profiles-intro](../../_includes/cdn/tls-profiles-intro.md) %}

{% include [tls-profiles-list](../../_includes/cdn/tls-profiles-list.md) %}

Настройка доступна с помощью API при [создании](../operations/resources/create-resource.md) и [изменении](../operations/resources/configure-basics.md) CDN-ресурса. Подробнее см. на странице [{#T}](../operations/resources/configure-tls-profile.md).

См. также [{#T}](../../glossary/tls.md).

## Проверка прав на домен {#domain-name-challenge}

Если вы [выпустили сертификат Let's Encrypt в {{ certificate-manager-name }}](../../certificate-manager/concepts/managed-certificate.md) и используете его в CDN-ресурсе, вам нужно пройти [проверку прав на домен](../../certificate-manager/concepts/challenges.md). {{ cdn-name }} поддерживает только проверку прав типа `DNS`, с помощью DNS-записи типа `TXT` или `CNAME`. На запросы к файлам по путям вида `/.well-known/acme-challenge/<имя_файла>`, которые используются в проверке прав типа `HTTP`, CDN-балансировщик будет отвечать кодом состояния `404`.

Если вы используете в CDN-ресурсе собственный сертификат, загруженный в {{ certificate-manager-name }}, проходить проверку не требуется.


## Примеры использования {#examples}

* [{#T}](../tutorials/migrate-to-yc-cdn.md)
* [{#T}](../tutorials/protected-access-to-content/index.md)