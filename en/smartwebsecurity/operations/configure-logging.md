---
title: Configuring logging in {{ sws-full-name }}
description: Follow this guide to configure logging in {{ sws-full-name }}.
---

# Configuring logging

Analyzing {{ sws-full-name }} logs enables you to:

* Test security rules, WAF, and ARL in **Logging only** (dry run) mode.

  In this mode, user requests are not blocked, but information about triggered rules is logged.

* View the number of blocked and allowed requests, evaluate and adjust rule performance.
* View detailed request information and and identify false positives.
* Investigate security incidents.

You can set up logging in {{ sws-full-name }} using either [{{ cloud-logging-full-name }}](../../logging/) or [{{ at-full-name }}](../../audit-trails/).

* {{ cloud-logging-short-name }}: Collects basic logs for traffic and triggered security profile, WAF, and ARL rules.

   {{ sws-name }} logs are transferred through an [L7 load balancer](../../application-load-balancer/concepts/application-load-balancer.md) connected to a security profile and are written to a [log group](../../logging/concepts/log-group.md).

* {{ at-name }}: Collects more detailed audit logs (events) for WAF and ARL rules.

   In {{ at-name }}, events are delivered directly from {{ sws-name }} without using an L7 load balancer. There are two types of events in {{ at-name }}:

   * [Management events](../at-ref.md#control-plane-events), which include actions related to {{ yandex-cloud }} resource configuration, e.g., creating or deleting a security profile.
   * [Data events](../at-ref.md#data-plane-events), i.e., actions taken with resources within {{ yandex-cloud }} services, such as triggering a WAF profile rule.

   You can log {{ at-name }} events to a bucket in {{ objstorage-name }}, log group in {{ cloud-logging-name }}, or data stream in {{ yds-name }}.

To get started with {{ sws-name }} logs:

1. [Enable and set up logging](#enable-logging).
1. [View and filter logs](#view-logs).

## Enable logging {#enable-logging}

{% list tabs group=instructions %}

- {{ cloud-logging-short-name }} {#logging}

  1. In the [management console]({{ link-console-main }}), select the folder containing the {{ sws-name }} profile.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Select the load balancer with a linked security profile from the list.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.alb.section_logs-settings }}**:
     1. Enable **{{ ui-key.yacloud.alb.label_log-requests }}**.
     1. Select or create a {{ cloud-logging-name }} [log group](../../logging/concepts/log-group.md) to store your load balancer logs.
     1. Click **{{ ui-key.yacloud.alb.button_add-discard-rule }}** and configure its [settings](../../application-load-balancer/concepts/application-load-balancer.md#discard-logs-rules).
  1. Click **{{ ui-key.yacloud.common.save }}**.

  For other methods of how to enable logging, see [{#T}](../../application-load-balancer/operations/application-load-balancer-manage-logs.md).

- {{ at-name }} {#at}

  You can log {{ at-name }} events to a bucket in {{ objstorage-name }}, log group in {{ cloud-logging-name }}, or data stream in {{ yds-name }}. In this guide, we will set up logging events to a log group.

  1. In the [management console]({{ link-console-main }}), select the folder containing the {{ sws-name }} profile.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Click **{{ ui-key.yacloud.audit-trails.button_create-trail }}**.
  1. Enter a name for the trail, e.g., `trail-sws`.
  1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, select the **{{ ui-key.yacloud.audit-trails.label_cloudLogging }}** destination object.
  1. Select or create a {{ cloud-logging-name }} [log group](../../logging/concepts/log-group.md) to store {{ sws-name }} events.
  1. Under **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}**, enable collecting events and select **{{ sws-name }}**.

      Leave the default values for other settings in this section. All data events from {{ sws-name }} in the current folder will be logged. Management events will not be logged.
  
  1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, create or select an account with the `logging.writer` role.
  1. Click **{{ ui-key.yacloud.common.create }}**.

  For other methods of how to enable event logging, see [{#T}](../../audit-trails/operations/create-trail.md).

{% endlist %}

## Viewing logs {#view-logs}

{% list tabs group=instructions %}

- {{ cloud-logging-short-name }} {#logging}

  1. In the [management console]({{ link-console-main }}), select the folder containing the {{ sws-name }} profile.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Go to the **{{ ui-key.yacloud.common.logs }}** section.
  1. Select the number of messages per page and the period: 1 hour, 3 hours, 1 day, 1 week, 2 weeks.
  1. In the **Request** row, specify you request using the [filter expression language](../../logging/concepts/filter.md) and click **Run**.

     You can find examples of requests below.

  1. To view log details, expand it.

  For other methods of how to view logs, see [{#T}](../../application-load-balancer/operations/application-load-balancer-get-logs.md) and [{#T}](../../logging/operations/read-logs.md).


  ### Examples of preset log filters {#filtration}

  Logs are provided in JSON format. A single log entry represents one client request to the L7 load balancer.

  Requests for log filtering are based on the relationship between [{{ sws-name }}](../concepts/profiles.md#profile-rules-schema) profiles and rules. You can view logs for active, running rules, or rules in **Logging only** (dry run) mode.

  #### Filters for active rules {#active-rule-filters}

  * Show requests blocked by basic rules with specific [conditions](../concepts/conditions.md), such as an IP list or region:
    ```
    json_payload.smartwebsecurity.matched_rule.rule_type = RULE_CONDITION and json_payload.smartwebsecurity.matched_rule.verdict = DENY
    ```
  * Show requests which triggered [Smart Protection](../concepts/rules.md##smart-protection-rules) rules with a CAPTCHA challenge:
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

  ### Filters for rules in logging mode {#dry-run-filters}

  * Show requests which triggered [Smart Protection](../concepts/rules.md##smart-protection-rules) rules with a CAPTCHA challenge:
    ```
    json_payload.smartwebsecurity.dry_run_matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.dry_run_matched_rule.verdict = CAPTCHA
    ```

  * Show requests which triggered a specific ARL rule, `arl-rule-1`:
    ```
    json_payload.smartwebsecurity.advanced_rate_limiter.verdict = DENY and json_payload.smartwebsecurity.advanced_rate_limiter.applied_quota_name = "arl-rule-1"
    ```

  You can similarly add other conditions to the filters and adjust them for your traffic flow as appropriate.

- {{ at-name }} {#at}

  1. In the [management console]({{ link-console-main }}), select the folder containing the {{ sws-name }} profile.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. Select the log group to which the {{ at-name }} events are sent.
  1. Select the number of messages per page and the period: 1 hour, 3 hours, 1 day, 1 week, 2 weeks.
  1. In the **Request** row, specify you request using the [filter expression language](../../logging/concepts/filter.md) and click **Run**.

     {{ at-name }} logs are written in JSON format. To find a specific [event](../at-ref.md#data-plane-events), specify its name in the following format:

     ```
     yandex.cloud.audit.smartwebsecurity.<event_name>
     ```

     For examples of how to create requests, see [{#T}](../../audit-trails/tutorials/search-events-audit-logs/examples.md).

  1. To view log details, expand it.

For other methods of how to view logs, see [{#T}](../../application-load-balancer/operations/application-load-balancer-get-logs.md).

{% endlist %}


