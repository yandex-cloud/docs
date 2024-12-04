---
title: Access management in {{ ml-platform-full-name }}
description: Access management in {{ ml-platform-full-name }}, a service providing an ML development environment. For access to {{ ml-platform-name }} resources, assign to the user the required roles from the list below.
---

# Access management in {{ ml-platform-name }}

User access to {{ ml-platform-full-name }} depends on relevant permissions granted within an organization. Organizations are managed using [{{ org-full-name }}](../../organization/).

The operations available to {{ ml-platform-short-name }} users are determined by their roles. You can assign roles to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md). For more information about access management in {{ yandex-cloud }}, see [{#T}](../../iam/concepts/access-control/index.md).

## Which resources you can assign a role for {#resources}

Access control is implemented at the [community](../concepts/community.md) and [project](../concepts/project.md) level. You can also make resources available to all community users by [publishing](../operations/index.md#share) them in the community. The access permissions you grant apply to the whole hierarchy of resources. For example, if you assign a role for a {{ ml-platform-name }} project to a user, all permissions will also apply to resources within that project. Learn more about [relationships between {{ ml-platform-name }} resources](../concepts/resource-model.md).

## How to assign a role {#grant-role}

You can assign a role to a user in the {{ ml-platform-name }} interface:
* [{#T}](../operations/community/add-user.md).
* [{#T}](../operations/projects/add-user.md).
* [Share resources with community members](../operations/index.md#share).

You can also grant access permissions through the [{{ org-name }} interface in {{ cloud-center }}]({{ link-org-cloud-center }}) using [{{ TF }}]({{ tf-provider-link }}) and the [{{ yandex-cloud }} API](../api-ref/authentication.md).

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

> {% include [example-for-sharing](../../_includes/datasphere/roles-for-sharing-example.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles required to perform a particular action. You can always assign a role offering more permissions than the one specified. For example, you can assign the `Editor` role instead of `Viewer`.

#|
|| **Action** | **Required roles** ||
|| **Viewing data** ||
|| Viewing a project, its settings, and users | `Viewer` for a project ||
|| Viewing a project, its settings, and users | `Viewer` for a community ||
|| **Project management** ||
|| [Creating a project](../operations/projects/create.md) | `Developer` for a community ||
|| Running the IDE | `Developer` for a project ||
|| Using resources | `Developer` for a project ||
|| Creating resources | `Developer` for a project ||
|| Deleting resources | `Developer` for a project ||
|| Publishing resources in a community | `Editor` for a project and `Developer` for a community ||
|| [Editing project settings](../operations/projects/update.md) | `Editor` for a project ||
|| [Deleting a project](../operations/projects/delete.md) | `Editor` for a project ||
|| [Granting a role](#grant-role) in a project | `Admin` for a project ||
|| **Community management** ||
|| Editing community settings | `Editor` for a community ||
|| [Linking a billing account](../operations/community/link-ba.md) | `Editor` for a community and `{{ roles-admin }}` for a billing account ||
|| [Deleting a community](../operations/community/delete.md) | `Editor` for a community ||
|| [Granting a role](#grant-role) in a community | `Admin` for a community ||
|#

#### See also {#see-also}

* [{{ org-full-name }}](../../organization/)
* [{#T}](../../iam/concepts/access-control/index.md)
* [{#T}](../../iam/concepts/users/service-accounts.md)
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance)
