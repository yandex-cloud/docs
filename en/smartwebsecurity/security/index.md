---
title: Access management in {{ sws-name }}
description: This section describes the resources for which you can assign a role and the roles existing in the service.
---

# Access management in {{ sws-name }}

In this section, you will learn:

* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have the `smart-web-security.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Which resources you can assign a role for {#resources}

You can assign a role for an [organization](../../organization/), [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), or [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). Roles assigned for an organization, cloud, or folder also apply to security profiles in them.

## Which roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![service-roles-hierarchy](../../_assets/smartwebsecurity/service-roles-hierarchy.svg)

### Service roles {#service-roles}

#### smart-web-security.auditor {#smart-web-security-auditor}

{% include [sws-auditor](../../_roles/smart-web-security/auditor.md) %}

#### smart-web-security.viewer {#smart-web-security-viewer}

{% include [sws-viewer](../../_roles/smart-web-security/viewer.md) %}

#### smart-web-security.user {#smart-web-security-user}

{% include [sws-user](../../_roles/smart-web-security/user.md) %}

#### smart-web-security.editor {#smart-web-security-editor}

{% include [sws-editor](../../_roles/smart-web-security/editor.md) %}

#### smart-web-security.admin {#smart-web-security-admin}

{% include [sws-admin](../../_roles/smart-web-security/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}