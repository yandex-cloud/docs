---
title: Deleting expired metrics (TTL)
description: In this article, you will learn how to delete expired metrics (TTL).
---

# Deleting expired metrics (TTL)

In {{ monitoring-full-name }}, there are two types of metrics:

* Custom metrics.
* System metrics automatically collected from all active {{ yandex-cloud }} resources.

Metrics for which no new values have been received for 30 days are considered expired and automatically deleted from {{ monitoring-full-name }}. Automatic deletion of expired metrics is run once a day.

After you delete a resource, the collection of its metrics stops. The metrics data of deleted resources continues to be available for 30 days. After this period, metrics are automatically deleted.

Some services have special conditions:

* For {{ managed-prometheus-name }}, there is a separate retention period [quota](../operations/prometheus/index.md#quotas-per-endpoint) for expired metrics.
* For {{ compute-full-name }}, expired metrics are stored for 7 days. For example, if your folder hosts a VM and you delete or stop it on `August 1, 2020`, its metrics will be available in {{ monitoring-full-name }} until `August 8, 2020`.

To set a shorter retention period, contact [support]({{ link-console-support }}).
