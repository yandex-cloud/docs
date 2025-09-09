---
title: Access management in {{ websql-name }}
description: Access management in {{ websql-name }}, a service for working with queries to managed database clusters. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required for specific actions.
---

# Access management in {{ websql-name }}


In this section, you will learn:

* [What resources you can assign a role for](#resources).
* [What roles this service has](#roles-list).
* [What roles are required](#required-roles) for specific actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

To assign a role for a resource, you need the `websql.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can also assign roles in the [{{ websql-name }} interface]({{ websql-link }}) for [saved](../concepts/index.md#saved-queries) and [historical queries](../concepts/index.md#query-log) you published.

## What roles this service has {#roles-list}

You can use {{ websql-full-name }} roles (_service roles_) and {{ yandex-cloud }} roles (_primitive roles_) to manage query access permissions.

### Service roles {#service-roles}

The list below shows all roles used for access control in {{ websql-name }}.

#### websql.executedQueries.auditor {#websql-executedQueries-auditor}

{% include [websql.executedQueries.auditor](../../_roles/websql/executedQueries/auditor.md) %}

#### websql.savedQueries.auditor {#websql-savedQueries-auditor}

{% include [websql.savedQueries.auditor](../../_roles/websql/savedQueries/auditor.md) %}

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

#### websql.auditor {#websql-auditor}

{% include [websql.auditor](../../_roles/websql/auditor.md) %}

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

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## What roles do I need {#required-roles}

The table below lists the roles required for specific actions. You can always assign a role with more permissions. For example, you can assign the `editor` role instead of `viewer`. If you need access to multiple types of managed DB clusters within one folder, you can assign the `mdb.auditor` role for this folder, but bear in mind that the user will thus get excessive [permissions](../../iam/roles-reference#mdb-auditor).

Action | Required roles
----- | -----
**Viewing queries** |
Viewing information on connections | `{{ roles-connection-manager-viewer }}` for an organization, cloud, folder, or connection
Viewing information on {{ PG }} connections | `{{ roles.mpg.viewer }}` for an organization, cloud, or folder
Viewing information on {{ MY }} connections | `{{ roles.mmy.viewer }}` for an organization, cloud, or folder
Viewing information on {{ CH }} connections | `{{ roles.mch.viewer }}` for an organization, cloud, or folder
Viewing information on {{ VLK }} connections | `{{ roles.mrd.viewer }}` for an organization, cloud, or folder
Viewing information on {{ SD }} connections | `{{ roles.mmg.viewer }}` for an organization, cloud, or folder
Viewing information on {{ GP }} connections | `{{ roles.mgp.viewer }}` for an organization, cloud, or folder
Viewing information on [{{ mtr-full-name }}](../../managed-trino/concepts/index.md) connections (the service is at the [Preview](../../overview/concepts/launch-stages.md) stage): | `managed-trino.viewer` for an organization, cloud, or folder
Viewing metadata of published queries | `websql.auditor` for an organization, cloud, or folder
Viewing published queries | `websql.viewer` for an organization, cloud, or folder
**Viewing and running queries** |
Using a database connection | `{{ roles-connection-manager-user }}` for an organization, cloud, folder, or connection
Viewing information on {{ PG }} connections | `{{ roles.mpg.viewer }}` for an organization, cloud, or folder
Viewing information on {{ MY }} connections | `{{ roles.mmy.viewer }}` for an organization, cloud, or folder
Viewing information on {{ CH }} connections | `{{ roles.mch.viewer }}` for an organization, cloud, or folder
Viewing information on {{ VLK }} connections | `{{ roles.mrd.viewer }}` for an organization, cloud, or folder
Viewing information on {{ SD }} connections | `{{ roles.mmg.viewer }}` for an organization, cloud, or folder
Viewing information on {{ GP }} connections | `{{ roles.mgp.viewer }}` for an organization, cloud, or folder
Viewing information on [{{ mtr-full-name }}](../../managed-trino/concepts/index.md) connections (the service is at the [Preview](../../overview/concepts/launch-stages.md) stage): | `managed-trino.viewer` for an organization, cloud, or folder
Running queries | `websql.user` for an organization, cloud, or folder
Running [{{ mtr-full-name }}](../../managed-trino/concepts/index.md) queries (currently at the [Preview](../../overview/concepts/launch-stages.md) stage): | `managed-trino.user` for an organization, cloud, or folder
**Viewing, running, and publishing queries** |
Using a database connection | `{{ roles-connection-manager-user }}` for an organization, cloud, folder, or connection
Viewing information on {{ PG }} connections | `{{ roles.mpg.viewer }}` for an organization, cloud, or folder
Viewing information on {{ MY }} connections | `{{ roles.mmy.viewer }}` for an organization, cloud, or folder
Viewing information on {{ CH }} connections | `{{ roles.mch.viewer }}` for an organization, cloud, or folder
Viewing information on {{ VLK }} connections | `{{ roles.mrd.viewer }}` for an organization, cloud, or folder
Viewing information on {{ SD }} connections | `{{ roles.mmg.viewer }}` for an organization, cloud, or folder
Viewing information on {{ GP }} connections | `{{ roles.mgp.viewer }}` for an organization, cloud, or folder
Viewing information on [{{ mtr-full-name }}](../../managed-trino/concepts/index.md) connections (the service is at the [Preview](../../overview/concepts/launch-stages.md) stage): | `managed-trino.viewer` for an organization, cloud, or folder
Running, publishing, and editing queries | `websql.editor` for an organization, cloud, or folder
Running [{{ mtr-full-name }}](../../managed-trino/concepts/index.md) queries (currently at the [Preview](../../overview/concepts/launch-stages.md) stage): | `managed-trino.user` for an organization, cloud, or folder
**Managing queries** |
Using a database connection | `{{ roles-connection-manager-user }}` for an organization, cloud, folder, or connection
Viewing information on {{ PG }} connections | `{{ roles.mpg.viewer }}` for an organization, cloud, or folder
Viewing information on {{ MY }} connections | `{{ roles.mmy.viewer }}` for an organization, cloud, or folder
Viewing information on {{ CH }} connections | `{{ roles.mch.viewer }}` for an organization, cloud, or folder
Viewing information on {{ VLK }} connections | `{{ roles.mrd.viewer }}` for an organization, cloud, or folder
Viewing information on {{ SD }} connections | `{{ roles.mmg.viewer }}` for an organization, cloud, or folder
Viewing information on {{ GP }} connections | `{{ roles.mgp.viewer }}` for an organization, cloud, or folder
Viewing information on [{{ mtr-full-name }}](../../managed-trino/concepts/index.md) connections (the service is at the [Preview](../../overview/concepts/launch-stages.md) stage): | `managed-trino.viewer` for an organization, cloud, or folder
Running, publishing, and editing queries and managing access permissions to them | `websql.admin` for an organization, cloud, or folder
Running [{{ mtr-full-name }}](../../managed-trino/concepts/index.md) queries (currently at the [Preview](../../overview/concepts/launch-stages.md) stage): | `managed-trino.user` for an organization, cloud, or folder

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).


