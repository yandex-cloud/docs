# Настройка TLS-сертификатов для HTTPS-соединений между клиентами и CDN

Чтобы клиенты могли запрашивать файлы по HTTPS (например, если вы используете в сервисе URI со схемой `https` или включили переадресацию с HTTP на HTTPS в настройках [CDN-ресурса](resource.md)), для [доменного имени для раздачи контента](resource.md#hostnames), указанного в ресурсе, нужно настроить TLS-сертификат.

Поддерживаются сертификаты из [Yandex Certificate Manager](../../certificate-manager/index.md). Вы можете [выпустить новый сертификат Let's Encrypt®](../../certificate-manager/operations/managed/cert-create.md) или [загрузить собственный](../../certificate-manager/operations/import/cert-create.md).

Сертификат должен находиться в том же [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором расположен ваш CDN-ресурс.

Сертификат настраивается при создании ресурса. После этого сертификат можно изменить вместе с другими основными настройками ресурса. Подробнее см. в инструкциях:

* [Создание ресурса](../operations/resources/create-resource.md)
* [Изменение основных настроек ресурса](../operations/resources/configure-basics.md)

## Профили безопасности TLS {#tls-profiles}

Для соединения с клиентами в Cloud CDN поддерживается использование протокола TLS, начиная с версии 1.0.

Чтобы обеспечить большую безопасность вашего CDN-ресурса, вы можете настроить для него специальный профиль с допустимыми для использования версиями протокола TLS.

Поддерживаются следующие профили безопасности:
* `PROFILE_STRICT` — шифры, совместимые только с TLS версии 1.3.

    {% note info %}

    Все шифры TLS версии 1.3 считаются безопасными.

    {% endnote %}

* `PROFILE_SECURE` — шифры, совместимые с TLS версии 1.2 и новее с поддержкой PFS (Perfect Forward Secrecy) и AEAD (Authenticated Encryption with Associated Data).
* `PROFILE_COMPATIBLE` — шифры, совместимые с TLS версии 1.2 и новее без известных критических уязвимостей.

    Этот профиль используется по умолчанию.
* `PROFILE_LEGACY` — шифры, совместимые с TLS версии 1.0 и новее без известных критических уязвимостей.

Настройка доступна с помощью API при [создании](../operations/resources/create-resource.md) и [изменении](../operations/resources/configure-basics.md) CDN-ресурса. Подробнее см. на странице [Настройка профиля безопасности TLS для CDN-ресурса](../operations/resources/configure-tls-profile.md).

См. также [Введение в TLS: обзор принципов и основных характеристик](../../glossary/tls.md).

## Проверка прав на домен {#domain-name-challenge}

Если вы [выпустили сертификат Let's Encrypt в Certificate Manager](../../certificate-manager/concepts/managed-certificate.md) и используете его в CDN-ресурсе, вам нужно пройти [проверку прав на домен](../../certificate-manager/concepts/challenges.md). Cloud CDN поддерживает только проверку прав типа `DNS`, с помощью DNS-записи типа `TXT` или `CNAME`. На запросы к файлам по путям вида `/.well-known/acme-challenge/<имя_файла>`, которые используются в проверке прав типа `HTTP`, CDN-балансировщик будет отвечать кодом состояния `404`.

Если вы используете в CDN-ресурсе собственный сертификат, загруженный в Certificate Manager, проходить проверку не требуется.


## Примеры использования {#examples}

* [Миграция в Yandex Cloud CDN из стороннего CDN-провайдера](../tutorials/migrate-to-yc-cdn.md)
* [Организация защищенного доступа к контенту в Cloud CDN](../tutorials/protected-access-to-content/index.md)