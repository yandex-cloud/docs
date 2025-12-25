---
title: Access management in {{ cr-full-name }}
description: Access management in {{ cr-name }}. To allow access to {{ cr-name }} resources, assign the necessary roles to the user from the list below. Currently, a role can only be assigned for a parent resource (folder or cloud).
---

# Access management in {{ cr-name }}

{% include [operate-via-roles-paragraph](../../_includes/iam/operate-via-roles-paragraph.md) %}

To allow access to {{ cr-name }} resources, assign relevant roles from the list below to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated](../../iam/concepts/users/accounts.md#saml-federation) or [local](../../iam/concepts/users/accounts.md#local) users, [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md). Currently, a role can be [assigned](../../iam/operations/roles/grant.md) for a parent resource (folder or cloud) or an organization.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} guide.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a role for the cloud:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

For more information about assigning roles, see the [{{ iam-full-name }}](../../iam/operations/roles/grant.md) documentation.

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}


## Roles this service has {#roles-list}

The list below shows all roles used for access control in {{ interconnect-name }}.

### Service roles {#service-roles}

#### cloud-router.auditor {#cloudrouter-auditor}

{% include [cloud-router.auditor](../../_roles/cloud-router/auditor.md) %}

#### cloud-router.viewer {#cloudrouter-viewer}

{% include [cloud-router.viewer](../../_roles/cloud-router/viewer.md) %}

#### cloud-router.prefixEditor {#cloudrouter-prefixEditor}

{% include [cloud-router.prefixEditor](../../_roles/cloud-router/prefixEditor.md) %}

#### cloud-router.editor {#cloudrouter-editor}

{% include [cloud-router.editor](../../_roles/cloud-router/editor.md) %}

#### cloud-router.admin {#cloudrouter-admin}

{% include [cloud-router.admin](../../_roles/cloud-router/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}
