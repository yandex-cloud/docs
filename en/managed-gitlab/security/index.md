---
title: "Access management in {{ mgl-full-name }}"
description: "Access management in {{ mgl-full-name }}, a web-based open-source DevOps lifecycle tool. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action."
---

# Access management in {{ mgl-name }}

In this section, you will learn:
* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#required-roles) for particular actions.


To use the service, log in to the management console with a [Yandex account](../../iam/concepts/users/accounts.md#passport) or [federated account](../../iam/concepts/users/accounts.md#saml-federation).


{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have the `gitlab.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Which resources you can assign a role for {#resources}

You can assign a role for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) or [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). Cloud roles also apply to nested folders.

## Which roles exist in the service {#roles-list}

### Service roles {#service-roles}

#### gitlab.auditor {#gitlab-auditor}

{% include [gitlab.auditor](../../_roles/gitlab/auditor.md) %}

#### gitlab.viewer {#gitlab-viewer}

{% include [gitlab.viewer](../../_roles/gitlab/viewer.md) %}

#### gitlab.editor {#gitlab-editor}

{% include [gitlab.editor](../../_roles/gitlab/editor.md) %}

#### gitlab.admin {#gitlab-admin}

{% include [gitlab.admin](../../_roles/gitlab/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## Roles required {#required-roles}

To use the service, you need the `{{ roles.gitlab.editor }}` [role](../../iam/concepts/access-control/roles.md) or higher for the folder where the projects are created. With the `{{ roles.gitlab.viewer }}` role, you can only view the list of projects and the contents of uploaded files.

You can always assign a role with more permissions. For instance, you can assign `{{ roles.gitlab.admin }}` instead of `{{ roles.gitlab.editor }}`.

To create a {{ GL }} instance, you also need the [`{{ roles-vpc-user }}`](../../vpc/security/index.md#vpc-user) role.


## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

