---
title: "Access management in {{ sf-name }}"
description: "Access management in {{ sf-name }}, a service for running applications without creating and maintaining VM instances. This section describes what resources you can assign a role for and what roles the service supports."
---

# Access management in {{ sf-name }}

In this section, you will learn:

* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign roles to {#resources}

Roles can be assigned for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), and [function](../concepts/function.md). Roles assigned to a cloud or folder also affect the functions that are located there.

## Which roles exist in the service {#roles-list}

The list below shows all roles that are considered when verifying access rights in the {{ sf-name }} service.

### Service roles {#service-roles}

{% include [functions-roles-viewer](../../_includes/roles-functions-viewer.md) %}

{% include [functions-roles-auditor](../../_includes/roles-functions-auditor.md) %}

{% include [functions-roles-invoker](../../_includes/roles-functions-invoker.md) %}

{% include [functions-roles-editor](../../_includes/roles-functions-editor.md) %}


{% include [functions-roles-mdbproxy](../../_includes/roles-functions-mdbproxy.md) %}


{% include [functions-roles-admin](../../_includes/roles-functions-admin.md) %}

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}
