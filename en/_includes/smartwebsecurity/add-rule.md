1. Enter a name for the rule.
1. (optional) Enter a description.
1. Set the rule priority. The rule you add will have a higher priority than the preconfigured rules.

   {% include [preconfigured-rules-priority](./preconfigured-rules-priority.md) %}

1. (Optional) Enable **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)** if you want only to log data about the traffic fulfilling the specified conditions without applying any actions to it.
1. Select the rule type:
   * [**{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}**](../../smartwebsecurity/concepts/rules.md#base-rules): Allows or denies traffic based on specified conditions.
   * [**{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}**](../../smartwebsecurity/concepts/rules.md#smart-protection-rules): Sends traffic for automatic processing by machine learning and behavioral analysis algorithms. Suspicious requests are sent to [{{ captcha-full-name }}](../../smartcaptcha/) for additional verification.
   * [**{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}**](../../smartwebsecurity/concepts/rules.md#waf-rules): Integrates rules from a WAF profile. Suspicious requests are sent to {{ captcha-full-name }}.

      For a WAF rule, select or [create a WAF profile](../../smartwebsecurity/operations/waf-profile-create.md).
1. Select an [action](../../smartwebsecurity/concepts/rules.md#rule-action):
   * For a basic rule: `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}` or `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-allow }}` traffic whose parameters match the conditions.
   * For a Smart Protection or WAF rule:

      * `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}`: After verification, suspicious requests are sent to {{ captcha-name }}.
      * `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}`: After verification, suspicious requests are blocked.

1. {% include [arl-rule-traffic-conditions](../../_includes/smartwebsecurity/arl-rule-traffic-conditions.md) %}

1. Click **{{ ui-key.yacloud.common.add }}**.