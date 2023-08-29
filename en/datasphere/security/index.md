---
title: "Access management in {{ ml-platform-full-name }}"
description: "Access management in {{ ml-platform-full-name }}, a service that provides an ML development environment. To grant access to {{ ml-platform-name }} resources, assign the necessary roles from the list below to the user."
---

# Access management in {{ ml-platform-name }}

Access to {{ ml-platform-full-name }} is regulated by assigning permissions in an organization. Organizations are managed using [{{ org-full-name }}](../../organization/).

The list of operations available to {{ ml-platform-short-name }} users is determined by the roles they have. For more information about managing access to {{ yandex-cloud }}, see [{#T}](../../iam/concepts/access-control/index.md).

## Which resources you can assign roles to {#resources}

Access control is implemented at the level of [communities](../concepts/community.md) and [projects](../concepts/project.md). You can also grant resource access to all community users. The access rights granted apply to the entire hierarchy of resources. For example, if you assign a user a role for a {{ ml-platform-name }} project, all permissions are also valid for resources within this project. Learn more about [relationships between {{ ml-platform-name }} resources](../concepts/resource-model.md).

## How to assign a role {#grant-role}

You can assign a role to a user in the {{ ml-platform-name }} interface:
* [{#T}](../operations/community/add-user.md)
* [{#T}](../operations/projects/add-user.md)
* [Share resources with community members](../operations/index.md#share)

You can also [grant access rights](../../organization/roles.md) through the {{ org-name }} interface.

## Which roles exist in the service {#roles-list}

### Service roles {#service-roles}

{% include [projects-viewer](../../_includes/roles-datasphere-project-viewer.md) %}

In the {{ ml-platform-name }} interface, users with the `{{ roles-datasphere-project-viewer }}` role have the `Viewer` role in the **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** tab on the project page.

{% include [projects-developer](../../_includes/roles-datasphere-projects-developer.md) %}

In the {{ ml-platform-name }} interface, users with the `{{ roles-datasphere-project-developer }}` role have the `Developer` role in the **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** tab on the project page.

{% include [projects-editor](../../_includes/roles-datasphere-projects-editor.md) %}

In the {{ ml-platform-name }} interface, users with the `{{ roles-datasphere-project-editor }}` role have the `Editor` role in the **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** tab on the project page.

{% include [projects-admin](../../_includes/roles-datasphere-projects-admin.md) %}

In the {{ ml-platform-name }} interface, users with the `{{ roles-datasphere-project-admin }}` role have the `Admin` role in the **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** tab on the project page.

{% include [communities-viewer](../../_includes/roles-datasphere-communities-viewer.md) %}

In the {{ ml-platform-name }} interface, users with the `{{ roles-datasphere-communities-viewer }}` role have the `Viewer` role in the **{{ ui-key.yc-ui-datasphere.common.members }}** tab on the community page.

{% include [communities-developer](../../_includes/roles-datasphere-communities-developer.md) %}

In the {{ ml-platform-name }} interface, users with the `{{ roles-datasphere-communities-developer }}` role have the `Developer` role in the **{{ ui-key.yc-ui-datasphere.common.members }}** tab on the community page.

{% include [communities-editor](../../_includes/roles-datasphere-communities-editor.md) %}

In the {{ ml-platform-name }} interface, users with the `{{ roles-datasphere-communities-editor }}` role have the `Editor` role in the **{{ ui-key.yc-ui-datasphere.common.members }}** tab on the community page.

{% include [communities-admin](../../_includes/roles-datasphere-communities-admin.md) %}

In the {{ ml-platform-name }} interface, users with the `{{ roles-datasphere-communities-admin }}` role have the `Admin` role in the **{{ ui-key.yc-ui-datasphere.common.members }}** tab on the community page.

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

* [{{ org-full-name }}](../../organization/)
* [{#T}](../../iam/concepts/access-control/index.md)
* [{#T}](../../iam/concepts/users/service-accounts.md)
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance)