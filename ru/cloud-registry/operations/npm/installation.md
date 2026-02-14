---
title: Настроить пакетные менеджеры для Node.js
description: Следуя данной инструкции, вы настроите npm, yarn или pnpm.
---

# Настроить пакетный менеджер для Node.js

Перед настройкой пакетного менеджера настройте переменные окружения `REGISTRY_USERNAME` и `REGISTRY_PASSWORD`:

{% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}

## Настроить для всех проектов {#all-projects}

Выберите пакетный менеджер:

{% list tabs %}

- npm {#npm}

  Выполните команду:

  `npm config set registry https://{{ cloud-registry }}/npm/<идентификатор_реестра>`

- yarn {#yarn}

  Выполните команду:

  `yarn config set registry https://{{ cloud-registry }}/npm/<идентификатор_реестра>`

- pnpm {#pnpm}

  Выполните команду:

  `pnpm config set registry https://{{ cloud-registry }}/npm/<идентификатор_реестра>`

{% endlist %}

## Настроить для одного проекта {#single-project}

Настройка для одного проекта одинакова для всех пакетных менеджеров:

1. Создайте файл `.npmrc` в корне проекта.
1. В зависимости от способа аутентификации:

    {% list tabs %}

    - Basic-аутентификация {#basic}

      1. Создайте переменную окружения `NPM_AUTH` с закодированными в [Base64](https://www.base64encode.org/) учетными данными:

          ```bash
          export NPM_AUTH=$(echo -n "${REGISTRY_USERNAME}:${REGISTRY_PASSWORD}" | base64)
          ```

          Где:
          * `REGISTRY_USERNAME` — переменная окружения, содержащая тип токена (`iam`, `oauth` или `api_key`).
          * `REGISTRY_PASSWORD` — переменная окружения, содержащая тело токена для аутентификации.
          * `NPM_AUTH` — переменная окружения, содержащая учетные данные в кодировке Base64.

      1. Добавьте в созданный ранее файл `.npmrc` следующие строки:

          ```text
          registry=https://{{ cloud-registry }}/npm/<идентификатор_реестра>
          //{{ cloud-registry }}/npm/:_auth=${NPM_AUTH}
          always-auth=true
          ```

    - Bearer-аутентификация {#bearer}

      {% note info %}

      Для Bearer-аутентификации используйте IAM-токен или API-ключ (не OAuth-токен).

      {% endnote %}

      1. Добавьте в созданный ранее файл `.npmrc` следующие строки:

          ```text
          registry=https://{{ cloud-registry }}/npm/<идентификатор_реестра>
          //{{ cloud-registry }}/npm/:_authToken=${REGISTRY_PASSWORD}
          always-auth=true
          ```

          Где `REGISTRY_PASSWORD` — переменная окружения, содержащая IAM-токен или API-ключ для аутентификации.

    {% endlist %}