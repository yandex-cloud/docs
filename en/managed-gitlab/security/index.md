# Access management in {{ mgl-name }}

In this section, you will learn:
* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#required-roles) for particular actions.


To use the service, log in to the management console with a [Yandex account](../../iam/concepts/index.md#passport) or [federated account](../../iam/concepts/index.md#saml-federation).


{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign roles to {#resources}

You can assign a role to a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) or [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). Cloud roles also apply to nested folders.

## Which roles exist in the service {#roles-list}

{% include [gitlab-viewer](../../_includes/iam/roles/gitlab-viewer.md) %}

{% include [gitlab-editor](../../_includes/iam/roles/gitlab-editor.md) %}

{% include [gitlab-admin](../../_includes/iam/roles/gitlab-admin.md) %}

### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../_includes/roles-viewer.md) %}

### {{ roles-editor }} {#editor}

{% include [roles-editor](../../_includes/roles-editor.md) %}

### {{ roles-admin }} {#admin}

{% include [roles-admin](../../_includes/roles-admin.md) %}

### {{ roles-cloud-member }} {#member}

{% include [roles-cloud-member](../../_includes/roles-cloud-member.md) %}

### {{ roles-cloud-owner }} {#owner}

{% include [roles-cloud-owner](../../_includes/roles-cloud-owner.md) %}

## Roles required {#required-roles}

To use the service, you need the `{{ roles.gitlab.editor }}` [role](../../iam/concepts/access-control/roles.md) or higher for the folder where the projects are created. With the `{{ roles.gitlab.viewer }}` role, you can only view the list of projects and the contents of uploaded files.

You can always assign a role with more permissions. For instance, you can assign `{{ roles.gitlab.admin }}` instead of `{{ roles.gitlab.editor }}`.


## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
