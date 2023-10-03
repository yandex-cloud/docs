---
title: "Access management in {{ monitoring-full-name }}"
description: "Access management in {{ monitoring-full-name }}, a service for collecting and storing metrics and using them to build charts on dashboards. To grant access to {{ monitoring-full-name }} resources, assign relevant roles from the list to the user."
---

# Access management in {{ monitoring-name }}


{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. If a user does not have any roles assigned, almost all operations are forbidden.

To allow access to {{ monitoring-full-name }} resources, assign the Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), or [system group](../../iam/concepts/access-control/system-group.md) the required roles from the list below.

Currently, a role can only be assigned to a parent resource (folder or cloud). Roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Which roles exist in the service {#roles-list}

The list below shows all roles that are considered when verifying access rights in the {{ monitoring-full-name }} service.

### Service roles {#service-roles}

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

#### {{ roles-monitoring-viewer }} {#monitoring-viewer}

Users with the `{{ roles-monitoring-viewer }}` role can view created dashboards and widgets, as well as uploaded metrics.

#### {{ roles-monitoring-editor }} {#monitoring-editor}

Users with the `{{ roles-monitoring-editor }}` role can create dashboards and widgets as well as upload metrics and manage alerts.

The `{{ roles-monitoring-editor }}` role also includes all permissions of the `{{ roles-monitoring-viewer }}` role.

#### {{ roles-monitoring-admin }} {#monitoring-admin}

Users with the `{{ roles-monitoring-admin }}` role can create dashboards and widgets as well as upload metrics and manage alerts.

The `{{ roles-monitoring-admin }}` role also includes all permissions of the `{{ roles-monitoring-editor }}` role.

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}


