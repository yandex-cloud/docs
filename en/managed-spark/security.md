---
title: Access management in {{ msp-full-name }}
description: Access management in {{ SPRK }}, a cluster creation and management service. This section covers the resources supporting role assignment, the roles this service has, and the required roles for specific actions.
---

# Managing access to {{ msp-name }}

{% include notitle [preview](../_includes/note-preview.md) %}


In this section, you will learn:

* [What resources you can assign a role for](#resources).
* [What roles this service has](#roles-list).
* [What roles are required for specific actions](#required-roles).

To use the service, log in to the management console with a [Yandex account](../iam/concepts/users/accounts.md#passport) or [federated account](../iam/concepts/users/accounts.md#saml-federation).

{% include [about-access-management](../_includes/iam/about-access-management.md) %}

To assign a role for a resource, a user should have the `managed-spark.admin` role or one of the following roles for that resource:

{% include [roles-list](../_includes/iam/roles-list.md) %}

## Resources supporting role assignment {#resources}

{% include [basic-resources](../_includes/iam/basic-resources-for-access-control.md) %}

To allow access to {{ msp-name }} resources, such as clusters and accounts, give the user the relevant roles for the folder, cloud, or organization containing those resources.

## What roles exist in this service {#roles-list}

Below is a list of all roles that are used to verify access rights in the service.

### Service roles {#service-roles}

#### managed-spark.auditor {#managed-spark-auditor}

{% include [managed-spark.auditor](../_roles/managed-spark/auditor.md) %}

#### managed-spark.viewer {#managed-spark-viewer}

{% include [managed-spark.viewer](../_roles/managed-spark/viewer.md) %}

#### managed-spark.user {#managed-spark-user}

{% include [managed-spark.user](../_roles/managed-spark/user.md) %}

#### managed-spark.editor {#managed-spark-editor}

{% include [managed-spark.editor](../_roles/managed-spark/editor.md) %}

#### managed-spark.admin {#managed-spark-admin}

{% include [managed-spark.admin](../_roles/managed-spark/admin.md) %}

#### managed-spark.integrationProvider {#managed-spark-integrationProvider}

{% include [managed-spark.integrationProvider](../_roles/managed-spark/integrationProvider.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../_includes/primitive-roles-footnote.md) %}

## Roles required {#required-roles}

To use the service, the user needs the `managed-spark.editor` role or higher for the folder in which the cluster is created. With the `managed-spark.viewer` role, one can only view the list of clusters.

To create an {{ msp-name }} cluster, the following roles are required: [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user), [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user), and `managed-spark.admin` or higher.

You can always assign a role with more permissions. For example, you can assign the `managed-spark.admin` role instead of `managed-spark.editor`.

## What's next {#whats-next}

* [How to assign a role](../iam/operations/roles/grant.md)
* [How to revoke a role](../iam/operations/roles/revoke.md)
* [Learn more about access management in {{ yandex-cloud }}](../iam/concepts/access-control/index.md)
* [Learn more about role inheritance](../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance)

