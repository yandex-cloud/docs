---
title: Deleting an MFA policy in {{ org-full-name }}
description: Follow this guide to delete an MFA policy in {{ org-full-name }}.
---

# Deleting an MFA policy

{% include [note-preview](../../../_includes/note-preview.md) %}

To delete [an MFA policy](../../concepts/mfa.md#mfa-policies):

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Go to the **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_mfa_policies_m8oE3 }}** tab.
  1. In the MFA policy list, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) next to the policy in question and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm the operation.

{% endlist %}

#### See also {#see-also}

* [{#T}](./create-policy.md)
* [{#T}](./update-policy.md)
* [{#T}](./add-users.md)
* [{#T}](./deactivate-reactivate-policy.md)
* [{#T}](./manage-verification.md)
* [{#T}](../../concepts/mfa.md)