---
title: "Quotas and limits in {{ interconnect-full-name }}"
description: "In this article, you will learn what quotas and limits are used in {{ interconnect-name }}."
editable: false
---

# Quotas and limits in {{ interconnect-name }}

## {{ interconnect-full-name }}

{{ interconnect-full-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [increase-quotas.md](../../_includes/increase-quotas.md) %}

{% include [interconnect-limits.md](../../_includes/interconnect-limits.md) %}

{% note warning "Important" %}

If the number of received prefixes exceeds the limit, a BGP session is terminated for 30 minutes.

To prevent the termination of a BGP session when the number of prefixes is unexpectedly exceeded, we recommend setting up [notifications](../../monitoring/operations/alert/create-alert.md) in the monitoring service for the `ipv4_announces_received_by_cloud_num` [metric](monitoring.md#private-metrics) and set thresholds for it to trigger notification sending.

{% endnote %}
