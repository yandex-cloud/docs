---
title: Correlation and exclusion rules in {{ yandex-siem-full-name }}
description: '{{ yandex-siem-full-name }} correlation rules allow you to automatically detect security threats based on KQL queries. Exclusions allow you to exclude events known to be safe from the analysis.'
---

# Correlation rules and exceptions

## Correlation rules {#correlation-rules}

A _correlation rule_ is a set of conditions that, when met, prompts {{ yandex-siem-full-name }} to automatically create an alert. The rules analyze the stream of security events to identify patterns typical for threats or anomalies.

### Types of rules {#rule-types}

There are two types of correlation rules available in {{ yandex-siem-full-name }}:

* **Pre-installed**: Supplied by default. Cover typical threats and attack scenarios. You cannot delete these, but you can disable them or create exceptions for them.

* **Custom**: Created by the user for specific tasks and scenarios. Can be edited and deleted.

### Rule structure {#rule-structure}

Each correlation rule contains the following parameters:

#|
|| Parameter | Description ||
|| **Name** | Unique name of the rule ||
|| **Description** | Additional information about the purpose of the rule ||
|| **Class** | Threat category the rule pertains to ||
|| **Severity** | Severity level of the alert generated when the rule triggers ||
|| **Correlation rule** | KQL query which decides which events will be seen as suspicious. To make the query, you can use the available templates, database schema, and datasets ||
|| **Event analysis mode** | Decides how the rule will process events: in real time or at specified intervals ||
|| **Aggregation key** | Field events are grouped based on before the condition is checked ||
|| **Aggregation window** | Time interval within which events are aggregated for analysis ||
|| **Actions upon triggering** | New alert settings: name, type, and classification ||
|#

### Rule statuses {#rule-statuses}

Each rule has a status that reflects its current state:

#|
|| Status | Description ||
|| **Healthy** | The rule is active and processing events normally ||
|| **Unhealthy** | The rule requires attention: there are event processing errors ||
|| **Inactive** | The rule is off and not processing events ||
|#

### Rule deployment {#rule-deployment}

Changes to rules take effect right after deployment. To apply changes, mark the rule for deployment. The deployment status reflects the current change application stage:

#|
|| Deployment status | Description ||
|| **Updated** | The rule was changed, but the changes are not marked for deployment yet ||
|| **Will be deployed** | The rule is marked for deployment ||
|| **Deploying** | Changes are being applied ||
|| **Deployed** | Changes were successfully applied and the rule operates in relevant configuration ||
|| **Error** | Error during deployment ||
|#

If you do not need the updates, you can reset them to the last deployed version.

## Exceptions {#exceptions}

_Exception_: Denies creating an alert when a correlation rule triggers for certain events. By using exceptions, you can reduce false positives and avoid analyzing events that are known to be safe.

### Exception structure {#exception-structure}

Each exception contains the following parameters:

#|
|| Parameter | Description ||
|| **Name** | Unique name of the exception ||
|| **Description** | Additional information about the purpose of the exception ||
|| **Linked rule** | Correlation rule the exception is valid for. Selected from the list of existing rules ||
|| **Conditions** | One or more _key = value_ pairs for events which must not trigger the rule ||
|#

### Exception deployment {#exception-deployment}

Same as in rules, changes in exceptions take effect after deployment. The exception deployment statuses are the same as the rule deployment statuses: **Updated**, **Will be deployed**, **Deploying**, **Deployed**, **Error**.

#### See also {#see-also}

* [{#T}](../operations/correlation-rules/manage-rules.md)
* [{#T}](../operations/exceptions/manage-exceptions.md)
