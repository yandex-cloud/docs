---
title: Скачать binary-артефакт из реестра {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы скачаете binary-артефакт из реестра {{ cloud-registry-full-name }}.
---

# Скачать binary-артефакт из реестра

1. {% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}
1. Скачайте [binary-артефакт](../../concepts/artifacts/binary.md) с помощью [HTTP](https://{{ lang }}.wikipedia.org/wiki/HTTP)-запроса методом GET:

    ```bash
    curl \
      --request GET \
      --user "$REGISTRY_USERNAME:$REGISTRY_PASSWORD" \
      --location \
      --output <локальный_путь_к_файлу> \
      https://{{ cloud-registry }}/binaries/<идентификатор_реестра>/<имя_артефакта>/<версия_артефакта>
    ```

    Где:

    * `--request` — метод.
    * `--user` — данные для аутентификации.
    * `--output` — локальный путь и имя файла, в который будет скачан артефакт.
    * URL запроса содержит URL реестра, а также имя и версию артефакта. Например:

        ```bash
        https://{{ cloud-registry }}/binaries/cn15fqbr806r********/sample-package/3.5.4
        ```