1. Enter a name for the rule.
1. Optionally, enter a description.
1. Set the rule priority. The rule you add will have a higher priority than the preconfigured rules.

    {% include [preconfigured-rules-priority](./preconfigured-rules-priority.md) %}

    To learn about rule priority, see [{#T}](../../smartwebsecurity/concepts/rules.md#rules-order).

1. Optionally, enable the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)** option to log information about the traffic that fulfills the specified conditions without applying any actions to it.
1. Select the rule type:
    * [**{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}**](../../smartwebsecurity/concepts/rules.md#base-rules): Allows, denies, or forwards traffic to [{{ captcha-full-name }}](../../smartcaptcha/) under specified conditions.
    * [**{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}**](../../smartwebsecurity/concepts/rules.md#smart-protection-rules): Sends traffic for automatic processing by machine learning and behavioral analysis algorithms. In the full protection mode, suspicious requests are sent for an [extra verification](../../smartwebsecurity/concepts/rules.md#client-checks) automatically selected by Smart Protection.
    * [**{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}**](../../smartwebsecurity/concepts/rules.md#waf-rules): Integrates rules from a WAF profile

        For a WAF rule, select or [create a Cloud WAF profile](../../smartwebsecurity/operations/waf-profile-create.md).
1. Select the [protection modes](../../smartwebsecurity/concepts/profiles.md#protection-mode) for the rule to apply in:

    * **All modes** (default).
    * **_Enhanced protection_ and _Under attack_**.
    * **_Under attack_**.

1. Select an [action](../../smartwebsecurity/concepts/rules.md#rule-action):
    * For a basic rule:
      * `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}`.
      * `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-allow }}`.
      * `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-captcha }}`: To show the CAPTCHA selected in the security profile.
      
    
    * For a Smart Protection or WAF rule:

      * `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}`: Suspicious requests are sent for an [extra verification](../../smartwebsecurity/concepts/rules.md#client-checks) automatically selected by Smart Protection.
      * `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}`: To block suspicious requests after verification.

1. Optionally, select or [create](../../smartwebsecurity/operations/template-create.md) a response template that will be returned to the client whenever a rule triggers. The standard {{ yandex-cloud }} template is used by default.
1. {% include [arl-rule-traffic-conditions](../../_includes/smartwebsecurity/arl-rule-traffic-conditions.md) %}

1. Click **{{ ui-key.yacloud.common.add }}**.
