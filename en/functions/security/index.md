---
title: "Access management in {{ sf-name }}"
description: "Access management in {{ sf-name }}, a service for running applications without creating and maintaining VM instances. This section describes what resources you can assign a role for and what roles the service supports."
---

# Access management in {{ sf-name }}

In this section, you'll learn:

* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to {#resources}

Roles can be assigned for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), and [function](../concepts/function.md). Roles assigned to a cloud or folder also affect the functions that are located there.

## What roles exist in the service {#roles}

The list below shows all roles that are considered when verifying access rights in the {{ sf-name }} service.

{% include [functions-roles-viewer](../../_includes/roles-functions-viewer.md) %}

{% include [functions-roles-auditor](../../_includes/roles-functions-auditor.md) %}

{% include [functions-roles-invoker](../../_includes/roles-functions-invoker.md) %}

{% include [functions-roles-editor](../../_includes/roles-functions-editor.md) %}

{% include [functions-roles-mdbproxy](../../_includes/roles-functions-mdbproxy.md) %}

{% include [functions-roles-admin](../../_includes/roles-functions-admin.md) %}

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### {{ roles-viewer }} {#viewer}

The user with the `{{ roles-viewer }}` role can view information about resources, such as the list of functions or their versions and the function execution log.

### {{ roles-editor }} {#editor}

A user with the `{{ roles-editor }}` role can manage functions and their versions, such as creating or deleting a version or editing information about a function.

The `{{ roles-editor }}` role includes all permissions of the `{{ roles-viewer }}` role.

### {{ roles-admin }} {#admin}

A user with the `{{ roles-admin }}` role can manage access rights to resources, such as allow other users to invoke functions or work with their versions.

The `{{ roles-admin }}` role includes all permissions of the `{{ roles-editor }}` role.
