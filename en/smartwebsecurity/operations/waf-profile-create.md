# Creating a WAF profile

{% include [note-preview-waf](../../_includes/smartwebsecurity/note-preview-waf.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder you want to create your WAF profile in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Go to the ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}** tab and click **{{ ui-key.yacloud.smart-web-security.waf.label_create-profile }}**.
  1. Describe how you plan to use WAF and click **Submit request**.

      Once your request is approved, you can proceed to create a WAF profile.
  1. Enter the profile name.
  1. (Optional) Enter a description.
  1. (Optional) Add a [label](../../resource-manager/concepts/labels.md) for the profile.
  1. The WAF profile's default basic rule set is called [OWASP Core Rule Set](https://coreruleset.org/). To view the rules it includes, click the line with its description.
  1. Click **Create**.

{% endlist %}

### See also {#see-also}

* [{#T}](rule-add.md)
* [{#T}](profile-update.md)
* [{#T}](waf-profile-delete.md)