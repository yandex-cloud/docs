# Logging

{% include [logging-preview](../../_includes/smartwebsecurity/logging-preview.md) %}

{{ sws-name }} allows you to collect and view service logs to configure protection and monitor security events.

There are two log collection options available: via {{ sws-name }} and via the L7 {{ alb-name }} the security profile is connected to.

This section provides information on logging via {{ sws-name }}. If you want to learn about collecting logs via an L7 balancer, see [{#T}](../operations/configure-logging-alb.md).

These logs contain information about all HTTP requests processed by {{ sws-name }}. You can set up logging only for requests that were blocked (the `DENY` verdict) or sent to CAPTCHA (the `CAPTCHA` verdict). Additionally, you can collect logs for legitimate requests that were allowed by {{ sws-name }} (the `ALLOW` verdict). To avoid overflowing logs with allowed requests, specify the percentage of logs that the system will collect, from 1 to 100 %.

{{ sws-name }} delivers logs in JSON format. Each log entry contains the following structural blocks: 

1. Log system fields that contain service information of the monitoring system. Only one field is significant for analysis: the `time` the event occurred in the protected system, with nanosecond precision.
1. `labels` block: Set of `<name>=<value>` pairs for log identification and quick filtering by different slices. You can also use top-level fields for filtering.
1. `message` block: Short text log message in [Unicode](https://wikipedia.org/wiki/Unicode) format.
1. `meta` block: Request metadata, which is detailed parameters of triggered rules and request parameters.
   
The description of SWS log fields is given in the table below. 

## Log contents {#log-contents}

#|
|| **Field** | **Description** ||
|| `client_ip` | IP address of the client that sent the HTTP request. ||
|| `request_time` | Time when the request was received. ||
|| `alb_id` | ID of the load balancer the request came through. ||
|| `alb_request_id` | HTTP request `X-Request-ID` header value. ||
|| `unique_key` | Internal request ID. ||
|| `http_version` | HTTP version. ||
|| `http_method` | HTTP request method, `POST` or `GET`. ||
|| `http_host` | Host name specified in the HTTP request. ||
|| `http_path` | Path in the HTTP request. ||
|| `http_queries` | Request parameters provided in the URL after the question mark. ||
|| `headers` | HTTP request headers. ||
|| `security_profile_id` | Security profile ID. ||
|| `security_profile_name` | Security profile name. ||
|| `module_type` | [SWS module](index.md) that made the final decision on the request. The possible values are `RULE_CONDITION`, `SMART_PROTECTION`, `WAF`, `ARL`, or `DEFAULT` (the [default basic rule](rules.md#base-rules) in the security profile). ||
|| `action` | Action applied to the request: `ALLOW`, `DENY`, or `CAPTCHA`. ||
|| `matched_rule_name` | Triggered rule name. ||
|| `dry_run_matched_rule_name` | Name of the triggered rule that is in **Dry run** mode. In this mode, the action is not applied to the request, while information about the trigger is logged. ||
|| `matched_rule_verdict` | Expected action (verdict) applied by the rule to the request. The possible values are `ALLOW`, `DENY`, or `CAPTCHA`. ||
|| `dry_run_matched_rule_verdict` | Expected action that would be applied by the rule to the request, but it is not applied in **Dry run** mode. The possible values are `ALLOW`, `DENY`, or `CAPTCHA`. ||
|| `waf_profile_id` | WAF profile ID, if used in the rule. ||
|| `dry_run_waf_profile_id` | WAF profile ID in dry run mode. ||
|| `waf_profile_name` | WAF profile name, if used in the rule. ||
|| `dry_run_waf_profile_name` | WAF profile name in dry run mode. ||
|| `waf_applied_rule_set_id` | ID of the rule set that made the final decision in the WAF profile. The possible values are ID of a specific set or `ALL` (if the `match_all_rule_sets` flag was enabled). ||
|| `dry_run_waf_applied_rule_set_id` | ID of the rule set that made the final decision in the WAF profile in dry run mode. ||
|| `waf_rule_sets_ids` | IDs of all rule sets included in the WAF profile. ||
|| `dry_run_waf_rule_sets_ids` | IDs of all rule sets included in the WAF profile in dry run mode. ||
|| `waf_matched_rules` | Triggered rules in the WAF profile. This field has nested fields. ||
||
* `score` | Anomaly level obtained when checking the request using the WAF profile. ||
|| 
* `rule_id` | ID of the WAF rule added to the security profile. ||
|| 
* `rule_set_id` | Rule set ID of this WAF rule. ||
|| 
* `rule_group_id` | Group ID of this WAF rule. ||
|| 
* `data` | All values ​​from the `matched_data_variable`, `matched_data_key`, `matched_data_value` fields. ||
|| 
* `message` | Name of the rule from the WAF rule set. ||
|| 
* `matched_data_variable` | Request parameter the anomaly (threat) was detected in. ||
|| 
* `matched_data_key` | Parameter name the anomaly was detected in. ||
|| 
* `matched_data_value` | Parameter value the anomaly was detected in. ||
|| 
* `is_blocking_rule` | Blocking rule flag. ||
|| `dry_run_waf_matched_rules` | Triggered rules in the WAF profile in dry run mode. Nested fields are similar to `waf_matched_rules`. ||
|| `waf_matched_exclusion_rules` | List of exclusion rules triggered in the WAF profile. ||
|| 
* `exclusion_rule_name` | Exclusion rule name. ||
|| 
* `excluded_rule_ids` | Rule IDs from the rule sets added to this exclusion rule. ||
|| `dry_run_waf_matched_exclusion_rules` | List of exclusion rules triggered in the WAF profile in dry run mode. Nested fields are similar to `waf_matched_exclusion_rules`. ||
|| `arl_profile_id` | ARL profile ID. ||
|| `arl_profile_name` | ARL profile name. ||
|| `arl_verdict` | Expected action (verdict) applied to the request by the ARL profile: `ALLOW`, `DENY`, or `CAPTCHA`. ||
|| `arl_applied_quota_name` | Name of the rule in the ARL profile that made the final decision on the request. ||
|| `arl_matched_quotas` | List of rules in the ARL profile triggered for the request. ||
|| 
* `quota_name` | ARL rule name. ||
|| 
* `allowed` | Indicates that this rule allows requests. ||
|| 
* `dry_run` | Indicates that dry run mode is enabled in the rule. ||
|| 
* `priority` | Rule priority. ||
|| 
* `counter` | Rule counter state. ||
|| 
* `requests` | Number of requests matching the rule conditions. ||
|| 
* `period` | Period for which the number of requests is counted. ||
|| 
* `limit` | Request limit. ||
|| 
* `ban_period` | Time period during which requests are counted to reach the limit. ||
|| `dry_run_exceeded_quota_names` | Names of the ARL rules with the number of requests above the limit in dry run mode. ||
|#

To analyze {{ sws-name }} logs, make requests that include the fields and field combinations you need. Check the examples of ready-made requests in [Examples of preset log filters](../operations/configure-logging.md#filtration).

## Using logs when setting up protection {#log-uses}

To ensure {{ sws-name }} does not disrupt your service availability while maintaining an adequate level of protection:

1. Enable logging in your security profile.
1. Set all rules to **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** mode.
1. Check the logs for correct traffic filtering.
1. After checking, disable the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** mode.

Each time you update or add security profile, WAF, or ARL rules, enable the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** mode. Activate a rule only after the logs confirm that it works correctly.

#### See also {#see-also}

* [{#T}](../operations/configure-logging.md)
* [{#T}](../tutorials/sws-basic-protection.md)