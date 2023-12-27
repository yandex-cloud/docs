---
title: "Access management in {{ objstorage-full-name }} (S3)"
description: "Access management in {{ objstorage-full-name }} (S3), a service for scalable data storage. This section describes the resources for which you can assign a role and the roles existing in the service."
---

# Access management in {{ objstorage-name }}

In this section, you will learn:

* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign a role for {#resources}

Using the {{ yandex-cloud }} console or the YC CLI, you can assign a role for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), or an individual bucket. These assigned roles will also apply to nested resources.

For information about managing access to buckets and objects, see [{#T}](../concepts/acl.md).

## Which roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![service-roles-hierarchy](../../_assets/storage/service-roles-hierarchy.svg)

### Service roles {#service-roles}

{% include [storage-viewer](../../_includes/iam/roles/storage-viewer.md) %}

{% include [storage-config-viewer](../../_includes/iam/roles/storage-config-viewer.md) %}

{% include [storage-configurer](../../_includes/iam/roles/storage-configurer.md) %}

{% include [storage-uploader](../../_includes/iam/roles/storage-uploader.md) %}

{% include [storage-editor](../../_includes/iam/roles/storage-editor.md) %}

{% include [storage-admin](../../_includes/iam/roles/storage-admin.md) %}


### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}