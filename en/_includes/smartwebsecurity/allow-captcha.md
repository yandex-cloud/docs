An allowing rule for {{ captcha-name }} is requred in case the `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}` action is set for the default basic rule and the requests are sent to {{ captcha-name }} for verification.

   1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
   1. Enter a name for the rule, e.g., `allow-captcha`.
   1. Set **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}** higher than that of the rules sending requests to captcha checks.
   1. Enable **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
   1. Specify the rule settings:
        * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}**: `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`.
        * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}**: `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
        * **Traffic**: `On condition`.
        * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}**: `{{ ui-key.yacloud.component.condition-column.condition_name-requestUri }}`.
        * **Request path**: `Matches the regular expression`.
        * Enter this expression: `/(captcha_smart.*\.(css|js)|showcaptcha|checkcaptcha)`.
   1. Click **{{ ui-key.yacloud.common.add }}**.
