---
title: Access management in Yandex Monitoring
description: "Access management in the monitoring service, which allows you to collect and store metrics, as well as display them in the form of graphs on dashboards — Yandex Monitoring. To allow access to the resources of the Yandex Monitoring service, assign the user the necessary roles from the list."
---

# Access management

Yandex.Cloud users can only perform operations on resources that are permitted under the roles assigned to them.
If a user doesn't have any roles assigned, almost all operations are forbidden.

To allow access to resources in the {{ monitoring-full-name }} service, assign the required roles to the user from the list below. Roles can currently only be assigned to parent resources (folders or clouds), whose roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a role to a user:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles {#roles}

The list below shows all roles that are considered when verifying access rights in the {{ monitoring-full-name }} service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### {{ roles-monitoring-viewer }} {#monitoring-viewer}

Users with the `{{ roles-monitoring-viewer }}` role can view created dashboards and widgets, as well as written metrics.

### {{ roles-monitoring-editor }} {#monitoring-editor}

Users with the `{{ roles-monitoring-editor }}` role can create dashboards and widgets, write metrics and manage alerts.

In addition, the `{{ roles-monitoring-editor }}` role includes all permissions of the `{{ roles-monitoring-viewer }}` role.

### {{ roles-monitoring-admin }} {#monitoring-admin}

Users with the `{{ roles-monitoring-admin }}` role can create dashboards and widgets, write metrics and manage alerts.

In addition, the `{{ roles-monitoring-admin }}` role includes all permissions of the `{{ roles-monitoring-editor }}` role.

