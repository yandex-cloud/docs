# Creating an ARL profile

{% note info %}

This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage. To gain access, provide a description of how you plan to use ARL when creating your first ARL profile and click **{{ ui-key.yacloud_components.request-alpha-flag-dialog.button_send }}**.

Once your request is approved, you can proceed to create an ARL profile.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create your [ARL profile](../concepts/arl.md) in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}** and click **{{ ui-key.yacloud.smart-web-security.arl.label_create-profile }}**.
  1. Enter the profile name.
  1. (Optional) Enter a description.
  1. (Optional) Add [labels](../../resource-manager/concepts/labels.md) for your profile.
  1. [Add](arl-rule-add.md) ARL rules.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### See also {#see-also}

* [{#T}](arl-rule-add.md)
* [{#T}](profile-update.md)
* [{#T}](arl-profile-delete.md)