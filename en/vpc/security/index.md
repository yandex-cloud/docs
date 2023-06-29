---
title: "Managing access in {{ vpc-full-name }} ({{ vpc-short-name }})"
description: "Managing access within the cloud network service (private cloud), mutual communications between cloud services, and their online interactions — {{ vpc-full-name }} ({{ vpc-short-name }}). This section describes which resources you can assign roles to, which roles exist in the service, and which roles are required for particular actions."
---

# Access management in {{ vpc-name }}

{{ vpc-name }} uses [roles](../../iam/concepts/access-control/roles.md) to manage access rights.


In this section, you will learn:
* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#choosing-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign roles to {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Which roles exist in the service {#roles-list}

The chart below shows which roles are available in the service and how they inherit each other's permissions. For example, the `editor` role includes all `viewer` role permissions. You can find the description of each role under the chart.

![image](../../_assets/vpc/security/service-roles-hierarchy.svg)

Active roles in the service:

* Service roles:
   * {% include [resource-manager.clouds.owner](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.owner.md) %}
   * {% include [resource-manager.clouds.member](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.member.md) %}
   * {% include [vpc.viewer](../../_includes/iam/roles/short-descriptions/vpc.viewer.md) %}
   * {% include [vpc.user](../../_includes/iam/roles/short-descriptions/vpc.user.md) %}
   * {% include [vpc.privateAdmin](../../_includes/iam/roles/short-descriptions/vpc.privateAdmin.md) %}
   * {% include [vpc.publicAdmin](../../_includes/iam/roles/short-descriptions/vpc.publicAdmin.md) %}
   * {% include [vpc.gateways.editor](../../_includes/iam/roles/short-descriptions/vpc.gateways.editor.md) %}
   * {% include [vpc.gateways.user](../../_includes/iam/roles/short-descriptions/vpc.gateways.user.md) %}
   * {% include [vpc.securityGroups.admin](../../_includes/iam/roles/short-descriptions/vpc.securityGroups.admin.md) %}
   * {% include [vpc.admin](../../_includes/iam/roles/short-descriptions/vpc.admin.md) %}
* Primitive roles:
   * {% include [viewer](../../_includes/iam/roles/short-descriptions/viewer.md) %}
   * {% include [editor](../../_includes/iam/roles/short-descriptions/editor.md) %}
   * {% include [admin](../../_includes/iam/roles/short-descriptions/admin.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles needed to perform a particular action. You can always assign a role granting more permissions than the role specified. For example, assign `editor` instead of `viewer` or `vpc.admin` instead of `vpc.publicAdmin`.

| Action | Methods | Required roles |
----- | ----- | -----
| **View data** | |
| View information about any resource | `get`, `list`, `listOperations` | `vpc.viewer` or `viewer` for this resource |
| List subnets in the network | `listSubnets` | `vpc.viewer` or `viewer` for the network |
| **Use of resources** | |
| Assign {{ vpc-short-name }} resources to other {{ yandex-cloud }} resources (for example, assigning an address to an interface or connecting a network interface to a subnet) | Various | `vpc.user` for the resource and the right to change the receiving object if the resource assignment operation is mutating |
| Assign or delete the public address of an interface | various | `vpc.publicAdmin` for the network |
| Creating a VM connected to multiple networks | `create` | `vpc.publicAdmin` for each network the VM is connecting to |
| **Manage resources** | |
| [Create networks in a folder](../operations/network-create.md) | `create` | `vpc.privateAdmin` or `editor` for the folder |
| [Update](../operations/network-update.md), and [delete networks](../operations/network-delete.md) | `update`, `delete` | `vpc.privateAdmin` or `editor` for the network |
| [Create subnets in a folder](../operations/subnet-create.md) | `create` | `vpc.privateAdmin` or `editor` for the folder and network |
| [Update](../operations/subnet-update.md) and [delete subnets](../operations/subnet-delete.md) | `update`, `delete` | `vpc.privateAdmin` or `editor` for the folder |
| [Create a route table](../operations/static-route-create.md) | `create` | `vpc.privateAdmin` or `editor` for the folder |
| Update or delete a route table | `update`, `delete` | `vpc.privateAdmin` or `editor` for the route table |
| [Create public addresses](../operations/get-static-ip.md) | `create` | `vpc.publicAdmin` or `editor` for the folder |
| [Delete public addresses](../operations/address-delete.md) | `delete` | `vpc.publicAdmin` or `editor` for the address |
| [Create a gateway](../operations/create-nat-gateway.md) | `create` | `vpc.gateways.editor` |
| Enable the gateway in a route table | `create`, `update` | `vpc.gateways.user` |
| Create security groups | `create` | `vpc.securityGroups.admin` or `editor` for the folder and network |
| Update and delete security groups | `update`, `delete` | `vpc.securityGroups.admin` or `editor` for the network and security group |
| **Managing resource access** | |
| [Grant a role](../../iam/operations/roles/grant.md), [revoke a role](../../iam/operations/roles/revoke.md), and view roles granted for the resource | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` for the resource |

To create a [NAT gateway](../concepts/gateways.md) and connect it to a route table, you must be assigned the `vpc.gateways.editor` and `vpc.gateways.user` roles. Currently, you cannot use reserved public IP addresses for gateways, so the `vpc.admin` role is not enough.

#### What's next {#what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
