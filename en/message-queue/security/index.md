---
title: "Access management in {{ message-queue-full-name }}"
description: "Access management in {{ message-queue-full-name }}, an inter-application messaging system. To grant access to {{ message-queue-full-name }} resources, assign the necessary roles from the list below to the user."
---

# Access management in {{ message-queue-name }}

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. As long as a user has no roles assigned, all operations are forbidden.

To allow access to {{ message-queue-full-name }} resources, assign the required roles from the list below to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md). Currently, a role can only be assigned for a parent resource (folder or cloud). Roles are inherited by nested resources.

{% include [roles-assign](../../_includes/iam/roles-assign.md) %}

{% note info %}

For more information about role inheritance, see [Inheritance of access rights](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To manage message queues, the user must have the appropriate permissions in the cloud and folders where operations will be performed.

To grant the user permissions:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Which roles exist in the service {#roles-list}

The list below shows all roles considered when verifying access permissions in {{ service-name }}.

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
