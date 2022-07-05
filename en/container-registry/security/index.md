---
title: Access management in {{ container-registry-full-name }}
description: "Access management in the service for storing and distributing Docker images — {{ container-registry-full-name }}. The section describes which resources can be assigned a role, which roles act in the service, which roles are required for this or that action."
---

# Access management in {{ container-registry-name }}

In this section, you'll learn:
* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#choosing-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to {#resources}

You can assign a role to a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), a [registry](../concepts/registry.md), or a [repository](../concepts/repository.md). These roles also apply to nested resources.

## What roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![service-roles-hierarchy](../../_assets/container-registry/service-roles-hierarchy.svg)

### Service roles {#service-roles}

Role | Permissions
--- | ---
`container-registry.admin` | Lets you create, edit, and delete [registries](../concepts/registry.md).
`container-registry.images.puller` | Lets you download [Docker images](../concepts/docker-image.md) and view information about service resources (registries, Docker images, and repositories).
`container-registry.images.pusher` | Lets you manage Docker images and view information about service resources (registries, Docker images, and repositories).
`resource-manager.clouds.member` | A role everyone requires to access cloud resources, except for [cloud owners](../../resource-manager/concepts/resources-hierarchy.md#owner) and [service accounts](../../iam/concepts/users/service-accounts.md).
`resource-manager.clouds.owner` | Grants you full access to a cloud and the resources in it. You can only assign this role for a cloud.

For more information about service roles, see [{#T}](../../iam/concepts/access-control/roles.md) in the {{ iam-full-name }} service documentation.

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles needed to perform a given action. You can always assign a role granting more permissions than the role specified. For example, you can assign `editor` instead of `viewer`.

{% if product == "yandex-cloud" %}

Action | Methods | Required roles
--- | --- | ---
**View data** |
Get a list of [registries](../operations/registry/registry-list.md). | `list` | `container-registry.images.puller` for a folder.
Get information about registries, [Docker images](../operations/docker-image/docker-image-list.md), and [repositories](../operations/repository/repository-list.md). | `get`, `list` | `container-registry.images.puller` for the registry containing the resource.
[Pulling a Docker image](../operations/docker-image/docker-image-pull.md). | — | `container-registry.images.puller`<br>for the registry or repository.
Getting information on [lifecycle policies](../operations/lifecycle-policy/lifecycle-policy-list.md) and the outcomes of their [dry runs](../operations/lifecycle-policy/lifecycle-policy-dry-run.md). | `get`, `list`, `getDryRunResult`, `listDryRunResults` | `viewer` for the registry or repository that the lifecycle policy was created for.
**Manage resources** |
[Create registries in a folder](../operations/registry/registry-create.md). | `create` | `editor` for the folder.
[Update](../operations/registry/registry-update.md) and [delete](../operations/registry/registry-delete.md) registries | `update`, `delete` | `editor` for the registry.
[Create Docker images](../operations/docker-image/docker-image-create.md) using basic Docker images from the registry | — | `container-registry.images.puller`<br>for the registry or repository.
Create Docker images without using basic Docker images from the registry. | — | No roles required.
[Push Docker images to the registry](../operations/docker-image/docker-image-push.md). | — | `container-registry.images.pusher`<br>for the registry or repository.
[Delete Docker images](../operations/docker-image/docker-image-delete.md). | `delete` | `editor` for a registry or repository containing a Docker image.
[Creating](../operations/lifecycle-policy/lifecycle-policy-create.md), [editing](../operations/lifecycle-policy/lifecycle-policy-update.md), [deleting](../operations/lifecycle-policy/lifecycle-policy-delete.md), and performing a [dry run](../operations/lifecycle-policy/lifecycle-policy-dry-run.md) of a lifecycle policy. | `create`, `update`, `delete`, `dryRun` | `editor` for the registry or repository that the lifecycle policy was created for.
**Manage resource access** |
[Granting a role](../../iam/operations/roles/grant.md), [revoking a role](../../iam/operations/roles/revoke.md), and viewing the roles assigned to a folder, a cloud, or a registry. | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` for the resource.
**Scanning for vulnerabilities** |
[Scanning](../operations/scanning-docker-image.md) a Docker image. | `scan` | `editor` for a registry or repository containing a Docker image.
Getting the results of a Docker image scan. | `get`, `getLast`, `list`, `listVulnerabilities` | `viewer` to a registry or a repository containing a Docker image.

{% endif %}

{% if product == "cloud-il" %}

Action | Methods | Required roles
--- | --- | ---
**View data** |
Get a list of [registries](../operations/registry/registry-list.md). | `list` | `container-registry.images.puller` for a folder.
Get information about registries, [Docker images](../operations/docker-image/docker-image-list.md), and [repositories](../operations/repository/repository-list.md). | `get`, `list` | `container-registry.images.puller` for the registry containing the resource.
[Pulling a Docker image](../operations/docker-image/docker-image-pull.md). | — | `container-registry.images.puller`<br>for the registry or repository.
Getting information on [lifecycle policies](../operations/lifecycle-policy/lifecycle-policy-list.md) and the outcomes of their [dry runs](../operations/lifecycle-policy/lifecycle-policy-dry-run.md). | `get`, `list`, `getDryRunResult`, `listDryRunResults` | `viewer` for the registry or repository that the lifecycle policy was created for.
**Manage resources** |
[Create registries in a folder](../operations/registry/registry-create.md). | `create` | `editor` for the folder.
[Update](../operations/registry/registry-update.md) and [delete](../operations/registry/registry-delete.md) registries | `update`, `delete` | `editor` for the registry.
[Create Docker images](../operations/docker-image/docker-image-create.md) using basic Docker images from the registry | — | `container-registry.images.puller`<br>for the registry or repository.
Create Docker images without using basic Docker images from the registry. | — | No roles required.
[Push Docker images to the registry](../operations/docker-image/docker-image-push.md). | — | `container-registry.images.pusher`<br>for the registry or repository.
[Delete Docker images](../operations/docker-image/docker-image-delete.md). | `delete` | `editor` for a registry or repository containing a Docker image.
[Creating](../operations/lifecycle-policy/lifecycle-policy-create.md), [editing](../operations/lifecycle-policy/lifecycle-policy-update.md), [deleting](../operations/lifecycle-policy/lifecycle-policy-delete.md), and performing a [dry run](../operations/lifecycle-policy/lifecycle-policy-dry-run.md) of a lifecycle policy. | `create`, `update`, `delete`, `dryRun` | `editor` for the registry or repository that the lifecycle policy was created for.
**Manage resource access** |
[Granting a role](../../iam/operations/roles/grant.md), [revoking a role](../../iam/operations/roles/revoke.md), and viewing the roles assigned to a folder, a cloud, or a registry. | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` for the resource.

{% endif %}

#### What's next {what-is-next}

* [Assigning a role](../operations/roles/grant.md).
* [Viewing assigned roles](../operations/roles/get-assigned-roles.md).
* [Revoking a role](../operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [More information on inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).