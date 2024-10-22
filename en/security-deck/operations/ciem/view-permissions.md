---
title: Viewing a list of accesses in the {{ sd-full-name }} CIEM
description: In this section, you will learn how to view all account's or group's access permissions for organization resources in the {{ sd-name }} CIEM.
---

# Viewing a list of a subject's accesses

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

[Cloud Infrastructure Entitlement Management (CIEM)](../../concepts/ciem.md) enables you to view a list of individual [subject](../../../iam/concepts/access-control/index.md#subject) and group access permissions for organization [resources](../../../iam/concepts/access-control/resources-with-access-control.md) in a centralized manner.

Only [organization members](../../../organization/concepts/membership.md) who with the `organization-manager.viewer` [role](../../../organization/security/index.md#organization-manager-viewer) or higher for the organization can view access permissions in the [{{ sd-name }} interface]({{ link-sd-main }}iam-diagnostics/).

To get a list of a subject's accesses to the organization's resources:

{% list tabs group=instructions %}

- {{ sd-name }} interface {#cloud-sd}

  1. [Log in]({{ link-passport-login }}) as an organization user with the `organization-manager.viewer` [role](../../../organization/security/index.md#organization-manager-viewer) or higher for the organization.
  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![person-gear](../../../_assets/console-icons/person-gear.svg) **CIEM**.
  1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.page.acl-diagnostics.action_select-subject }}** and in the window that opens:
  
      1. Select the [user](../../../overview/roles-and-resources.md#users), [service account](../../../iam/concepts/users/accounts.md#sa), [user group](../../../organization/concepts/groups.md), [system group](../../../iam/concepts/access-control/system-group.md), or [public group](../../../iam/concepts/access-control/public-group.md) you need.

          You may want to use the search feature.
      1. Click **{{ ui-key.yacloud.common.select }}**.

{% endlist %}

This will open a list of accesses assigned to the selected subject. For each access, the list indicates the name/ID and type of resource, the [role](../../../iam/concepts/access-control/roles.md) assigned to the subject for that resource, and information about whether the role was assigned to the subject directly or inherited from a group of which the subject is a member.

If the selected subject has multiple accesses, only some of them will be displayed. To display the remaining access permissions, сlick **Load more** at the bottom of the page.

Use filtering by resource ID, role ID, or access assignment method (`{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_direct }}` or `{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_group }}`) as needed.

Cloud Infrastructure Entitlement Management does not display subjects' access permissions for [{{ datalens-full-name }}](../../../datalens/index.yaml) [billing accounts](../../../billing/concepts/billing-account.md) and resources.

#### See also {#see-also}

* [{#T}](./revoke-permissions.md)
* [{#T}](../../concepts/ciem.md)
* [{#T}](../../security/index.md)