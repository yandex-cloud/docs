---
title: "Access management in {{ message-queue-full-name }}"
description: "Access management in {{ message-queue-full-name }}, an inter-application messaging system. To grant access to {{ message-queue-full-name }} resources, assign the necessary roles from the list below to the user."
---

# Access management in {{ message-queue-name }}

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. If the user has no roles assigned, all operations are forbidden.

To allow access to resources in {{ message-queue-full-name }}, assign the required roles to the user from the list below. Currently, a role can only be assigned to a parent resource (folder or cloud). Roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see the section [Inheritance of access rights](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To manage message queues, the user must have the appropriate permissions in the cloud and folders where operations will be performed.

To grant the user permissions:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles {#roles}

The list below shows all roles that are considered when verifying access rights in the {{ service-name }} service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### {{ roles-viewer }} {#viewer}
Users with the `{{ roles-viewer }}` role can view lists of cloud message queues and messages.

### {{ roles-editor }} {#editor}
Users with the `{{ roles-editor }}` role can perform any operations on message queues and messages.

The `{{ roles-editor }}` role also includes all permissions of the `{{ roles-viewer }}` role.

### {{ roles-admin }} {#admin}
Users with the `{{ roles-admin }}` role can manage resource access rights, such as allowing other users to create message queues and messages or view their details.

The `{{ roles-admin }}` role also includes all permissions of the `{{ roles-editor }}` role.

## See also {#see-also}

[Hierarchy of {{ yandex-cloud }} resources](../../resource-manager/concepts/resources-hierarchy.md)
