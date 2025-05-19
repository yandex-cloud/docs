---
title: Access management in {{ alb-full-name }}
description: Access management in {{ alb-full-name }}, a service terminating TLS connections and routing requests to backend applications. This section covers the resources supporting role assignment, the available service roles, and required permissions for specific actions.
---

# Access management in {{ alb-name }}

In this section, you will learn:
* [What resources support role assignment](#resources).
* [What roles are available in this service](#roles-list).
* [What roles are required](#required-roles) for specific actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

{% include [roles-assign](../../_includes/iam/roles-assign.md) %}

## Resources supporing role assignment {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Available service roles {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/application-load-balancer/security/service-roles-hierarchy.svg)

### Service roles {#service-roles}

#### alb.auditor {#alb-auditor}

{% include [alb.auditor](../../_roles/alb/auditor.md) %}

#### alb.viewer {#alb-viewer}

{% include [alb.viewer](../../_roles/alb/viewer.md) %}

#### alb.user {#alb-user}

{% include [alb.user](../../_roles/alb/user.md) %}

#### alb.editor {#alb-editor}

{% include [alb.editor](../../_roles/alb/editor.md) %}

#### alb.admin {#alb-admin}

{% include [alb.admin](../../_roles/alb/admin.md) %}

{% note info %}

Assigning a public IP address to an L7 load balancer requires `vpc.publicAdmin` and `alb.editor` / `alb.admin` role permissions for the network where the load balancer is located.

{% endnote %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## What roles do I need {#required-roles}

The table below lists the roles required for specific actions. You can always assign a role with more permissions. For example, you can assign the `editor` role instead of `viewer`.

Action | Methods | Required roles
----- | ----- | -----
**Viewing data** | |
Viewing resource details | `get`, `list`, `listOperations` | `alb.viewer` for the required resource
**Managing L7 load balancers** | |
[Creating](../operations/application-load-balancer-create.md) and [updating](../operations/application-load-balancer-update.md) L7 load balancers with public IP addresses | `create` | `alb.editor` and `vpc.publicAdmin` for the network containing the load balancer
Creating and updating L7 load balancers without public IP addresses | `create` | `alb.editor`
[Deleting L7 load balancers](../operations/application-load-balancer-delete.md) | `update`, `delete` | `alb.editor`
Getting target group statuses | `getTargetStates` | `alb.viewer`
Adding, updating, and removing listeners | `addListener`, `updateListener`, `removeListener` | `alb.editor`
Adding, updating, and removing SNI listeners | `addSniMatch`, `updateSniMatch`, `removeSniMatch` | `alb.editor`
Getting TLS listener certificates | `addListener`, `updateListener` | `certificate-manager.certificates.downloader`
Stopping and starting an L7 load balancer | `stop`, `start` | `alb.editor`
**Managing HTTP routers** | |
[Creating an HTTP router](../operations/http-router-create.md) | `create` | `alb.editor`
[Updating an HTTP router](../operations/http-router-update.md) | `update` | `alb.editor`
[Deleting an HTTP router](../operations/http-router-delete.md) | `delete` | `alb.editor`
**Managing backend groups** | |
[Creating](../operations/backend-group-create.md) and [updating](../operations/backend-group-update.md) backend groups | `create`, `update`, `updateBackend` | `alb.editor`
[Deleting backend groups](../operations/backend-group-delete.md) | `delete` | `alb.editor`
Adding resources to a backend group | `addBackend` | `alb.editor`
Removing resources from a backend group | `removeBackend` | `alb.editor`
**Managing target groups** | |
[Creating](../operations/target-group-create.md) and [updating](../operations/target-group-update.md) target groups in a folder | `create`, `update` | `alb.editor`
[Deleting target groups](../operations/target-group-delete.md) | `delete` | `alb.editor`
Adding resources to a target group | `addTargets` | `alb.editor`
Removing resources from a target group | `removeTargets` | `alb.editor`
**Resource access management** | |
[Granting](../../iam/operations/roles/grant.md), [revoking](../../iam/operations/roles/revoke.md), and viewing assigned resource roles | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` for the required resource

#### What's next

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
