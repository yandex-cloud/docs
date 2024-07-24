---
title: "Adding a rule to a security profile"
description: "Follow this guide to add a rule to a security profile."
---

# Adding a rule to a security profile

You can add basic [rules](../concepts/rules.md), Smart Protection, and WAF to a [security profile](../concepts/profiles.md). ARL rules are [added to an ARL profile](arl-rule-add.md).

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to add a rule to a security profile.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. Select the profile to add a rule to.
   1. Click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
   1. In the rule creation window:

      {% include [add-rule](../../_includes/smartwebsecurity/add-rule.md) %}

- API {#api}

   {% include [api-profile-update](../../_includes/smartwebsecurity/api-profile-update.md) %}

{% endlist %}

### See also {#see-also}

* [{#T}](rule-update.md)
* [{#T}](rule-delete.md)
