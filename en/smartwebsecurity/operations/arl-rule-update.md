---
title: "Updating a rule in an ARL profile"
description: "Follow this guide to update a rule in an ARL profile."
---

# Updating a rule in an ARL profile

You can only update ARL rules in an [ARL](../concepts/arl.md) profile. Basic [rules](../concepts/rules.md), Smart Protection, and WAF are [updated in a security profile](rule-update.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to update a rule in an ARL profile.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Go to the ![image](../../_assets/smartwebsecurity/arl.svg) **ARL profiles** tab.
   1. Select the profile to update a rule in.
   1. Click ![options](../../_assets/console-icons/ellipsis.svg) next to the rule and select **{{ ui-key.yacloud.common.edit }}**.
   1. Edit the basic rule settings:
      * **{{ ui-key.yacloud.common.name }}**​.
      * **{{ ui-key.yacloud.common.description }}**​.
      * Rule **priority**. The smaller the value, the higher is the rule priority.
      * Dry run (logging without request blocking).
   1. Modify the [conditions](../concepts/conditions.md) the traffic must satisfy for the rule to apply.

      You can set multiple conditions of the same type. Different types of conditions use different logical operators: _and_ or _or_. To add more than one condition of a certain type, click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_and }}** or ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_or }}**.

      To remove a condition, click ![options](../../_assets/console-icons/trash-bin.svg).
   1. Change the method for counting requests and the criteria for their grouping.
   1. Click **Save rule**.

{% endlist %}

### See also {#see-also}

* [{#T}](rule-delete.md)
