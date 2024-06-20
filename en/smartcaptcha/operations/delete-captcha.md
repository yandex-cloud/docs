# Deleting a CAPTCHA


In this section, you will learn how to delete a [CAPTCHA](../concepts/validation.md).

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha }}**.
   1. Select a CAPTCHA and click ![image](../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.common.delete }}**.
   1. Confirm the deletion.

{% endlist %}

The deleted CAPTCHA's [keys](../concepts/keys.md) will become invalid. The service will return an error message to any request made using these keys.
