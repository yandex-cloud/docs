---
title: Recommendations for improving {{ mgp-name }} cluster reliability, cost optimization, and performance
description: In this section, you will learn how to work with the results of {{ mgp-name }} cluster checks and diagnostics.
---

# Inspections and recommendations in {{ mgp-name }} 

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

To manage recommendations in {{ mgp-name }}, you need the [{{ roles.mgp.editor }} role or higher](../managed-greenplum/security/index.md).

## Inspections available in {{ mgp-name }} {#mgp-recommendations}

| **Category** | **Check** | **Risk** | **Severity** |
|---------------------|-------------------------|----------------------------------------------------------------------------------------------------|-----------------|
| Performance | CPU usage | [Risk of degraded performance](#greenplum_cpu_idle) | High         |
| High availability | Memory allocation | [Lack of RAM](#greenplum_oom) | Moderate       |
| High availability | ZSTD memory accounting | [Risk of exceeding resource manager memory limits](#greenplum_gp_enable_zstd_memory_accounting) | Moderate       |

{% include [greenplum-cpu-idle](../_advisor/managed-greenplum/greenplum-cpu-idle.md) %}

{% include [greenplum-oom](../_advisor/managed-greenplum/greenplum-oom.md) %} 

{% include [greenplum-gp-enable-zstd-memory-accounting](../_advisor/managed-greenplum/greenplum-gp-enable-zstd-memory-accounting.md) %}
