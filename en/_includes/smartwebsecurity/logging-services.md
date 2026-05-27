To write logs, {{ sws-name }} integrates with [{{ cloud-logging-short-name }}](../../logging/) and [{{ at-name }}](../../audit-trails/). They solve different tasks:

* {{ cloud-logging-short-name }}: Analyzes HTTP requests and triggered rules in security, WAF, and ARL profiles.
* {{ at-name }}: Collects {{ sws-name }} audit events. These are not full {{ sws-name }} logs but records of security events and actions with resources.

## Audit logs {#audit-events}

There are two types of events in {{ at-name }}:

* [Management events](../../smartwebsecurity/at-ref.md#control-plane-events), which include actions related to {{ yandex-cloud }} resource configuration, such as creating or deleting a security profile.
* [Data events](../../smartwebsecurity/at-ref.md#data-plane-events), which include actions performed on resources within {{ yandex-cloud }} services, e.g., triggering a rule from a WAF profile.

You can log events to a bucket in {{ objstorage-name }}, log group in {{ cloud-logging-name }}, or data stream in {{ yds-name }}.

## Logs of HTTP requests and triggered rules {#requests-logging}

There are two logging options available: via {{ sws-name }} and via the {{ alb-name }} L7 load balancer the security profile is connected to. Logging via {{ sws-name }} provides more analysis options than logging via {{ alb-name }}. Logs are written to a log group in {{ cloud-logging-name }}.

Log analysis enables you to configure and monitor {{ sws-name }} performance:

* Test security rules, WAF, and ARL in **Logging only** (dry run) mode. In this mode, the system does not block user requests but logs rule matches.
* View the number of blocked and allowed requests, evaluate and adjust rule performance.
* View detailed request information and identify false positives.

## Working with logs {#configure-logging}

To get started with {{ sws-name }} logs:

1. [Enable and set up logging](#enable-logging).
1. [View and filter logs](#view-logs).
