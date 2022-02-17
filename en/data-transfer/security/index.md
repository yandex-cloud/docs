---
title: Access management in Yandex Data Transfer
description: "Access management in the service for transferring data between storages — Yandex Data Transfer. The section describes which roles are required for this or that action, which resources can be assigned a role, which roles operate in the service."
---
# Access management in {{ data-transfer-name }}

In this section, you'll learn:

* [What resources you can assign roles to](#resources).
* [What roles exist in the service](#roles-list).
* [What roles are required](#required-roles) for particular actions.

To use the service, log in to the management console with your [Yandex account](../../iam/concepts/index.md#passport) or [federated account](../../iam/concepts/index.md#saml-federation).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to {#resources}

You can assign roles for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). Cloud roles also apply to nested folders.

## What roles exist in the service {#roles-list}

### Service roles {#service-roles}

| Role | Permissions |
| ----- | ----- |
| `data-transfer.admin` | Enables you to manage (create, modify, and delete) [endpoints](../concepts/index.md#endpoint) and [transfers](../concepts/index.md#transfer) as well as activate and deactivate transfers. |
| `data-transfer.viewer` | Only enables you to view information about the resources of the {{ data-transfer-name }} service. |

### Roles of other {{ yandex-cloud }} services {#other-roles}

{% include [roles-resource-manager](../../_includes/roles-resource-manager.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## What roles do I need {#required-roles}

To use the service, you need the [role](../../iam/concepts/access-control/roles.md) `editor` or higher to the folder where [transfers](../concepts/index.md#transfer) and [endpoints](../concepts/index.md#endpoint) are created. With the `viewer` role, you can only view the list of existing transfers and endpoints.

You can always assign a role granting more permissions than the role specified. For example, assign the `admin` role instead of `editor`.

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [For more information about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

