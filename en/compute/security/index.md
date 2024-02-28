---
title: "Access management in {{ compute-full-name }}"
description: "Access management in {{ compute-full-name }}, a service providing scalable computing capacities for creating and managing VM instances. This section describes the resources for which you can assign a role and the roles existing in the service."
---

# Access management in {{ compute-name }}

In this section, you will learn:
* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can also assign a role for a separate VM.

## Which roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/compute/security/service-roles-hierarchy.svg)

### Service roles {#service-roles}

#### compute.auditor {#compute-auditor}

{% include [compute.auditor](../../_roles/compute/auditor.md) %}

#### compute.viewer {#compute-viewer}

{% include [compute.viewer](../../_roles/compute/viewer.md) %}

#### compute.editor {#compute-editor}

{% include [compute.editor](../../_roles/compute/editor.md) %}

#### compute.admin {#compute-admin}

{% include [compute.admin](../../_roles/compute/admin.md) %}

#### compute.osLogin {#compute-oslogin}

{% include [compute.oslogin](../../_roles/compute/osLogin.md) %}

#### compute.osAdminLogin {#compute-osadminlogin}

{% include [compute.osadminlogin](../../_roles/compute/osAdminLogin.md) %}

#### compute.disks.user {#compute-disks-user}

{% include [compute.disks.user](../../_roles/compute/disks/user.md) %}

#### compute.images.user {#compute-images-user}

{% include [compute.images.user](../../_roles/compute/images/user.md) %}

#### compute.operator {#compute-operator}

{% include [compute.operator](../../_roles/compute/operator.md) %}

#### compute.snapshotSchedules.viewer {#compute-snapshotSchedules-viewer}

{% include [compute.snapshotSchedules.viewer](../../_roles/compute/snapshotSchedules/viewer.md) %}

#### compute.snapshotSchedules.editor {#compute-snapshotSchedules-editor}

{% include [compute.snapshotSchedules.editor](../../_roles/compute/snapshotSchedules/editor.md) %}

#### iam.serviceAccounts.user {#iam-serviceAccounts-user}

{% include [iam.serviceAccounts.user](../../_roles/iam/serviceAccounts/user.md) %}

For more information about service roles, see [{#T}](../../iam/concepts/access-control/roles.md) in the {{ iam-full-name }} service documentation.

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

#### What's next {#what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
