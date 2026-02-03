---
title: Enabling the two-factor authentication requirement
description: This guide will help you set up access to resources only for users with two-factor authentication.
---

# Enabling the two-factor authentication requirement

You can deny {{ yandex-cloud }} authentication to all [Yandex account](../../iam/concepts/users/accounts.md#passport) users in your organization without [two-factor authentication](https://yandex.com/support/id/en/authorization/twofa.html) enabled.

{% note warning %}

With this setting on, all users authenticated without the two-factor identity check, including administrators and owners, will lose access to the organization and all its resources.

To grant access to the organization, [configure](https://id.yandex.ru/security/enter-methods) two-factor authentication for the Yandex account. It is best to notify the users of the organization in advance of the required actions.

{% endnote %}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.

      [Switch](./manage-organizations.md#switch-to-another-org) to an organization of your choice as required.

  1. In the left-hand panel, select ![shield](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.oslogin.title }}**.
  1. Navigate to the **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_other_kJgk8 }}** tab and, under **{{ ui-key.yacloud_org.organization.security-settings.OtherSecuritySettingsForm.auth_settings_1RoAM }}**, enable **{{ ui-key.yacloud_org.organization.security-settings.OtherSecuritySettingsForm.required_mfa_6P4xN }}**.

{% endlist %}

#### See also {#see-also}

* [{#T}](../operations/os-login-access.md)
* [{#T}](../operations/enable-refresh-tokens.md)
* [{#T}](../operations/hide-user-info.md)