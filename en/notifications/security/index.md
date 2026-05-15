---
title: Access management in {{ cns-full-name }}
description: Access management in the {{ cns-full-name }} email service. To allow a user access to {{ cns-name }} resources, assign them the roles from the list below.
---

# Access management in {{ cns-full-name }}

{% include [operate-via-roles-paragraph](../../_includes/iam/operate-via-roles-paragraph.md) %}

To allow access to {{ cns-full-name }} resources, assign the relevant roles from the list below to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated](../../iam/concepts/users/accounts.md#saml-federation) or [local](../../iam/concepts/users/accounts.md#local) users, [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md). Currently, a role can only be assigned for a parent resource, such as a folder or cloud. Roles are inherited by nested resources.

For more information about role inheritance, see [Inheritance of access permissions](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-name }} documentation.

## Roles available in the service {#roles-list}

In {{ cns-name }}, you can manage access using both service and primitive roles.

{% include [cns](../../_mermaid/roles/cns.md) %}

### Service roles {#service-roles}

#### notifications.auditor {#notifications-auditor}

{% include [notifications.auditor](../../_roles/notifications/auditor.md) %}

#### notifications.viewer {#notifications-viewer}

{% include [notifications.viewer](../../_roles/notifications/viewer.md) %}

#### notifications.publisher {#notifications-publisher}

{% include [notifications.publisher](../../_roles/notifications/publisher.md) %}

#### notifications.editor {#notifications-editor}

{% include [notifications.editor](../../_roles/notifications/editor.md) %}

#### notifications.admin {#notifications-admin}

{% include [notifications.admin](../../_roles/notifications/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## See also {#see-also}

[Hierarchy of {{ yandex-cloud }} resources](../../resource-manager/concepts/resources-hierarchy.md)