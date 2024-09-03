1. Enter a name for the rule.
1. (Optional) Enter a description.
1. Set the rule priority. This priority applies only to ARL rules and is independent of the rule priority in the [security profile](../../smartwebsecurity/concepts/profiles.md).
1. (Optional) Enable **Enable dry run (logging only)** to test the rule and estimate the load on the web service. Requests will not be blocked in this mode.

1. {% include [arl-rule-traffic-conditions](../../_includes/smartwebsecurity/arl-rule-traffic-conditions.md) %}

1. Under **Request counting**, select:

   {% include [arl-rule-request-count](../../_includes/smartwebsecurity/arl-rule-request-count.md) %}

1. Click **{{ ui-key.yacloud.smart-web-security.arl.label_save-rule }}**.