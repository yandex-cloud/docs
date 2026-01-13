---
title: Configuring logging in {{ sws-full-name }}
description: Follow this guide to configure logging in {{ sws-full-name }}.
---

# Configuring logging via {{ sws-name }}

{% include [logging-preview](../../_includes/smartwebsecurity/logging-preview.md) %}

There are two log collection options available: via {{ sws-name }} and via the L7 {{ alb-name }} the security profile is connected to.

This section provides information on logging via {{ sws-name }}. If you want to learn about collecting logs via an L7 balancer, see [{#T}](configure-logging-alb.md).

Analyzing {{ sws-full-name }} logs enables you to:

* Test security rules, WAF, and ARL in **Logging only** (dry run) mode.

  In this mode, the system does not block user requests but logs rule matches.

* View the number of blocked and allowed requests, evaluate and adjust rule performance.
* View detailed request information and identify false positives.
* Investigate security incidents.

You can set up logging in {{ sws-full-name }} using either [{{ cloud-logging-full-name }}](../../logging/) or [{{ at-full-name }}](../../audit-trails/).

* {{ cloud-logging-short-name }}: Collects detailed logs on HTTP requests and rule matches from security profiles, WAF, and ARL.

* {{ at-name }}: Collects audit logs (events) for WAF and ARL rules and security events.

   There are two types of events in {{ at-name }}:

   * [Management events](../at-ref.md#control-plane-events), which include actions related to {{ yandex-cloud }} resource configuration, such as creating or deleting a security profile.
   * [Data events](../at-ref.md#data-plane-events), which include actions performed on resources within {{ yandex-cloud }} services, e.g., triggering a rule from a WAF profile.

   You can log {{ at-name }} events to a bucket in {{ objstorage-name }}, log group in {{ cloud-logging-name }}, or data stream in {{ yds-name }}.

To get started with {{ sws-name }} logs:

1. [Enable and set up logging](#enable-logging).
1. [View and filter logs](#view-logs).

## Enable logging {#enable-logging}

You can enable logging when [creating a security profile](profile-create.md) or later, when editing it:

{% list tabs group=instructions %}

- {{ cloud-logging-short-name }} {#logging}

  1. In the [management console]({{ link-console-main }}), select the folder containing the {{ sws-name }} profile.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. In the row with the security profile you need, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Enable **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.loggingEnable_6eK2x }}**.
  1. In the **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.outputTitle_tw1oT }}** field, select **{{ cloud-logging-name }}**.
  1. Select or create a {{ cloud-logging-name }} [log group](../../logging/concepts/log-group.md) to store your logs.
  1. For logging, you can choose only those requests that triggered:
     * **{{ ui-key.yacloud.smart-web-security.baseRulesTitle_xcJEe }}**.
     * **{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}** rules.
     * **{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}** rules.
     * **{{ ui-key.yacloud.smart-web-security.arlTitle_e3MD8 }}** rules.
     * All selected rules applied the **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.denyAndCaptchaTitle_tCthP }}** action (verdict).
     * All selected rules applied the **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.allowTitle_g6CLe }}** action (legitimate requests).

       Usually the number of legitimate requests is much higher than illegitimate ones. To reduce the amount of logs, configure the **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.allowPercentageTitle_3334 }}** parameter: from 1 to 100 %. When setting up rules for the first time, we recommend that you analyze all legitimate requests. Once you make sure the rules are working correctly, you can change the log percentage or disable logging of requests with the **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.allowTitle_g6CLe }}** verdict. 
  
  1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ at-name }} {#at}

  You can log {{ at-name }} events to a bucket in {{ objstorage-name }}, log group in {{ cloud-logging-name }}, or data stream in {{ yds-name }}. In this guide, we will set up logging of events to a log group.

  1. In the [management console]({{ link-console-main }}), select the folder containing the {{ sws-name }} profile.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Click **{{ ui-key.yacloud.audit-trails.button_create-trail }}**.
  1. Enter a name for the trail, e.g., `trail-sws`.
  1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, select **{{ ui-key.yacloud.audit-trails.label_cloudLogging }}** as the destination object.
  1. Select or create a {{ cloud-logging-name }} [log group](../../logging/concepts/log-group.md) to store {{ sws-name }} events.
  1. Under **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}**, enable event collection and select **{{ sws-name }}**.

      Leave the default values for other settings in this section. The system will log all data events from {{ sws-name }} in the current folder, ignoring management events.
  
  1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, create or select an account with the `logging.writer` role.
  1. Click **{{ ui-key.yacloud.common.create }}**.

  For other ways to enable event logging, see [{#T}](../../audit-trails/operations/create-trail.md).

  To make {{ sws-full-name }} deliver its events to {{ at-name }}:

  1. In the [management console]({{ link-console-main }}), select the folder containing the {{ sws-name }} profile.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. In the row with the security profile you need, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Enable **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.loggingEnable_6eK2x }}**.
  1. In the **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.outputTitle_tw1oT }}** field, select **{{ at-name }}**.
  1. Optionally, select for which rules or verdicts to deliver events:
     * **{{ ui-key.yacloud.smart-web-security.baseRulesTitle_xcJEe }}**.
     * **{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}**.
     * **{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}**.
     * **{{ ui-key.yacloud.smart-web-security.arlTitle_e3MD8 }}**.
     * **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.denyAndCaptchaTitle_tCthP }}**.
     * **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.allowTitle_g6CLe }}**.
  1. Click **{{ ui-key.yacloud.common.create }}**.

  This allows configuring event delivery only from specific security profiles or only for specific rules and verdicts.

