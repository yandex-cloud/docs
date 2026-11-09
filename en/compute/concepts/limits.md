---
title: '{{ compute-full-name }} quotas and limits'
description: '{{ compute-name }} has limits and quotas on virtual machines, HDDs, and SSDs. For more information about the service limitations, read this article.'
editable: false
---

# {{ compute-name }} quotas and limits


{% note warning %}

Nine quotas for {{ compute-name }} resources apply separately to each availability zone rather than to the entire region.

{% endnote %}



{% include [reserved-pools-preview-notice](../../_includes/compute/reserved-pools-preview-notice.md) %}

{{ compute-name }} has the following limitations:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}


{{ compute-name }} has *regional* and *zonal* quotas. A regional quota limits resource usage by a single cloud across the entire [region](../../overview/concepts/region.md). A zonal quota limits resource usage by a single cloud separately in each [availability zone](../../overview/concepts/geo-scope.md).


{% include [increase-quotas.md](../../_includes/increase-quotas.md) %}

{% include [compute-limits.md](../../_includes/compute-limits.md) %}