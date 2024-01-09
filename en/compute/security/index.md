---
title: "Access management in {{ compute-full-name }}"
description: "Access management in {{ compute-full-name }}, a service providing scalable computing capacities for creating and managing VM instances. This section describes the resources for which you can assign a role and the roles existing in the service."
---

# Access management in {{ compute-name }}

In this section, you will learn:
* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can also assign a role for a separate VM.

## Which roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/compute/security/service-roles-hierarchy.svg)

### Service roles {#service-roles}

| Role | Permissions |
----- | -----
| `compute.admin` | Grants the permission to manage VMs and [instance groups](../../compute/concepts/instance-groups/index.md) and assign roles to other users. |
| `compute.editor` | Grants the permission to manage virtual machines and instance groups. |
| `compute.viewer` | Grants the permission to view information on [{{ compute-name }} resources](../concepts/index.md). |
| `compute.auditor` | Enables you to view the amount of used resources and quotas, disk limits, lists of {{ compute-name }} resource operations and their details. |
| `compute.disks.user` | Allows you to use disks to create new resources, such as virtual machines. |
| `compute.images.user` | Allows you to use images to create new resources, such as virtual machines. |
| `compute.operator` | Allows you to [stop, start, and restart virtual machines](../../compute/operations/vm-control/vm-stop-and-start.md), but does not allow creating or deleting them. |
| `compute.snapshotSchedules.editor` | Grants the permission to [create](../operations/snapshot-control/create-schedule.md) scheduled disk snapshots and [update](../operations/snapshot-control/update-schedule.md) them. |
| `compute.snapshotSchedules.viewer` | Grants the permission to view information about [scheduled disk snapshots](../concepts/snapshot-schedule.md). |
| `compute.osLogin` | Allows SSH access to VMs via OS Login. |
| `compute.osAdminLogin` | Allows SSH access to VMs via OS Login and enables you to run commands as a superuser (`sudo`). |
| `iam.serviceAccounts.user` | Verifies the right to use the service account.<br/>This role is required to perform operations with instance groups. If you specify a service account in the request, {{ iam-short-name }} will check whether you have permissions to use this account. |

For more information about service roles, see [{#T}](../../iam/concepts/access-control/roles.md) in the {{ iam-full-name }} service documentation.

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

#### What's next {#what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
