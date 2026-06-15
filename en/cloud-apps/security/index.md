---
title: Access management in {{ cloud-apps-full-name }}
description: Access management in {{ cloud-apps-full-name }}. To allow a user access to {{ cloud-apps-full-name }} resources, assign them the roles from the list below.
---

# Access management in {{ cloud-apps-full-name }}

{% include [operate-via-roles-paragraph](../../_includes/iam/operate-via-roles-paragraph.md) %}

To grant access to {{ cloud-apps-name }} resources, assign the relevant roles from the list below to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated](../../iam/concepts/users/accounts.md#saml-federation) or [local](../../iam/concepts/users/accounts.md#local) users, [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md). Currently, a role can only be assigned for a parent resource, i.e., folder or cloud, whose roles are inherited by nested resources.

For more information about role inheritance, see [Inheritance of access permissions](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-name }} documentation.

## Roles this service has {#roles-list}

In {{ cloud-apps-name }}, you can manage access using both service and primitive roles.

{% include [cloud-apps](../../_mermaid/roles/cloud-apps.md) %}

### Service roles {#service-roles}

#### cloudapps.auditor {#cloudapps-auditor}

{% include [cloudapps.auditor](../../_roles/cloudapps/auditor.md) %}

#### cloudapps.viewer {#cloudapps-viewer}

{% include [cloudapps.viewer](../../_roles/cloudapps/viewer.md) %}

#### cloudapps.editor {#cloudapps-editor}

{% include [cloudapps.editor](../../_roles/cloudapps/editor.md) %}

#### cloudapps.admin {#cloudapps-admin}

{% include [cloudapps.admin](../../_roles/cloudapps/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## See also {#see-also}

[Hierarchy of {{ yandex-cloud }} resources](../../resource-manager/concepts/resources-hierarchy.md)
