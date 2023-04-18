---
title: "Access management in {{ objstorage-full-name }} (S3)"
description: "Access management in {{ objstorage-full-name }} (S3), a service for scalable data storage. This section describes what resources you can assign a role for and what roles the service supports."
---

# Access management in {{ objstorage-name }}

In this section, you will learn:

* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign roles to {#resources}

Using the {{ yandex-cloud }} console or the YC CLI, you can assign a role to a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) or [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). These assigned roles will also apply to nested resources.

For information about managing access to buckets and objects, see [{#T}](../concepts/acl.md).

## Which roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![service-roles-hierarchy](../../_assets/storage/service-roles-hierarchy.svg)

{% include [storage-viewer](../../_includes/iam/roles/storage-viewer.md) %}

{% include [storage-config-viewer](../../_includes/iam/roles/storage-config-viewer.md) %}

{% include [storage-configurer](../../_includes/iam/roles/storage-configurer.md) %}

{% include [storage-uploader](../../_includes/iam/roles/storage-uploader.md) %}

{% include [storage-editor](../../_includes/iam/roles/storage-editor.md) %}

{% include [storage-admin](../../_includes/iam/roles/storage-admin.md) %}

### {{ roles-cloud-member }} {#member}

{% include [roles-cloud-member](../../_includes/roles-cloud-member.md) %}

### {{ roles-cloud-owner }} {#owner}

{% include [roles-cloud-owner](../../_includes/roles-cloud-owner.md) %}

### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../_includes/roles-viewer.md) %}

### {{ roles-editor }} {#editor}

{% include [roles-editor](../../_includes/roles-editor.md) %}

### {{ roles-admin }} {#admin}

{% include [roles-admin](../../_includes/roles-admin.md) %}
