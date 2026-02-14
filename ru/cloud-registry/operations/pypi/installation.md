---
title: Настроить PyPI
description: Следуя данной инструкции, вы настроите PyPI.
---

# Настроить PyPI

Перед настройкой пакетного менеджера настройте переменные окружения `REGISTRY_USERNAME` и `REGISTRY_PASSWORD`:

{% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}

1. В корневой директории пользователя создайте файл `~/.pypirc` со следующим содержимым:

    ```text
    [distutils]
    index-servers =
        cloud-registry

    [cloud-registry]
    repository = https://{{ cloud-registry }}/pypi/<идентификатор_реестра>/legacy/
    username = REGISTRY_USERNAME
    password = REGISTRY_PASSWORD
    ```

    Где:
    * `REGISTRY_USERNAME` — тип токена (`iam`, `oauth` или `api_key`).
    * `REGISTRY_PASSWORD` — тело токена для аутентификации.