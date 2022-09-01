# Access management in {{ ml-platform-name }}

Access to {{ ml-platform-full-name }} is regulated by assigning permissions in an organization. Organizations are managed using [{{ org-full-name }}](../../organization/).

The list of operations available to {{ ml-platform-short-name }} users is determined by the roles they have. For more information about managing access to {{ yandex-cloud }}, see [{#T}](../../iam/concepts/access-control/index.md). 

## What resources you can assign roles to {#resources}

Access control is implemented at the level of [communities](../concepts/community.md) and [projects](../concepts/project.md). You can also grant resource access to all community users. The access rights granted apply to the entire hierarchy of resources. For example, if you assign a user a role for a {{ ml-platform-name }} project, all permissions are also valid for resources within this project. Learn more about [relationships between {{ ml-platform-name }} resources](../concepts/resource-model.md).

## How to assign a role {#grant-role}

You can assign a role to a user in the {{ ml-platform-name }} interface:
* [{#T}](../operations/community/add-user.md).
* [{#T}](../operations/projects/add-user.md).
* [Share resources with community members](../operations/index.md#share).

You can also [grant access rights](../../organization/roles.md) through the {{ org-name }} interface.

## What roles exist in the service {#roles-list}

### Service roles {#services}

{% include [projects-viewer](../../_includes/roles-datasphere-project-viewer.md) %}

Users with the `{{ roles-datasphere-project-viewer }}` role are not displayed in the lists of project and community members, and you can't assign it in the {{ ml-platform-name }} interface.

{% include [projects-developer](../../_includes/roles-datasphere-projects-developer.md) %}

In the {{ ml-platform-name }} interface, users with the `{{ roles-datasphere-project-developer }}` role have the `Developer` role in the **Members** tab on the project page.

{% include [projects-admin](../../_includes/roles-datasphere-projects-admin.md) %}

In the {{ ml-platform-name }} interface, users with the `{{ roles-datasphere-project-admin }}` role have the `Admin` role in the **Members** tab on the project page.

{% include [communities-viewer](../../_includes/roles-datasphere-communities-viewer.md) %}

Users with the `{{ roles-datasphere-communities-viewer }}` role are not displayed in the list of community members.

{% include [communities-editor](../../_includes/roles-datasphere-communities-editor.md) %}

In the {{ ml-platform-name }} interface, users with the `{{ roles-datasphere-communities-developer }}` role have the `Developer` role in the **Members** tab on the community page.

{% include [communities-admin](../../_includes/roles-datasphere-communities-admin.md) %}

In the {{ ml-platform-name }} interface, users with the `{{ roles-datasphere-communities-admin }}` role have the `Admin` role in the **Members** tab on the community page.

> {% include [example-for-sharing](../../_includes/datasphere/roles-for-sharing-example.md) %}

### Roles of other services {#integration-roles}

{{ ml-platform-name }} projects can interact with other {{ yandex-cloud }} services using [service accounts](../../iam/concepts/users/service-accounts.md). A service account may need these roles.

#### resource-manager.editor {#resource-manager-editor}

{% include [roles-resources](../../_includes/roles-resource-manager-editor.md) %}

#### storage.editor {#storage-editor}

{% include notitle [roles-s3](../../_includes/roles-storage-editor.md) %}

### Primitive roles {#primitive}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

#### See also {#see-also}

* [{{ org-full-name }}](../../organization/).
* [{#T}](../../iam/concepts/access-control/index.md).
* [{#T}](../../iam/concepts/users/service-accounts.md).
* [More information on inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).