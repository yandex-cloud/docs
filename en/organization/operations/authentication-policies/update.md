---
title: How to edit an authentication policy in {{ org-full-name }}
description: Follow this guide to edit an authentication policy in {{ org-full-name }}.
---

# Editing an authentication policy

{% include [note-preview](../../../_includes/note-preview.md) %}

{% include [auth-policy-intro](../../../_includes/organization/auth-policy-intro.md) %}

{% include [auth-policy-role](../../../_includes/organization/auth-policy-role.md) %}

To edit an authentication policy:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}** and go to the **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_auth_policies }}** tab.
  1. In the row with the authentication policy, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Optionally, change the policy [name](*policy_name) in the **{{ ui-key.yacloud.common.name }}** field.
  1. Optionally, change the policy description in the **{{ ui-key.yacloud.common.description }}** field.
  1. Optionally, set [labels](*labels) for the policy in the **{{ ui-key.yacloud.common.labels }}** field.
  1. Optionally, toggle **{{ ui-key.yacloud_org.form.auth-policy.caption.active }}** to deactivate or activate the policy.
  1. Optionally, configure **{{ ui-key.yacloud_org.organization.security-settings.AuthPolicyForm.section_title_scope_b9vbe }}** policies:

      {% include [auth-policy-and-logic-notice](../../../_includes/organization/auth-policy-and-logic-notice.md) %}

      1. {% include [auth-policy-create-users](../../../_includes/organization/auth-policy-create-users.md) %}
      1. {% include [auth-policy-create-apps](../../../_includes/organization/auth-policy-create-apps.md) %}
      1. {% include [auth-policy-create-ntwrks](../../../_includes/organization/auth-policy-create-ntwrks.md) %}
      1. {% include [auth-policy-create-action](../../../_includes/organization/auth-policy-create-action.md) %}
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../../concepts/applications.md)
* [{#T}](../../concepts/authentication-policy.md)
* [{#T}](./create.md)
* [{#T}](./activate-deactivate.md)
* [{#T}](./delete.md)

[*policy_name]: The naming requirements are as follows:
* It must be between 3 and 63 characters in length.
* It can only contain lowercase Latin letters, numbers, and hyphens.
* It must start with a letter and cannot end with a hyphen.

[*labels]: Labels are `key:value` pairs you can use to logically group your resources. For more information, see [{#T}](../../../resource-manager/concepts/labels.md).
