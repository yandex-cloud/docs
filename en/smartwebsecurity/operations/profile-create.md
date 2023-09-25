# Creating a security profile

{% include [ask-for-turning-on](../../_includes/smartwebsecurity/ask-for-turning-on.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [security profile](../concepts/profiles.md).
   1. In the list of services, select **{{ sws-name }}**.
   1. Click **Create security profile**.
   1. Select one of the creation options:
      * **Based on a template with a preset profile**. Preconfigured profiles include:
         * [Basic default rule](../concepts/rules.md#base-rules) enabled for all traffic.
         * [Smart Protection rule](../concepts/rules.md#smart-protection-rules) enabled for all traffic, with the **Full protection** type.
      * **From scratch**. This profile includes only the basic default rule enabled for all traffic.

      {% include [smart-protection-tip](../../_includes/smartwebsecurity/smart-protection-tip.md) %}

   1. Enter the profile name.
   1. (optional) Enter a description.
   1. (optional) Add a [label](../../resource-manager/concepts/labels.md) for the profile.
   1. In the **Action of the basic default rule** field, select an action to be applied to the traffic that mismatches the criteria of other rules: **Deny** or **Allow**.
   1. Click ![plus-sign](../../_assets/plus-sign.svg) **Add rule**.
   1. In the rule creation window:

      {% include [add-rule](../../_includes/smartwebsecurity/add-rule.md) %}

   1. Add all relevant rules to the profile one by one.

      You will see the rules you created in the table on the **Security rules** tab.
   1. (optional) Connect the profile to a [virtual host](../../application-load-balancer/concepts/http-router.md#virtual-host) in [{{ alb-full-name }}](../../application-load-balancer/):

      {% include [host-connect](../../_includes/smartwebsecurity/host-connect.md) %}

   1. Click **Create**.

{% endlist %}
