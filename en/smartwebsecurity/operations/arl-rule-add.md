---
title: "Adding a rule to an ARL profile"
description: "Follow this guide to add a rule to an ARL profile."
---

# Adding a rule to an ARL profile

You can only add ARL rules to an [ARL](../concepts/arl.md) profile. Basic [rules](../concepts/rules.md), Smart Protection, and WAF are [added to a security profile](rule-add.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to add a rule to an ARL profile.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Go to the ![image](../../_assets/smartwebsecurity/arl.svg) **ARL profiles** tab.
  1. Select the profile to add a rule to.
  1. Click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. In the rule creation window:

      {% include [add-rule](../../_includes/smartwebsecurity/add-arl-rule.md) %}


{% endlist %}

### See also {#see-also}

* [{#T}](rule-update.md)
* [{#T}](rule-delete.md)
