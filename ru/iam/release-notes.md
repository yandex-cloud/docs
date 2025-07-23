---
title: История изменений в {{ iam-full-name }}
description: В разделе представлена история изменений сервиса {{ iam-name }}.
---


# История изменений в {{ iam-full-name }}

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}

## II квартал 2025 {#q2-2025}

* Добавлено создание и использование [Refresh-токенов](concepts/authorization/refresh-token.md). {{ tag-cli }}

## I квартал 2025 {#q1-2025}

* [Добавлены](./concepts/authorization/api-key.md#scoped-api-keys) новые области действия для API-ключей и возможность назначать больше одной области действия в сервисе. {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}
* [Федерации сервисных аккаунтов](./concepts/workload-identity.md) (Workload Identity Federation) стали [доступны](../overview/concepts/launch-stages.md) всем пользователям. {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}
* [Добавлено](../iam/concepts/authorization/id-token.md) создание ID-токена для сервисного аккаунта, специального короткоживущего токена для аутентификации в сторонних системах. {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}


## IV квартал 2024 {#q4-2024}

* [Добавлена](../iam/at-ref.md#data-plane-events) отправка события уровня сервисов `CreateIamToken` при создании IAM-токена.
* Расширена область действия [API-ключей с ограниченным сроком](./concepts/authorization/api-key.md#supported-services) для работы с [{{ ydb-full-name }}](../ydb/) в режиме совместимости с {{ PG }}, [{{ postbox-full-name }}](../postbox/) и [{{ serverless-containers-full-name }}](../serverless-containers/). {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}
* Добавлено отображение даты и времени последней аутентификации сервисного аккаунта. Информация доступна в поле `last_authenticated_at` с помощью команды `yc iam user-account get` [{{ yandex-cloud}} CLI](../cli/cli-ref/iam/cli-ref/user-account/get). {{ tag-cli }}


## III квартал 2024 {#q3-2024}

* Появились [федерации сервисных аккаунтов](./concepts/workload-identity.md) (Workload Identity Federation), которые позволяют предоставлять доступ внешним приложениям без использования долгоживущих ключей доступа. {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}
* Добавлена возможность создавать [API-ключи с ограниченным сроком и областью действия](./concepts/authorization/api-key.md#scoped-api-keys). {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}
* Добавлен метод REST API [ResolveAgent](./api-ref/ServiceControl/resolveAgent.md). {{ tag-api }}
* Добавлена возможность отзывать [IAM-токен](./concepts/authorization/iam-token.md) с помощью [{{ yandex-cloud}} CLI](../cli/cli-ref/iam/cli-ref/revoke-token.md). {{ tag-cli }}
* Появились [системные группы](./concepts/access-control/system-group.md) `All users in organization X` и `All users in federation N`.
* Добавлен источник данных {{ TF }}, который позволяет получить идентификатор [сервисного агента](./concepts/service-control.md#service-agent). {{ tag-tf }}


## II квартал 2024 {#q2-2024}

* Добавлено отображение даты последнего использования ключей доступа сервисных аккаунтов. Информация доступна на странице сервисного аккаунта в [консоли управления]({{ link-console-main }}), а также в поле `last_used_at` при вызове методов управления ключами доступа через API. {{ tag-con }} {{ tag-api }}


## I квартал 2024 {#q1-2024}

* Добавлен компонент [{{ sts-name }}](./concepts/authorization/sts.md) для получения временных ключей доступа, совместимых с [AWS S3 API](../storage/s3/index.md). Функциональность находится на [стадии Preview](../overview/concepts/launch-stages.md). {{ tag-cli }} {{ tag-api }}
* Добавлена поддержка аутентификации OAuth-клиентов с помощью аутентификации токена сервисного аккаунта.
* Добавлена возможность использования идентификатора для маскированного токена для логов {{ at-name }}.
* Улучшен механизм ротации ключей в [OpenID Connect](https://openid.net/).