---
title: "Access management in {{ api-gw-full-name }}"
description: "Access management in {{ api-gw-full-name }}, an API gateway service with OpenAPI 3.0 support. To allow access to resources (API gateways) in {{ api-gw-name }}, assign the required roles to the user from the list below. Currently, a role can only be assigned for a parent resource (folder or cloud)."
---

# Access management in {{ api-gw-name }}

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. If a user does not have any roles assigned, almost all operations are forbidden.

To allow access to {{ api-gw-name }} resources (API gateways), assign the Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), or [system group](../../iam/concepts/access-control/system-group.md) the required roles from the list below. Currently, a role can be [assigned](../../iam/operations/roles/grant.md) for a parent resource (folder or cloud) or an organization.

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a user a role for the cloud:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

For more information about assigning roles, see the [{{ iam-full-name }}](../../iam/operations/roles/grant.md) documentation.

## Which roles exist in the service {#roles-list}

The list below shows all roles that are considered when verifying access rights in the {{ api-gw-name }} service.

### Service roles {#service-roles}

{% include [api-gateway-viewer](../../_includes/roles-api-gateway-viewer.md) %}

{% include [api-gateway-editor](../../_includes/roles-api-gateway-editor.md) %}

{% include [api-gateway-websocket-writer](../../_includes/roles-api-gateway-websocket-writer.md) %}

{% include [api-gateway-admin](../../_includes/roles-api-gateway-admin.md) %}

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}
