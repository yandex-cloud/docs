---
title: "Access management in {{ sws-name }}"
description: "This section describes what resources you can assign a role for and what roles the service supports."
---

# Access management in {{ sws-name }}

In this section, you will learn:

* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign roles to {#resources}

You can assign a role to an [organization](../../organization/), [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), or [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). Roles assigned to an organization, cloud, or folder also apply to security profiles in them.

## Which roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![service-roles-hierarchy](../../_assets/smartwebsecurity/service-roles-hierarchy.svg)

### Service roles {#service-roles}

{% include [sws-auditor](../../_includes/iam/roles/sws-auditor.md) %}

{% include [sws-viewer](../../_includes/iam/roles/sws-viewer.md) %}

{% include [sws-user](../../_includes/iam/roles/sws-user.md) %}

{% include [sws-editor](../../_includes/iam/roles/sws-editor.md) %}

{% include [sws-admin](../../_includes/iam/roles/sws-admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}
