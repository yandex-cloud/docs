---
title: Configuring logging in {{ sws-full-name }} via {{ alb-name }}
description: Follow this guide to configure logging in {{ sws-full-name }} via {{ alb-name }}.
---

# Configuring logging via {{ alb-name }}

{% include [logging-services](../../_includes/smartwebsecurity/logging-services.md) %}

### Enable logging {#enable-logging}

{% note info %}

To manage [logging](../concepts/logging.md) in the L7 load balancer, you need the following roles:

- [alb.editor](../../application-load-balancer/security/index.md#alb-editor) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the security profile.
- [logging.writer](../../logging/security/index.md#logging-writer) for the [log group](../../logging/concepts/log-group.md) receiving the logs.

To view logs, you need the [logging.viewer](../../logging/security/index.md#logging-viewer) role for the log group.

{% endnote %}

{% list tabs group=instructions %}

- {{ cloud-logging-short-name }} {#logging}

  1. In the [management console]({{ link-console-main }}), select the folder containing the {{ sws-name }} profile.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the list, select the load balancer linked to the security profile.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.alb.section_logs-settings }}**:
     1. Enable **{{ ui-key.yacloud.alb.label_log-requests }}**.
     1. Select or create a {{ cloud-logging-name }} [log group](../../logging/concepts/log-group.md) to store your load balancer logs.
     1. Click **{{ ui-key.yacloud.alb.button_add-discard-rule }}** and configure its [settings](../../application-load-balancer/concepts/application-load-balancer.md#discard-logs-rules).
  1. Click **{{ ui-key.yacloud.common.save }}**.

  For other ways to enable logging, see [{#T}](../../application-load-balancer/operations/application-load-balancer-manage-logs.md).

- {{ at-name }} {#at}

  You can log {{ at-name }} events to a bucket in {{ objstorage-name }}, log group in {{ cloud-logging-name }}, data stream in {{ yds-name }}, or bus in {{ er-name }}. In this guide, we will set up logging of audit events to a log group.

  1. In the [management console]({{ link-console-main }}), select the folder containing the {{ sws-name }} profile.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Click **{{ ui-key.yacloud.audit-trails.button_create-trail }}**.
  1. Enter a name for the trail, e.g., `trail-sws`.
  1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, select **{{ ui-key.yacloud.audit-trails.label_cloudLogging }}** as the destination object.
  1. Select or create a {{ cloud-logging-name }} [log group](../../logging/concepts/log-group.md) to store {{ sws-name }} events.
  1. Under **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}**, enable event collection and select **{{ sws-name }}**.

      For the rest of the settings in this section, leave the default values. The system will log all data events from {{ sws-name }} in the current folder, ignoring management events.
  
  1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, create or select an account with the `logging.writer` role.
  1. Click **{{ ui-key.yacloud.common.create }}**.

  For other ways to enable event logging, see [{#T}](../../audit-trails/operations/create-trail.md).

{% endlist %}

### Viewing logs {#view-logs}

{% list tabs group=instructions %}

- {{ cloud-logging-short-name }} {#logging}

  1. In the [management console]({{ link-console-main }}), select the folder containing the {{ sws-name }} profile.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Select **{{ ui-key.yacloud.common.logs }}**.
  1. Select the number of messages per page and the time interval: 1 hour, 3 hours, 1 day, 1 week, 2 weeks.
  1. In the **Query** row, specify you query using the [filter expression language](../../logging/concepts/filter.md) and click **Run**.

     You can find examples of queries below.

  1. To view log details, expand it.

  For other ways to view logs, see [{#T}](../../application-load-balancer/operations/application-load-balancer-get-logs.md) and [{#T}](../../logging/operations/read-logs.md).


  ## Examples of preset log filters {#filtration}

  Logs are delivered in JSON format. A single log entry maps to a single client request to the L7 load balancer.

  Requests for log filtering are based on the relationship between [{{ sws-name }}](../concepts/profiles.md#profile-rules-schema) profiles and rules. You can view logs for active, running rules, or rules in **Logging only** (dry run) mode.

  ### Filters for active rules {#active-rule-filters}

  * Show requests blocked by basic rules based on specific [conditions](../concepts/conditions.md), e.g., by IP list or region:
    ```
    json_payload.smartwebsecurity.matched_rule.rule_type = RULE_CONDITION and json_payload.smartwebsecurity.matched_rule.verdict = DENY
    ```
    
  * Show requests that have triggered the [Smart Protection](../concepts/rules.md#smart-protection-rules) rules with a CAPTCHA challenge:
    ```
    json_payload.smartwebsecurity.matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.matched_rule.verdict = CAPTCHA
    ```

  * Show requests blocked based on the [WAF](../concepts/waf.md) profile, i.e., by the security profile WAF rules:
    ```
    json_payload.smartwebsecurity.matched_rule.rule_type = WAF and json_payload.smartwebsecurity.matched_rule.verdict = DENY
    ```

  * Show requests blocked by the [ARL](../concepts/arl.md) profile rules:
    ```
    json_payload.smartwebsecurity.advanced_rate_limiter.verdict = DENY
    ```

  * Show requests which triggered a specific ARL rule, `arl-rule-1`:
    ```
    json_payload.smartwebsecurity.advanced_rate_limiter.verdict = DENY and json_payload.smartwebsecurity.advanced_rate_limiter.applied_quota_name = "arl-rule-1"
    ```

  You can similarly add other conditions to the filters and adjust them to fit your traffic flow.

  ### Filters for rules in logging mode {#dry-run-filters}

  * Show requests that have triggered the [Smart Protection](../concepts/rules.md#smart-protection-rules) rules with a CAPTCHA challenge:
    
    ```
    json_payload.smartwebsecurity.dry_run_matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.dry_run_matched_rule.verdict = CAPTCHA
    ```

  * View requests that have triggered the ARL rules (limits on requests).
    
    For the **Logging only** mode, you cannot use a request filtered by the `DENY` verdict, because this mode does not block requests. The rule verdict will be `ALLOW` even after the limit is exceeded. To debug the rules, use the `dry_run_exceeded_quota_names` parameter. This parameter shows which ARL rules were triggered by the request. If this parameter contains no rules, no limits were exceeded.

    Here is an example of a log fragment with the `dry_run_exceeded_quota_names` parameter:

    ```text
    "smartwebsecurity": {
      "advanced_rate_limiter": {
        "applied_quota_name": "",
        "dry_run_exceeded_quota_names": [
          "<rule_name_1>",
          "<rule_name_2>"
        ],
        "profile_id": "<profile_id>",
        "verdict": "ALLOW"
      },
    ```

  In this fragment, limits were exceeded for the `<rule_name_1>` and `<rule_name_2>` rules in the `<profile_id>` profile.

- {{ at-name }} {#at}

  1. In the [management console]({{ link-console-main }}), select the folder containing the {{ sws-name }} profile.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. Select the log group receiving your {{ at-name }} events.
  1. Select the number of messages per page and the time interval: 1 hour, 3 hours, 1 day, 1 week, 2 weeks.
  1. In the **Query** field, specify you query using the [filter expression language](../../logging/concepts/filter.md) and click **Run**.

     {{ at-name }} events are written in JSON format. To find a specific [event](../at-ref.md#data-plane-events), provide its name in the following format:

     ```
     yandex.cloud.audit.smartwebsecurity.<event_name>
     ```

     For examples of how to create queries, see [{#T}](../../audit-trails/tutorials/search-events-audit-logs/examples.md).

  1. To view log details, expand it.

For other ways to view logs, see [{#T}](../../application-load-balancer/operations/application-load-balancer-get-logs.md).

{% endlist %}


