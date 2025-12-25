---
title: Access management in {{ message-queue-full-name }}
description: Access management in {{ message-queue-full-name }}, the cross-application messaging service. To allow a user access to {{ message-queue-full-name }} resources, assign them the roles from the list below.
---

# Access management in {{ message-queue-name }}

{% include [operate-via-roles-paragraph](../../_includes/iam/operate-via-roles-paragraph.md) %}

To allow access to {{ message-queue-full-name }} resources, assign relevant roles from the list below to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated](../../iam/concepts/users/accounts.md#saml-federation) or [local](../../iam/concepts/users/accounts.md#local) users, [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md). Currently, a role can only be assigned for a parent resource, such as a folder or cloud. Roles are inherited by nested resources.

{% include [roles-assign](../../_includes/iam/roles-assign.md) %}

{% note info %}

For more information about role inheritance, see [Inheritance of access permissions](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To manage message queues, the user must have the appropriate permissions in the cloud and folders where operations will be performed.

To grant the user permissions:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles this service has {#roles-list}

The list below shows all roles used for access control in {{ service-name }}.

{% include [message-queue](../../_mermaid/roles/message-queue.md) %}

### Service roles {#service-roles}

#### ymq.reader {#ymq-reader}

{% include [ymq.reader](../../_roles/ymq/reader.md) %}

#### ymq.writer {#ymq-writer}

{% include [ymq.writer](../../_roles/ymq/writer.md) %}

#### ymq.admin {#ymq-admin}

{% include [ymq.admin](../../_roles/ymq/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## See also {#see-also}

[Hierarchy of {{ yandex-cloud }} resources](../../resource-manager/concepts/resources-hierarchy.md)
