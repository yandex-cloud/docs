---
title: "Editing a rule in a security profile"
description: "Follow this guide to edit a rule in a security profile."
---

# Editing a rule in a security profile

You can update [basic rules](../concepts/profiles.md), Smart Protection, and WAF in a [security profile](../concepts/rules.md). ARL rules are [updated in an ARL profile](arl-rule-update.md).

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to update a rule in a security profile.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. Select the profile to update a rule in.
   1. In the **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** tab, next to the rule to edit, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
   1. Edit the basic rule settings:
      * **{{ ui-key.yacloud.common.name }}**​.
      * **{{ ui-key.yacloud.common.description }}**​.
      * Rule **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}**.

         {% include [preconfigured-rules-priority](../../_includes/smartwebsecurity/preconfigured-rules-priority.md) %}

      * Dry run (logging traffic without further filtering)
      * Rule type:
         * [**{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}**](../concepts/rules.md#base-rules): Allows or denies traffic based on specified conditions.
         * [**{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}**](../concepts/rules.md#smart-protection-rules): Sends traffic for automatic processing by machine learning and behavioral analysis algorithms. Suspicious requests are sent to {{ captcha-name }} for additional verification.
         * [**{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}**](../../smartwebsecurity/concepts/rules.md#waf-rules): Integrates rules from a WAF profile. Suspicious requests are sent to {{ captcha-name }} for additional verification.
      * [**{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}**](../concepts/rules.md#rule-action):
         * For a basic rule: `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}` or `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-allow }}` traffic whose parameters match the conditions.
         * For a Smart Protection or WAF rule:
            * `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}`: After verification, suspicious requests are sent to {{ captcha-name }}.
            * `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}`: After verification, suspicious requests are blocked.
   1. In the **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** field and the additional fields below, modify the conditions the traffic must satisfy for the rule to apply. For more details, see [Rule action conditions](../concepts/conditions.md).

      You can set multiple conditions of the same type. Different types of conditions use different logical operators: _and_ or _or_. To add more than one condition of a certain type, click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_and }}** or ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_or }}**.

      To remove a condition, click ![options](../../_assets/console-icons/trash-bin.svg).
   1. Click **{{ ui-key.yacloud.common.save-changes }}**.

- API {#api}

   {% include [api-profile-update](../../_includes/smartwebsecurity/api-profile-update.md) %}

{% endlist %}

### See also {#see-also}

* [{#T}](rule-delete.md)
