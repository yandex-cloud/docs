Under **{{ ui-key.yacloud.smart-web-security.arl.column_rule-conditions }}**, specify the traffic the rule will apply to:
* `{{ ui-key.yacloud.component.condition-column.condition_full-trafic }}`: The rule will be used to analyze the whole traffic.
* `On condition`: The rule will be used to analyze the traffic specified in the **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** field:
    * `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`: IP address, IP address range, IP address region, or [address list](../../smartwebsecurity/concepts/lists.md).
    * `{{ ui-key.yacloud.component.condition-column.condition_name-header }}`: HTTP header string.
    * `{{ ui-key.yacloud.component.condition-column.condition_name-requestUri }}`: Request path.
    * `{{ ui-key.yacloud.component.condition-column.condition_name-host }}`: Domain receiving the request.
    * `{{ ui-key.yacloud.component.condition-column.condition_name-httpMethod }}`: Request method.
    * `{{ ui-key.yacloud.component.condition-column.condition_name-cookie }}`: Cookie header string.
    * `Bot name`: Names of legitimate bots owned by various companies and services.
    * `Bot category`: Verified bot categories based on their purpose or nature of action.
    * `Verified bot`: Filtering based on whether the bot is verified (`yes` or `no`).
    * `Bot score`: Filtering based on request bot score, from `0` (the lowest, represents a human) to `100` (the highest, represents a bot).
    * `FingerPrint`: SSL/TLS connection [fingerprint](../../smartwebsecurity/concepts/botes.md#fingerprint).

    You can set multiple conditions by selecting all the condition types you need in the **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** field.

    You can also set multiple conditions of the same type by clicking ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_and }}** or ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_or }}** in the section with the condition you need.

    To delete a condition, click ![options](../../_assets/console-icons/trash-bin.svg).