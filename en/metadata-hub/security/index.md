---
title: "Access management in {{ metadata-hub-full-name }}"
description: "Access management in {{ metadata-hub-full-name }}. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action."
---

# Access management

{% include notitle [preview](../../_includes/note-preview.md) %}

In this section, you will learn:
* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#choosing-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign a role for {#resources}

You can assign a role for an [organization](../../organization/quickstart.md), [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), or [connection](../concepts/connection-manager.md). The roles assigned for organizations, clouds, or folders also apply to nested resources.

You can assign a role for a connection in the management console.

## Roles existing in {{ connection-manager-name }} {#roles-list}

You can use {{ metadata-hub-full-name }} roles (_service roles_) and {{ yandex-cloud }} roles (_primitive roles_) to manage connection access permissions.

### Service roles for managing connections using {{ connection-manager-full-name }} {#service-roles}

With {{ connection-manager-full-name }} service roles, you can view non-secret connection data and manage connections. You can view secret connection data, such as DB passwords, in [{{ lockbox-full-name }}](../../lockbox/index.yaml). To do this, you will also need the `lockbox.payloadViewer` [role](../../lockbox/security/index.md#lockbox-payloadViewer).

#### connection-manager.auditor {#connection-manager-auditor}

{% include [connection-manager.auditor](../../_roles/connection-manager/auditor.md) %}

#### connection-manager.viewer {#connection-manager-viewer}

{% include [connection-manager.viewer](../../_roles/connection-manager/viewer.md) %}


#### connection-manager.editor {#connection-manager-editor}

{% include [connection-manager.editor](../../_roles/connection-manager/editor.md) %}

#### connection-manager.admin {#connection-manager-admin}

{% include [connection-manager.admin](../../_roles/connection-manager/admin.md) %}



### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

### What roles do I need {#choosing-roles}

The table below lists the roles needed to perform a particular action. You can always assign a role granting more permissions than the role specified. For example, you can assign the `editor` role instead of `viewer`.

| Action | Required roles |
|-----------------------------------------|-----------------------------|
| Getting information about connections | `connection-manager.viewer` |
| Getting a list of connections | `connection-manager.viewer` |
| Creating a connection | `connection-manager.editor` |
| Editing a connection | `connection-manager.editor` |
| Deleting a connection | `connection-manager.editor` |
| Setting connection access permissions | `connection-manager.admin` |
| Changing connection access permissions | `connection-manager.admin` |

## What's next {what-is-next}

* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).