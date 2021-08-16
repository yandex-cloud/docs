---
title: Access management in Cloud Functions
description: "Access management in the service where you can launch the applications without creating and maintaining virtual machines — Cloud Functions. The section describes which resources can be assigned a role, which roles act in the service."
---

# Access management in {{ sf-name }}

In this section, you'll learn:

* [What resources you can assign roles to](#resources).
* [What roles exist in the service](#roles).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to {#resources}

You can assign roles for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), and a [function](../concepts/function.md). Roles assigned to a cloud or folder also affect the functions that are located there.

## What roles exist in the service {#roles}

The list below shows all roles that are considered when verifying access rights in the {{ sf-name }} service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

{% include [functions-roles-invoker](../../_includes/roles-functions-invoker.md) %}

{% include [functions-roles-admin](../../_includes/roles-functions-admin.md) %}

### {{ roles-viewer }} {#viewer}

The user with the `{{ roles-viewer }}` role can view information about resources, such as the list of functions or their versions and the function execution log.

### {{ roles-editor }} {#editor}

The user with the `{{ roles-editor }}` role can manage functions and their versions, such as creating or deleting a version or editing information about a function.

The `{{ roles-editor }}` role also includes all `{{ roles-viewer }}` role permissions.

### {{ roles-admin }} {#admin}

The user with the `{{ roles-admin }}` role can manage access rights to resources, such as allow other users to invoke functions or work with their versions.

The `{{ roles-admin }}` role also includes all `{{ roles-editor }}` role permissions.

