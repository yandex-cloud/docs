# Access management

In this section, you'll learn:

* [What resources](#resources) you can assign the role to.
* [What roles exist in the service](#roles-list).
* [What roles are required](#required-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to {#resources}

Now you can assign roles for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). These roles also apply to nested resources.

## What roles exist in the service {#roles-list}

The diagram shows which roles are available in the service and how they inherit each other's permissions. For example, the `editor` role includes all `viewer` role permissions. A description of each role is given under the diagram.

![image](service-roles-hierarchy.svg)

Active roles in the service:

* Service roles:
    * {% include [container-registry.images.puller](../../_includes/iam/roles/short-descriptions/container-registry.images.puller.md) %}
    * {% include [container-registry.images.pusher](../../_includes/iam/roles/short-descriptions/container-registry.images.pusher.md) %}
    * {% include [resource-manager.clouds.owner](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.owner.md) %}
    * {% include [resource-manager.clouds.member](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.member.md) %}
* Primitive roles:
    * {% include [viewer](../../_includes/iam/roles/short-descriptions/viewer.md) %}
    * {% include [editor](../../_includes/iam/roles/short-descriptions/editor.md) %}
    * {% include [admin](../../_includes/iam/roles/short-descriptions/admin.md) %}

## What roles do I need {#required-roles}

The table below lists the roles needed to perform a given action. You can always assign a role granting more permissions than the role specified. For example, you can assign `editor` instead of `viewer`.

| Action | Methods | Required roles |
| ----- | ----- | ----- |
| **View data** | | |
| Get a list of [registries](../operations/registry/registry-list.md) | `list` | `container-registry.images.puller` for the folder
| Get information about registries, [Docker](../operations/docker-image/docker-image-list.md) images, and [repositories](../operations/repository/repository-list.md) | `get`, `list` | `container-registry.images.puller` for the registry containing the resources |
| [Pull a Docker image from a registry](../operations/docker-image/docker-image-pull.md) | — | `container-registry.images.puller`<br>for the specified registry |
| **Manage resources** |  |
| [Create registries in a folder](../operations/registry/registry-create.md) | `create` | `editor` for the folder |
| [Update](../operations/registry/registry-update.md) and [delete](../operations/registry/registry-delete.md) registries | `update`, `delete` | `editor` for the specified registry |
| [Create Docker images](../operations/docker-image/docker-image-create.md) using basic Docker images from the registry | — | `container-registry.images.puller`<br>for the specified registry |
| [Create Docker images](../operations/docker-image/docker-image-create.md) without using basic Docker images from the registry | — | No roles required |
| [Push Docker images to the registry](../operations/docker-image/docker-image-push.md) | — | `container-registry.images.pusher`<br>for the specified registry |
| [Delete Docker images](../operations/docker-image/docker-image-delete.md) | `delete` | `editor` for the registry containing the Docker image |
| **Manage resource access** |  |
| [Assign a role](../../iam/operations/roles/grant.md), [revoke a role](../../iam/operations/roles/revoke.md), and view roles granted for the folder or cloud | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` for the resource |

#### What's next

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Read more about access management in Yandex.Cloud](../../iam/concepts/access-control/index.md).
* [More about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

