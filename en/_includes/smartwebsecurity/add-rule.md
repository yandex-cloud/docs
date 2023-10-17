1. Enter a name for the rule.
1. (optional) Enter a description.
1. Set the rule priority. The rule will have higher priority than the preconfigured ones.

   {% include [preconfigured-rules-priority](preconfigured-rules-priority.md) %}

1. (optional) Enable the **Dry run** option if you want to log data about the traffic satisfying the specified conditions without applying any action to it.
1. Select the rule type:
   * [**Basic**](../../smartwebsecurity/concepts/rules.md#base-rules): Allows or denies traffic based on specified conditions.
   * [**Smart Protection**](../../smartwebsecurity/concepts/rules.md#smart-protection-rules): Sends traffic for automatic processing by machine learning and behavioral analysis algorithms. Suspicious requests are sent to [{{ captcha-full-name }}](../../smartcaptcha/) for additional verification.
1. Select an [action](../../smartwebsecurity/concepts/rules.md#rule-action):
   * For a basic rule: **Deny** or **Allow** traffic whose parameters match the conditions.
   * For a Smart Protection rule:
      * **Full Protection**: Traffic is checked by ML models and behavioral analysis algorithms. Suspicious requests are sent to {{ captcha-name }}.
      * **API Protection**: Traffic is checked by ML models and behavioral analysis algorithms. Suspicious requests are denied.
1. Expand the **Conditions** field.
1. Set the conditions the traffic must match for the rule to be applied to it. For more details, see [Rule action conditions](../../smartwebsecurity/concepts/conditions.md).

   You can set multiple conditions of the same type. Different types of conditions use different logical operators: _and_ or _or_. To add more than one condition of a certain type, click ![plus-sign](../../_assets/plus-sign.svg) **and** or ![plus-sign](../../_assets/plus-sign.svg) **or**.
1. Click **Add**.