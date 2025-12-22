# Access management in {{ video-full-name }}

In this section, you will learn about:

* [What resources you can assign a role for](#resources).
* [What roles exist in this service](#roles-list).

## Access management {#about-access-control}

Access to {{ video-name }} is controlled by assigning permissions within the [organization](../../organization/concepts/organization.md). Organizations are managed using [{{ org-full-name }}](../../organization/index.yaml).

The operations available to {{ video-name }} users are determined by their roles. You can assign roles to a Yandex account, [federated](../../iam/concepts/users/accounts.md#saml-federation) or [local](../../iam/concepts/users/accounts.md#local) users, [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md). For more information about access management in {{ yandex-cloud }}, see [{#T}](../../iam/concepts/access-control/index.md).

To assign a role for a resource, a user should have the `video.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Resources you can assign a role for {#resources}

You can assign a role for a [channel](../concepts/index.md#channels) from the {{ video-name }} [interface]({{ link-video-main }}) or via the [API](../api-ref/authentication.md).

## Adding a user to {{ video-name }} {#add-user}

You can add a user to {{ video-name }} as follows:
* Send an invitation from the {{ video-name }} [interface]({{ link-video-main }}) by specifying the email address the user used to sign up to the organization.
* [Grant](../../organization/security/index.md) access permissions via the {{ org-name }} interface.

## Roles this service has {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![service-roles-hierarchy](../../_assets/video/service-roles-hierarchy.svg)

### Service roles {#service-roles}

#### video.auditor {#video-auditor}

{% include [video.auditor](../../_roles/video/auditor.md) %}

#### video.viewer {#video-viewer}

{% include [video.viewer](../../_roles/video/viewer.md) %}

#### video.editor {#video-editor}

{% include [video.editor](../../_roles/video/editor.md) %}

#### video.admin {#video-admin}

{% include [video.admin](../../_roles/video/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}