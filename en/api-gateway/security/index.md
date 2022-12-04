---
title: "Access management in Yandex API Gateway"
description: "Access management in the API gateway service that supports the OpenAPI 3.0 specification. To allow access to the API Gateway service resources, assign the user the necessary roles from the list below. At the moment, a role can be assigned only to the parent resource (directory or cloud)."
---

# Access management in {{ api-gw-name }}

Yandex Cloud users can only perform operations on resources that are permitted under the roles assigned to them.
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

### {{ roles-viewer }} {#viewer}

The user with the `{{ roles-viewer }}` role can view information about resources, such as the list of functions or their versions and the function execution log.

### {{ roles-editor }} {#editor}

The user with the `{{ roles-editor }}` role can manage functions and their versions, such as creating or deleting a version or editing information about a function.

The `{{ roles-editor }}` role also includes all `{{ roles-viewer }}` role permissions.

### {{ roles-admin }} {#admin}

The user with the `{{ roles-admin }}` role can manage access rights to resources, such as allow other users to invoke functions or work with their versions.

The `{{ roles-admin }}` role also includes all `{{ roles-editor }}` role permissions.

