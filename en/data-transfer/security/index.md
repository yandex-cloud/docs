---
title: Access management in Yandex Data Transfer
description: "Access management in the service for transferring data between storages — Yandex Data Transfer. The section describes which roles are required for this or that action, which resources can be assigned a role, which roles operate in the service."
---

# Access management in {{ data-transfer-name }}

To use the service, log in to the management console with your [Yandex account](../../iam/concepts/index.md#passport) or [federated account](../../iam/concepts/index.md#saml-federation).

In this section, you'll learn:

* [What roles are required](#choosing-roles) for particular actions.
* [What resources you can assign roles to](#resources).
* [What roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Roles required {#required-roles}

To use the service, you need the [role](../../iam/concepts/access-control/roles.md) `of editor` or higher for the folder where projects are created. With the `viewer` role, you can only view the list of projects and the contents of files that were downloaded.

You can always assign a role granting more permissions than the role specified. For example, assign the `admin` role instead of `editor`.

## What resources you can assign roles to {#resources}

You can assign roles for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). Cloud roles also apply to nested folders.

## What roles exist in the service {#roles-list}

* Service roles:
   * `data-transfer.viewer`: Lets you view information only about {{ data-transfer-name }} resources.
   * {% include [resource-manager.clouds.owner](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.owner.md) %}
   * {% include [resource-manager.clouds.member](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.member.md) %}
* Primitive roles:
   * {% include [viewer](../../_includes/iam/roles/short-descriptions/viewer.md) %}
   * {% include [editor](../../_includes/iam/roles/short-descriptions/editor.md) %}
   * {% include [admin](../../_includes/iam/roles/short-descriptions/admin.md) %}

#### What's next {#what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [For more information about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

