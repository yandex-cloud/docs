[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > [Пошаговые инструкции](../index.md) > Управление артефактами > Binary-артефакт > Загрузить binary-артефакт в реестр

# Загрузить binary-артефакт в реестр

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
1. Загрузите [binary-артефакт](../../concepts/artifacts/binary.md) с помощью [HTTP](https://ru.wikipedia.org/wiki/HTTP)-запроса методом POST:

    ```bash
    curl \
      --request PUT \
      --user "$REGISTRY_USERNAME:$REGISTRY_PASSWORD" \
      --header "X-Checksum-SHA256: <хеш_файла>" \
      --upload-file <локальный_путь_к_файлу> \
      https://registry.yandexcloud.net/binaries/<идентификатор_реестра>/<имя_артефакта>/<версия_артефакта>/<имя_файла_в_реестре>
    ```

    Где:

    * `--request` — метод.
    * `--user` — данные для аутентификации.
    * `--header` — заголовок API-запроса. Необязательный параметр.

        В заголовке `X-Checksum-SHA256` вы можете передать хеш загружаемого файла, чтобы после загрузки сервис проверил его целостность. Сгенерировать хеш можно, например, с помощью команды:

        ```bash
        openssl dgst -sha256 <путь_к_файлу> | awk '{print $2}'
        ```

    * `--upload-file` — локальный путь к загружаемому файлу.
    * URL запроса содержит URL реестра, имя и версию артефакта, а также имя файла в реестре. Например:

        ```bash
        https://registry.yandexcloud.net/binaries/cn15fqbr806r********/sample-package/3.5.4/agent-installer.sh
        ```