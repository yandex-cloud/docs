---
title: "Access management in {{ compute-full-name }}"
description: "Access management in {{ compute-full-name }}, a service providing scalable computing capacities for creating and managing VM instances. This section describes what resources you can assign a role for and what roles the service supports."
---

# Access management in {{ compute-name }}

In this section, you will learn:
* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign roles to {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Which roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/compute/security/service-roles-hierarchy.svg)

### Service roles {#service-roles}

| Role | Permissions |
----- | -----
| `compute.admin` | Grants the right to manage VMs and [instance groups](../../compute/concepts/instance-groups/index.md) and assign roles to other users. |
| `compute.editor` | Gives rights to manage virtual machines and instance groups. |
| `compute.viewer` | Grants the right to view information on [{{ compute-name }} resources](../concepts/index.md). |
| `compute.disks.user` | Allows you to use disks to create new resources, such as virtual machines. |
| `compute.images.user` | Allows you to use images to create new resources, such as virtual machines. |
| `compute.operator` | Allows you to [stop, start, and restart virtual machines](../../compute/operations/vm-control/vm-stop-and-start.md), but does not allow creating or deleting virtual machines. |
| `compute.snapshotSchedules.editor` | Grants the permission to [create](../operations/snapshot-control/create-schedule.md) scheduled disk snapshots and [update](../operations/snapshot-control/update-schedule.md) them. |
| `compute.snapshotSchedules.viewer` | Grants the permission to view information about [scheduled disk snapshots](../concepts/snapshot-schedule.md). |
| `compute.osLogin` | Allows SSH access to VMs via OS Login. |
| `compute.osAdminLogin` | Allows SSH access to VMs via OS Login and enables you to run commands as a superuser (`sudo`). |
| `iam.serviceAccounts.user` | Verifies the right to use the service account.<br/>This role is required to perform operations with instance groups. If you specify a service account in the request, {{ iam-short-name }} will check whether you have permissions to use this account. |
| `resource-manager.clouds.member` | Role everyone requires to access cloud resources, except for [cloud owners](../../resource-manager/concepts/resources-hierarchy.md#owner) and [service accounts](../../iam/concepts/users/service-accounts.md). |
| `resource-manager.clouds.owner` | Grants you full access to a cloud and the resources in it. You can only assign this role for a cloud. |

For more information about service roles, see [{#T}](../../iam/concepts/access-control/roles.md) in the {{ iam-full-name }} service documentation.

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

#### What's next {#what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
