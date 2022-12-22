---
editable: false
---

# Quotas and limits in {{ interconnect-name }}

## {{ interconnect-full-name }}

{{ interconnect-full-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [interconnect-limits.md](../../_includes/interconnect-limits.md) %}

{% note warning "Important" %}

If the number of received prefixes exceeds the limit, a BGP session is terminated for 30 minutes.

We recommend setting up [alerting](../../monitoring/operations/alert/create-alert.md) for the `ipv4_announces_received_by_cloud_num` [metric](user-metrics.md) and set alert thresholds to prevent the termination of a BGP session when the number of prefixes is suddenly exceeded.

{% endnote %}