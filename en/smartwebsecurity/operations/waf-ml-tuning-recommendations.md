---
title: Monitoring and adjusting ML WAF protection
description: How to monitor changes in ML WAF behavior after a model update and adjust the protection settings.
---

# Monitoring and adjusting ML WAF protection

This section describes how to monitor changes in [ML WAF (Yandex Malicious Score)](../concepts/waf.md#yandex-ml-ruleset) behavior after a model update and adjust the protection settings. Since the model is fine-tuned regularly, the `score` value for the same request may change. If `score` reaches or exceeds the specified [anomaly threshold](../concepts/waf.md#anomaly), the verdict for the request may change. The logs do not show the model revision, but changes in `score` and verdicts can indicate changes in model behavior. A threshold of `90` guarantees stable verdicts. Start with this value, monitor rule matches, and adjust the settings as needed.

To ensure your infrastructure is always protected:

1. [Enable detailed logging](#enable-logging).
1. [Set baseline protection metrics](#fix-baseline).
1. [Narrow down the change scope](#handle-false-positives).
1. [Adjust the protection scope to the minimum necessary](#change-one-parameter).
1. [Assess the impact using security and availability metrics](#verify-after-change).
1. [When to contact support](#contact-support).

## Enable detailed logging {#enable-logging}

[Configure logging](configure-logging.md) via {{ sws-name }} and enable logging for:

* Requests with the `DENY` and `CAPTCHA` verdicts.
* Percentage of requests with the `ALLOW` action. For allowed traffic, you can use a sampling rate from `1` to `100` percent. The higher the percentage, the more information you get, but the more logs are generated.

Use the following [log fields](../concepts/logging.md#log-contents) to analyze ML WAF rule matches:

* `action` and `dry_run_matched_rule_verdict`: Final and dry-run verdict for the request.
* `waf_applied_rule_set_id`: Rule set that made the verdict.
* `waf_matched_rules` and `dry_run_waf_matched_rules`: WAF rules that matched, including those in dry-run mode.
* `rule_id`, `rule_set_id`, and `rule_group_id`: Rule, rule set, and rule group IDs.
* `score`: [Anomaly](../concepts/waf.md#anomaly) score for the request.
* `matched_data_variable`, `matched_data_key`, and `matched_data_value`: Part of the request containing the anomaly.
* `waf_matched_exclusion_rules`: Exclusion rules that matched.

## Set baseline protection metrics {#fix-baseline}

Before changing the ML WAF settings, set the following metrics separately for each attack group:

* Number and percentage of requests with the `ALLOW`, `DENY`, and `CAPTCHA` verdicts.
* Distribution of `score` values.
* Top routes, request parameters, and request parts triggering rule matches.
* Percentage of `4xx` and `5xx` responses, service availability, and business metrics for critical scenarios.
* Current WAF profile configuration, including the rule set ID and version.

Baseline metrics help distinguish the impact of a model update from seasonal traffic fluctuations, changes in traffic composition, and your own configuration changes.

## Narrow down the change scope {#handle-false-positives}

When a false positive is detected:

1. Use the application logs to confirm that the request is legitimate.
1. Identify the specific ML WAF attack group, rule, route, and request part for which the rule matched.
1. Temporarily increase the anomaly threshold for the affected group or switch the rule back to **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** mode.
1. Once the false positive is confirmed, create an [exclusion rule](../concepts/waf.md#exclusion-rules).
1. Enable logging for the exclusion and check the logs to make sure it only applies to expected traffic.

{% note warning %}

Do not disable the entire WAF profile or exclude the entire request if the false positive can be isolated to a single rule, route, or request field. A broad exclusion can create an uncontrolled protection bypass.

{% endnote %}

Narrow down your exclusion rule by combining multiple criteria:

* Specific WAF rule.
* Route, host, or HTTP method.
* Specific part of the request: HTTP request body, cookie, HTTP header, or query string parameters.
* Specific parameter or header, if known.

## Adjust the protection scope to the minimum necessary {#change-one-parameter}

Start with the recommended anomaly threshold of `90` and enable attack groups one at a time.

Do not combine the following in a single change:

* Enabling a new attack group.
* Lowering the anomaly threshold.
* Expanding the profile scope.

When lowering the anomaly threshold, consider the risk of false positives: the lower the threshold, the higher the protection sensitivity.

## Assess the impact using security and availability metrics {#verify-after-change}

After each change, monitor security and availability metrics.

Security metrics:
* Number and breakdown of ML WAF rule matches.
* Distribution of `score` values.
* Suspicious traffic and incidents.
* Changes in coverage across attack groups.

Availability and business metrics:
* Percentage of `4xx` and `5xx` responses.
* Authorization and payment errors.
* Successful API requests and integrations.
* User support requests.
* Conversion rates for critical user scenarios.

A lower percentage of blocked requests does not always mean better protection. It may be due either to fewer false positives or more attacks getting through.

## When to contact support {#contact-support}

Contact {{ yandex-cloud }} [support]({{ link-console-support }}) in the following cases:

* Verdicts started changing at scale without any configuration changes on your side.
* The issue manifested simultaneously on unrelated routes.
* The matches cannot be isolated to a single rule or request field.
* Mitigating the issue safely requires a broad exclusion or disabling ML WAF.
* A business metric changed, but the logs do not provide enough information to associate it with a specific rule or request.
* The timing of the change coincided with an ML WAF model or rule set update.

Specify the following in your support ticket:

* Change start time and time zone.
* `security_profile_id` and `waf_profile_id`.
* Rule set ID and version (`ruleSet.id` and `ruleSet.version`).
* `rule_id` and `rule_group_id` in question.
* Several `alb_request_id` and `unique_key` values from the logs.
* Aggregated comparison of metrics before and after the change.
* Actions taken so far.

#### Useful links {#see-also}

* [{#T}](../concepts/waf.md)
* [{#T}](configure-set-rules.md)
* [{#T}](exclusion-rule-add.md)
* [{#T}](configure-logging.md)
* [{#T}](monitoring.md)
