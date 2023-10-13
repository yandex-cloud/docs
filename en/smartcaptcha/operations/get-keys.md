# Retrieving the CAPTCHA keys


In this section, you'll learn how to retrieve the CAPTCHA keys. With the client key, you can [add a {{ captcha-name }} widget](../quickstart.md#add-widget) to your page. You'll need a server key to [check the user response](../quickstart.md#check-answer).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha }}**.
   1. Click the name of the CAPTCHA or [create](../quickstart.md#creat-captcha) a new one.
   1. In the **{{ ui-key.yacloud.common.overview }}** tab, copy the **{{ ui-key.yacloud.smartcaptcha.label_client-key }}** and **{{ ui-key.yacloud.smartcaptcha.label_server-key }}** field values.

{% endlist %}
