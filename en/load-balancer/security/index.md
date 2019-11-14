# Access management

In this section, you'll learn:

* [What resources you can assign the](#resources) role to.
* [What roles exist in the service](#roles-list).
* [What roles are required](#required-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to. {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## What roles exist in the service {#roles-list}

The diagram shows which roles are available in the service and how they inherit each other's permissions. For example, the `editor` role includes all `viewer` role permissions. A description of each role is given under the diagram.

![image](service-roles-hierarchy.svg)

Active roles in the service:

* Service roles:
    * {% include [resource-manager.clouds.owner](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.owner.md) %}
    * {% include [resource-manager.clouds.member](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.member.md) %}
* Primitive roles:
    * {% include [viewer](../../_includes/iam/roles/short-descriptions/viewer.md) %}
    * {% include [editor](../../_includes/iam/roles/short-descriptions/editor.md) %}
    * {% include [admin](../../_includes/iam/roles/short-descriptions/admin.md) %}

## What roles do I need {#required-roles}

The table below lists the roles needed to perform a given action. You can always assign a role granting more permissions than the role specified. For example, you can assign `editor` instead of `viewer`.

| Action | Methods | Required roles |
| ----- | ----- | ----- |
| **View data** |  |
| View information about any resource | `get`, `list`, `listOperations` | `viewer` for this resource |
| **Manage load balancers** |  |
| [Create load balancers in a folder](../operations/load-balancer-create.md) | `create` | `editor` for the folder and specified target groups |
| Update and [delete load balancers](../operations/load-balancer-delete.md) | `update`, `delete` | `editor` for the load balancer and specified target groups |
| [Attach](../operations/target-group-attach.md) and [detach target groups](../operations/target-group-detach.md) | `attachTargetGroup`, `detachTargetGroup` | `editor` for the load balancer and specified target groups |
| [Get states of target groups](../operations/check-resource-health.md) | `getTargetStates` | `viewer` for the load balancer and specified target groups |
| [Add](../operations/listener-add.md) and [remove](../operations/listener-remove.md) listeners | `addListener`, `removeListener` | `editor` for the load balancer |
| [Stop](../operations/load-balancer-stop.md) and [start](../operations/load-balancer-start.md) a load balancer | `stop`, `start` | `editor` for the load balancer |
| **Manage target groups** |  |
| [Create target groups in a folder](../operations/target-group-create.md) | `create` | `editor` for the folder and specified subnets |
| Update and [delete target groups](../operations/target-group-delete.md) | `update`, `delete` | `editor` for the target group, load balancer, and specified subnets |
| Add and remove resources in a target group | `addTargets`, `removeTargets` | `editor` for the target group, load balancer, and specified subnets |
| **Manage resource access** |  |
| [Assign a role](../../iam/operations/roles/grant.md), [revoke a role](../../iam/operations/roles/revoke.md), and view roles granted for the resource | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` for the resource |

#### What's next

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Read more about access management in Yandex.Cloud](../../iam/concepts/access-control/index.md).
* [More about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

