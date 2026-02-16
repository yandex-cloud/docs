---
title: Аутентификация в API {{ postbox-full-name }}
description: Для выполнения операций через API {{ postbox-name }} получите статический ключ доступа.
---

# Аутентификация в API {{ postbox-name }}

Вы можете работать с {{ postbox-name }} с помощью [API Amazon](../aws-compatible-api/api-ref/index.md). Для аутентификации в нем используйте [статический ключ доступа](../../iam/concepts/authorization/access-key.md) или [IAM-токен](../../iam/concepts/authorization/iam-token.md). Все операции выполняются от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), которому выдан статический ключ или IAM-токен. Подробнее описано в разделе [Как пользоваться API](../aws-compatible-api/index.md).

Чтобы использовать API Amazon напрямую, без [AWS CLI](../tools/aws-cli.md) и приложений, воспользуйтесь одним из способов:

* Самостоятельно составьте подпись запроса, она передается в заголовке `Authorization`. О том, как подписать запрос и проверить подпись, читайте в разделе [{#T}](../aws-compatible-api/signing-requests.md).
* Аутентифицируйтесь через IAM-токен: получите его для сервисного аккаунта и передайте в заголовке `X-YaCloud-SubjectToken`. В этом случае заголовок `Authorization` и подпись не нужны.

## Примеры использования API Amazon {#ses-api-example}

В примерах приводится запрос для получения списка [конфигураций](../concepts/glossary.md#configuration). Запрос отправляется через утилиту [cURL](https://curl.se/).

Перед началом работы [создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с подходящей вам [ролью](../security/index.md#service-roles). Для этих примеров подойдет роль `postbox.viewer`.

### Аутентификация с помощью статического ключа {#access-key-ses-example}

1. [Создайте статический ключ](../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта.
1. Выполните запрос:

    ```bash
    export AWS_KEY_ID="<идентификатор_статического_ключа>" && \
    export AWS_SECRET_KEY="<секретный_ключ>" && \
    curl \
       --request GET \
       --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
       --aws-sigv4 "aws:amz:{{ region-id }}:ses" \
       --url '{{ postbox-endpoint }}/v2/email/configuration-sets' \
       --verbose
    ```

### Аутентификация с помощью IAM-токена {#iam-ses-example}

1. [Получите IAM-токен](../../iam/operations/iam-token/create-for-sa.md#via-cli) для сервисного аккаунта.
1. Выполните запрос:

    ```bash
    export IAM_TOKEN="<IAM-токен>" && \
    curl \
       --request GET \
       --header "X-YaCloud-SubjectToken: ${IAM_TOKEN}" \
       --url 'https://postbox.cloud.yandex.net/v2/email/configuration-sets' \
       --verbose
    ```
