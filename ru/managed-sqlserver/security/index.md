---
title: Доступ к {{ mms-name }}
description: Чтобы разрешить доступ к ресурсам сервиса {{ mms-name }} (кластеры и хосты БД, резервные копии кластеров, базы данных и их пользователи), назначьте пользователю нужные роли на каталог или облако, в котором эти ресурсы лежат.
keywords:
  - доступ
  - access
  - настройка доступа
  - доступ {{ MS }}
  - ms sql server
  - {{ MS }}
---

# Управление доступом в {{ mms-name }}

{% if audience != "internal"%}

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

Чтобы разрешить доступ к ресурсам сервиса {{ mms-name }} (кластеры и хосты БД, резервные копии кластеров, базы данных и их пользователи), назначьте пользователю нужные роли на каталог или облако, в котором эти ресурсы лежат.

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-mdb](../../_includes/roles-mdb.md) %}

## Какие роли мне необходимы {#required-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `editor` вместо `viewer`.

Действие | Методы | Необходимые роли
--- | --- | ---
**Просмотр информации** | |
Просмотр информации о кластере и связанных ресурсах | `get`, `list` | `viewer` на каталог с кластером
**Управление ресурсами** | |
Создание кластеров и бэкапов в каталоге | `create` | `mdb.admin` или `editor` на каталог
Создание кластеров с хостами, для которых включен публичный доступ | `create` | Либо `vpc.publicAdmin` вместе с `mdb.admin`, либо `editor` на каталог
Изменение, удаление кластеров и связанных ресурсов | `update`, `delete` | `mdb.admin` или `editor` на каталог с кластером
**Управление доступом к ресурсам** | |
[Добавление](../operations/cluster-users.md#adduser), [изменение](../operations/cluster-users.md#updateuser), [удаление](../operations/cluster-users.md#removeuser) пользователей в кластере | `create`, `update`, `delete` | `editor` на каталог с кластером
[Управление доступом к базам данных](../operations/grant.md) в кластере | `grantPermission`, `revokePermission` | `editor` на каталог с кластером
[Назначение роли](../../iam/operations/roles/grant.md), [отзыв роли](../../iam/operations/roles/revoke.md) и просмотр назначенных ролей на каталог или облако | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` на этот каталог или облако

## Что дальше {#whats-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

{% else %}

{% include [abc-roles](../../_includes/mdb/internal/abc-roles.md) %}

{% endif %}
