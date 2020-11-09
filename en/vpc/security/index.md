# Access management

In this section, you'll learn:

* [What resources you can assign roles to](#resources).
* [What roles exist in the service](#roles-list).
* [What roles are required](#choosing-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to. {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## What roles exist in the service {#roles-list}

The diagram shows which roles are available in the service and how they inherit each other's permissions. For example, the `editor` role includes all `viewer` role permissions. A description of each role is given under the diagram.

![image](service-roles-hierarchy.png)

Active roles in the service:

* Service roles:
    * {% include [resource-manager.clouds.owner](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.owner.md) %}
    * {% include [resource-manager.clouds.member](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.member.md) %}
    * {% include [vpc.viewer](../../_includes/iam/roles/short-descriptions/vpc.viewer.md) %}
    * {% include [vpc.user](../../_includes/iam/roles/short-descriptions/vpc.user.md) %}
    * {% include [vpc.privateAdmin](../../_includes/iam/roles/short-descriptions/vpc.privateAdmin.md) %}
    * {% include [vpc.publicAdmin](../../_includes/iam/roles/short-descriptions/vpc.publicAdmin.md) %}
    * {% include [vpc.securityGroups.admin](../../_includes/iam/roles/short-descriptions/vpc.securityGroups.admin.md) %}
    * {% include [vpc.admin](../../_includes/iam/roles/short-descriptions/vpc.admin.md) %}
* Primitive roles:
    * {% include [viewer](../../_includes/iam/roles/short-descriptions/viewer.md) %}
    * {% include [editor](../../_includes/iam/roles/short-descriptions/editor.md) %}
    * {% include [admin](../../_includes/iam/roles/short-descriptions/admin.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles needed to perform a given action. You can always assign a role granting more permissions than the role specified. For example, assign `editor` instead of `viewer` or `vpc.admin` instead of `vpc.publicAdmin`.

| Action | Methods | Required roles |
| ----- | ----- | ----- |
| **View data** |  |
| View information about any resource | `get`, `list`, `listOperations` | `vpc.viewer` or `viewer` for this resource |
| List subnets in the network | `listSubnets` | `vpc.viewer` or `viewer` for the network |
| **Use of resources** |  |
| Assign {{ vpc-short-name }} resources to other {{ yandex-cloud }} resources (for example, assigning an address to a VM or connecting a network interface to a subnet) | Various | `vpc.user` for the resource and the right to change the receiving object if the resource assignment operation is mutating |
| Creating a VM connected to multiple networks | `create` | `vpc.publicAdmin` for each network the VM is connecting to |
| **Manage resources** |  |
| [Create networks in a folder](../operations/network-create.md) | `create` | `vpc.privateAdmin` or `editor` for the folder |
| [Update](../operations/network-update.md), and [delete networks](../operations/network-delete.md) | `update`, `delete` | `vpc.privateAdmin` or `editor` for the network |
| [Create subnets in a folder](../operations/subnet-create.md) | `create` | `vpc.privateAdmin` or `editor` for the folder and network |
| [Update](../operations/subnet-update.md) and [delete subnets](../operations/subnet-delete.md) | `update`, `delete` | `vpc.privateAdmin` or `editor` for the folder |
| [Create a route table](../operations/static-route-create.md) | `create` | `vpc.privateAdmin` or `editor` for the folder |
| Update or delete a route table | `update`, `delete` | `vpc.privateAdmin` or `editor` for the route table |
| [Create public addresses](../operations/get-static-ip.md) | `create` | `vpc.publicAdmin` or `editor` for the folder |
| [Delete public addresses](../operations/address-delete.md) | `delete` | `vpc.publicAdmin` or `editor` for the address |
| [Enable NAT to the internet](../operations/enable-nat.md) |  | `vpc.publicAdmin` or `editor` for the subnet |
| Create security groups | `create` | `vpc.securityGroups.admin` or `editor` for the folder and network |
| Update and delete security groups | `update`, `delete` | `vpc.securityGroups.admin` or `editor` for the network and security group |
| **Manage resource access** |  |
| [Assign](../../iam/operations/roles/grant.md), [revoke](../../iam/operations/roles/revoke.md), and view roles granted for the resource | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` for the resource |

#### What's next {#what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [For more information about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

