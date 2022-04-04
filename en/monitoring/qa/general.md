---
title: "Yandex Monitoring. FAQ"
description: "How can I supply metrics of my application to Yandex Monitoring? How can I supply metrics of third-party applications to Yandex Monitoring? Answers to these and other questions are in this article."
---

# General questions about {{ monitoring-name }}

{% include [qa-logs.md](../../_includes/qa-logs.md) %}

#### I don't see service dashboards {#dont-see-dashboards}

Service dashboards are created automatically after resources are created in {{ yandex-cloud }}. Add a resource to {{ yandex-cloud }} and update the {{ monitoring-name }} [homepage]((https://monitoring.cloud.yandex.com).

#### The old data in {{ monitoring-name }} charts has disappeared {#lost-data-graphs}

Metrics that haven't received new values for in 30 days are automatically deleted from {{ monitoring-full-name }}. For more information, see [Deleting expired metrics (TTL)](../concepts/ttl.md).

There is also a non-configurable [decimation mechanism](../concepts/decimation.md) that decreases the amount of stored data.