{% endlist %}

## Viewing logs {#view-logs}

{% list tabs group=instructions %}

- {{ cloud-logging-short-name }} {#logging}

  1. In the [management console]({{ link-console-main }}), select the folder containing the {{ sws-name }} profile.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Select **{{ ui-key.yacloud.common.logs }}**.
  1. Select a log group if there are several.
  
  1. Select the log display period using one of the following methods:
     
     * Click the interval button, e.g., **Last hour**, and select one of the options: **Last 5 minutes**, **Last 30 minutes**... **Last day**.
        You can also select the required dates in the calendar and specify the time in the **From** and **To** fields.
     * Select a preset period: **Now**, **5m**, **30m**, **1h**, **1d**, **2d**, or specify your own value.
     * On the timeline, move the period start and end indicators.
  
  1. In the **Request** line, specify the selection parameters:
     
     * Select the log fields from the drop-down list or start typing the field name.

       Fields for filtering are described in [{#T}](../concepts/logging.md).
  
     * To the right of the request string, click **</>** and enter your request in text mode using the [filter expression language](../../logging/concepts/filter.md).

       You can find examples of queries below.

     {% note info %}

     By default, the following internal fields are selected in the request string: `project`, `cluster`, `service`, and `message = *SWS`. Do not change these values.

     {% endnote %}

  1. Click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**. To view log details, expand it.

  ## Examples of preset log filters {#filtration}

  Logs are delivered in JSON format. One log entry is one client request processed by {{ sws-name }}.

  Queries for log filtering are based on the relationship between [{{ sws-name }}](../concepts/profiles.md#profile-rules-schema) profiles and rules. You can view logs for active, running rules, or rules in **Logging only** (dry run) mode.

  ### Filters for active rules {#active-rule-filters}

  * Show requests blocked by basic rules based on specific [conditions](../concepts/conditions.md), e.g., by IP list or region:
    ```
    module_type = "RULE_CONDITION", meta.matched_rule_verdict = "DENY"
    ```
  * Show requests that have triggered the [Smart Protection](../concepts/rules.md##smart-protection-rules) rules with a CAPTCHA challenge:
    ```
    module_type = "SMART_PROTECTION", meta.matched_rule_verdict = "CAPTCHA"
    ```
  * Show requests blocked based on the [WAF](../concepts/waf.md) profile, i.e., by the security profile WAF rules:
    ```
    module_type = "WAF", meta.matched_rule_verdict = "DENY"
    ```
  * Show requests blocked by the [ARL](../concepts/arl.md) profile rules:
    ```
    meta.arl_verdict = "DENY"
    ```

  * Show requests which triggered a specific ARL rule, `arl-rule-1`:
    ```
    meta.arl_verdict = "DENY", meta.arl_applied_quota_name = "arl-rule-1"
    ```

  ### Filters for rules in logging mode {#dry-run-filters}

  * Show requests that have triggered the [Smart Protection](../concepts/rules.md#smart-protection-rules) rules with a CAPTCHA challenge:
    ```
    module_type = "SMART_PROTECTION", meta.dry_run_matched_rule_verdict = "CAPTCHA"
    ```

  * Show requests that exceeded the specific ARL rule, `arl-rule-1`:
    ```
    meta.arl_verdict = "DENY", meta.arl_dry_run_exceeded_quota_names = "arl-rule-1"
    ```

  You can similarly add other conditions to the filters and adjust them to fit your traffic flow.

- {{ at-name }} {#at}

  1. In the [management console]({{ link-console-main }}), select the folder containing the {{ sws-name }} profile.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. Select the log group receiving your {{ at-name }} events.
  1. Select the number of messages per page and the time interval: 1 hour, 3 hours, 1 day, 1 week, 2 weeks.
  1. In the **Query** field, specify you query using the [filter expression language](../../logging/concepts/filter.md) and click **Run**.

     {{ at-name }} logs are written in JSON format. To find a specific [event](../at-ref.md#data-plane-events), provide its name in the following format:

     ```
     yandex.cloud.audit.smartwebsecurity.<event_name>
     ```

     For examples of how to create queries, see [{#T}](../../audit-trails/tutorials/search-events-audit-logs/examples.md).

  1. To view log details, expand it.

{% endlist %}