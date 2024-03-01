---
title: "Access management in {{ maf-full-name }}"
description: "Access management in the {{ AF }} database creation and management service. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action."
---

# Access management in {{ maf-name }}


In this section, you will learn:

* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To allow access to {{ maf-name }} service resources, assign the user the appropriate roles for the folder or cloud hosting the resources.

## Which roles exist in the service {#roles-list}

### Service roles {#service-roles}

Below is a list of all roles that are used to verify access rights in the service.

#### managed-airflow.viewer {#managed-airflow-viewer}

{% include [managed-airflow.viewer](../../_roles/managed-airflow/viewer.md) %}

#### managed-airflow.editor {#managed-airflow-editor}

{% include [managed-airflow.editor](../../_roles/managed-airflow/editor.md) %}

#### managed-airflow.admin {#managed-airflow-admin}

{% include [managed-airflow.admin](../../_roles/managed-airflow/admin.md) %}

### Primitive roles {#primitive-roles}

#### {{ roles-viewer }} {#viewer}

The `{{ roles-viewer }}` role enables you to view information about {{ maf-name }} clusters and their runtime logs.

#### {{ roles-editor }} {#editor}

Users with the `{{ roles-editor }}` role can manage any resource, e.g., create clusters and create and delete their subclusters.

This role includes the `{{ roles-viewer }}` role.

#### {{ roles-admin }} {#admin}

Users with the `{{ roles-admin }}` role can manage resource access rights, e.g., allow other users to create {{ maf-name }} clusters and to view information about user rights.

This role includes the `{{ roles-editor }}` role.

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

