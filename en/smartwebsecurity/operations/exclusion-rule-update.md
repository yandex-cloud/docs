---
title: "Updating a WAF exclusion rule"
description: "Follow this guide to update a WAF exclusion rule."
---

# Updating a WAF exclusion rule

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the WAF profile.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Go to the ![image](../../_assets/smartwebsecurity/waf.svg) **WAF profiles** tab.
  1. Select the profile you want to update an [exclusion rule](../concepts/waf.md#exclusion-rules) in.
  1. Go to the ![image](../../_assets/console-icons/file-xmark.svg) **Exclusion rules** tab.
  1. Click ![options](../../_assets/console-icons/ellipsis.svg) next to the rule and select **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the exclusion rule name and description.
  1. Under **Scope of use**, specify rules from the basic set for which the exclusion will be valid:
     1. **All rules**.
     1. **Selected rules**: Click **Add rules** and select the rules from the basic set.
  1. Under **Traffic conditions**, select the [conditions](../concepts/conditions.md) for the exclusion rule to trigger.

      If you leave the **Conditions** field empty, the exclusion rule will apply to the whole traffic.
  1. Click **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}


### See also {#see-also}

* [{#T}](exclusion-rule-add.md)
* [{#T}](exclusion-rule-delete.md)
* [{#T}](configure-set-rules.md)
