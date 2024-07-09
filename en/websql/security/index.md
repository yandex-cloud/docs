---
title: "Access management in {{ websql-name }}"
description: "Access management in {{ websql-name }}, a service used to manage queries to managed database clusters. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action."
---

# Access management in {{ websql-name }}

In this section, you will learn:

* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have the `websql.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can also assign roles to saved and historical queries you published.

## Which roles exist in the service {#roles-list}

You can use {{ websql-full-name }} roles (_service roles_) and {{ yandex-cloud }} roles (_primitive roles_) to manage query access permissions.

### Service roles {#service-roles}

The list below shows all roles considered when verifying access permissions in {{ websql-name }}.

#### websql.executedQueries.viewer {#websql-executedQueries-viewer}

{% include [websql.executedQueries.viewer](../../_roles/websql/executedQueries/viewer.md) %}

The role is assigned for a published historical query.

#### websql.savedQueries.viewer {#websql-savedQueries-viewer}

{% include [websql.savedQueries.viewer](../../_roles/websql/savedQueries/viewer.md) %}

The role is assigned for a saved query you published.

#### websql.executedQueries.editor {#websql-executedQueries-editor}

{% include [websql.executedQueries.editor](../../_roles/websql/executedQueries/editor.md) %}

The role is assigned for a published historical query.

#### websql.savedQueries.editor {#websql-savedQueries-editor}

{% include [websql.savedQueries.editor](../../_roles/websql/savedQueries/editor.md) %}

The role is assigned for a saved query you published.

#### websql.executedQueries.admin {#websql-executedQueries-admin}

{% include [websql.executedQueries.admin](../../_roles/websql/executedQueries/admin.md) %}

The role is assigned for a published historical query.

#### websql.savedQueries.admin {#websql-savedQueries-admin}

{% include [websql.savedQueries.admin](../../_roles/websql/savedQueries/admin.md) %}

The role is assigned for a saved query you published.

#### websql.viewer {#websql-viewer}

{% include [websql.viewer](../../_roles/websql/viewer.md) %}

#### websql.user {#websql-user}

{% include [websql.user](../../_roles/websql/user.md) %}

#### websql.editor {#websql-editor}

{% include [websql.editor](../../_roles/websql/editor.md) %}

#### websql.admin {#websql-admin}

{% include [websql.admin](../../_roles/websql/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
