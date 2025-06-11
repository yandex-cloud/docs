---
title: Access management in {{ cr-full-name }}
description: Access management in {{ cr-name }}. To allow access to {{ cr-name }} resources, assign the necessary roles to the user from the list below. Currently, a role can only be assigned for a parent resource (folder or cloud).
---

# Access management in {{ cr-name }}

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. With no roles assigned, a user cannot perform most operations.

To allow a user or group, e.g., Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated user](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md), access to {{ cr-name }} resources, assign them the roles from the list below. Currently, a role can be [assigned](../../iam/operations/roles/grant.md) for a parent resource (folder or cloud) or an organization.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a role for the cloud:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

For more information about assigning roles, see the [{{ iam-full-name }}](../../iam/operations/roles/grant.md) documentation.

## Resources supporting role assignment {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}


## Roles this service has {#roles-list}

The list below shows {{ interconnect-name }} roles.

### Service roles {#service-roles}

#### cloud-router.auditor {#cloudrouter-auditor}

{% include [cloud-router.auditor](../../_roles/cloud-router/auditor.md) %}

#### cloud-router.viewer {#cloudrouter-viewer}

{% include [cloud-router.viewer](../../_roles/cloud-router/viewer.md) %}

#### cloud-router.editor {#cloudrouter-editor}

{% include [cloud-router.editor](../../_roles/cloud-router/editor.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}
