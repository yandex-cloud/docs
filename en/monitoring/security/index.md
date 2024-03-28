---
title: "Access management in {{ monitoring-full-name }}"
description: "Access management in {{ monitoring-full-name }}, a service for collecting and storing metrics and using them to build charts on dashboards. To grant access to {{ monitoring-full-name }} resources, assign relevant roles from the list to the user."
---

# Access management in {{ monitoring-name }}

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. If a user does not have any roles assigned, almost all operations are forbidden.

To allow access to {{ monitoring-full-name }} resources, assign the required roles from the list below to the Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), or [system group](../../iam/concepts/access-control/system-group.md).

Currently, a role can only be assigned to a parent resource (folder or cloud). Roles are inherited by nested resources.

Only users with the `admin`, `resource-manager.clouds.owner`, or `organization-manager.organizations.owner` role for a resource can assign roles for this resource.

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Which roles exist in the service {#roles-list}

The list below shows all roles that are considered when verifying access rights in the {{ monitoring-full-name }} service.

### Service roles {#service-roles}

#### monitoring.viewer {#monitoring-viewer}

{% include [monitoring.viewer](../../_roles/monitoring/viewer.md) %}

#### monitoring.editor {#monitoring-editor}

{% include [monitoring.editor](../../_roles/monitoring/editor.md) %}

#### monitoring.admin {#monitoring-admin}

{% include [monitoring.admin](../../_roles/monitoring/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}
