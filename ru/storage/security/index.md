---
title: Управление доступом в Yandex Object Storage (S3)
description: "Управление доступом в сервисе, предоставляющим масштабируемое решение для хранения данных — Yandex Object Storage (S3). В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе."
---

# Управление доступом в {{ objstorage-name }}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

В консоли {{ yandex-cloud }} или с помощью YC CLI вы можете назначить роль на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Назначенные роли будут действовать и на вложенные ресурсы.

Об управлении доступом к бакетам и объектам см. раздел [{#T}](../concepts/acl.md).

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![service-roles-hierarchy](../../_assets/storage/service-roles-hierarchy.svg)

### Сервисные роли {#service-roles}

Роль | Разрешения
----- | -----
`resource-manager.clouds.member` | Роль, необходимая для доступа к ресурсам в облаке всем, кроме [владельцев облака](../../resource-manager/concepts/resources-hierarchy.md#owner) и [сервисных аккаунтов](../../iam/concepts/users/service-accounts.md).
`resource-manager.clouds.owner` | Дает полный доступ к облаку и ресурсам в нем. Можно назначить только на облако.
`storage.admin` | Дает право на управление сервисом {{ objstorage-name }}.
`storage.configViewer` | Роль дает права просматривать настройки безопасности бакетов и [объектов](../../storage/concepts/object.md) в них, при этом не дает доступ к данным внутри бакета.
`storage.configurer` | Позволяет управлять настройками [жизненных циклов объектов](../../storage/concepts/lifecycles.md), [хостинга статических сайтов](../../storage/concepts/hosting.md), [политики доступа](../concepts/policy.md) и [CORS](../../storage/concepts/cors.md).
`storage.editor` | Разрешает любые операции с бакетами и объектами в них, кроме изменения настроек [версионирования](../../storage/concepts/versioning.md) и [политики доступа](../../storage/concepts/policy.md), для которых нужна роль `storage.admin`.
`storage.uploader` | Дает право на загрузку объектов в бакет.
`storage.viewer` | Дает доступ на чтение списка бакетов, их настроек и данных в бакетах.

Более подробную информацию о сервисных ролях читайте на странице [{#T}](../../iam/concepts/access-control/roles.md) в документации сервиса {{ iam-full-name }}.

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}
