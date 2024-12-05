---
title: Access management in {{ api-gw-full-name }}
description: Access management in {{ api-gw-full-name }}, an API gateway service with OpenAPI 3.0 support. To allow access to resources (API gateways) in {{ api-gw-name }}, assign the required roles to the user from the list below. Currently, a role can only be assigned for a parent resource (folder or cloud).
---

# Access management in {{ api-gw-name }}

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. As long as a user has no roles assigned, almost all operations are forbidden.

To allow access to {{ api-gw-name }} resources (API gateways), assign the required roles from the list below to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md). Currently, a role can be [assigned](../../iam/operations/roles/grant.md) for a parent resource (folder or cloud) or an organization.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have the `api-gateway.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a user a role for the cloud:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

For more information about assigning roles, see the [{{ iam-full-name }}](../../iam/operations/roles/grant.md) documentation.

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can assign a role for an [API gateway](../concepts/index.md) via the {{ yandex-cloud }} [CLI](../../cli/cli-ref/serverless/cli-ref/api-gateway/add-access-binding.md) or [API](../api-ref/apigateway/authentication.md).

## Which roles exist in the service {#roles-list}

The list below shows all roles considered when verifying access permissions in {{ api-gw-name }}.

### Service roles {#service-roles}

#### api-gateway.auditor {#api-gateway-auditor}

{% include [api-gateway.auditor](../../_roles/api-gateway/auditor.md) %}

#### api-gateway.viewer {#api-gateway-viewer}

{% include [api-gateway.viewer](../../_roles/api-gateway/viewer.md) %}

#### api-gateway.editor {#api-gateway-editor}

{% include [api-gateway.editor](../../_roles/api-gateway/editor.md) %}

#### api-gateway.websocketWriter {#api-gateway-websocketwriter}

{% include [api-gateway.websocketWriter](../../_roles/api-gateway/websocketWriter.md) %}

#### api-gateway.websocketBroadcaster {#api-gateway-websocketBroadcaster}

{% include [api-gateway.websocketBroadcaster](../../_roles/api-gateway/websocketBroadcaster.md) %}

#### api-gateway.admin {#api-gateway-admin}

{% include [api-gateway.admin](../../_roles/api-gateway/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}