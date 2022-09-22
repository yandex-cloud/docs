---
title: Access management in Yandex DataSphere
description: "Access management in the service providing an environment for ML development — Yandex DataSphere. To allow access to the resources of the DataSphere service, assign the user the necessary roles from the list given."
---

# Access management in {{ ml-platform-name }}

The list of operations available to {{ yandex-cloud }} users is determined by the roles they have. A role is assigned to a user at the folder or cloud level, and nested resources inherit this role.

To allow access to resources in {{ ml-platform-short-name }}, assign the required roles to the user from the list below.

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-role}

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles for managing clouds and folders {#rm-roles}

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

## Service roles {#services}

{% include [datasphere.user](../../_includes/roles-datasphere-user.md) %}

{% include [datasphere.admin](../../_includes/roles-datasphere-admin.md) %}

## Primitive roles {#primitive}

### {{ roles-viewer }} {#viewer}

The `{{ roles-viewer }}` role includes all permissions of the `{{ roles-datasphere-user }}` role. The user can view the list of projects and work with existing projects. The user can't create or delete projects.

### {{ roles-editor }} {#editor}

The `{{ roles-editor }}` role includes all permissions of the `{{ roles-viewer }}` role. In terms of access to {{ ml-platform-short-name }} service resources, these roles match.

### {{ roles-admin }} {#admin}

Users with the `{{ roles-admin }}` role can manage resource access rights, such as allow other users to work with folders or view information about projects and user permissions.

The `{{ roles-admin }}` role also includes all permissions of the `{{ roles-editor }}` role.