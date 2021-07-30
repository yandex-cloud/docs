---
title: Access management in Yandex Object Storage (S3)
description: "Access management in the service providing a scalable storage solution — Yandex Object Storage (S3). The section describes which resources can be assigned a role, which roles are active in the service."

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Access management in {{ objstorage-name }}

In this section, you'll learn:

* [What resources you can assign roles to](#resources).
* [What roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to {#resources}

In the {{ yandex-cloud }} console, you can assign a role for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). In YC CLI, you can assign a role for a cloud, folder, or [bucket](../../storage/concepts/bucket.md). These roles also apply to nested resources.

## What roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![service-roles-hierarchy](../../_assets/storage/service-roles-hierarchy.svg)

### Service roles

| Role | Permissions |
| ----- | ----- |
| `resource-manager.clouds.member` | The role required to access resources in the cloud for all users except [cloud owners](../../resource-manager/concepts/resources-hierarchy.md#owner) and [service accounts](../../iam/concepts/users/service-accounts.md). |
| `resource-manager.clouds.owner` | Grants you full access to a cloud and the resources in it. You can only assign this role for a cloud. |
| `storage.admin` | Gives the right to manage {{ objstorage-name }}. |
| `storage.configViewer` | The role allows users to view the security settings of buckets and [objects](../../storage/concepts/object.md) in them, but doesn't grant them access to data stored in buckets. |
| `storage.configurer` | Lets you manage the settings of [object lifecycles](../../storage/concepts/lifecycles.md), [static site hosting](../../storage/concepts/hosting.md), [access policy](../concepts/policy.md), and [CORS](../../storage/concepts/cors.md). |
| `storage.editor` | Permits any operations on buckets and objects in them. |
| `storage.uploader` | Gives the right to upload objects to buckets. |
| `storage.viewer` | Gives access to read the list of buckets, their settings, and data in buckets. |

For more information about service roles, see [{#T}](../../iam/concepts/access-control/roles.md) in the {{ iam-full-name }} documentation.

### Primitive roles

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

