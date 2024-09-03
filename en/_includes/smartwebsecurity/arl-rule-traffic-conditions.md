Under **{{ ui-key.yacloud.smart-web-security.arl.column_rule-conditions }}**, specify which traffic the rule will be used to analyze:
* `{{ ui-key.yacloud.component.condition-column.condition_full-trafic }}`: The rule will be used to analyze the whole traffic.
* `Conditional`: The rule will be used to analyze the traffic specified in the **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** field:
   * `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`: IP address, IP address range, or IP address region.
   * `{{ ui-key.yacloud.component.condition-column.condition_name-header }}`: HTTP header string.
   * `{{ ui-key.yacloud.component.condition-column.condition_name-requestUri }}`: Request path.
   * `{{ ui-key.yacloud.component.condition-column.condition_name-host }}`: Domain receiving the request.
   * `{{ ui-key.yacloud.component.condition-column.condition_name-httpMethod }}`: Request method.
   * `{{ ui-key.yacloud.component.condition-column.condition_name-cookie }}`: Cookie header string.

   You can set multiple conditions. To do this, select all the condition types you need in the **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** field.

   You can also set multiple conditions of the same type. To do this, click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_and }}** or ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_or }}** in the section with the condition you need.

   To delete a condition, click ![options](../../_assets/console-icons/trash-bin.svg).