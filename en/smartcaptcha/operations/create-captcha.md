---
title: "How to create a CAPTCHA in {{ captcha-full-name }}"
description: "Follow this guide to create a CAPTCHA."
---

# Creating a CAPTCHA

{{ captcha-name }} allows you to create a CAPTCHA of multiple levels of complexity. You can:

* Connect a CAPTCHA to multiple websites.
* Set the parameters of all CAPTCHA layout elements, including background, possible errors, or the **I'm not a robot** button style.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha }}**.
   1. Click **{{ ui-key.yacloud.smartcaptcha.button_captcha-settings-create }}** and specify:
      * **{{ ui-key.yacloud.common.name }}**: Name of the CAPTCHA being created. The naming requirements are as follows:

         {% include [name-format](../../_includes/smartcaptcha/name-format.md) %}

      * **{{ ui-key.yacloud.smartcaptcha.label_main-challenge }}**: Type of the [main challenge](../concepts/tasks.md#main-task) to complete by the user.
      * **{{ ui-key.yacloud.smartcaptcha.label_additional-challenge }}**: Type of the [additional challenge](../concepts/tasks.md#additional-task) to complete by the user.
      * **{{ ui-key.yacloud.smartcaptcha.label_complexity }}**: [Difficulty level](../concepts/tasks.md#task-difficulty) of the challenge the user will be offered:
         * `{{ ui-key.yacloud.smartcaptcha.value_complexity-easy }}`: Simple challenge.
         * `{{ ui-key.yacloud.smartcaptcha.value_complexity-medium }}`: Medium level challenge.
         * `{{ ui-key.yacloud.smartcaptcha.value_complexity-hard }}`: Difficult challenge.
         * `{{ ui-key.yacloud.smartcaptcha.value_complexity-force_hard }}`: Difficult challenge. The user is required to solve an additional challenge, regardless of the results of the main one.

         You can see a sample challenge in the preview window.
      * **{{ ui-key.yacloud.smartcaptcha.label_no-hostname-check }}**: Option disabling [domain validation](../concepts/domain-validation.md).
      * **{{ ui-key.yacloud.smartcaptcha.label_allowed-sites }}**: As IP addresses or domain names. Do not use `http`, `https`, or `/` at the end, e.g., `example.com`.

         The CAPTCHA will also be valid for all subdomains of the specified domain names.

      * **{{ ui-key.yacloud.smartcaptcha.label_section-style }}**: Appearance of the **I'm not a robot** button and the challenge window:
         * `{{ ui-key.yacloud.smartcaptcha.value_config-standard }}`: Default appearance
         * `Grey`
         * `Dark theme`
         * `Blue`

         Under **{{ ui-key.yacloud.smartcaptcha.label_section-customization }}**, you can set custom parameters for the challenge window and other elements: fill out the form or describe styles in `JSON` format.

         All changes are displayed in the preview window.
   1. Click **{{ ui-key.yacloud.common.create }}**.

   The CAPTCHA will appear on the service page under **{{ ui-key.yacloud.smartcaptcha.label_captcha-settings-list }}**.

{% endlist %}
