---
title: Управление доступом в {{ backup-full-name }} (S3)
description: Управление доступом в сервисе, предоставляющим решение для резервного копирования данных в {{ yandex-cloud }} — {{ backup-full-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе.
---

# Управление доступом в {{ backup-name }}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `backup.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

В консоли {{ yandex-cloud }} или с помощью YC CLI вы можете назначить роль на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Назначенные роли будут действовать и на вложенные ресурсы.

## Какие роли действуют в сервисе {#roles-list}

### Сервисные роли {#service-roles}

#### backup.viewer {#backup-viewer}

{% include [backup.viewer](../../_roles/backup/viewer.md) %}

#### backup.editor {#backup-editor}

{% include [backup.editor](../../_roles/backup/editor.md) %}

#### backup.admin {#backup-admin}

{% include [backup.admin](../../_roles/backup/admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}