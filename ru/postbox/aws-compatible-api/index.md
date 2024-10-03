---
title: Как пользоваться API Amazon для работы с {{ postbox-name }}
description: Из статьи вы узнаете, как подготовиться к работе с API {{ postbox-name }} и как выглядит запрос к API.
keywords:
  - ses
  - simple email service
  - aws
  - ses api
  - aws api
  - api
  - api postbox
  - aws api postbox
  - postbox
  - cloud postbox
  - yandex cloud postbox
  - апи ses
  - апи aws
---

# Как пользоваться API Amazon для работы с {{ postbox-name }}

## Подготовка к работе {#before-you-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md).
1. [Назначьте сервисному аккаунту необходимые роли](../../iam/operations/sa/assign-role-for-sa.md).

   Подходящую роль можно выбрать из раздела [Управление доступом](../security/index.md#service-roles). Например, чтобы получить информацию о [конфигурации](../concepts/glossary.md#configuration), достаточно роли `postbox.viewer`. Чтобы отправлять письма, назначьте сервисному аккаунту роль `postbox.sender`.

1. [Создайте статический ключ доступа](../../iam/operations/sa/create-access-key.md).

   Он нужен для авторизации при отправке запросов к API Amazon. Чтобы хранить ключ безопасно, воспользуйтесь сервисом [{{ lockbox-full-name }}](../../lockbox/tutorials/static-key-in-lockbox.md).

## Общий вид запроса к API {#common-request-form}

```text
<HTTP-метод> <эндпоинт> HTTP/2
Host: {{ postbox-host }}
{Authorization|X-YaCloud-SubjectToken}: <данные_для_аутентификации>
X-Amz-Date: <время_в_формате_ISO_8601>

<тело_запроса>
```

Список эндпоинтов и нужных для них HTTP-методов смотрите в [Справочнике API](api-ref/index.md), список доступных заголовков — в разделе [{#T}](api-ref/request-headers.md).

В запросе нужно передать один из заголовков для аутентификации:

* `X-YaCloud-SubjectToken` — содержит IAM-токен сервисного аккаунта. Подробнее об [аутентификации через IAM-токен](../api-ref/authentication.md).
* `Authorization` — содержит статический ключ доступа и подпись запроса. Она нужна, если вы используете API напрямую, без [AWS CLI](../tools/aws-cli.md) и приложений. {{ postbox-name }} поддерживает подпись [Amazon Signature Version 4](https://docs.amazonaws.cn/en_us/IAM/latest/UserGuide/reference_aws-signing.html). Подробнее см. в [описании заголовка](signing-requests.md#authorization-header) `Authorization`.

   Отрабатывать создание подписи вы можете с помощью AWS CLI в режиме отладки. Для этого к команде `aws` добавляйте флаг `--debug`. Подробнее см. в [примере отладки](signing-requests.md#debugging).

   Чтобы не составлять подпись вручную, вы можете использовать утилиту [cURL](https://curl.se/) — она автоматически подписывает запросы к API Amazon. Подробнее см. в [примере использования API](#ses-api-example).
