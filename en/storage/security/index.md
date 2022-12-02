---
title: Access management in {{ objstorage-full-name }} (S3)
description: "Access management in the service providing a scalable storage solution — {{ objstorage-full-name }} (S3). The section describes which resources can be assigned a role, which roles are active in the service."
---

# Access management in {{ objstorage-name }}

In this section, you'll learn:

* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to {#resources}

Using the {{ yandex-cloud }} console or the YC CLI, you can assign a role to a {% if audience != "internal" %}[cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud){% else %}cloud{% endif %} or {% if audience != "internal" %}[folder](../../resource-manager/concepts/resources-hierarchy.md#folder){% else %}folder{% endif %}. These assigned roles will also apply to nested resources.

For information about managing access to buckets and objects, see [{#T}](../concepts/acl.md).

## What roles exist in the service {#roles-list}

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
