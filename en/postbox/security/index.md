---
title: Access management in {{ postbox-full-name }}
description: Access management in the {{ postbox-full-name }} email service. To allow a user access to {{ postbox-full-name }} resources, assign them the roles from the list below.
---

# Access management in {{ postbox-full-name }}

{% include [operate-via-roles-paragraph](../../_includes/iam/operate-via-roles-paragraph.md) %}

To grant access to {{ postbox-name }} resources, assign the relevant roles from the list below to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated](../../iam/concepts/users/accounts.md#saml-federation) or [local](../../iam/concepts/users/accounts.md#local) users, [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md). Currently, a role can only be assigned for a parent resource, i.e., folder or cloud, whose roles are inherited by nested resources.

For more information about role inheritance, see [Inheritance of access permissions](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-name }} documentation.

You can use the `postbox.identities.restrictNetworkAccess` [access policy](../../iam/concepts/access-control/access-policies.md#postbox-identities-restrictNetworkAccess) to allow [sending emails](../operations/send-email.md) only from explicitly specified IP addresses. The access policy is created at the [folder](*folders), [cloud](*clouds), or [organization](*organizations) level and restricts sending emails from any IP addresses that are not on the list. For more information, see [{#T}](../../iam/concepts/access-control/access-policies.md).

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

#### postbox.messages.reader {#postbox-messages-reader}

{% include [postbox.messages.reader](../../_roles/postbox/messages/reader.md) %}

#### postbox.statistics.reader {#postbox-statistics-reader}

{% include [postbox.statistics.reader](../../_roles/postbox/statistics/reader.md) %}

#### postbox.admin {#postbox-admin}

{% include [postbox.admin](../../_roles/postbox/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Useful links {#see-also}

[Hierarchy of {{ yandex-cloud }} resources](../../resource-manager/concepts/resources-hierarchy.md)

[*folders]: {% include [folder-definition](../../_popups/resource-manager/folder-definition.md) %}

[*clouds]: {% include [cloud-definition](../../_popups/resource-manager/cloud-definition.md) %}

[*organizations]: {% include [organization-definition](../../_popups/identity-hub/organization-definition.md) %}
