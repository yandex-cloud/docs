---
title: Access management in {{ postbox-full-name }}
description: Access management in {{ postbox-full-name }}, a transactional email service. To grant access to {{ postbox-full-name }} resources, assign relevant roles from the list to the user.
---

# Access management in {{ postbox-full-name }}

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. If the user has no roles assigned, all operations are forbidden.

To allow access to {{ postbox-name }} resources, assign the required roles from the list below to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md). Currently, a role can only be assigned for a parent resource (folder or cloud). Roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [Inheritance of access rights](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-name }} documentation.

{% endnote %}

## Which roles exist in the service {#roles-list}

In {{ postbox-name }}, you can manage access using both service and primitive roles.

### Service roles {#service-roles}

#### postbox.sender {#postbox-sender}

{% include [postbox.sender](../../_roles/postbox/sender.md) %}

#### postbox.auditor {#postbox-auditor}

{% include [postbox.auditor](../../_roles/postbox/auditor.md) %}

#### postbox.viewer {#postbox-viewer}

{% include [postbox.viewer](../../_roles/postbox/viewer.md) %}

#### postbox.editor {#postbox-editor}

{% include [postbox.editor](../../_roles/postbox/editor.md) %}

#### postbox.admin {#postbox-admin}

{% include [postbox.admin](../../_roles/postbox/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## See also {#see-also}

[Hierarchy of {{ yandex-cloud }} resources](../../resource-manager/concepts/resources-hierarchy.md)
