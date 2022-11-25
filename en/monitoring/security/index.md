---
title: Access management in {{ monitoring-full-name }}
description: "Access management in the monitoring service, which allows you to collect and store metrics, as well as display them in the form of graphs on dashboards — {{ monitoring-full-name }}. To allow access to the resources of the Yandex Monitoring service, assign the user the necessary roles from the list."
---

# Access management in {{ monitoring-name }}

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. If a user doesn't have any roles assigned, almost all operations are forbidden.

To allow access to resources in {{ monitoring-full-name }}, assign the required roles to the user from the list below.

Currently, a role can only be assigned to a parent resource (folder or cloud). Roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles {#roles}

The list below shows all roles that are considered when verifying access rights in the {{ monitoring-full-name }} service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### {{ roles-monitoring-viewer }} {#monitoring-viewer}

Users with the `{{ roles-monitoring-viewer }}` role can view created dashboards and widgets, as well as uploaded metrics.

### {{ roles-monitoring-editor }} {#monitoring-editor}

Users with the `{{ roles-monitoring-editor }}` role can create dashboards and widgets as well as upload metrics and manage alerts.

The `{{ roles-monitoring-editor }}` role also includes all permissions of the `{{ roles-monitoring-viewer }}` role.

### {{ roles-monitoring-admin }} {#monitoring-admin}

Users with the `{{ roles-monitoring-admin }}` role can create dashboards and widgets as well as upload metrics and manage alerts.

The `{{ roles-monitoring-admin }}` role also includes all permissions of the `{{ roles-monitoring-editor }}` role.
