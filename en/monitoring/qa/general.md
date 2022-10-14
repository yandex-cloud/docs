---
title: "{{ monitoring-full-name }}. FAQ"
description: "How can I supply metrics of my application to {{ monitoring-full-name }}? How can I supply metrics of third-party applications to {{ monitoring-full-name }}? Answers to these and other questions are in this article."
---

# General questions about {{ monitoring-name }}

{% include [logs](../../_qa/logs.md) %}

#### How do I view service dashboards? {#dont-see-dashboards}

Service dashboards are created automatically after resources are created in {{ yandex-cloud }}. Add a resource and update the {{ monitoring-name }} [homepage]({{ link-monitoring }}).

#### The old data in {{ monitoring-name }} charts has disappeared. Why? {#lost-data-graphs}

Metrics that haven't received new values for in 30 days are automatically deleted from {{ monitoring-name }}. For more information, see [{#T}](../concepts/ttl.md).

There is also a non-configurable [decimation mechanism](../concepts/decimation.md) that decreases the amount of stored data.
