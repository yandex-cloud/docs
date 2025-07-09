---
title: '{{ ycdr-full-name }}'
description: '{{ ycdr-name }} is a module within {{ sd-name }} that collects data on settings of your {{ yandex-cloud }} service infrastructure.'
---

# About {{ ycdr-full-name }}

{% include [preview-by-request](../../_includes/note-preview-by-request.md) %}

{{ ycdr-full-name }} is a module that monitors and responds to{{ yandex-cloud }} infrastructure incidents. {{ ycdr-name }} is built around {{ yandex-cloud }}'s in-house Security Operations Center (SOC). The module collects data from the cloud infrastructure to detect anomalies. When {{ ycdr-name }} detects an anomaly, it creates alerts indicating a potential incident.

The {{ yandex-cloud }} SIEM system analyzes the collected data. Events are sent to the SIEM system via a _collector_. The collector is installed in a {{ managed-k8s-name }} cluster, which ensures its scalability and fault-tolerance.

The collector must have access to the external network to send events to the {{ yandex-cloud }} SIEM. Yet, since events are sent over the TLS protocol and SIEM is physically located in the {{ yandex-cloud }} infrastructure, the data remains inside the data center.

The collector works at the [cloud](../../resource-manager/concepts/resources-hierarchy.md) level. Each cloud must have a dedicated collector for sending events.

The collector architecture comprises two modules:

1. `Vector`-based component for collecting and sending events. It enables receiving events from `osquery` agents and random events over HTTP.
1. `syslog` event collection component which collects events and sends them to the `Vector`-based component for further processing.

In {{ ycdr-full-name }}, you can acess a list of detected incidents and select one to get troubleshooting recommendations with additional context and view the incident details and category. To see the statistics for detected incidents, refer to the dashboard on the main page.
