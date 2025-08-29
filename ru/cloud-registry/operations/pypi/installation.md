---
title: Настроить PyPI
description: Следуя данной инструкции, вы настроите PyPI.
---

# Настроить PyPI

1. В зависимости от способа аутентификации:

    {% list tabs group=registry_auth %}

    - IAM-токен {#iam-token}

      Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md) для [аккаунта на Яндексе](../../../iam/operations/iam-token/create.md) или [сервисного аккаунта](../../../iam/operations/iam-token/create-for-sa.md), от имени которых вы будете выполнять аутентификацию.

      {% note info %}

      [Время жизни](../../../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена — не больше {{ iam-token-lifetime }}.

      {% endnote %}

    - OAuth-токен {#oauth-token}

      [Получите]({{ link-cloud-oauth }}) OAuth-токен для аккаунта на Яндексе, от имени которого вы будете выполнять аутентификацию.

    {% endlist %}

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

    {% endlist %}