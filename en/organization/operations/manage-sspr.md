---
title: Configuring self-service password reset in {{ org-full-name }}
description: Follow this guide to configure self-service password reset (SSPR) in {{ org-full-name }}.
---

# Configuring self-service password reset in {{ org-full-name }}

You can enable [self-service password reset (SSPR)](https://en.wikipedia.org/wiki/Self-service_password_reset) for [local](../../iam/concepts/users/accounts.md#local) {{ org-full-name }} users using [MFA policies](../concepts/mfa.md).

To configure self-service password reset:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shield](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Navigate to the **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_mfa_policies_m8oE3 }}** tab.
  1. In the MFA policy list, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) in the policy row and select ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. If you do not have an MFA policy, [create](./mfa/create-policy.md) a new one. In the window that opens:

      1. To enable [self-service password reset](../../organization/concepts/sspr.md) for users added to an MFA policy target group, under **{{ ui-key.yacloud_org.organization.security-settings.MfaPolicyForm.sspr-section_4HP7w }}**:

          1. Enable **{{ ui-key.yacloud_org.organization.security-settings.MfaPolicyForm.caption_sspr_enabled_dXFne }}**.
          1. In the **{{ ui-key.yacloud_org.organization.security-settings.MfaPolicyForm.caption_sspr_methods_7Xw6F }}** field, select at least one user verification method during the password reset:

          {% include [password-reset-mfa-methods](../../_includes/organization/password-reset-mfa-methods.md) %}

      {% note info %}

      To disable self-service password reset, disable **{{ ui-key.yacloud_org.organization.security-settings.MfaPolicyForm.caption_sspr_enabled_dXFne }}** under **{{ ui-key.yacloud_org.organization.security-settings.MfaPolicyForm.sspr-section_4HP7w }}**.

      {% endnote %}

  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../concepts/sspr.md)
* [{#T}](../concepts/mfa.md)
* [{#T}](./user-account/reset-password.md)