---
title: "Quotas and limits in {{ interconnect-full-name }}"
description: "This article explains what quotas and limits {{ interconnect-name }} has."
editable: false
---

# Quotas and limits in {{ interconnect-name }}

## {{ interconnect-full-name }}

{{ interconnect-full-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [increase-quotas.md](../../_includes/increase-quotas.md) %}

{% include [interconnect-limits.md](../../_includes/interconnect-limits.md) %}

{% note warning "Important" %}

If the number of received prefixes exceeds the limit, a BGP session will be terminated for 30 minutes.

To prevent such termination when the number of prefixes unexpectedly goes up, consider using monitoring to set up [notifications](../../monitoring/operations/alert/create-alert.md) for the [ipv4_announces_received_by_cloud_num](monitoring.md#private-metrics) `metric` and provide thresholds for it to trigger notifications.

{% endnote %}
