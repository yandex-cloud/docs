---
title: Common {{ sd-full-name }} roles
description: Managing access permissions in {{ sd-full-name }} information security management service. To allow a user access to {{ sd-name }} resources, assign them the roles from the list below.
---

# Common {{ sd-full-name }} roles

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. If a user has no roles yet, they cannot perform any operations.

To allow a user or group, e.g., Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated user](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), or [system group](../../iam/concepts/access-control/system-group.md), access to {{ sd-name }} resources, assign them the roles from the list below. Currently, a role can only be assigned for a folder or cloud and it is inherited by nested resources.

{% note info %}

For more information about role inheritance, see [Inheritance of access permissions](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-name }} documentation.

{% endnote %}

## What roles exist in this service {#roles-list}

In {{ sd-name }}, you can manage access using both service and primitive roles.

### Service roles {#service-roles}

#### security-deck.auditor {#security-deck-auditor}

{% include [security-deck.auditor](../../_roles/security-deck/auditor.md) %}

#### security-deck.viewer {#security-deck-viewer}

{% include [security-deck.viewer](../../_roles/security-deck/viewer.md) %}

#### security-deck.editor {#security-deck-editor}

{% include [security-deck.editor](../../_roles/security-deck/editor.md) %}

#### security-deck.admin {#security-deck-admin}

{% include [security-deck.admin](../../_roles/security-deck/admin.md) %}

{{ yandex-cloud }} also supports a separate list of roles for each {{ sd-name }} module. For more information, see:

* [Roles for {{ atr-name }} data analysis](./access-transparency-roles.md).
* [Roles for Data Security Posture Management](./dspm-roles.md).
* [Roles for Cloud Infrastructure Entitlement Management](./ciem-roles.md).

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## See also {#see-also}

[Hierarchy of {{ yandex-cloud }}](../../resource-manager/concepts/resources-hierarchy.md) resources