Under **{{ ui-key.yacloud.smart-web-security.arl.column_rule-conditions }}**, specify the traffic the rule will apply to:
* `{{ ui-key.yacloud.component.condition-column.condition_full-trafic }}`: The rule will be used to analyze the whole traffic.
* `On condition`: The rule will be used to analyze the traffic specified in the **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** field:
    * `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`: IP address, IP address range, IP address region, or [address list](../../smartwebsecurity/concepts/lists.md).
    * `{{ ui-key.yacloud.component.condition-column.condition_name-header }}`: HTTP header string.
    * `{{ ui-key.yacloud.component.condition-column.condition_name-requestUri }}`: Request path.
    * `{{ ui-key.yacloud.component.condition-column.condition_name-host }}`: Domain receiving the request.
    * `{{ ui-key.yacloud.component.condition-column.condition_name-httpMethod }}`: Request method.
    * `{{ ui-key.yacloud.component.condition-column.condition_name-cookie }}`: Cookie header string.
    * `Bot name`: Legitimate bots belonging to various businesses and services.
    * `Bot category`: Categories of verified bots by purpose or type of activity.
    * `Verified bot`: Filtering based on whether the bot is verified (`yes` or `no`).
    * `Bot score`: Filtering by score from `0` (lowest probability, i.e., human) to `100` (highest probability, i.e., bot).

    You can set multiple conditions by selecting all the condition types you need in the **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** field.

    You can also set multiple conditions of the same type by clicking ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_and }}** or ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_or }}** in the section with the condition you need.

    To delete a condition, click ![options](../../_assets/console-icons/trash-bin.svg).