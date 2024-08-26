---
title: "История изменений в {{ iam-full-name }}"
description: "В разделе представлена история изменений сервиса {{ iam-name }}."
---

# История изменений в {{ iam-full-name }}

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}

## I квартал 2024 {#q1-2024}

* Добавлен компонент [{{ sts-name }}](./concepts/authorization/sts.md) для получения временных ключей доступа, совместимых с [AWS S3 API](../storage/s3/index.md). Функциональность находится на [стадии Preview](../overview/concepts/launch-stages.md). {{ tag-cli }} {{ tag-api }}
* Добавлена поддержка аутентификации OAuth-клиентов с помощью аутентификации токена сервисного аккаунта.
* Добавлена возможность использования идентификатора для маскированного токена для логов {{ at-name }}.
* Улучшен механизм ротации ключей в [OpenID Connect](https://openid.net/).
