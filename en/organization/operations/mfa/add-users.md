---
title: Applying an MFA policy to users in {{ org-full-name }}
description: Follow this guide to add and delete users and groups to and from an MFA policy in {{ org-full-name }}.
---

# Applying an MFA policy to users

{% include [note-preview](../../../_includes/note-preview.md) %}

For an [MFA policy](../../concepts/mfa.md#mfa-policies) to apply to user accounts, you need to explicitly add the relevant users or the [groups](../../concepts/groups.md) they are members of to the policy's target groups.

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Navigate to the **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_mfa_policies_m8oE3 }}** tab and select the policy you need from the list. In the window that opens:

      1. Go to the **{{ ui-key.yacloud_org.organization.security-settings.MfaPolicyPageLayout.tab_groups }}** tab.
      1. To add a new user or group to the policy's target groups:

          1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.mfa-policy-audiences.action_add-users }}**.
          1. In the window that opens, select the required user or user group.
          1. Click **{{ ui-key.yacloud.common.add }}**.
      1. To delete a user or group from the policy:
          1. In the list of users and groups, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}** next to the user or user group.
          1. Confirm the deletion.

{% endlist %}

{% include [mfa-policy-applications-acc-type-notice](../../../_includes/organization/mfa-policy-applications-acc-type-notice.md) %}

#### See also {#see-also}

* [{#T}](./create-policy.md)
* [{#T}](./update-policy.md)
* [{#T}](./deactivate-reactivate-policy.md)
* [{#T}](./delete-policy.md)
* [{#T}](./manage-verification.md)
* [{#T}](../../concepts/mfa.md)