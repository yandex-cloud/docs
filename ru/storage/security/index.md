---
title: "Управление доступом в {{ objstorage-full-name }} (S3)"
description: "Управление доступом в сервисе, предоставляющим масштабируемое решение для хранения данных — {{ objstorage-full-name }} (S3). В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе."
---

# Управление доступом с помощью {{ iam-full-name }}

{% include [full-overview](../../_includes/storage/security/full-overview.md) %}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `storage.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

В консоли {{ yandex-cloud }} или с помощью YC CLI вы можете назначить роль на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud), [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) или отдельный бакет. Назначенные роли будут действовать и на вложенные ресурсы.

О том, как управлять доступом к бакетам и объектам в них, см. раздел [{#T}](../concepts/acl.md).

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![service-roles-hierarchy](../../_assets/storage/service-roles-hierarchy.svg)

### Сервисные роли {#service-roles}

#### storage.viewer {#storage-viewer}

{% include [storage-viewer](../../_roles/storage/viewer.md) %}

#### storage.configViewer {#storage-config-viewer}

{% include [storage-configviewer](../../_roles/storage/configViewer.md) %}

#### storage.configurer {#storage-configurer}

{% include [storage-configurer](../../_roles/storage/configurer.md) %}

#### storage.uploader {#storage-uploader}

{% include [storage-uploader](../../_roles/storage/uploader.md) %}

#### storage.editor {#storage-editor}

{% include [storage-editor](../../_roles/storage/editor.md) %}

#### storage.admin {#storage-admin}

{% include [storage-admin](../../_roles/storage/admin.md) %}


### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}


## См. также {#see-also}

* [{#T}](../operations/buckets/iam-access.md)
