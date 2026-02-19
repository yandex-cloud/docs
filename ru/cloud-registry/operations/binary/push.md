---
title: Загрузить binary-артефакт в реестр {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы загрузите binary-артефакт в реестр {{ cloud-registry-full-name }}.
---

# Загрузить binary-артефакт в реестр

1. {% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}
1. Загрузите [binary-артефакт](../../concepts/artifacts/binary.md) с помощью [HTTP](https://{{ lang }}.wikipedia.org/wiki/HTTP)-запроса методом POST:

    ```bash
    curl \
      --request PUT \
      --user "$REGISTRY_USERNAME:$REGISTRY_PASSWORD" \
      --header "X-Checksum-SHA256: <хеш_файла>" \
      --upload-file <локальный_путь_к_файлу> \
      https://{{ cloud-registry }}/binaries/<идентификатор_реестра>/<имя_артефакта>/<версия_артефакта>/<имя_файла_в_реестре>
    ```

    Где:

    * `--request` — метод.
    * `--user` — данные для аутентификации.
    * `--header` — заголовок API-запроса. Необязательный параметр.

        В заголовке `X-Checksum-SHA256` вы можете передать хеш загружаемого файла, чтобы после загрузки сервис проверил его целостность. Сгенерировать хеш можно, например, с помощью команды:

        ```bash
        openssl dgst -sha256 <путь_к_файлу> | awk '{print $2}'
        ```

    * `--upload-file` — локальный путь к загружаемому файлу. Максимальный размер — 100 МБ.
    * URL запроса содержит URL реестра, имя и версию артефакта, а также имя файла в реестре. Например:

        ```bash
        https://{{ cloud-registry }}/binaries/cn15fqbr806r********/sample-package/3.5.4/agent-installer.sh
        ```