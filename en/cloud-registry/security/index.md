---
title: Access management in {{ cloud-registry-full-name }}
description: Access management in {{ cloud-registry-full-name }}, a secure storage service for software artifacts. For access to {{ cloud-registry-name }} resources, assign to the user the required roles from the list below.
---

# Access management in {{ cloud-registry-full-name }}

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. As long as a user has no roles assigned, all operations are forbidden.

To allow access to {{ cloud-registry-name }} resources, assign the required roles from the list below to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md).

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

{% note info %}

For more information about role inheritance, see [Inheritance of access permissions](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-name }} documentation.

{% endnote %}

You can also assign a role for [{{ cloud-registry-name }} registries](../concepts/registry.md) as well as directories inside them.

## Which roles exist in the service {#roles-list}

In {{ cloud-registry-name }}, you can manage access using both service and primitive roles.

### Service roles {#service-roles}

#### cloud-registry.auditor {#cloud-registry-auditor}

{% include [cloud-registry-auditor](../../_roles/cloud-registry/auditor.md) %}

#### cloud-registry.viewer {#cloud-registry-viewer}

{% include [cloud-registry-viewer](../../_roles/cloud-registry/viewer.md) %}

#### cloud-registry.editor {#cloud-registry-editor}

{% include [cloud-registry-editor](../../_roles/cloud-registry/editor.md) %}

#### cloud-registry.admin {#cloud-registry-admin}

{% include [cloud-registry-admin](../../_roles/cloud-registry/admin.md) %}

#### cloud-registry.artifacts.puller {#cloud-registry-artifacts-puller}

{% include [cloud-registry-artifacts-puller](../../_roles/cloud-registry/artifacts/puller.md) %}

#### cloud-registry.artifacts.pusher {#cloud-registry-artifacts-pusher}

{% include [cloud-registry-artifacts-pusher](../../_roles/cloud-registry/artifacts/pusher.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## See also {#see-also}

[Hierarchy of {{ yandex-cloud }} resources](../../resource-manager/concepts/resources-hierarchy.md)
