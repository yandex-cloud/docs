---
title: Viewing a list of accesses in the {{ sd-full-name }} {{ ciem-name }}
description: In this section, you will learn how to view all access permissions an account or group has for the organization resources in the {{ sd-name }} {{ ciem-name }}.
---

# Viewing a list of a subject's accesses

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

[Cloud Infrastructure Entitlement Management](../../concepts/ciem.md) (CIEM) provides a centralized view of the full list of access permissions for the organization's [resources](../../../iam/concepts/access-control/resources-with-access-control.md) available to individual [subjects](../../../iam/concepts/access-control/index.md#subject) and groups.

Only [organization members](../../../organization/concepts/membership.md) with the `organization-manager.viewer` [role](../../../organization/security/index.md#organization-manager-viewer) or higher for the organization can view access permissions in the [{{ sd-name }}]({{ link-sd-main }}iam-diagnostics/) interface.

To get a list of a subject's accesses to the organization's resources:

{% include [view-subject-access-bindings](../../../_includes/security-deck/view-subject-access-bindings.md) %}


#### See also {#see-also}

* [{#T}](./revoke-permissions.md)
* [{#T}](../../concepts/ciem.md)
* [{#T}](../../security/index.md)