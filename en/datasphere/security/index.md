---
title: "Access management in {{ ml-platform-full-name }}"
description: "Access management in {{ ml-platform-full-name }}, a service that provides an ML development environment. To grant access to {{ ml-platform-name }} resources, assign the necessary roles from the list below to the user."
---

# Access management in {{ ml-platform-name }}

User access to {{ ml-platform-full-name }} depends on relevant permissions granted within an organization. Organizations are managed using [{{ org-full-name }}](../../organization/).

The list of operations available to {{ ml-platform-short-name }} users is determined by the roles they have. Roles can be assigned to a Yandex account, a [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), a [user group](../../organization/operations/manage-groups.md), or a [system group](../../iam/concepts/access-control/system-group.md). For more information about managing access to {{ yandex-cloud }}, see [{#T}](../../iam/concepts/access-control/index.md).

Only users with the `admin`, `resource-manager.clouds.owner`, or `organization-manager.organizations.owner` role for a resource can assign roles for this resource.

## Which resources you can assign a role for {#resources}

Access control is implemented at the [community](../concepts/community.md) and [project](../concepts/project.md) level. You can also make resources available to all community users. Once granted, access permissions apply to the whole hierarchy of resources. For example, if you give a user a role for a {{ ml-platform-name }} project, all the permissions will also be valid for the resources within this project. Learn more about [relationships between {{ ml-platform-name }} resources](../concepts/resource-model.md).

## How to assign a role {#grant-role}

You can assign a role to a user in the {{ ml-platform-name }} interface:
* [{#T}](../operations/community/add-user.md)
* [{#T}](../operations/projects/add-user.md)
* [Share resources with community members](../operations/index.md#share).

You can also [grant access rights](../../organization/security/index.md) through the {{ org-name }} interface.

## Which roles exist in the service {#roles-list}

### Service roles {#service-roles}

#### datasphere.community-projects.viewer {#datasphere-communityprojects-viewer}

{% include [datasphere.community-projects.viewer](../../_roles/datasphere/community-projects/viewer.md) %}

#### datasphere.community-projects.developer {#datasphere-communityprojects-developer}

{% include [datasphere.community-projects.developer](../../_roles/datasphere/community-projects/developer.md) %}

#### datasphere.community-projects.editor {#datasphere-communityprojects-editor}

{% include [datasphere.community-projects.editor](../../_roles/datasphere/community-projects/editor.md) %}

#### datasphere.community-projects.admin {#datasphere-communityprojects-admin}

{% include [datasphere.community-projects.admin](../../_roles/datasphere/community-projects/admin.md) %}

#### datasphere.communities.viewer {#datasphere-communities-viewer}

{% include [datasphere.communities.viewer](../../_roles/datasphere/communities/viewer.md) %}

#### datasphere.communities.developer {#datasphere-communities-developer}

{% include [datasphere.communities.developer](../../_roles/datasphere/communities/developer.md) %}

#### datasphere.communities.editor {#datasphere-communities-editor}

{% include [datasphere.communities.editor](../../_roles/datasphere/communities/editor.md) %}

#### datasphere.communities.admin {#datasphere-communities-admin}

{% include [datasphere.communities.admin](../../_roles/datasphere/communities/admin.md) %}

#### datasphere.user {#datasphere-user}

{% include [datasphere.user](../../_roles/datasphere/user.md) %}

#### datasphere.admin {#datasphere-admin}

{% include [datasphere.admin](../../_roles/datasphere/admin.md) %}

> {% include [example-for-sharing](../../_includes/datasphere/roles-for-sharing-example.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles needed to perform a particular action. You can always assign a role granting more permissions than the role specified. For example, you can assign `Editor` instead of `Viewer`.

#|
|| **Action** | **Roles required** ||
|| **Viewing information** ||
|| Viewing a project, their settings and users | `Viewer` for the project ||
|| Viewing a community, their settings and users | `Viewer` for the community ||
|| **Managing a project** ||
|| [Creating a project](../operations/projects/create.md) | `Developer` for the community ||
|| Running an IDE | `Developer` for the project ||
|| Using resources | `Developer` for the project ||
|| Creating resources | `Developer` for the project ||
|| Deleting resources | `Developer` for the project ||
|| Publishing resources in a community | `Editor` for the project and `Developer` for the community ||
|| [Editing project settings](../operations/projects/update.md) | `Editor` for the project ||
|| [Deleting a project](../operations/projects/delete.md) | `Editor` for the project ||
|| [Granting a role](#grant-role) in a project | `Admin` for the project ||
|| **Managing a community** ||
|| Editing community settings | `Editor` for the community ||
|| [Linking a billing account](../operations/community/link-ba.md) | `Editor` for the community ||
|| [Deleting a community](../operations/community/delete.md) | `Editor` for the community ||
|| [Granting a role](#grant-role) in a community | `Admin` for the community ||
|#

#### See also {#see-also}

* [{{ org-full-name }}](../../organization/).
* [{#T}](../../iam/concepts/access-control/index.md).
* [{#T}](../../iam/concepts/users/service-accounts.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).