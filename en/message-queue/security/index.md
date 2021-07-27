---
title: Access management in Yandex Message Queue
description: "Access management in the service for exchanging messages between applications — Yandex Message Queue. To allow access to the resources of the Yandex Message Queue service, assign the user the necessary roles from the list provided."

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Access management

Yandex.Cloud users can only perform operations on resources that are permitted under the roles assigned to them. If the user has no roles assigned, all operations are forbidden.

To allow access to resources in {{ message-queue-full-name }}, assign the required roles to the user from the list below. For now, a role can only be assigned for a parent resource (folder or cloud), and roles are inherited by nested resources.

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

The `{{ roles-editor }}` role also includes all `{{ roles-viewer }}` role permissions.

### {{ roles-admin }} {#admin}

Users with the `{{ roles-admin }}` role can manage resource access rights, such as allowing other users to create message queues and messages or view their details.

The `{{ roles-admin }}` role also includes all `{{ roles-editor }}` role permissions.

## See also {#see-also}

[Hierarchy of Yandex.Cloud resources](../../resource-manager/concepts/resources-hierarchy.md)

