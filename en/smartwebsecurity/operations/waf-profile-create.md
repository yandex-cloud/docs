# Creating a WAF profile

{% note info %}

This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage. To gain access to it, describe how you are going to use WAF when creating your first WAF profile and click **{{ ui-key.yacloud_components.request-alpha-flag-dialog.button_send }}**.

Once your request is approved, you can proceed to create a WAF profile.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your [WAF profile](../concepts/waf.md).
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}** and click **{{ ui-key.yacloud.smart-web-security.waf.label_create-profile }}**.
   1. Enter the profile name.
   1. (Ooptional) Enter a description.
   1. (Optional) Add [labels](../../resource-manager/concepts/labels.md) for your profile.
   1. The WAF profile's default basic rule set is called [OWASP Core Rule Set](https://coreruleset.org/). Click the row with the rule set to view the rules it includes.

   1. {% include [waf-inspect-request](../../_includes/smartwebsecurity/waf-inspect-request.md) %}

   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### See also {#see-also}

* [{#T}](rule-add.md)
* [{#T}](profile-update.md)
* [{#T}](waf-profile-delete.md)