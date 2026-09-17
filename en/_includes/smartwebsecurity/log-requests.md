Select ![receipt](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.common.logs }}**:

* Select the log display period using one of the following methods:

  * Click the interval, e.g., **Last hour**, and select one of the options: from **Last 5 minutes** to **Last day**.
  * Select a preset period: **Now**, **5m**, **30m**, **1h**, **1d**, **2d**, or specify your own value.
  * On the timeline, move the period start and end indicators.

* In the **Query** row, specify your query using the [filter expression language](../../logging/concepts/filter.md) and click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.

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