---
title: Viewing a list of accesses in the {{ sd-full-name }} {{ ciem-name }}
description: In this section, you will learn how to view all access permissions an account or group has for the organization resources in the {{ sd-name }} {{ ciem-name }}.
---

# Viewing a list of a subject's accesses

[{{ ciem-full-name }} ({{ ciem-name }})](../../concepts/ciem.md) enables you to view a list of individual [subject](../../../iam/concepts/access-control/index.md#subject) and group access permissions for organization [resources](../../../iam/concepts/access-control/resources-with-access-control.md) in a centralized manner.

Only [organization members](../../../organization/concepts/membership.md) with the `organization-manager.viewer` [role](../../../organization/security/index.md#organization-manager-viewer) or higher for the organization can view access permissions in the [{{ sd-name }}]({{ link-sd-main }}iam-diagnostics/) interface.

To get a list of a subject's accesses to the organization's resources:

{% include [view-subject-access-bindings](../../../_includes/security-deck/view-subject-access-bindings.md) %}


#### See also {#see-also}

* [{#T}](./revoke-permissions.md)
* [{#T}](../../concepts/ciem.md)
* [{#T}](../../security/index.md)