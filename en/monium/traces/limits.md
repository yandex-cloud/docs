---
title: Limitations
description: '{{ traces-name }} limits and quotas: storage, writes, and reads. Incoming span validation.'
---

# Limitations

## Limits {#traces-limits}

{% include [limits-traces.md](../../_includes/monium/limits-traces.md) %}

## Incoming span validation {#validation}

Before ingestion, each batch of spans has to pass validation in terms of required fields (`trace_id`, `span_id`, timestamps), compliance with the [above limits](#traces-limits), and validity of formats. Spans that fail validation are rejected (other spans in the batch may still be accepted), and the error details go to the exporter in the response.

If some spans are missing from the UI or a trace appears incomplete, see [{#T}](operations/incomplete-traces.md) for common causes and troubleshooting steps.
