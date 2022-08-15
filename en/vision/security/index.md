---
title: Access management in Yandex Vision
description: "Access management in the computer vision and image analysis service — Yandex Vision. Permissions are issued when a role is assigned. The role can be assigned to the directory or the cloud — all permissions from the cloud are inherited. To use the service, you need one of the roles — editor, admin, resource-manager.cloud.owner"
---

# Access management in {{ vision-name }}

In this section, you'll learn:
* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control-without-service-account.md) %}

## What roles exist in the service {#roles-list}

### Service roles {#service-roles}

{% include [service-roles](../../_includes/roles-service-roles-vision.md) %}

For more information about service roles, see [{#T}](../../iam/concepts/access-control/roles.md) in the {{ iam-full-name }} service documentation.

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

#### What's next {#what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [More information on inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
