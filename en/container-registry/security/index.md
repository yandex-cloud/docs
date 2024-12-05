---
title: Access management in {{ container-registry-full-name }}
description: Access management in {{ container-registry-full-name }}, a service for Docker image storage and distribution. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action.
---

# Access management in {{ container-registry-name }}

In this section, you will learn:
* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#choosing-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have the `container-registry.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can also assign roles for individual resources within the service:

{% list tabs group=instructions %}

- Management console {#console}

  You can use the [management console]({{ link-console-main }}) to assign roles for a [registry](../concepts/registry.md).

- CLI {#cli}

  You can use the [{{ yandex-cloud }} CLI](../../cli/cli-ref/container/cli-ref/index.md) to assign roles for the following resources:

  * [Registry](../concepts/registry.md)
  * [Repository](../concepts/repository.md)

- {{ TF }} {#tf}

  You can use [{{ TF }}]({{ tf-provider-link }}) to assign roles for the following resources:

  * [Registry](../concepts/registry.md)
  * [Repository](../concepts/repository.md)

- API {#api}

  You can use the [{{ yandex-cloud }}](../api-ref/authentication.md) API to assign roles for the following resources:

  * [Registry](../concepts/registry.md)
  * [Repository](../concepts/repository.md)

{% endlist %}

## Which roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![service-roles-hierarchy](../../_assets/container-registry/service-roles-hierarchy.svg)

### Service roles {#service-roles}

#### container-registry.viewer {#container-registry.viewer}

{% include [container-registry.viewer](../../_roles/container-registry/viewer.md) %}

#### container-registry.editor {#container-registry.editor}

{% include [container-registry.editor](../../_roles/container-registry/editor.md) %}

#### container-registry.admin {#container-registry.admin}

{% include [container-registry.admin](../../_roles/container-registry/admin.md) %}

#### container-registry.images.pusher {#container-registry-images-pusher}

{% include [container-registry.images.pusher](../../_roles/container-registry/images/pusher.md) %}

#### container-registry.images.puller {#container-registry-images-puller}

{% include [container-registry.images.puller](../../_roles/container-registry/images/puller.md) %}

#### container-registry.images.scanner {#container-registry-images-scanner}

{% include [container-registry.images.scanner](../../_roles/container-registry/images/scanner.md) %}

For more information about service roles, see [{#T}](../../iam/concepts/access-control/roles.md) in the {{ iam-full-name }} documentation.

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles required to perform a particular action. You can always assign a role offering more permissions than the one specified. For example, you can assign the `editor` role instead of `viewer`.


Action | Methods | Required roles
--- | --- | ---
**Viewing data** |
[Get a list of registries](../operations/registry/registry-list.md). | `list` | `container-registry.viewer` for the folder
Get information about registries, [Docker images](../operations/docker-image/docker-image-list.md), and [repositories](../operations/repository/repository-list.md). | `get`, `list` | `container-registry.viewer` for the registry containing the resource
[Pulling a Docker image](../operations/docker-image/docker-image-pull.md). | `pull` | `container-registry.images.puller`<br>For the registry or repository
Get information on [lifecycle policies](../operations/lifecycle-policy/lifecycle-policy-list.md) and the outcomes of their [dry runs](../operations/lifecycle-policy/lifecycle-policy-dry-run.md). | `get`, `list`, `getDryRunResult`, `listDryRunResults`| `container-registry.viewer` for the registry or repository the lifecycle policy was created for
**Managing resources** |
[Create registries in a folder](../operations/registry/registry-create.md). | `create` | `container-registry.editor` for the folder
[Update](../operations/registry/registry-update.md) and [delete](../operations/registry/registry-delete.md) registries | `update`, `delete` | `container-registry.editor` for the registry
[Create Docker images](../operations/docker-image/docker-image-create.md) using basic Docker images from the registry | — | `container-registry.images.puller`<br>For the registry or repository
[Create Docker images](../operations/docker-image/docker-image-create.md) without using basic Docker images from the registry. | — | No roles required.
[Push Docker images to the registry](../operations/docker-image/docker-image-push.md). | `push` | `container-registry.images.pusher`<br>For the registry or repository
[Delete Docker images](../operations/docker-image/docker-image-delete.md). | `delete` | `container-registry.images.pusher` for the registry or repository containing the Docker image
[Create](../operations/lifecycle-policy/lifecycle-policy-create.md), [edit](../operations/lifecycle-policy/lifecycle-policy-update.md), [delete](../operations/lifecycle-policy/lifecycle-policy-delete.md), and perform a [dry run](../operations/lifecycle-policy/lifecycle-policy-dry-run.md) of a lifecycle policy. | `create`, `update`, `delete`, `dryRun` | `container-registry.editor` for the registry or repository the lifecycle policy was created for
**Resource access management** |
[Grant a role](../../iam/operations/roles/grant.md), [revoke a role](../../iam/operations/roles/revoke.md), and view the roles assigned to a folder, a cloud, or a registry. | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` for the resource
**Scan for vulnerabilities** |
[Scan](../operations/scanning-docker-image.md) a Docker image. | `scan` | `container-registry.images.scanner` for the registry or repository containing the Docker image
Get the results of a Docker image scan. | `get`, `getLast`, `list`, `listVulnerabilities` | `container-registry.images.scanner` for the registry or repository containing the Docker image



#### What's next {what-is-next}

* [Assigning a role](../operations/roles/grant.md).
* [Viewing assigned roles](../operations/roles/get-assigned-roles.md).
* [Revoking a role](../operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).