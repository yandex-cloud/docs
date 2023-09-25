# Editing a rule in a security profile

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to update a [rule](../concepts/rules.md) in a [security profile](../concepts/profiles.md).
   1. In the list of services, select **{{ sws-name }}**.
   1. Next to the profile to edit the rule in, click ![options](../../_assets/options.svg) and select ![pencil](../../_assets/pencil.svg) **Edit profile data**.
   1. On the **Security rules** tab, next to the rule to edit, click ![options](../../_assets/options.svg) and select ![pencil](../../_assets/pencil.svg) **Edit**.
   1. Edit the basic rule settings:
      * Name
      * Description
      * Rule priority

         {% include [preconfigured-rules-priority](../../_includes/smartwebsecurity/preconfigured-rules-priority.md) %}

      * Dry run (logging traffic without further filtering)
      * Rule type:
         * [Basic](../concepts/rules.md#base-rules): Allows or denies traffic based on specified conditions.
         * [Smart Protection](../concepts/rules.md#smart-protection-rules): Sends traffic for automatic processing by machine learning and behavioral analysis algorithms. Suspicious requests are sent to {{ captcha-name }} for additional verification.
      * [Action](../concepts/rules.md#rule-action):
         * For a basic rule: **Deny** or **Allow** traffic whose parameters match the conditions.
         * For a Smart Protection rule:
            * **Full Protection**: Traffic is checked by ML models and behavioral analysis algorithms. Suspicious requests are sent to {{ captcha-name }}.
            * **API Protection**: Traffic is checked by ML models and behavioral analysis algorithms. Suspicious requests are denied.
   1. Expand the **Conditions** field.
   1. Modify the criteria the traffic must match to get processed by the rule. For more details, see [Rule action conditions](../concepts/conditions.md).

      You can set multiple conditions of the same type. Different types of conditions use different logical operators: _and_ or _or_. To add more than one condition of a certain type, click ![plus-sign](../../_assets/plus-sign.svg) **and** or ![plus-sign](../../_assets/plus-sign.svg) **or**.

      To remove a condition, click ![options](../../_assets/basket.svg).
   1. Click **Save rule**.
   1. Click **Save**.

{% endlist %}
