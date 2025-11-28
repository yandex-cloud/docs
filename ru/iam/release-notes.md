---
title: История изменений в {{ iam-full-name }}
description: В разделе представлена история изменений сервиса {{ iam-name }}.
---


# История изменений в {{ iam-full-name }}

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}

## Октябрь 2025 {#october-2025}

Добавлены [роли](roles-reference.md):

{% cut "Управляемые базы данных" %}

  Роль | Описание
  --- | ---
  `mdb.restorer` | Позволяет восстанавливать кластеры управляемых баз данных из резервных копий, а также предоставляет доступ к чтению информации из кластеров и к логам их работы.

{% endcut %}

{% cut "{{ org-full-name }}" %}

  Роль | Описание
  --- | ---
  `organization-manager.groups.externalConverter` | Позволяет добавлять в группы пользователей {{ org-name }} атрибут с идентификатором внешней группы при выполнении синхронизации с группами пользователей в каталоге Active Directory или другом внешнем источнике.
  `organization-manager.groups.externalCreator` | Позволяет создавать группы пользователей {{ org-name }} при выполнении синхронизации с группами пользователей в каталоге Active Directory или другом внешнем источнике.
  `organization-manager.userpools.syncAgent` | Позволяет выполнять синхронизацию пользователей и групп {{ org-name }} с пользователями и группами в каталоге Active Directory или другом внешнем источнике.

{% endcut %}

{% cut "{{ mkf-full-name }}" %}

  Роль | Описание
  --- | ---
  `managed-kafka.restorer` | Позволяет восстанавливать кластеры {{ KF }} из резервных копий, просматривать информацию о кластерах и логи их работы, а также данные о квотах и операциях с ресурсами сервиса {{ mkf-name }}.

{% endcut %}

{% cut "{{ mch-full-name }}" %}

  Роль | Описание
  --- | ---
  `managed-clickhouse.restorer` | Позволяет восстанавливать кластеры {{ CH }} из резервных копий, просматривать информацию о кластерах {{ CH }} и логи их работы, а также данные о квотах и операциях с ресурсами сервиса {{ mch-name }}.

{% endcut %}


{% cut "{{ mmy-full-name }}" %}

  Роль | Описание
  --- | ---
  `managed-mysql.restorer` | Позволяет восстанавливать кластеры {{ MY }} из резервных копий, просматривать информацию о кластерах, хостах, базах данных и пользователях {{ MY }}, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса {{ mmy-name }}.

{% endcut %}

{% cut "{{ mos-full-name }}" %}

  Роль | Описание
  --- | ---
  `managed-opensearch.restorer` | Позволяет восстанавливать кластеры {{ OS }} из резервных копий, просматривать информацию о кластерах {{ OS }}, логи их работы, а также информацию о квотах и операциях с ресурсами сервиса {{ mos-name }}.

{% endcut %}

{% cut "{{ mpg-full-name }}" %}

  Роль | Описание
  --- | ---
  `managed-postgresql.restorer` | Позволяет восстанавливать кластеры {{ PG }} из резервных копий, просматривать информацию о кластерах, хостах, базах данных и пользователях {{ PG }}, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса {{ mpg-name }}.

{% endcut %}

{% cut "{{ mspqr-full-name }}" %}

  Роль | Описание
  --- | ---
  `managed-spqr.restorer` | Позволяет восстанавливать кластеры {{ SPQR }} из резервных копий, а также просматривать информацию о кластерах, хостах, базах данных и пользователях в кластерах {{ SPQR }}, логи работы кластеров, данные о квотах и операциях с ресурсами сервиса {{ mspqr-name }}.

{% endcut %}


{% cut "{{ mrd-full-name }}" %}

  Роль | Описание
  --- | ---
  `managed-redis.restorer` | Позволяет восстанавливать кластеры {{ VLK }} из резервных копий, а также просматривать информацию о хостах и кластерах {{ VLK }}, логи их работы, данные о квотах и операциях с ресурсами сервиса {{ mrd-name }}.

{% endcut %}

{% cut "{{ mgp-full-name }}" %}

  Роль | Описание
  --- | ---
  `managed-greenplum.restorer` | Позволяет восстанавливать кластеры {{ GP }} из резервных копий, просматривать информацию о кластерах и хостах {{ GP }}, логи их работы, а также данные о квотах и операциях с ресурсами сервиса {{ mgp-name }}.

{% endcut %}

{% cut "{{ mmg-full-name }}" %}

  Роль | Описание
  --- | ---
  `managed-mongodb.restorer` | Позволяет восстанавливать кластеры {{ MG }} из резервных копий, просматривать информацию о кластерах, хостах, шардах, базах данных и пользователях {{ MG }}, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса {{ mmg-name }}.

{% endcut %}

## III квартал 2025 {#q3-2025}

* [Добавлена](../organization/operations/view-subject-access-bindings.md) возможность посмотреть список доступов субъекта с помощью [CLI](../cli/cli-ref/iam/cli-ref/access-analyzer/) и [API](../iam/api-ref/AccessAnalyzer/). {{ tag-con }} {{ tag-cli }} {{ tag-api }}
* Реализовано управление секретами OAuth-клиентов с помощью [CLI](../cli/cli-ref/iam/cli-ref/oauth-client-secret/) и [API](../iam/api-ref/OAuthClientSecret/). {{ tag-cli }} {{ tag-api }}
* В [CLI](../cli/cli-ref/iam/cli-ref/oauth-client/) и [API](../iam/api-ref/OAuthClient/) добавлена группа команд для управления OAuth-клиентами. {{ tag-cli }} {{ tag-api }}

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
* Добавлена возможность отзывать [IAM-токен](./concepts/authorization/iam-token.md) с помощью [{{ yandex-cloud }} CLI](../cli/cli-ref/iam/cli-ref/revoke-token.md). {{ tag-cli }}
* Появились [системные группы](./concepts/access-control/system-group.md) `All users in organization X` и `All users in federation N`.
* Добавлен источник данных {{ TF }}, который позволяет получить идентификатор [сервисного агента](./concepts/service-control.md#service-agent). {{ tag-tf }}


## II квартал 2024 {#q2-2024}

* Добавлено отображение даты последнего использования ключей доступа сервисных аккаунтов. Информация доступна на странице сервисного аккаунта в [консоли управления]({{ link-console-main }}), а также в поле `last_used_at` при вызове методов управления ключами доступа через API. {{ tag-con }} {{ tag-api }}


## I квартал 2024 {#q1-2024}

* Добавлен компонент [{{ sts-name }}](./concepts/authorization/sts.md) для получения временных ключей доступа, совместимых с [AWS S3 API](../storage/s3/index.md). Функциональность находится на [стадии Preview](../overview/concepts/launch-stages.md). {{ tag-cli }} {{ tag-api }}
* Добавлена поддержка аутентификации OAuth-клиентов с помощью аутентификации токена сервисного аккаунта.
* Добавлена возможность использования идентификатора для маскированного токена для логов {{ at-name }}.
* Улучшен механизм ротации ключей в [OpenID Connect](https://openid.net/).