---
title: "Access management in {{ message-queue-full-name }}"
description: "Access management in {{ message-queue-full-name }}, an inter-application messaging system. To grant access to {{ message-queue-full-name }} resources, assign the necessary roles from the list below to the user."
---

# Access management in {{ message-queue-name }}

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. If the user has no roles assigned, all operations are forbidden.

To allow access to {{ message-queue-full-name }} resources, assign the required roles from the list below to the Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), or [system group](../../iam/concepts/access-control/system-group.md). Currently, a role can only be assigned to a parent resource (folder or cloud). Roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see the section [Inheritance of access rights](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To manage message queues, the user must have the appropriate permissions in the cloud and folders where operations will be performed.

To grant the user permissions:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Which roles exist in the service {#roles-list}

The list below shows all roles that are considered when verifying access rights in the {{ service-name }} service.

### Service roles {#service-roles}

{% include [roles-ymq-reader](../../_includes/roles-ymq-reader.md) %}

{% include [roles-ymq-writer](../../_includes/roles-ymq-writer.md) %}

{% include [roles-ymq-admin](../../_includes/roles-ymq-admin.md) %}

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## See also {#see-also}

[Hierarchy of {{ yandex-cloud }} resources](../../resource-manager/concepts/resources-hierarchy.md)
