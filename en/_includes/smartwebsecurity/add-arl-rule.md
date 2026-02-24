1. Enter a name for the rule.
1. Optionally, enter a description.
1. Set the rule priority. This priority applies only to ARL rules and is independent of the rule priority in the [security profile](../../smartwebsecurity/concepts/profiles.md).
1. Optionally, enable **Enable dry run (logging only)** to test the rule and estimate the load on your web service. Requests will not be blocked in this mode.

1. {% include [arl-rule-traffic-conditions](arl-rule-traffic-conditions.md) %}

1. Under **Request counting**, select:

    {% include [arl-rule-request-count](arl-rule-request-count.md) %}

1. {% include [arl-rule-action-over-limit](arl-rule-action-over-limit.md) %}

1. Optionally, select or [create](../../smartwebsecurity/operations/template-create.md) a response template that will be returned to the client whenever a rule triggers. The standard {{ yandex-cloud }} template is used by default.

1. Click **{{ ui-key.yacloud.smart-web-security.arl.label_save-rule }}**.