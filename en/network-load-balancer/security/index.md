---
title: Access management in {{ network-load-balancer-full-name }}
description: Access management in the {{ network-load-balancer-full-name }} network balancer service. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action.
---

# Access management in {{ network-load-balancer-name }}

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

![image](../../_assets/network-load-balancer/security/service-roles-hierarchy.svg)

### Service roles {#service-roles}

#### load-balancer.auditor {#load-balancer-auditor}

{% include [load-balancer.auditor](../../_roles/load-balancer/auditor.md) %}

#### load-balancer.viewer {#load-balancer-viewer}

{% include [loadbalancer-viewer](../../_roles/load-balancer/viewer.md) %}

#### load-balancer.privateAdmin {#load-balancer-private-admin}

{% include [loadbalancer-privateadmin](../../_roles/load-balancer/privateAdmin.md) %}

#### load-balancer.admin {#load-balancer-admin}

{% include [loadbalancer-admin](../../_roles/load-balancer/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles required to perform a particular action. You can always assign a role offering more permissions than the one specified. For example, you can assign the `editor` role instead of `viewer`.

Any operations with a network load balancer that has a public IP address require the `load-balancer.admin` role. In networks where target groups are located, you can have the `vpc.publicAdmin` role instead. Operations on the internal network load balancer require the `load-balancer.privateAdmin` role and operations on its target groups, the `load-balancer.privateAdmin` or `compute.admin` role.

Operations on target groups located in subnets, where the specified administrative roles are missing, require the `vpc.user` role for these subnets.

| Action | Methods | Required roles |
----- | ----- | -----
| **View data** | |
| View information about any resource | `get`, `list`, `listOperations` | `viewer` for this resource |
| **Manage network load balancers** | |
| [Create](../operations/load-balancer-create.md) and update load balancers in folders | `create` | `load-balancer.privateAdmin` / `load-balancer.admin` or `editor` for the folder and, if the load balancer is public, networks where target groups are located |
| [Delete load balancers](../operations/load-balancer-delete.md) | `update`, `delete` | `load-balancer.privateAdmin` / `load-balancer.admin` or `editor` for the load balancer |
| [Attach target groups](../operations/target-group-attach.md) | `attachTargetGroup` | `load-balancer.privateAdmin` / `load-balancer.admin` or `editor` for the folder and, if the load balancer is public, networks where target groups are located |
| [Detach target groups](../operations/target-group-detach.md) | `detachTargetGroup` | `load-balancer.privateAdmin` / `load-balancer.admin` or `editor` for the load balancer |
| [Get states of target groups](../operations/check-resource-health.md) | `getTargetStates` | `load-balancer.viewer` or `viewer` for the load balancer and the specified target groups |
| [Add](../operations/listener-add.md) and [remove](../operations/listener-remove.md) listeners | `addListener`, `removeListener` | `load-balancer.privateAdmin` / `load-balancer.admin` or `editor` for the load balancer |
| [Stop and start](../operations/load-balancer-start-and-stop.md) a load balancer | `stop`, `start` | `load-balancer.privateAdmin` / `load-balancer.admin` or `editor` for the load balancer |
| **Manage target groups** | |
| [Create](../operations/target-group-create.md) and update target groups in folders | `create` | `load-balancer.privateAdmin` / `load-balancer.admin` or `editor` for the folder and subnets where target groups are located |
| [Delete target groups](../operations/target-group-delete.md) | `update`, `delete` | `load-balancer.privateAdmin` / `load-balancer.admin` or `editor` for the target group and load balancer |
| Add resources in a target group | `addTargets` | `load-balancer.privateAdmin` / `load-balancer.admin` or `editor` for the target group, load balancer, and subnets where target groups are located |
| Remove resources in a target group | `removeTargets` | `load-balancer.privateAdmin` / `load-balancer.admin` or `editor` for the target group |
| **Manage resource access** | |
| [Grant a role](../../iam/operations/roles/grant.md), [revoke a role](../../iam/operations/roles/revoke.md), and view roles granted for the resource | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` for the resource |

#### What's next {what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
