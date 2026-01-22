---
title: Access management in {{ mtr-full-name }}
description: Access management in {{ TR }}, a cluster creation and management service. This section describes the resources for which you can assign a role, the roles existing in this service, and the roles required for specific actions.
---

# Managing access to {{ mtr-name }}


In this section, you will learn about:

* [Resources you can assign a role for](#resources).
* [Roles this service has](#roles-list).
* [Roles required](#required-roles) for specific actions.

To use the service, log in to the management console with your [Yandex account](../iam/concepts/users/accounts.md#passport), [federated account](../iam/concepts/users/accounts.md#saml-federation), or [local account](../iam/concepts/users/accounts.md#local).

{% include [about-access-management](../_includes/iam/about-access-management.md) %}

To assign a role for a resource, a user should have the `managed-trino.admin` role or one of the following roles for that resource:

{% include [roles-list](../_includes/iam/roles-list.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../_includes/iam/basic-resources-for-access-control.md) %}

To allow access to {{ mtr-name }} resources, such as clusters and accounts, give the user the relevant roles for the folder, cloud, or organization containing those resources.

You can assign a role for an individual cluster in the [management console]({{ link-console-main }}), via the [CLI](../cli), or [API](./api-ref/authentication.md).

## Roles this service has {#roles-list}

The list below shows all the roles used for access control in this service.

{% include [roles-managed-trino](../_mermaid/roles/managed-trino.md) %}

### Service roles {#service-roles}

#### managed-trino.auditor {#managed-trino-auditor}

{% include [managed-trino.auditor](../_roles/managed-trino/auditor.md) %}

#### managed-trino.viewer {#managed-trino-viewer}

{% include [managed-trino.viewer](../_roles/managed-trino/viewer.md) %}

#### managed-trino.user {#managed-trino-user}

{% include [managed-trino.user](../_roles/managed-trino/user.md) %}

#### managed-trino.editor {#managed-trino-editor}

{% include [managed-trino.editor](../_roles/managed-trino/editor.md) %}

#### managed-trino.admin {#managed-trino-admin}

{% include [managed-trino.admin](../_roles/managed-trino/admin.md) %}

#### managed-trino.integrationProvider {#managed-trino-integrationProvider}

{% include [managed-trino.integrationProvider](../_roles/managed-trino/integrationProvider.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../_includes/primitive-roles-footnote.md) %}

## Required roles {#required-roles}

As a user, you need the `managed-trino.editor` role or higher for the folder that will contain the new cluster. The `managed-trino.viewer` role only allows you to view the list of clusters.

To create an {{ mtr-name }} cluster, the following roles are required: [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user), [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user), and `managed-trino.admin` or higher.

You can always assign a role with more permissions. For example, you can assign the `managed-trino.admin` role instead of `managed-trino.editor`.

## What's next {#whats-next}

* [How to assign a role](../iam/operations/roles/grant.md).
* [How to revoke a role](../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../iam/concepts/access-control/index.md).
* [Learn more about role inheritance](../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

