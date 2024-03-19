---
title: "Access management in {{ metadata-hub-full-name }}"
description: "This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action."
---

# Access management

{% include notitle [preview](../../_includes/note-preview.md) %}

In this section you will learn:
* [Which resources can be assigned a role](#resources).
* [What roles operate in the service](#roles-list).
* [What roles are needed](#choosing-roles) for a particular action.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign a role for {#resources}

You can assign a role to [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), [directory](../../resource-manager/concepts/resources-hierarchy.md#folder) or to a separate [connection](../operations/connection-access.md). These roles will also affect the invested resources.

## Which roles exist in the service {{ connection-manager-name }}{#roles-list}

To manage access rights to connections, you can use the service roles {{ metadata-hub-full-name }} (_service roles_) and the {{ yandex-cloud }} roles (_primitive roles_).

### Service roles for managing connections using {{ connection-manager-full-name }} {#service-roles}

{% include [connection-manager-auditor](../../_includes/iam/roles/connection-manager-auditor.md) %}

{% include [connection-manager-viewer](../../_includes/iam/roles/connection-manager-viewer.md) %}


{% include [connection-manager-editor](../../_includes/iam/roles/connection-manager-editor.md) %}

{% include [connection-manager-admin](../../_includes/iam/roles/connection-manager-admin.md) %}


### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

### What roles do I need {#choosing-roles}

The table below lists which roles are needed to perform the specified action. You can always assign a role that gives greater permissions than the one specified. For example, assign `editor` instead of `viewer`.

| Actions                                 | Required roles              |
|-----------------------------------------|-----------------------------|
| Obtain information about connections    | `connection-manager.viewer` |
| Obtain the list of connections          | `connection-manager.viewer` | 
| Create a connection                     | `connection-manager.editor` | 
| Update a connection                     | `connection-manager.editor` |
| Delete a connection                     | `connection-manager.editor` |
| Configure access rights to a connection | `connection-manager.admin`  |
| Change access rights to a connection    | `connection-manager.admin`  |

## What's next {what-is-next}

* [More details about access rights {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).