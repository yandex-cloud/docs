---
title: Access management in Yandex Data Transfer
description: "Access management in the service for transferring data between storages — Yandex Data Transfer. The section describes which roles are required for this or that action, which resources can be assigned a role, which roles operate in the service."
---

# Access management in {{ data-transfer-name }}

In this section, you'll learn:

* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#required-roles) for particular actions.

{% if audience != "internal" %}

To use the service, log in to the management console with a [Yandex account](../../iam/concepts/index.md#passport) or [federated account](../../iam/concepts/index.md#saml-federation).

{% endif %}

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to {#resources}

{% if audience != "internal" %}

You can assign a role for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) or [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). Cloud roles also apply to nested folders.

{% else %}

You can assign a role for a cloud or folder. Cloud roles also apply to nested folders.

{% endif %}

## What roles exist in the service {#roles-list}

{% include [data-transfer-viewer](../../_includes/roles-data-transfer-viewer.md) %}

{% include [data-transfer-privateadmin](../../_includes/roles-data-transfer-privateadmin.md) %}

{% include [data-transfer-admin](../../_includes/roles-data-transfer-admin.md) %}

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

## Roles required {#required-roles}

{% if audience != "internal" %}

To use the service, you need the [role](../../iam/concepts/access-control/roles.md) of `editor` or higher to the folder that projects are being created in. With the `viewer` role, you can only view the list of projects and the contents of files that were downloaded.

{% else %}

To use the service, you need the role of `editor` or higher to the folder that projects are being created in. With the `viewer` role, you can only view the list of projects and the contents of files that were downloaded.

{% endif %}

You can always assign a role granting more permissions than the role specified. For example, assign the `admin` role instead of `editor`.

{% if audience != "internal" %}

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [More information on inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

{% endif %}
