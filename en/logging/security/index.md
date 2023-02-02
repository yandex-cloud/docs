# Access management {{ cloud-logging-name }}

In this section, you'll learn:

* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to {#resources}

Roles can be assigned for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), and [custom log group](../concepts/log-group.md). Roles assigned for a cloud or folder also apply to their log groups.

## What roles exist in the service {#roles}

The list below shows all roles that are considered when verifying access rights in the {{ cloud-logging-name }} service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

{% include [logging-roles-viewer](../../_includes/roles-logging-viewer.md) %}

{% include [logging-roles-editor](../../_includes/roles-logging-editor.md) %}

{% include [logging-roles-reader](../../_includes/roles-logging-reader.md) %}

{% include [logging-roles-writer](../../_includes/roles-logging-writer.md) %}

{% include [logging-roles-admin](../../_includes/roles-logging-admin.md) %}

### {{ roles-viewer }} {#viewer}

Users with the `{{ roles-viewer }}` role can view information about resources, for example, a list of log groups or their records.

### {{ roles-editor }} {#editor}

Users with the `{{ roles-editor }}` role can manage log groups, for example, create a log group, add records to it, or update its settings.

The `{{ roles-editor }}` role also includes all permissions of the `{{ roles-viewer }}` role.

### {{ roles-admin }} {#admin}

Users with the `{{ roles-admin }}` role can manage resource access rights, such as allowing other users to add records to log groups.

The `{{ roles-admin }}` role also includes all permissions of the `{{ roles-editor }}` role.
