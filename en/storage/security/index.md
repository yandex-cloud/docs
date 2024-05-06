---
title: "Access management in {{ objstorage-full-name }} (S3)"
description: "Access management in {{ objstorage-full-name }} (S3), a service for scalable data storage. This section describes the resources for which you can assign a role and the roles existing in the service."
---

# Managing access with {{ iam-full-name }}

{% include [full-overview](../../_includes/storage/security/full-overview.md) %}

In this section, you will learn:

* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign a role for {#resources}

Using the {{ yandex-cloud }} console or the YC CLI, you can assign a role for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), or an individual bucket. These assigned roles will also apply to nested resources.

To learn how to manage access to buckets and objects in them, see [{#T}](../concepts/acl.md).

## Which roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![service-roles-hierarchy](../../_assets/storage/service-roles-hierarchy.svg)

### Service roles {#service-roles}

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


### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}


## See also {#see-also}

* [{#T}](../operations/buckets/iam-access.md)
