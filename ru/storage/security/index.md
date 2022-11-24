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

В консоли {{ yandex-cloud }} или с помощью YC CLI вы можете назначить роль на {% if audience != "internal" %}[облако](../../resource-manager/concepts/resources-hierarchy.md#cloud){% else %}облако{% endif %} или {% if audience != "internal" %}[каталог](../../resource-manager/concepts/resources-hierarchy.md#folder){% else %}каталог{% endif %}. Назначенные роли будут действовать и на вложенные ресурсы.

Об управлении доступом к бакетам и объектам см. раздел [{#T}](../concepts/acl.md).

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![service-roles-hierarchy](../../_assets/storage/service-roles-hierarchy.svg)

### storage.admin {#storage-admin}

{% include notitle [roles-storage-admin](../../_includes/roles-storage-admin.md) %}

### storage.configViewer {#storage-config-viewer}

{% include notitle [roles-storage-config-viewer](../../_includes/roles-storage-config-viewer.md) %}

### storage.configurer {#storage-configurer}

{% include notitle [roles-storage-configurer](../../_includes/roles-storage-configurer.md) %}

### storage.editor {#storage-editor}

{% include notitle [roles-storage-editor](../../_includes/roles-storage-editor.md) %}

### storage.uploader {#storage-uploader}

{% include notitle [roles-storage-uploader](../../_includes/roles-storage-uploader.md) %}

### storage.viewer {#storage-viewer}

{% include notitle [roles-storage-viewer](../../_includes/roles-storage-viewer.md) %}

### {{ roles-cloud-member }} {#resmgr-clouds-member}

{% include [roles-cloud-member](../../_includes/roles-cloud-member.md) %}

### {{ roles-cloud-owner }} {#resmgr-clouds-owner}

{% include [roles-cloud-owner](../../_includes/roles-cloud-owner.md) %}

### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../_includes/roles-viewer.md) %}

### {{ roles-editor }} {#editor}

{% include [roles-editor](../../_includes/roles-editor.md) %}

### {{ roles-admin }} {#admin}

{% include [roles-admin](../../_includes/roles-admin.md) %}
