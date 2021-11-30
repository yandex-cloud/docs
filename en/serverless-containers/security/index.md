# Access management {{ serverless-containers-name }}

In this section, you'll learn:

* [What resources you can assign roles to](#resources).
* [What roles exist in the service](#roles).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to {#resources}

You can assign roles for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), and a [container](../concepts/container.md).

## What roles exist in the service {#roles}

The list below shows all roles that are considered when verifying access rights in the {{ serverless-containers-name }} service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

{% include [serverless-containers-roles-viewer](../../_includes/roles-serverless-containers-viewer.md) %}

{% include [serverless-containers-roles-invoker](../../_includes/roles-serverless-containers-invoker.md) %}

{% include [serverless-containers-roles-editor](../../_includes/roles-serverless-containers-editor.md) %}

{% include [serverless-containers-roles-admin](../../_includes/roles-serverless-containers-admin.md) %}

### {{ roles-viewer }} {#viewer}

Users with the `{{ roles-viewer }}` role can view information about resources, for example, a list of containers or their revisions.

### {{ roles-editor }} {#editor}

Users with the `{{ roles-editor }}` role can manage containers, for example, create a container or invoke it.

The `{{ roles-editor }}` role also includes all permissions of the `{{ roles-viewer }}` role.

### {{ roles-admin }} {#admin}

Users with the `{{ roles-admin }}` role can manage resource access rights, such as permitting other users to invoke a container.

The `{{ roles-admin }}` role also includes all permissions of the `{{ roles-editor }}` role.

