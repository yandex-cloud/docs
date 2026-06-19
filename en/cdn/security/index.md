# Access management in {{ cdn-name }}

{{ cdn-name }} uses [roles](../../iam/concepts/access-control/roles.md) to manage access permissions.

In this section, you will learn about:

* [Resources you can assign a role for](#resources).
* [Roles this service has](#roles-list).
* [Roles required](#required-roles) for specific actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

{% include [roles-assign](../../_includes/iam/roles-assign.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Roles this service has {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

{% include [roles-cdn](../../_mermaid/roles/cdn.md) %}

### Service roles {#service-roles}

#### cdn.viewer {#cdn-viewer}

{% include [cdn-viewer](../../_roles/cdn/viewer.md) %}

#### cdn.editor {#cdn-editor}

{% include [cdn-editor](../../_roles/cdn/editor.md) %}

#### cdn.admin {#cdn-admin}

{% include [cdn-admin](../../_roles/cdn/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Required roles {#required-roles}

The table below lists the roles required for specific actions. You can always assign a role with more permissions, e.g., `editor` instead of `viewer`.

Action | Required roles
-------- | --------
**Viewing data** | 
Viewing resource details | `cdn.viewer` for this resource
**Managing CDN resources** | 
[Creating a resource](../operations/resources/create-resource.md) | `cdn.editor` for the folder to host new resources
[Updating basic settings of a resource](../operations/resources/configure-basics.md) | `cdn.editor` for the folder with CDN resources
[Suspending and resuming a resource](../operations/resources/disable-resource.md) | `cdn.editor` for the folder with CDN resources
[Configuring resource caching](../operations/resources/configure-caching.md) | `cdn.editor` for the folder with CDN resources
[Prefetching files to the CDN server cache](../operations/resources/prefetch-files.md) | `cdn.editor` for the folder with CDN resources
[Purging resource cache](../operations/resources/purge-cache.md) | `cdn.editor` for the folder with CDN resources
Configuring HTTP request and response headers | `cdn.editor` for the folder with CDN resources
[Configuring CORS for responses to clients](../operations/resources/configure-cors.md) | `cdn.editor` for the folder with CDN resources
[Configuring HTTP methods](../operations/resources/configure-http.md) | `cdn.editor` for the folder with CDN resources
[Enabling file compression](../operations/resources/enable-compression.md) | `cdn.editor` for the folder with CDN resources
[Enabling file segmentation](../operations/resources/enable-segmentation.md) | `cdn.editor` for the folder with CDN resources
**Managing origin groups** | 
[Creating an origin group](../operations/origin-groups/create-group.md) | `cdn.editor` for the folder with the origin group
[Updating an origin group](../operations/origin-groups/edit-group.md) | `cdn.editor` for the folder with the origin group
[Adding an origin group to a resource](../operations/origin-groups/bind-group-to-resource.md) | `cdn.editor` for the folder with the CDN resource
[Deleting an origin group](../operations/origin-groups/delete-group.md) | `cdn.editor` for the folder with the origin group
**Managing paid features** | 
Origin shielding | `cdn.editor` for the folder with CDN resources
Log export | `cdn.editor` for the folder with CDN resources
**Managing resource access** | 
[Granting](../../iam/operations/roles/grant.md), [revoking](../../iam/operations/roles/revoke.md), and viewing roles for a resource | `admin` for this resource

#### What's next

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
