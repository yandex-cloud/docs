---
title: Access management in {{ mtr-full-name }}
description: Access management in {{ TR }}, a cluster creation and management service. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action.
noIndex: true
---

# Managing access to {{ mtr-name }}

{% include [preview](../_includes/managed-trino/note-preview.md) %}


In this section, you will learn:

* [What resources you can assign a role for](#resources).
* [Roles existing in this service](#roles-list).
* [What roles are required for particular actions](#required-roles).

To use the service, log in to the management console with a [Yandex account](../iam/concepts/users/accounts.md#passport) or [federated account](../iam/concepts/users/accounts.md#saml-federation).

{% include [about-access-management](../_includes/iam/about-access-management.md) %}

To assign a role for a resource, a user should have the `managed-trino.admin` role or one of the following roles for that resource:

{% include [roles-list](../_includes/iam/roles-list.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../_includes/iam/basic-resources-for-access-control.md) %}

To allow access to {{ mtr-name }} resources, such as clusters and accounts, give the user the relevant roles for the folder, cloud, or organization containing those resources.

## Roles existing in this service {#roles-list}

Below is a list of all roles that are used to verify access rights in the service.

### Service roles {#service-roles}

#### managed-trino.auditor {#managed-trino-auditor}

{% include [trino.auditor](../_roles/managed-trino/auditor.md) %}

#### managed-trino.viewer {#managed-trino-viewer}

{% include [trino.viewer](../_roles/managed-trino/viewer.md) %}

#### managed-trino.editor {#managed-trino-editor}

{% include [trino.editor](../_roles/managed-trino/editor.md) %}

#### managed-trino.admin {#managed-trino-admin}

{% include [trino.admin](../_roles/managed-trino/admin.md) %}

#### managed-trino.integrationProvider {#managed-trino-integrationProvider}

{% include [managed-trino.integrationProvider](../_roles/managed-trino/integrationProvider.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../_includes/primitive-roles-footnote.md) %}

## Roles required {#required-roles}

To use the service, the user needs the `managed-trino.editor` role or higher for the folder in which the cluster is created. With the `managed-trino.viewer` role, one can only view the list of clusters.

To create an {{ mtr-name }} cluster, the following roles are required: [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user), [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user), and `managed-trino.admin` or higher.

You can always assign a role with more permissions. For example, you can assign the `managed-trino.admin` role instead of `managed-trino.editor`.

## What's next {#whats-next}

* [How to assign a role](../iam/operations/roles/grant.md).
* [How to revoke a role](../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

