---
title: Access management in {{ vpc-full-name }} ({{ vpc-short-name }})
description: Access management within the cloud network service (private cloud), communications of cloud resources between themselves and with the internet – {{ vpc-full-name }} ({{ vpc-short-name }}). This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action.
---

# Access management in {{ vpc-name }}

{{ vpc-name }} uses [roles](../../iam/concepts/access-control/roles.md) to manage access rights.


In this section, you will learn:
* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#choosing-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

{% include [roles-assign](../../_includes/iam/roles-assign.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Which roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/vpc/security/service-roles-hierarchy.svg)

### Service roles {#service-roles}

#### vpc.auditor {#vpc-auditor}

{% include [vpc.auditor](../../_roles/vpc/auditor.md) %}

#### vpc.viewer {#vpc-viewer}

{% include [vpc-viewer](../../_roles/vpc/viewer.md) %}

#### vpc.user {#vpc-user}

{% include [vpc-user](../../_roles/vpc/user.md) %}

#### vpc.externalAddresses.user {#vpc-externalAddresses-user}

{% include [vpc.externalAddresses.user](../../_roles/vpc/externalAddresses/user.md) %}

#### vpc.admin {#vpc-admin}

{% include [vpc-admin](../../_roles/vpc/admin.md) %}

#### vpc.bridgeAdmin {#vpc-bridge-admin}

{% include [vpc.bridgeAdmin](../../_roles/vpc/bridgeAdmin.md) %}

#### vpc.privateAdmin {#vpc-private-admin}

{% include [vpc-privateadmin](../../_roles/vpc/privateAdmin.md) %}

#### vpc.publicAdmin {#vpc-public-admin}

{% include [vpc-publicadmin](../../_roles/vpc/publicAdmin.md) %}

#### vpc.gateways.viewer {#vpc-gw-viewer}

{% include [vpc.gateways.viewer](../../_roles/vpc/gateways/viewer.md) %}

#### vpc.gateways.user {#vpc-gw-user}

{% include [vpc-gateways-user](../../_roles/vpc/gateways/user.md) %}

#### vpc.gateways.editor {#vpc-gw-editor}

{% include [vpc-gateways-editor](../../_roles/vpc/gateways/editor.md) %}

#### vpc.securityGroups.user {#vpc-sg-user}

{% include [vpc.securityGroups.user](../../_roles/vpc/securityGroups/user.md) %}

#### vpc.securityGroups.admin {#vpc-sg-admin}

{% include [vpc-securitygroups-admin](../../_roles/vpc/securityGroups/admin.md) %}

#### vpc.privateEndpoints.viewer {#vpc-privateEndpoints-viewer}

{% include [vpc-privateEndpoints-viewer](../../_roles/vpc/privateEndpoints/viewer.md) %}

#### vpc.privateEndpoints.editor {#vpc-privateEndpoints-editor}

{% include [vpc-privateEndpoints-editor](../../_roles/vpc/privateEndpoints/editor.md) %}

#### vpc.privateEndpoints.admin {#vpc-privateEndpoints-admin}

{% include [vpc-privateEndpoints-admin](../../_roles/vpc/privateEndpoints/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles required to perform a particular action. You can always assign a role offering more permissions than the one specified. For example, you can assign the `editor` role instead of `viewer`, or `vpc.admin` instead of `vpc.publicAdmin`.

Action | Methods | Required roles
----- | ----- | -----
**Viewing data** | |
Viewing information about any resource | `get`, `list`, `listOperations` | `vpc.viewer` or `viewer` for the resource
List subnets in the network | `listSubnets` | `vpc.viewer` or `viewer` for the network
**Use of resources** | |
Assign {{ vpc-short-name }} resources to other {{ yandex-cloud }} resources (for example, assigning an address to an interface or connecting a network interface to a subnet) | Various | `vpc.user` for the resource, and the permission to change the receiving object if the resource assignment operation is mutating
Assign or delete the public address of an interface | various | `vpc.publicAdmin` for the network
Creating a VM connected to multiple networks | `create` | `vpc.publicAdmin` for each network the VM connects to
**Managing resources** | |
[Create networks in a folder](../operations/network-create.md) | `create` | `vpc.privateAdmin` or `editor` for the folder
[Update](../operations/network-update.md), and [delete networks](../operations/network-delete.md) | `update`, `delete` | `vpc.privateAdmin` or `editor` for the network
[Create subnets in a folder](../operations/subnet-create.md) | `create` | `vpc.privateAdmin` or `editor` for the folder and network
[Update](../operations/subnet-update.md) and [delete subnets](../operations/subnet-delete.md) | `update`, `delete` | `vpc.privateAdmin` or `editor` for the folder
[Creating a route table](../operations/static-route-create.md) | `create` | `vpc.privateAdmin` or `editor` for the folder
Update or delete a route table | `update`, `delete` | `vpc.privateAdmin` or `editor` for the route table
[Create public addresses](../operations/get-static-ip.md) | `create` | `vpc.publicAdmin` or `editor` for the folder
[Delete public addresses](../operations/address-delete.md) | `delete` | `vpc.publicAdmin` or `editor` for the address
[Create a gateway](../operations/create-nat-gateway.md) | `create` | `vpc.gateways.editor`
Enable the gateway in a route table | `create`, `update` |  `vpc.gateways.user`
Create security groups | `create` | `vpc.securityGroups.admin` or `editor` for the folder and network
Update and delete security groups | `update`, `delete` | `vpc.securityGroups.admin` or `editor` for the network and security group
**Resource access management** | |
[Granting a role](../../iam/operations/roles/grant.md), [revoking a role](../../iam/operations/roles/revoke.md), and viewing roles granted for the resource | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` for the resource

To create a [NAT gateway](../concepts/gateways.md) and connect it to a route table, the `vpc.gateways.editor` and `vpc.gateways.user` roles are required. Currently, you cannot use reserved public IP addresses for gateways, so the `vpc.admin` role will not be enough.

#### What's next {#what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
