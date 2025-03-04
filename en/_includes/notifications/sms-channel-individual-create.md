{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to create a notification channel in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Click **{{ ui-key.yacloud.cns.action_create-channel }}**.
  1. In the **{{ ui-key.yacloud.cns.type_sms }}** tab, select the **{{ ui-key.yacloud.cns.sender_sms-individual }}** sender type.
  1. Specify the sender’s text name of your choice and click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

With that done, a tech support ticket to register the sender's text name will be automatically generated.

{% include [registration-duration-warning](registration-duration-warning.md) %}

When your registration is complete, you will be notified by tech support that you now have access to an individual sender channel.