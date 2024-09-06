---
title: "Access management in {{ mos-full-name }}"
description: "Access management in {{ OS }}, the database creation and management service. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action."
---

# Managing access to {{ mos-name }}


In this section, you will learn:

* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#required-roles) for particular actions.

To use the service, log in to the management console with a [Yandex account](../../iam/concepts/users/accounts.md#passport) or [federated account](../../iam/concepts/users/accounts.md#saml-federation).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have the `mdb.admin`, `managed-opensearch.admin`, or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To allow access to {{ mos-name }} resources (clusters and hosts, cluster backups, and accounts), assign the user the appropriate roles for a folder, cloud, or organization containing these resources.

## Which roles exist in the service {#roles-list}

The chart below shows which roles are available in the service and how they inherit each other's permissions. For example, the `{{ roles-editor }}` role includes all the permissions of `{{ roles-viewer }}`. You can find the description of each role under the chart.

![image](../../_assets/mdb/roles-managed-opensearch.svg)

### Service roles {#service-roles}

#### managed-opensearch.auditor {#managed-opensearch-auditor}

{% include [opensearch.auditor](../../_roles/managed-opensearch/auditor.md) %}

#### managed-opensearch.viewer {#managed-opensearch-viewer}

{% include [opensearch.viewer](../../_roles/managed-opensearch/viewer.md) %}

#### managed-opensearch.editor {#managed-opensearch-editor}

{% include [opensearch.editor](../../_roles/managed-opensearch/editor.md) %}

#### managed-opensearch.admin {#managed-opensearch-admin}

{% include [opensearch.admin](../../_roles/managed-opensearch/admin.md) %}

#### mdb.auditor {#mdb-auditor}

{% include [mdb-auditor](../../_roles/mdb/auditor.md) %}

#### mdb.viewer {#mdb-viewer}

{% include [mdb-viewer](../../_roles/mdb/viewer.md) %}

#### mdb.admin {#mdb-admin}

{% include [mdb-admin](../../_roles/mdb/admin.md) %}

#### vpc.publicAdmin {#vpc-public-admin}

{% include [vpc-publicadmin](../../_roles/vpc/publicAdmin.md) %}


### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## Roles required {#required-roles}

To use the service, you need the [{{ roles.mos.editor }} role](../../iam/concepts/access-control/roles.md) or higher for the folder to house the new cluster. The `{{ roles.mos.viewer }}` role enables you only to view the list of clusters.

To create a {{ mos-name }} cluster, you need the [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) role and the `{{ roles.mos.editor }}` role or higher.

You can always assign a role with more permissions. For instance, you can assign `{{ roles.mos.admin }}` instead of `{{ roles.mos.editor }}`.

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

