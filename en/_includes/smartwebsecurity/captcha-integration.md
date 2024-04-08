* `Default`: Managed on the {{ yandex-cloud }} side, captcha parameters:
   * [Main challenge](../../smartcaptcha/concepts/tasks.md#main-task): **Checkbox**.
   * [Additional challenge](../../smartcaptcha/concepts/tasks.md#additional-task): ![image](../../_assets/console-icons/picture.svg) **Silhouettes**.
   * Additional challenge difficulty: **Easy**.
   * Appearance: **Standard**.

   The `Default` captcha usage fee is included in the cost of {{ sws-name }}.
* `Custom captcha`: You can [customize](../../smartcaptcha/operations/create-captcha.md) captcha difficulty, types of main and additional challenges, and appearance.

   {% note info %}

   To use a custom captcha, select **Disable domain verification** in its settings.

   {% endnote %}

   The custom captcha usage fee is charged according to {{ captcha-name }} [pricing policy](../../smartcaptcha/pricing.md).