---
title: Access management in {{ maf-full-name }}
description: Access management in {{ AF }}, a database creation and management service. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required for specific actions.
---

# Access management in {{ maf-name }}


In this section, you will learn:

* [What resources you can assign a role for](#resources).
* [What roles exist in this service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

To assign a role for a resource, a user should have the `managed-airflow.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To allow access to {{ maf-name }} resources, assign the user the appropriate roles for the folder, cloud, or organization containing these resources.

## What roles exist in this service {#roles-list}

### Service roles {#service-roles}

The list below shows all the roles used for access control in {{ maf-name }}.

#### managed-airflow.auditor {#managed-airflow-auditor}

{% include [managed-airflow.auditor](../../_roles/managed-airflow/auditor.md) %}

#### managed-airflow.viewer {#managed-airflow-viewer}

{% include [managed-airflow.viewer](../../_roles/managed-airflow/viewer.md) %}

#### managed-airflow.user {#managed-airflow-user}

{% include [managed-airflow.user](../../_roles/managed-airflow/user.md) %}

#### managed-airflow.editor {#managed-airflow-editor}

{% include [managed-airflow.editor](../../_roles/managed-airflow/editor.md) %}

#### managed-airflow.admin {#managed-airflow-admin}

{% include [managed-airflow.admin](../../_roles/managed-airflow/admin.md) %}

#### managed-airflow.integrationProvider {#managed-airflow-integrationProvider}

{% include [managed-airflow.integrationProvider](../../_roles/managed-airflow/integrationProvider.md) %}

### Primitive roles {#primitive-roles}

#### {{ roles-viewer }} {#viewer}

The `{{ roles-viewer }}` role enables you to view information about {{ maf-name }} clusters and their performance logs.

#### {{ roles-editor }} {#editor}

Users with the `{{ roles-editor }}` role can manage any resource, e.g., create clusters and create or delete their subclusters.

This role includes the `{{ roles-viewer }}` role.

#### {{ roles-admin }} {#admin}

Users with the `{{ roles-admin }}` role can manage resource access permissions, e.g., allow other users to create {{ maf-name }} clusters or to view information about user permissions.

This role includes the `{{ roles-editor }}` role.

## What roles are required {#required-roles}

To use {{ maf-name }}, you need the [{{ roles.maf.editor }} role or higher](../../iam/concepts/access-control/roles.md) for the folder to house the new cluster. The `{{ roles.maf.viewer }}` role allows you only to view the list of clusters.

To create a {{ maf-name }} cluster, you need the [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) role and the `{{ roles.maf.editor }}` role or higher.

You can always assign a role with more permissions. For example, you can assign the `{{ roles.maf.admin }}` role instead of `{{ roles.maf.editor }}`.

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

