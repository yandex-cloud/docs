---
title: Управление доступом в {{ mch-full-name }}
description: "Управление доступом в сервисе создания и управления базами данных ClickHouse. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия."
---

# Управление доступом в {{ mch-name }}


В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

Чтобы разрешить доступ к ресурсам сервиса {{ mch-name }} (кластеры и хосты БД, резервные копии кластеров, базы данных и их пользователи), назначьте пользователю нужные роли на каталог или облако, в котором эти ресурсы лежат.

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-mdb](../../_includes/roles-mdb.md) %}

## Какие роли мне необходимы {#required-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `{{ roles-editor }}` вместо `{{ roles-viewer }}`.

Действие | Методы | Необходимые роли
----- | ----- | -----
**Просмотр информации** | |
Просмотр информации о кластере и связанных ресурсах | `get`, `list` | `{{ roles-viewer }}` на каталог с кластером
Просмотр информации об управляемых базах данных кластера и логах их работы | `get`, `list` | `{{ roles-mdb-viewer }}` на каталог с кластером
Просмотр информации об управляемых базах данных кластера (без доступа к данным и логам работы) | `get`, `list` | `{{ roles-mdb-auditor }}` на каталог с кластером
**Управление ресурсами** | |
Создание кластеров и бэкапов в каталоге | `create` | `{{ roles-mdb-admin }}` или `{{ roles-editor }}` на каталог
Создание кластеров с хостами, для которых включен публичный доступ | `create` | Либо `{{ roles-vpc-public-admin }}` вместе с `{{ roles-mdb-admin }}`, либо `{{ roles-editor }}` на каталог
Изменение, удаление кластеров и связанных ресурсов | `update`, `delete` | `{{ roles-mdb-admin }}` или `{{ roles-editor }}` на каталог с кластером
**Управление доступом к ресурсам** | |
[Добавление](../operations/cluster-users.md#adduser), [изменение](../operations/cluster-users.md#updateuser), [удаление](../operations/cluster-users.md#removeuser) пользователей в кластере | `create`, `update`, `delete` | `{{ roles-editor }}` на каталог с кластером
[Назначение роли](../../iam/operations/roles/grant.md), [отзыв роли](../../iam/operations/roles/revoke.md) и просмотр назначенных ролей на каталог или облако | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `{{ roles-admin }}` на этот каталог или облако

## Что дальше {#whats-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

