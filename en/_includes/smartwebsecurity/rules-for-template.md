[Rules](../../smartwebsecurity/concepts/rules.md) you can assign a page template to:

* Security profile rules:
  * **{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}** with the **{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}** action.
  * **{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}** with the **{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}** or **{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}** action.
  * **{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}** with the **{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}** or **{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}** action.
* ARL profile rules with the **{{ ui-key.yacloud.smart-web-security.arl.label_rule-action-deny_3kenc }}** or **Temporarily block all requests** actions.

Additionally, you can customize the {{ captcha-name }} challenge window. Do it by [creating](../../smartcaptcha/operations/create-captcha.md) a new CAPTCHA or modifying an existing one linked to the security profile.