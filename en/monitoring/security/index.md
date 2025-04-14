---
title: Access management in {{ monitoring-full-name }}
description: How access management works in {{ monitoring-full-name }}, a service for collecting and storing metrics and using them to build charts on dashboards. To allow a user access to {{ monitoring-full-name }} resources, assign them the roles from the list below.
---

# Access management in {{ monitoring-name }}

Working with {{ yandex-cloud }} resources, users can only perform operations allowed by the roles assigned to them. With no roles assigned, a user cannot perform most operations.

To allow a user or group, e.g., Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated user](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md), access to {{ monitoring-full-name }} resources, assign them the roles from the list below. 

Currently, a role can only be assigned for a folder or cloud and it is inherited by nested resources.

{% include [roles-assign](../../_includes/iam/roles-assign.md) %}

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a role to a user:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles this service has {#roles-list}

The list below shows {{ monitoring-full-name }} roles.

### Service roles {#service-roles}

#### monitoring.viewer {#monitoring-viewer}

{% include [monitoring.viewer](../../_roles/monitoring/viewer.md) %}

#### monitoring.editor {#monitoring-editor}

{% include [monitoring.editor](../../_roles/monitoring/editor.md) %}

#### monitoring.admin {#monitoring-admin}

{% include [monitoring.admin](../../_roles/monitoring/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}