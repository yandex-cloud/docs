---
title: Updating a WAF exclusion rule
description: Follow this guide to update a WAF exclusion rule.
---

# Updating a WAF exclusion rule

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) the [WAF profile](../concepts/waf.md) is in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
   1. Select the profile you want to update an [exclusion rule](../concepts/waf.md#exclusion-rules) in.
   1. In the left-hand menu, go to the ![image](../../_assets/console-icons/file-xmark.svg) **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rules }}** tab.
   1. In the row with the rule, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**. In the window that opens:
      1. Edit the exclusion rule name and description.
      1. (Optional) Enable **{{ ui-key.yacloud.smart-web-security.waf.field_logging }}** to log exception rule triggering.
      1. Under **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rule-rules-section }}**, update rules from the basic set for which the exclusion will be valid:
         * `{{ ui-key.yacloud.smart-web-security.waf.value_exclude-all-yes }}`: Exclusion will be valid for all rules.
         * `{{ ui-key.yacloud.smart-web-security.waf.value_exclude-all-no }}`: Exclusion will be valid for the selected rules.

            Click **{{ ui-key.yacloud.smart-web-security.waf.action_exclusion-rule-add-rules }}** to select rules from the basic set.

      1. {% include [waf-rule-traffic-conditions](../../_includes/smartwebsecurity/waf-rule-traffic-conditions.md) %}

      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}


### See also {#see-also}

* [{#T}](exclusion-rule-add.md)
* [{#T}](exclusion-rule-delete.md)
* [{#T}](configure-set-rules.md)
