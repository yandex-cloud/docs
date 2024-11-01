---
title: История изменений в {{ iam-full-name }}
description: В разделе представлена история изменений сервиса {{ iam-name }}.
---

# История изменений в {{ iam-full-name }}

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}

## III квартал 2024 {#q3-2024}

* Появились [федерации сервисных аккаунтов](./concepts/workload-identity.md) (Workload Identity Federation), которые позволяют предоставлять доступ внешним приложениям без использования долгоживущих ключей доступа. Функциональность находится на [стадии Preview](../overview/concepts/launch-stages.md). {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}
* Добавлена возможность создавать [API-ключи с ограниченным сроком и областью действия](./concepts/authorization/api-key.md#scoped-api-keys). {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}
* Добавлен метод REST API [ResolveAgent](./api-ref/ServiceControl/resolveAgent.md). {{ tag-api }}
* Добавлена возможность отзывать [IAM-токен](./concepts/authorization/iam-token.md) с помощью [{{ yandex-cloud}} CLI](../cli/cli-ref/managed-services/iam/revoke-token.md). {{ tag-cli }}
* Появились [системные группы](./concepts/access-control/system-group.md) `All users in organization X` и `All users in federation N`.
* Добавлен источник данных {{ TF }}, который позволяет получить идентификатор [сервисного агента](./concepts/service-control.md#service-agent). {{ tag-tf }}

## II квартал 2024 {#q2-2024}

* Добавлено отображение даты последнего использования ключей доступа сервисных аккаунтов. Информация доступна на странице сервисного аккаунта в [консоли управления]({{ link-console-main }}), а также в поле `last_used_at` при вызове методов управления ключами доступа через API. {{ tag-con }} {{ tag-api }}

## I квартал 2024 {#q1-2024}

* Добавлен компонент [{{ sts-name }}](./concepts/authorization/sts.md) для получения временных ключей доступа, совместимых с [AWS S3 API](../storage/s3/index.md). Функциональность находится на [стадии Preview](../overview/concepts/launch-stages.md). {{ tag-cli }} {{ tag-api }}
* Добавлена поддержка аутентификации OAuth-клиентов с помощью аутентификации токена сервисного аккаунта.
* Добавлена возможность использования идентификатора для маскированного токена для логов {{ at-name }}.
* Улучшен механизм ротации ключей в [OpenID Connect](https://openid.net/).
