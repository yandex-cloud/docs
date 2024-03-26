---
title: "Access management in {{ at-full-name }}"
description: "Access management in the {{ at-name }} service for managing trails. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action."
---

# Access management {{ at-name }}

In this section, you will learn:

* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).

{% include notitle [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign a role for {#resources}

In the {{ yandex-cloud }} console, you can assign a role for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). Roles assigned for clouds or folders also apply to the trails in them.

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

## What roles do I need {#choosing-roles}

The table shows actions and minimum roles required to perform them. You can always assign a role granting broader access rights than the role from the table. For example, instead of `audit-trails.configViewer`, you can assign the `audit-trails.editor` role.

| Action | Role |
----- | -----
| Viewing information about a trail | `audit-trails.auditor` |
| Collecting and viewing audit events in a trail | `audit-trails.viewer` |
| Creating a trail | `audit-trails.editor` |
| Editing a trail | `audit-trails.editor` |
| Deleting a trail | `audit-trails.editor` |
| Managing roles of other users for a trail | `audit-trails.admin` |


## What's next {#whats-next}

* Review the [audit log](../concepts/format.md) structure.
* See an example of [uploading audit logs to {{ cloud-logging-name }}](../operations/export-cloud-logging.md).
