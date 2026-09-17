Under **{{ ui-key.yacloud.smart-web-security.arl.column_rule-conditions }}**, specify the traffic the rule will apply to:
* `{{ ui-key.yacloud.component.condition-column.condition_full-trafic }}`: The rule will be used to analyze the whole traffic.
* `On condition`: Rule will apply to the traffic defined in the **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** field:

    {% include [traffic-conditions-list](traffic-conditions-list.md) %}

    You can set multiple conditions by selecting all the condition types you need in the **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** field.

    You can also set multiple conditions of the same type. Do this by clicking ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_and }}** or ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_or }}** in the section with the condition you need.

    To delete a condition, click ![options](../../_assets/console-icons/trash-bin.svg).