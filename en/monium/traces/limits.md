---
title: Limits
description: '{{ traces-name }} limits and quotas: storage, writes, and reads. Incoming span validation.'
---

# Limitations

There are [configurable quotas](../concepts/limits.md) and permanent limits in {{ traces-name }}.

{% include [limits-traces.md](../../_includes/monium/limits-traces.md) %}

## Incoming span validation {#validation}

Before ingestion, each batch of spans has to pass validation in terms of required fields (`trace_id`, `span_id`, timestamps), compliance with the [above limits](#traces-limits), and validity of formats. Spans that fail validation are rejected (other spans in the batch may still be accepted), and the error details go to the exporter in the response.

If some spans fail to appear in the interface or the trace looks incomplete, see [{#T}](operations/incomplete-traces.md) for common causes and troubleshooting steps.
