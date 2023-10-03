# Access management {{ cloud-logging-name }}

{{ cloud-logging-name }} uses [roles](../../iam/concepts/access-control/roles.md) to manage access rights.

In this section, you will learn:

* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign roles to {#resources}

Roles can be assigned for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), or [custom log group](../concepts/log-group.md). Roles assigned for a cloud or folder also apply to their log groups.

## Which roles exist in the service {#roles-list}

The list below shows all roles that are considered when verifying access rights in the {{ cloud-logging-name }} service.

### Service roles {#service-roles}

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

{% include [logging-roles-viewer](../../_includes/roles-logging-viewer.md) %}

{% include [logging-roles-editor](../../_includes/roles-logging-editor.md) %}

{% include [logging-roles-reader](../../_includes/roles-logging-reader.md) %}

{% include [logging-roles-writer](../../_includes/roles-logging-writer.md) %}

{% include [logging-roles-admin](../../_includes/roles-logging-admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}
