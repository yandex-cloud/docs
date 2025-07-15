1. Name the rule.
1. Optionally, provide a description.
1. Set the rule priority. The rule you add will have a higher priority than the preconfigured rules.

    {% include [preconfigured-rules-priority](./preconfigured-rules-priority.md) %}

1. Optionally, enable **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)** if you want only to log data about the traffic matching the specified conditions without applying any actions to it.
1. Select the rule type:
    * [**{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}**](../../smartwebsecurity/concepts/rules.md#base-rules): Allows, denies, or forwards traffic to [{{ captcha-full-name }}](../../smartcaptcha/) under specified conditions.
    * [**{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}**](../../smartwebsecurity/concepts/rules.md#smart-protection-rules): Sends traffic for automatic processing by machine learning and behavioral analysis algorithms and redirects suspicious requests to {{ captcha-full-name }} for additional verification.
    * [**{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}**](../../smartwebsecurity/concepts/rules.md#waf-rules): Integrates rules from a WAF profile and redirects suspicious requests to {{ captcha-full-name }}.

        For a WAF rule, select or [create a WAF profile](../../smartwebsecurity/operations/waf-profile-create.md).
1. Select an [action](../../smartwebsecurity/concepts/rules.md#rule-action):
    * For a basic rule:
      * `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}`.
      * `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-allow }}`.
      * `Show CAPTCHA`: To show the CAPTCHA selected in the security profile.
    * For a Smart Protection or WAF rule:

      * `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}`: To redirect suspicious requests to {{ captcha-name }} after verification.
      * `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}`: To block suspicious requests after verification.

1. {% include [arl-rule-traffic-conditions](../../_includes/smartwebsecurity/arl-rule-traffic-conditions.md) %}

1. Click **{{ ui-key.yacloud.common.add }}**.