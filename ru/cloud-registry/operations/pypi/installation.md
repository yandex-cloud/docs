---
title: Настроить PyPI
description: Следуя данной инструкции, вы настроите PyPI.
---

# Настроить PyPI

1. {% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}
1. В корневой директории пользователя создайте файл `~/.pypirc` со следующим содержимым, указав в нем полученный токен:

    {% list tabs group=registry_auth %}

    - IAM-токен {#iam-token}

      ```text
      [distutils]
      index-servers =
          cloud-registry

      [cloud-registry]
      repository = https://{{ cloud-registry }}/pypi/<идентификатор_реестра>/legacy/
      username = iam
      password = <IAM-токен>
      ```

    - OAuth-токен {#oauth-token}

      ```text
      [distutils]
      index-servers =
          cloud-registry

      [cloud-registry]
      repository = https://{{ cloud-registry }}/pypi/<идентификатор_реестра>/legacy/
      username = oauth
      password = <OAuth-токен>
      ```

    - API-ключ {#api-key}

      ```text
      [distutils]
      index-servers =
          cloud-registry

      [cloud-registry]
      repository = https://{{ cloud-registry }}/pypi/<идентификатор_реестра>/legacy/
      username = api_key
      password = <API-ключ>
      ```

    {% endlist %}