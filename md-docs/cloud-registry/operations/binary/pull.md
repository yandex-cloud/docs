[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > [Пошаговые инструкции](../index.md) > Управление артефактами > Binary-артефакт > Скачать binary-артефакт из реестра

# Скачать binary-артефакт из реестра

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
1. Скачайте [binary-артефакт](../../concepts/artifacts/binary.md) с помощью [HTTP](https://ru.wikipedia.org/wiki/HTTP)-запроса методом GET:

    ```bash
    curl \
      --request GET \
      --user "$REGISTRY_USERNAME:$REGISTRY_PASSWORD" \
      --location \
      --output <локальный_путь_к_файлу> \
      https://registry.yandexcloud.net/binaries/<идентификатор_реестра>/<имя_артефакта>/<версия_артефакта>
    ```

    Где:

    * `--request` — метод.
    * `--user` — данные для аутентификации.
    * `--output` — локальный путь и имя файла, в который будет скачан артефакт.
    * URL запроса содержит URL реестра, а также имя и версию артефакта. Например:

        ```bash
        https://registry.yandexcloud.net/binaries/cn15fqbr806r********/sample-package/3.5.4
        ```