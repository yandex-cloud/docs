Select **{{ ui-key.yacloud.common.logs }}**:

* Select the number of messages per page and the period, e.g., `1 hour`.

* In the **Query** field, specify you query using the [filter expression language](../../logging/concepts/filter.md) and click **Run**.

  **Request examples**

  * Show requests which triggered a Smart Protection rule with a CAPTCHA challenge (in logging mode):

    ```
    json_payload.smartwebsecurity.dry_run_matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.dry_run_matched_rule.verdict = CAPTCHA
    ```

  * Similar request without the logging mode:

    ```
    json_payload.smartwebsecurity.matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.matched_rule.verdict = CAPTCHA
    ```

  * Show requests blocked by basic rules based on any conditions (in logging mode):

    ```
    json_payload.smartwebsecurity.dry_run_matched_rule.rule_type = RULE_CONDITION and json_payload.smartwebsecurity.matched_rule.verdict = DENY
    ```

  * Similar request without the logging mode:

    ```
    json_payload.smartwebsecurity.matched_rule.rule_type = RULE_CONDITION and json_payload.smartwebsecurity.matched_rule.verdict = DENY
    ```