---
title: Настроить npm
description: Следуя данной инструкции, вы настроите npm.
---

# Настроить npm

Чтобы сделать настройку:

* для всех проектов, выполните команду:

    `npm config set registry https://{{ cloud-registry }}/npm/<идентификатор_реестра>`

* для одного проекта:

    1. Создайте файл `.npmrc` в корне проекта.
    1. В зависимости от способа аутентификации:

        {% list tabs %}

        - IAM-токен (Base64)

          1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md) для [аккаунта на Яндексе](../../../iam/operations/iam-token/create.md) или [сервисного аккаунта](../../../iam/operations/iam-token/create-for-sa.md), от имени которых вы будете выполнять аутентификацию.
          1. Добавьте в созданный ранее файл `.npmrc` следующие строки:

              ```text
              registry=https://{{ cloud-registry }}/npm/<идентификатор_реестра>
              //{{ cloud-registry }}/npm/:_auth=${NPM_AUTH}
              always-auth=true
              ```
          1. Создайте переменную окружения `NPM_AUTH`, содержащую строку `iam:<IAM-токен>` в кодировке [Base64](https://www.base64encode.org/):

              ```bash
              export NPM_AUTH=$(echo -n 'iam:<IAM-токен>' | base64)
              ```

              Где `<IAM-токен>` — полученный ранее IAM-токен.

        - IAM-токен

          1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md) для [аккаунта на Яндексе](../../../iam/operations/iam-token/create.md) или [сервисного аккаунта](../../../iam/operations/iam-token/create-for-sa.md), от имени которых вы будете выполнять аутентификацию.
          1. Добавьте в созданный ранее файл `.npmrc` следующие строки:

              ```text
              registry=https://{{ cloud-registry }}/npm/<идентификатор_реестра>
              //{{ cloud-registry }}/npm/:_authToken=${NPM_AUTH_TOKEN}
              always-auth=true
              ```
          1. Создайте переменную окружения `NPM_AUTH_TOKEN`, содержащую полученный ранее IAM-токен:

              ```bash
              export NPM_AUTH_TOKEN="<IAM-токен>"
              ```

        - OAuth-токен (Base64)

          1. [Получите]({{ link-cloud-oauth }}) OAuth-токен для аккаунта на Яндексе, от имени которого вы будете выполнять аутентификацию.
          1. Добавьте в созданный ранее файл `.npmrc` следующие строки:

              ```text
              registry=https://{{ cloud-registry }}/npm/<идентификатор_реестра>
              //{{ cloud-registry }}/npm/:_auth=${NPM_AUTH}
              always-auth=true
              ```
          1. Создайте переменную окружения `NPM_AUTH`, содержащую строку `oauth:<OAuth-токен>` в кодировке [Base64](https://www.base64encode.org/):

              ```bash
              export NPM_AUTH=$(echo -n 'oauth:<OAuth-токен>' | base64)
              ```

              Где `<OAuth-токен>` — полученный ранее [OAuth-токен](../../../iam/concepts/authorization/oauth-token.md).

        {% endlist %}