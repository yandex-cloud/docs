---
title: Загрузить Debian-пакет в реестр {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы загрузите Debian-пакет в реестр {{ cloud-registry-full-name }}.
---

# Загрузить Debian-пакет в реестр

Инструкция описывает, как загрузить [Debian-пакет](../../concepts/artifacts/debian.md) в [локальный реестр](../../concepts/registry.md#local-registry).

Для загрузки Debian-пакета в реестр необходима [роль](../../security/index.md#cloud-registry-artifacts-pusher) `cloud-registry.artifacts.pusher` или выше.

{% list tabs group=debian_tools %}

- cURL {#curl} 

    1. {% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}

    1. Загрузите пакет с помощью HTTP-запроса:

        ```bash
        curl \
          --url-query "dist=<дистрибутив>" \
          --url-query "comp=<компонент>" \
          --user "${REGISTRY_USERNAME}:${REGISTRY_PASSWORD}" \
          --upload-file "<пакет>.deb" \
          "https://{{ cloud-registry }}/debian/<идентификатор_реестра>"
        ```

- dput {#dput}

  [dput](https://packages.debian.org/stable/dput) (Debian package upload tool) — утилита для загрузки пакетов в Debian-репозитории.

  1. {% include [auth-env](../../../_includes/cloud-registry/auth-env.md) %}

  1. Добавьте конфигурацию реестра в файл `/etc/dput.cf`:

      {% list tabs %}

      - IAM-токен

          ```ini
          [ycr]
          fqdn = {{ cloud-registry }}
          incoming = /debian/<идентификатор_реестра>/upload/
          login = iam
          method = https
          allow_unsigned_uploads = 1
          ```

      - API-ключ

          ```ini
          [ycr]
          fqdn = {{ cloud-registry }}
          incoming = /debian/<идентификатор_реестра>/upload/
          login = api_key
          method = https
          allow_unsigned_uploads = 1
          ```

      {% endlist %}

  1. Загрузите пакет:

      ```bash
      dput ycr <пакет>.changes
      ```

      Где `<пакет>.changes` — файл изменений пакета, сгенерированный при сборке.

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](installation.md)
* [{#T}](pull.md)
