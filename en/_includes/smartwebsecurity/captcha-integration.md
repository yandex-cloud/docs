* `Default`: Managed by {{ yandex-cloud }}. This CAPTCHA has the following settings:
  * [Main challenge](../../smartcaptcha/concepts/tasks.md#main-task): **Checkbox**.
  * [Additional challenge](../../smartcaptcha/concepts/tasks.md#additional-task): ![image](../../_assets/console-icons/picture.svg) **Silhouettes**.
  * Additional challenge difficulty: **Easy**.
  * Appearance: **Standard**.

  The `Default` CAPTCHA usage fee is included in the cost of {{ sws-name }}.
* `Custom CAPTCHA`: You can [customize](../../smartcaptcha/operations/create-captcha.md) CAPTCHA's difficulty, types of main and additional challenges, and appearance.

  {% note info %}

  To use a custom CAPTCHA, select **Disable domain verification** in its settings.

  {% endnote %}

  The custom CAPTCHA usage fee is charged according to the {{ captcha-name }} [pricing policy](../../smartcaptcha/pricing.md).