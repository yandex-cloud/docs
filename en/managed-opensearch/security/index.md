---
title: Access management in {{ mos-full-name }}
description: Access management in {{ OS }}, a solution for creating and managing databases. This section describes the resources for which you can assign a role, the roles existing in this service, and the roles required for specific actions.
---

# Managing access to {{ mos-name }}


In this section, you will learn about:

* [Resources you can assign a role for](#resources).
* [Roles this service has](#roles-list).
* [Roles required for specific actions](#required-roles).

To use the service, log in to the management console with your [Yandex account](../../iam/concepts/users/accounts.md#passport), [federated account](../../iam/concepts/users/accounts.md#saml-federation), or [local account](../../iam/concepts/users/accounts.md#local).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

To assign a role for a resource, you need the `mdb.admin` role, the `managed-opensearch.admin` role, or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To allow access to {{ mos-name }} resources (clusters and hosts, cluster backups, and accounts), assign the user the appropriate roles for a folder, cloud, or organization containing these resources.

You can assign a role for a separate cluster from the [management console]({{ link-console-main }}) or via the [API](../api-ref/authentication.md).

## Roles this service has {#roles-list}

The chart below shows the roles existing in the service and their permission inheritance. For example, `{{ roles-editor }}` inherits all `{{ roles-viewer }}` permissions. You can find the role descriptions below the chart.

{% include [roles-managed-opensearch](../../_mermaid/roles/managed-opensearch.md) %}

### Service roles {#service-roles}

#### managed-opensearch.auditor {#managed-opensearch-auditor}

{% include [opensearch.auditor](../../_roles/managed-opensearch/auditor.md) %}

#### managed-opensearch.viewer {#managed-opensearch-viewer}

{% include [opensearch.viewer](../../_roles/managed-opensearch/viewer.md) %}

#### managed-opensearch.restorer {#managed-opensearch-restorer}

{% include [opensearch.restorer](../../_roles/managed-opensearch/restorer.md) %}

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

#### mdb.restorer {#mdb-restorer}

{% include [mdb-restorer](../../_roles/mdb/restorer.md) %}

#### vpc.publicAdmin {#vpc-public-admin}

{% include [vpc-publicadmin](../../_roles/vpc/publicAdmin.md) %}


### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Required roles {#required-roles}

To use {{ maf-name }}, you need the [{{ roles.mos.editor }} role or higher](../../iam/concepts/access-control/roles.md) for the folder that will contain the new cluster. The `{{ roles.mos.viewer }}` role only allows you to view the list of clusters.

To create a {{ mos-name }} cluster, you need the [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) role and the `{{ roles.mos.editor }}` role or higher.

You can always assign a role with more permissions. For example, you can assign the `{{ roles.mos.admin }}` role instead of `{{ roles.mos.editor }}`.

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

