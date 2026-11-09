---
title: Viewing a list of a subject's accesses in {{ org-full-name }}
description: In this section, you will learn how to view all access permissions of an account or group to resources in a {{ org-full-name }} organization.
---

# Viewing a list of a subject's accesses

You can have a centralized view of the full list of access permissions for the organization's [resources](../../iam/concepts/access-control/resources-with-access-control.md) held by individual [subjects](../../iam/concepts/access-control/index.md#subject) and groups. This can be done either via [{{ access-analyzer-name }} module](../../security-deck/concepts/access-analyzer.md) or the [{{ yandex-cloud }} CLI](../../cli/index.yaml).

Only organization members who have the `organization-manager.viewer` [role](../../organization/security/index.md#organization-manager-viewer) or higher for the organization can view access permissions in the {{ sd-name }} interface.

Access diagnostics via the {{ yandex-cloud }} CLI is available from release 0.171 onward.

To get a list of a subject's accesses to the organization's resources:

{% include [view-subject-access-bindings](../../_includes/security-deck/view-subject-access-bindings.md) %}

In {{ sd-full-name }}, you can also enable automatic analysis and recommendations for reducing excessive permissions and revoking unused roles. For more information, see [{#T}](../../security-deck/operations/access-analyzer/use-recommendations.md).

#### Useful links {#see-also}

* [{#T}](../../security-deck/operations/access-analyzer/use-recommendations.md)
* [{#T}](../../security-deck/concepts/access-analyzer.md)
* [{#T}](../../security-deck/security/index.md)