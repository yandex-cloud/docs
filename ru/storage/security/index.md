---
title: "Управление доступом в {{ objstorage-full-name }} (S3)"
description: "Управление доступом в сервисе, предоставляющим масштабируемое решение для хранения данных — {{ objstorage-full-name }} (S3). В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе."
---

# Управление доступом в {{ objstorage-name }}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

В консоли {{ yandex-cloud }} или с помощью YC CLI вы можете назначить роль на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud), [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) или отдельный бакет. Назначенные роли будут действовать и на вложенные ресурсы.

Об управлении доступом к бакетам и объектам см. раздел [{#T}](../concepts/acl.md).

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![service-roles-hierarchy](../../_assets/storage/service-roles-hierarchy.svg)

### Сервисные роли {#service-roles}

{% include [storage-viewer](../../_includes/iam/roles/storage-viewer.md) %}

{% include [storage-config-viewer](../../_includes/iam/roles/storage-config-viewer.md) %}

{% include [storage-configurer](../../_includes/iam/roles/storage-configurer.md) %}

{% include [storage-uploader](../../_includes/iam/roles/storage-uploader.md) %}

{% include [storage-editor](../../_includes/iam/roles/storage-editor.md) %}

{% include [storage-admin](../../_includes/iam/roles/storage-admin.md) %}

#### {{ roles-cloud-member }} {#member}

{% include [roles-cloud-member](../../_includes/roles-cloud-member.md) %}

#### {{ roles-cloud-owner }} {#owner}

{% include [roles-cloud-owner](../../_includes/roles-cloud-owner.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}