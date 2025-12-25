---
title: Access management in {{ postbox-full-name }}
description: Access management in {{ postbox-full-name }}, the transactional email service. To allow a user access to {{ postbox-full-name }} resources, assign them the roles from the list below.
---

# Access management in {{ postbox-full-name }}

{% include [operate-via-roles-paragraph](../../_includes/iam/operate-via-roles-paragraph.md) %}

To allow access to {{ postbox-name }} resources, assign relevant roles from the list below to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated](../../iam/concepts/users/accounts.md#saml-federation) or [local](../../iam/concepts/users/accounts.md#local) users, [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md). Currently, a role can only be assigned for a parent resource, such as a folder or cloud. Roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [Inheritance of access permissions](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-name }} documentation.

{% endnote %}

## Roles this service has {#roles-list}

In {{ postbox-name }}, you can manage access using both service and primitive roles.

{% include [postbox](../../_mermaid/roles/postbox.md) %}

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
