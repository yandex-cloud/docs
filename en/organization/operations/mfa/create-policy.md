---
title: Creating an MFA policy in {{ org-full-name }}
description: Follow this guide to create and set up an MFA policy in {{ org-full-name }}.
---

# Creating an MFA policy

{% include [note-preview](../../../_includes/note-preview.md) %}

[MFA policies](../../concepts/mfa.md#mfa-policies) enable configuring [multi-factor authentication](https://en.wikipedia.org/wiki/Multi-factor_authentication) (MFA) for [federated](../../../iam/concepts/users/accounts.md#saml-federation) and [local](../../../iam/concepts/users/accounts.md#local) user accounts.

To create an MFA policy:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Go to the **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_mfa_policies_m8oE3 }}** tab.
  1. In the top-right corner, click ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.organization.security-settings.mfa-policies-create-policy-action }}** and in the window that opens:

      1. In the **{{ ui-key.yacloud_org.forms.field.display-name }}** field, enter a name for the new policy. Follow these naming requirements:

          {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}
      1. {% include [mfa-create-policy-step2](../../../_includes/organization/mfa-create-policy-step2.md) %}
      1. If you do not want to activate the policy upon creation, disable **{{ ui-key.yacloud_org.form.mfa-enforcement.caption.active }}**.
      1. {% include [mfa-create-policy-step4](../../../_includes/organization/mfa-create-policy-step4.md) %}
      1. {% include [mfa-create-policy-step5](../../../_includes/organization/mfa-create-policy-step5.md) %}
      1. {% include [mfa-create-policy-step6](../../../_includes/organization/mfa-create-policy-step6.md) %}
      1. Click **{{ ui-key.yacloud_org.form.mfa-enforcement.create.action.create }}**.

{% endlist %}

{% include [mfa-policy-add-users-notice](../../../_includes/organization/mfa-policy-add-users-notice.md) %}

#### See also {#see-also}

* [{#T}](./update-policy.md)
* [{#T}](./add-users.md)
* [{#T}](./deactivate-reactivate-policy.md)
* [{#T}](./delete-policy.md)
* [{#T}](./manage-verification.md)
* [{#T}](../../concepts/mfa.md)