---
title: '{{ ycdr-full-name }}'
description: '{{ ycdr-name }} is a service that collects the infrastructure settings data of your {{ yandex-cloud }} services.'
---

# {{ ycdr-full-name }} overview

{% include [preview-by-request](../../_includes/note-preview-by-request.md) %}

{{ ycdr-full-name }} provides incident monitoring and response in {{ yandex-cloud }}. {{ ycdr-name }} is built around {{ yandex-cloud }}'s in-house Security Operations Center (SOC). This service collects data from the cloud infrastructure to detect anomalies. When {{ ycdr-name }} detects an anomaly, it creates an [alert](../../security-deck/concepts/alerts.md) indicating a potential incident.

The {{ yandex-cloud }} SIEM system analyzes the collected data. Events are sent to the SIEM system via a _collector_. The collector is installed in a {{ managed-k8s-name }} cluster, which ensures its scalability and fault-tolerance.

The collector must have access to the external network to send events to the {{ yandex-cloud }} SIEM. Yet, since events are sent over the TLS protocol and SIEM is physically located in the {{ yandex-cloud }} infrastructure, the data remains inside the data center.

The collector works at the [cloud](../../resource-manager/concepts/resources-hierarchy.md) level. Each cloud must have a dedicated collector for sending events.

The collector architecture comprises two modules:

1. `Vector`-based component for collecting and sending events. It enables receiving events from `osquery` agents and random events over HTTP.
1. `syslog` event collection component which collects events and sends them to the `Vector`-based component for further processing.

In {{ ycdr-full-name }}, you can access a list of detected incidents and select one to get troubleshooting recommendations with additional context and view the incident details and category. To see the statistics on detected incidents, refer to the dashboard on the service's home page.

