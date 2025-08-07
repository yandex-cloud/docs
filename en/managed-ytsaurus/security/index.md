---
title: Access management in {{ myt-full-name }}
description: Access management in {{ ytsaurus-name }}, a cluster creation and management service. This section covers the resources supporting role assignment, the roles this service has, and the required roles for specific actions.
---

# Access management in {{ myt-name }}

{% include [preview](../../_includes/managed-ytsaurus/note-preview.md) %}

In this section, you will learn:

* [What resources you can assign a role for](#resources).
* [What roles this service has](#roles-list).
* [What roles are required for specific actions](#required-roles).

To use the service, log in to the management console with a [Yandex account](../../iam/concepts/users/accounts.md#passport) or [federated account](../../iam/concepts/users/accounts.md#saml-federation).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

To assign a role for a resource, you should have the `managed-ytsaurus.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To allow access to {{ myt-name }} resources, such as clusters and accounts, give the user the relevant roles for the folder, cloud, or organization containing those resources.

## What roles exist in this service {#roles-list}

Below is a list of all roles relevant for access control in the service.

### Service roles {#service-roles}

#### managed-ytsaurus.auditor {#managed-ytsaurus-auditor}

{% include [managed-ytsaurus.auditor](../../_roles/managed-ytsaurus/auditor.md) %}

#### managed-ytsaurus.viewer {#managed-ytsaurus-viewer}

{% include [managed-ytsaurus.viewer](../../_roles/managed-ytsaurus/viewer.md) %}

#### managed-ytsaurus.user {#managed-ytsaurus-user}

{% include [managed-ytsaurus.user](../../_roles/managed-ytsaurus/user.md) %}

#### managed-ytsaurus.editor {#managed-ytsaurus-editor}

{% include [managed-ytsaurus.editor](../../_roles/managed-ytsaurus/editor.md) %}

#### managed-ytsaurus.admin {#managed-ytsaurus-admin}

{% include [managed-ytsaurus.admin](../../_roles/managed-ytsaurus/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Roles required {#required-roles}

To use the service, the user needs the `managed-ytsaurus.editor` role or higher for the folder in which the cluster is created. With the `managed-ytsaurus.viewer` role, one can only view the list of clusters.

To create an {{ myt-name }} cluster, the following roles are required: [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user), [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user), and `managed-ytsaurus.admin` or higher.

You can always assign a role with more permissions. For example, you can assign the `managed-ytsaurus.admin` role instead of `managed-ytsaurus.editor`.

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).