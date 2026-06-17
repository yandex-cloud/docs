---
title: Загрузить Go-модуль в реестр {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы загрузите Go-модуль в реестр {{ cloud-registry-full-name }}.
---

# Загрузить Go-модуль в реестр

Перед загрузкой подготовьте ZIP-архив Go-модуля. Подробнее в инструкции [{#T}](create.md).

1. {% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}
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
