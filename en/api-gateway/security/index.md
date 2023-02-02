---
title: "Access management in {{ api-gw-full-name }}"
description: "Access management in {{ api-gw-full-name }}, an API gateway service with OpenAPI 3.0 support. To allow access to resources (API gateways) in {{ api-gw-name }}, assign the required roles to the user from the list below. For now, a role can only be assigned for a parent resource (folder or cloud)."
---

# Access management in {{ api-gw-name }}

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them.
If a user doesn't have any roles assigned, almost all operations are forbidden.

To allow access to resources (API gateways) in {{ api-gw-name }}, assign the required roles to the user from the list below. For now, a role can only be assigned for a parent resource (folder or cloud).

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles {#roles}

The list below shows all roles that are considered when verifying access rights in the {{ api-gw-name }} service.

{% include [api-gateway-viewer](../../_includes/roles-api-gateway-viewer.md) %}

{% include [api-gateway-editor](../../_includes/roles-api-gateway-editor.md) %}

{% include [api-gateway-websocket-writer](../../_includes/roles-api-gateway-websocket-writer.md) %}

{% include [api-gateway-admin](../../_includes/roles-api-gateway-admin.md) %}

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### {{ roles-viewer }} {#viewer}

Users with the `{{ roles-viewer }}` role can view information about resources, such as a list of API gateways.

### {{ roles-editor }} {#editor}

Users with the `{{ roles-editor }}` role can manage API gateways, for example, create and delete them.

The `{{ roles-editor }}` role includes all permissions of the `{{ roles-viewer }}` role.

### {{ roles-admin }} {#admin}

Users with the `{{ roles-admin }}` role can manage resource access rights, such as allowing other users to edit API gateways.

The `{{ roles-admin }}` role includes all permissions of the `{{ roles-editor }}` role.
