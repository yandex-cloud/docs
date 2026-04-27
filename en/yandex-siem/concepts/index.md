---
title: '{{ yandex-siem-full-name }}'
description: '{{ yandex-siem-full-name }} is {{ yandex-cloud }}‘s proprietary SIEM system for monitoring and analysis of security events in the cloud infrastructure.'
---

# {{ yandex-siem-full-name }} overview

{% include [preview-by-request](../../_includes/note-preview-by-request.md) %}

{{ yandex-siem-full-name }} is {{ yandex-cloud }}‘s proprietary _SIEM_ (Security Information and Event Management) system for monitoring and analysis of security events in the cloud infrastructure. {{ yandex-siem-full-name }} collects and analyzes the cloud infrastructure events to detect anomalies and potential security threats. When {{ yandex-siem-full-name }} detects an anomaly, it creates an [alert](../../security-deck/concepts/alerts.md) indicating a potential incident.

## Access to the service {#access}

{% note info %}

You get access to {{ yandex-siem-full-name }} in the {{ sd-name }} interface in [{{ cloud-center }}]({{ cloud-center-link }}) after your access request gets approved.

{% endnote %}

In {{ yandex-siem-full-name }}, you can access a list of detected incidents and select one to get troubleshooting recommendations with additional context and view the incident details and category. To see the statistics on detected incidents, refer to the dashboard on the service's home page.

For automatic threat detection, {{ yandex-siem-full-name }} uses [correlation rules](correlation-rules.md), i.e., sets of conditions by which the system analyzes events and generates alerts. To eliminate false positives, you can configure exceptions for correlation rules.

