---
title: '{{ ycdr-full-name }}'
description: '{{ ycdr-name }} is a {{ sd-name }} module that collects data on your service settings within the {{ yandex-cloud }} infrastructure.'
---

# {{ ycdr-full-name }}

{% include [preview-by-request](../../_includes/note-preview-by-request.md) %}

{{ycdr-full-name }} is a {{sd-full-name }} module for monitoring and responding to incidents in {{yandex-cloud }}. {{ycdr-name }} is developed on the basis of the security operations center (SOC) of the {{yandex-cloud }} platform. The module collects data from the cloud infrastructure to detect anomalies. When anomalies are detected, {{ycdr-name }} creates alerts indicating a potential incident.

The collected data is analyzed using the {{yandex-cloud}} SIEM system. Events are transmitted to the SIEM system through a collector. The collector is installed in the {{managed-k8s-name}} cluster, which ensures its scalability and fault tolerance.

The collector must have access to an external network to send events to {{yandex-cloud}} SIEM. The events are sent over the TLS protocol, and since the SIEM is physically located within the {{yandex-cloud}} infrastructure, the data does not leave the data center.

The collector operates at the [cloud](../../resource-manager/concepts/resources-hierarchy.md) level. Each cloud should have a separate collector.

The collector architecture includes two modules:

1.  A component for collecting and sending events based on `Vector`. Allows receiving events from `osquery` agents and custom events over the HTTP protocol.
1. The `syslog` component collects events and sends them to the Vector-based component for further processing.

In {{ycdr-full-name}}, you can select a detected incident from the list and get additional context, classification, recommendations for its mitigation, and examine the incident details. Statistics on detected incidents are displayed on the dashboard on the module's main page.
