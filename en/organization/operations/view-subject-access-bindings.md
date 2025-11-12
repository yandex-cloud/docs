---
title: Viewing a list of a subject's accesses in {{ org-full-name }}
description: In this section, you will learn how to view all account's or group's access permissions for resources in a {{ org-full-name }} organization.
---

# Viewing a list of a subject's accesses

You can have a centralized view of the full list of access permissions for the organization's [resources](../../iam/concepts/access-control/resources-with-access-control.md) held by individual [subjects](../../iam/concepts/access-control/index.md#subject) and groups. This can be done either via [{{ sd-full-name }}]({{ link-sd-main }})'s [{{ ciem-name }} module](../../security-deck/concepts/ciem.md) or the [{{ yandex-cloud }} CLI](../../cli/).

 [Only organization members](../../organization/concepts/membership.md) who have the `organization-manager.viewer` [role](../../organization/security/index.md#organization-manager-viewer) or higher for the organization can view access permissions in the {{ sd-name }} interface.

Access diagnostics via the {{ yandex-cloud }} CLI is available from release 0.171 onward.

To get a list of a subject's accesses to the organization's resources:

{% include [view-subject-access-bindings](../../_includes/security-deck/view-subject-access-bindings.md) %}


#### See also {#see-also}

* [{#T}](../../security-deck/concepts/ciem.md)
* [{#T}](../../security-deck/security/index.md)