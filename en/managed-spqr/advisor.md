---
title: Recommendations for improving {{ mspqr-name }} cluster reliability, cost optimization, and performance
description: In this section, you will learn how to work with the results of {{ mspqr-name }} cluster checks and diagnostics.
---

# Inspections and recommendations in {{ mspqr-name }} 

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

Managing recommendations in {{ mspqr-name }} requires the [managed-spqr.editor role or higher](../managed-spqr/security.md).

## Available inspections in {{ mspqr-name }} {#mspqr-recommendations}

| **Category** | **Check** | **Risk** | **Severity** |
|---------------------|---------------------|-----------------------------------------------------------------------------|-----------------|
| Performance | CPU usage | [High CPU load is detected](#spqr_cpu_idle) | High |

{% include [spqr-cpu-idle](../_advisor/managed-spqr/spqr-cpu-idle.md) %}

