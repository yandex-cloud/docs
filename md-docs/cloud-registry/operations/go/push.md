[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > [Пошаговые инструкции](../index.md) > Управление артефактами > Go-артефакт > Загрузить Go-модуль в реестр

# Загрузить Go-модуль в реестр

Перед загрузкой подготовьте ZIP-архив Go-модуля. Подробнее в инструкции [Создать Go-модуль](create.md).

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
1. Загрузите [Go-модуль](../../concepts/artifacts/go.md) с помощью HTTP-запроса методом PUT:

    ```bash
    curl \
      --request PUT \
      --user "$REGISTRY_USERNAME:$REGISTRY_PASSWORD" \
      --header "X-Checksum-SHA256: <хеш_файла>" \
      --upload-file <локальный_путь_к_ZIP-архиву> \
      https://registry.yandexcloud.net/go/<идентификатор_реестра>/<имя_модуля>/<версия_модуля>/<имя_файла_в_реестре>
    ```

    Где:

    * `--request` — метод.
    * `--user` — данные для аутентификации.
    * `--header` — заголовок API-запроса. Необязательный параметр.

        В заголовке `X-Checksum-SHA256` вы можете передать хеш загружаемого файла, чтобы после загрузки сервис проверил его целостность. Сгенерировать хеш можно, например, с помощью команды:

        ```bash
        openssl dgst -sha256 <путь_к_файлу> | awk '{print $2}'
        ```

    * `--upload-file` — локальный путь к загружаемому ZIP-архиву. 
    * URL запроса содержит URL реестра, имя и версию Go-модуля, а также имя файла в реестре. Например:

        ```bash
        https://registry.yandexcloud.net/go/cn15fqbr806r********/mymodule/1.0.0/mymodule-v1.0.0.zip
        ```

    {% note warning %}

    Версия Go-модуля в URL передается без префикса `v`. Например, для версии `v1.0.0` укажите `1.0.0`.

    {% endnote %}

    {% note warning %}

    При публикации Go-модуля его имя указывается без префикса `registry.yandexcloud.net/go/<идентификатор_реестра>/`. Если основная версия Go-модуля больше 1, суффикс `/vN` также не указывается. Например, для Go-модуля `registry.yandexcloud.net/go/<идентификатор_реестра>/sample/module/v4` используйте имя `sample/module`.

    {% endnote %}