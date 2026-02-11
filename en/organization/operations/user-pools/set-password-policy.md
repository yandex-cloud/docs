---
title: How to set up a password policy in a {{ org-full-name }} user pool
description: Follow this guide to set up a password policy in a {{ org-name }} user pool.
---

# Setting up a password policy


To set up a [password policy](../../concepts/password-policy.md):

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** and select the user pool.
  1. Click **{{ ui-key.yacloud_org.organization.userpools.title_password_policy }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) and select ![gear](../../../_assets/console-icons/gear.svg) **{{ ui-key.yacloud_org.organization.userpools.UserpoolOverviewPage.action_set_password_policy_aaDns }}**.
  1. Under **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.complexity_oeJs5 }}**, specify the character class settings for the password:

     * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.symbol_classes_any_fqb6f }}**: Configure the minimum length depending on the number of character classes used in the password:
 
       * One class (`abc`)
       * Two classes (`aBc`)
       * Three classes (`aBc1`)
       * Four classes (`aB#c1`)
       
       This is the preferred option because it does not require particular characters and allows users to create more memorable yet strong passwords.
 
     * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.symbol_classes_required_1BHUu }}**: Select the character types for the password by activating the following options:

       * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.option_lowers_75kTr }}**
       * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.option_uppers_ur5iy }}**
       * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.option_digits_ssY6G }}**
       * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.option_specials_6GSqK }}**

       In the **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.min_length_title_mvmiQ }}** field, specify the minimum number of characters in the password but not less than seven.
       
  1. Under **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.lifetime_hnEhW }}**, set the minimum and maximum password lifetime (up to 730 days) or select **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.unlimited_cSfYU }}**.
  1. Under **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.brute_force_protection_msHno }}**, specify:
     * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.attempts_before_lockout_ay7Le }}**: From 1 to 100.
     * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.failed_attempts_interval_wfd7Z }}** in minutes or seconds.
     * **{{ ui-key.yacloud_org.organization.userpools.UserpoolPasswordPolicyForm.lockout_duration_t1CZB }}** in minutes or seconds.

{% endlist %}