# Access management

In this section, you'll learn:

* [What resources you can assign roles to](#resources).
* [What roles exist in the service](#roles-list).
* [What roles are required](#choosing-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to. {#resources}

You can assign a role for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), [registry](../concepts/registry.md), or [repository](../concepts/repository.md). These roles also apply to nested resources.

## What roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![service-roles-hierarchy](../../_assets/container-registry/service-roles-hierarchy.svg)

### Service roles

| Role | Permissions |
| ----- | ----- |
| `container-registry.admin` | Lets you create, edit, and delete [registries](../concepts/registry.md). |
| `container-registry.images.puller` | Lets you download [Docker images](../concepts/docker-image.md) and view information about service resources (registries, Docker images, and repositories). |
| `container-registry.images.pusher` | Lets you manage Docker images and view information about service resources (registries, Docker images, and repositories). |
| `resource-manager.clouds.member` | The role required to access resources in the cloud for all users except [cloud owners](../../resource-manager/concepts/resources-hierarchy.md#owner) and [service accounts](../../iam/concepts/users/service-accounts.md). |
| `resource-manager.clouds.owner` | Grants you full access to the cloud and the resources in it. You can assign this role only for a cloud. |

For more information about service roles, see [{#T}](../../iam/concepts/access-control/roles.md) in the service documentation {{ iam-full-name }}.

### Primitive roles

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles needed to perform a given action. You can always assign a role granting more permissions than the role specified. For example, you can assign `editor` instead of `viewer`.

| Action | Methods | Required roles |
| ----- | ----- | ----- |
| **View data** |  |
| Get a list of [registries](../operations/registry/registry-list.md) | `list` | `container-registry.images.puller` for a folder |
| Get information about registries, [Docker images](../operations/docker-image/docker-image-list.md), and [repositories](../operations/repository/repository-list.md) | `get`, `list` | `container-registry.images.puller` for the registry containing the resource |
| [Pull a Docker image](../operations/docker-image/docker-image-pull.md) | — | `container-registry.images.puller`<br>for the registry or repository |
| Get information about [lifecycle policies](../operations/lifecycle-policy/lifecycle-policy-list.md) and the results of their [dry runs](../operations/lifecycle-policy/lifecycle-policy-dry-run.md) | `get`, `list`, `getDryRunResult`, `listDryRunResults` | `viewer` for the registry or repository that the lifecycle policy was created for |
| **Manage resources** |  |
| [Create registries in a folder](../operations/registry/registry-create.md) | `create` | `editor` for the folder |
| [Update](../operations/registry/registry-update.md) and [delete](../operations/registry/registry-delete.md) registries | `update`, `delete` | `editor` for the registry |
| [Create Docker images](../operations/docker-image/docker-image-create.md) using basic Docker images from the registry | — | `container-registry.images.puller`<br>for the registry or repository |
| [Create Docker images](../operations/docker-image/docker-image-create.md) without using basic Docker images from the registry | — | No roles required |
| [Push Docker images to the registry](../operations/docker-image/docker-image-push.md) | — | `container-registry.images.pusher`<br>for the registry or repository |
| [Delete Docker images](../operations/docker-image/docker-image-delete.md) | `delete` | `editor` for a registry or repository containing a Docker image |
| [Create](../operations/lifecycle-policy/lifecycle-policy-create.md), [update](../operations/lifecycle-policy/lifecycle-policy-update.md), [delete](../operations/lifecycle-policy/lifecycle-policy-delete.md), and [dry run](../operations/lifecycle-policy/lifecycle-policy-dry-run.md) a lifecycle policy | `create`, `update`, `delete`, `dryRun` | `editor` for the registry or repository that the lifecycle policy was created for |
| **Manage resource access** |  |
| [Assign](../../iam/operations/roles/grant.md), [revoke](../../iam/operations/roles/revoke.md), and view roles granted for the folder, cloud, or registry | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` for the resource |

#### What's next {what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [For more information about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

