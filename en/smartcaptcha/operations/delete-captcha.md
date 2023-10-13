# Deleting a CAPTCHA


In this section, you'll learn how to delete a CAPTCHA.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha }}**.
   1. Select a CAPTCHA and click ![image](../../_assets/options.svg) → **{{ ui-key.yacloud.common.delete }}**.
   1. Confirm the deletion.

{% endlist %}

The keys of the deleted CAPTCHA become invalid. The service will return an error message to any request made using these keys.
