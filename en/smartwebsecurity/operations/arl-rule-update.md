---
title: "Updating a rule in an ARL profile"
description: "Follow this guide to update a rule in an ARL profile."
---

# Updating a rule in an ARL profile

You can only update ARL rules in an [ARL](../concepts/arl.md) profile. Basic [rules](../concepts/rules.md), as well as Smart Protection and WAF rules, are [updated in a security profile](rule-update.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) the ARL profile resides in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Select the profile to update a rule in.
  1. In the row with the rule, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**. In the window that opens:
      1. Edit the basic rule settings:
         * **{{ ui-key.yacloud.common.name }}**​.
         * **{{ ui-key.yacloud.common.description }}**​.
         * Rule **priority**. The smaller the value, the higher is the rule priority.
         * Dry run (logging without request blocking) settings.

      1. {% include [arl-rule-traffic-conditions](../../_includes/smartwebsecurity/arl-rule-traffic-conditions.md) %}

      1. Change the request counting method and grouping criteria:

         {% include [arl-rule-request-count](../../_includes/smartwebsecurity/arl-rule-request-count.md) %}

      1. Click **{{ ui-key.yacloud.smart-web-security.arl.label_save-rule }}**.

{% endlist %}

### See also {#see-also}

* [{#T}](rule-delete.md)
