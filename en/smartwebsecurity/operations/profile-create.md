# Creating a security profile

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [security profile](../concepts/profiles.md).
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. Click **{{ ui-key.yacloud.smart-web-security.action_empty }}**.
   1. Select one of the creation options:
      * **{{ ui-key.yacloud.smart-web-security.title_default-template }}**. Preset profiles include:
         * [Basic default rule](../concepts/rules.md#base-rules) enabled for all traffic with the `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}` [action type](../concepts/rules.md#rule-action).
         * [Smart Protection rule](../concepts/rules.md#smart-protection-rules) enabled for all traffic with the `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` action type.
      * **{{ ui-key.yacloud.smart-web-security.title_no-template }}**. This profile includes only the basic default rule enabled for all traffic.

      {% include [smart-protection-tip](../../_includes/smartwebsecurity/smart-protection-tip.md) %}

   1. Enter the profile name.
   1. (Optional) Enter a description.
   1. (Optional) Add a [label](../../resource-manager/concepts/labels.md) for the profile.
   1. In the **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** field, select an action to be applied to the traffic that mismatches the criteria of other rules: `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` or `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
   1. Click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
   1. In the rule creation window:

      {% include [add-rule](../../_includes/smartwebsecurity/add-rule.md) %}

   1. Add all relevant rules to the profile one by one.

      The rules you created will appear under **{{ ui-key.yacloud.smart-web-security.form.section_security-rules }}** in the table.
   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### See also {#see-also}

* [{#T}](host-connect.md)
* [{#T}](profile-update.md)
* [{#T}](profile-delete.md)