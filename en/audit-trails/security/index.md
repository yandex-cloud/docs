---
title: Access management in {{ at-full-name }}
description: Access management in {{ at-name }}, a trail management service. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action.
---

# Access management {{ at-name }}

In this section, you will learn:

* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).

{% include notitle [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have the `audit-trails.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can assign a role for a [trail](../concepts/trail.md) via the {{ yandex-cloud }} [CLI](../../cli/cli-ref/audit-trails/cli-ref/trail/add-access-binding.md) or [API](../api-ref/authentication.md).

## Which roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/audit-trails/at-role-diagram.svg)

### Service roles {#service-roles}

#### audit-trails.auditor {#at-auditor}

{% include [audit-trails.auditor](../../_roles/audit-trails/auditor.md) %}

#### audit-trails.viewer {#at-viewer}

{% include [audit-trails.viewer](../../_roles/audit-trails/viewer.md) %}

#### audit-trails.editor {#at-editor}

{% include [audit-trails.editor](../../_roles/audit-trails/editor.md) %}

#### audit-trails.admin {#at-admin}

{% include [audit-trails.admin](../../_roles/audit-trails/admin.md) %}

#### audit-trails.configViewer {#at-configviewer}

{% include [audit-trails.configviewer](../../_roles/audit-trails/configViewer.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## What roles do I need {#choosing-roles}

The table shows actions and minimum roles required to perform them. You can always assign a role offering more permissions than the one specified in the table. For example, you can assign `audit-trails.editor` instead of `audit-trails.configViewer`.

Action | User role
----- | -----
Viewing information about a trail | `audit-trails.auditor` 
Collecting and viewing audit events in a trail | `audit-trails.viewer` 
Creating a trail | `audit-trails.editor` 
Editing a trail | `audit-trails.editor` 
Deleting a trail | `audit-trails.editor` 
Managing roles of other users for a trail | `audit-trails.admin`


## What's next {#whats-next}

* Review the [audit log](../concepts/format.md) structure.
* Learn how to create a trail that [loads logs to the required destination](../operations/create-trail.md).
