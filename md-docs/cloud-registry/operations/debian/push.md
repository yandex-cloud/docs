[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > [Пошаговые инструкции](../index.md) > Управление артефактами > Debian-артефакт > Загрузить Debian-пакет в реестр

# Загрузить Debian-пакет в реестр

Инструкция описывает, как загрузить [Debian-пакет](../../concepts/artifacts/debian.md) в [локальный реестр](../../concepts/registry.md#local-registry).

Для загрузки Debian-пакета в реестр необходима [роль](../../security/index.md#cloud-registry-artifacts-pusher) `cloud-registry.artifacts.pusher` или выше.

{% list tabs group=debian_tools %}

- cURL {#curl} 

    1. Создайте переменные окружения в зависимости от способа аутентификации:
       
       {% list tabs group=registry_auth %}
       
       - IAM-токен {#iam-token}
       
         1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md) для [аккаунта на Яндексе](../../../iam/operations/iam-token/create.md) или [сервисного аккаунта](../../../iam/operations/iam-token/create-for-sa.md), от имени которого вы будете выполнять аутентификацию.
         1. Создайте переменные окружения `REGISTRY_USERNAME` и `REGISTRY_PASSWORD`:
       
             ```bash
             export REGISTRY_USERNAME="iam"
             export REGISTRY_PASSWORD="<IAM-токен>"
             ```
       
             Где:
       
             * `REGISTRY_USERNAME` — способ аутентификации.
             * `REGISTRY_PASSWORD` — тело полученного ранее IAM-токена.
       
         {% note info %}
       
         [Время жизни](../../../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена — не больше 12 часов.
       
         {% endnote %}
       
       - API-ключ {#api-key}
       
         1. [Создайте](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), от имени которого вы будете выполнять аутентификацию.
         1. Создайте переменные окружения `REGISTRY_USERNAME` и `REGISTRY_PASSWORD`:
       
             ```bash
             export REGISTRY_USERNAME="api_key"
             export REGISTRY_PASSWORD="<API-ключ>"
             ```
       
             Где:
       
             * `REGISTRY_USERNAME` — способ аутентификации.
             * `REGISTRY_PASSWORD` — тело созданного ранее [API-ключа](../../../iam/concepts/authorization/api-key.md).
       
         {% note info %}
       
         [Время жизни](../../../iam/concepts/authorization/api-key.md#scoped-api-keys) API-ключа ограничивается вручную при создании.
       
         {% endnote %}
       
       {% endlist %}

    1. Загрузите пакет с помощью HTTP-запроса:

        ```bash
        curl \
          --url-query "dist=<дистрибутив>" \
          --url-query "comp=<компонент>" \
          --user "${REGISTRY_USERNAME}:${REGISTRY_PASSWORD}" \
          --upload-file "<пакет>.deb" \
          "https://registry.yandexcloud.net/debian/<идентификатор_реестра>"
        ```

- dput {#dput}

  [dput](https://packages.debian.org/stable/dput) (Debian package upload tool) — утилита для загрузки пакетов в Debian-репозитории.

  1. Выберите способ аутентификации:
     
     {% list tabs group=registry_auth %}
     
     - IAM-токен {#iam-token}
     
         Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md) для [аккаунта на Яндексе](../../../iam/operations/iam-token/create.md) или [сервисного аккаунта](../../../iam/operations/iam-token/create-for-sa.md), от имени которого вы будете выполнять аутентификацию.
     
         {% note info %}
     
         [Время жизни](../../../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена — не больше 12 часов.
     
         {% endnote %}
     
     - API-ключ {#api-key}
     
         [Создайте](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), от имени которого вы будете выполнять аутентификацию.
     
         {% note info %}
     
         [Время жизни](../../../iam/concepts/authorization/api-key.md#scoped-api-keys) API-ключа ограничивается вручную при создании.
     
         {% endnote %}
     
     {% endlist %}

  1. Добавьте конфигурацию реестра в файл `/etc/dput.cf`:

      ```ini
      [ycr]
      fqdn = registry.yandexcloud.net
      incoming = /debian/<идентификатор_реестра>/upload/
      login = <логин>
      method = https
      allow_unsigned_uploads = 1
      ```

      Где:
      * `<идентификатор_реестра>` — идентификатор вашего реестра.
      * `login` — способ аутентификации: `iam` или `api_key`.

  1. Загрузите пакет:

      ```bash
      dput ycr <пакет>.changes
      ```

      Где `<пакет>.changes` — файл изменений пакета, сгенерированный при сборке.

{% endlist %}

#### Полезные ссылки {#see-also}

* [Настроить менеджер пакетов APT](installation.md)
* [Скачать Debian-пакет из реестра](pull.md)