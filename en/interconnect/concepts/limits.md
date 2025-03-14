---
title: Quotas and limits in {{ interconnect-full-name }}
description: In this article, you will learn about quotas and limits in {{ interconnect-name }}.
editable: false
---

# Quotas and limits in {{ interconnect-name }}

## {{ interconnect-full-name }}

{{ interconnect-full-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [increase-quotas.md](../../_includes/increase-quotas.md) %}

{% include [interconnect-limits.md](../../_includes/interconnect-limits.md) %}

{% note warning "Important" %}

If you go over the limit of prefixes you get, the BGP session will be teared down for 30 minutes.

To prevent such session teardown when the number of prefixes unexpectedly goes up, consider using monitoring to set up [notifications](../../monitoring/operations/alert/create-alert.md) for the `ipv4_announces_received_by_cloud_num` [metric](monitoring.md#private-metrics) and provide thresholds for it to trigger notifications.

{% endnote %}
