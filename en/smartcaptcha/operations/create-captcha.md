# Creating a CAPTCHA

{{ captcha-name }} lets you create a CAPTCHA of multiple levels of complexity. You can:

* Connect a CAPTCHA to multiple websites.
* Set up the appearance of the **I'm not a robot** button and the task window.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha }}**.
   1. Click **{{ ui-key.yacloud.smartcaptcha.button_captcha-settings-create }}** and specify:
      * **{{ ui-key.yacloud.common.name }}**: Name of the CAPTCHA being created.
      * **{{ ui-key.yacloud.smartcaptcha.label_main-challenge }}**: Type of the [main task](../concepts/tasks.md#main-task) to be solved by the user.
      * **{{ ui-key.yacloud.smartcaptcha.label_additional-challenge }}**: Type of the [additional task](../concepts/tasks.md#additional-task) to be solved by the user.
      * **{{ ui-key.yacloud.smartcaptcha.label_complexity }}**: Complexity of a task for the user:
         * `{{ ui-key.yacloud.smartcaptcha.value_complexity-easy }}`: Simple task.
         * `{{ ui-key.yacloud.smartcaptcha.value_complexity-medium }}`: Task of intermediate complexity.
         * `{{ ui-key.yacloud.smartcaptcha.value_complexity-hard }}`: Difficult task.

         You can see a sample task in the preview window.
      * **{{ ui-key.yacloud.smartcaptcha.label_allowed-sites }}**: As IP addresses or domain names. Do not use `http`, `htpps`, or `/` at the end. The correct format is `example.com`. Domain names also apply to subdomains with no wildcard character (`*`).
      * **{{ ui-key.yacloud.smartcaptcha.label_section-style }}**: Appearance of the **I'm not a robot** button and the task window:
         * `{{ ui-key.yacloud.smartcaptcha.value_config-standard }}`: Default appearance
         * `Grey`
         * `Dark theme`
         * `Blue`

         Under **{{ ui-key.yacloud.smartcaptcha.label_section-customization }}**, you can set custom parameters: fill out the form or describe styles in `JSON` format.

         All changes are displayed in the preview window.
   1. Click **{{ ui-key.yacloud.common.create }}**.

   The CAPTCHA will appear on the service page under **{{ ui-key.yacloud.smartcaptcha.label_captcha-settings-list }}**.

{% endlist %}
