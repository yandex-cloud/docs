# Creating an ARL profile

{% include [note-preview-arl](../../_includes/smartwebsecurity/note-preview-arl.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create your ARL profile.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Go to the ![image](../../_assets/smartwebsecurity/arl.svg) **ARL profiles** tab and click **Create ARL profile**.
  1. Describe how you plan to use ARL and click **Submit request**.

      Once your request is approved, you can proceed to create an ARL profile.
  1. Enter the profile name.
  1. (Optional) Enter a description.
  1. (Optional) Add a [label](../../resource-manager/concepts/labels.md) for the profile.
  1. [Add ARL rules](arl-rule-add.md).
  1. Click **Create**.

{% endlist %}

### See also {#see-also}

* [{#T}](arl-rule-add.md)
* [{#T}](profile-update.md)
* [{#T}](arl-profile-delete.md)