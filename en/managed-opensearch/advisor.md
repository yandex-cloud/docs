---
title: Recommendations for improving {{ mos-name }} cluster reliability, cost optimization, and performance
description: In this section, you will learn how to work with the results of {{ mos-name }} cluster checks and diagnostics.
---

# Inspections and recommendations in {{ mos-name }} 

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

Managing recommendations in {{ mos-name }} requires the [{{ roles.mos.editor }} role or higher](../managed-opensearch/security/index.md).

## Available inspections in {{ mos-name }} {#mos-recommendations}

| **Category** | **Check** | **Risk** | **Severity** |
|---------------------|-----------------------------------------------|---------------------------------------------------------------------------------------------------------|-----------------|
| Performance | CPU usage | [Risk of reduced performance](#opensearch_cpu_idle) | High         |
| High availability | Database version updates | [Database version is out of date](#opensearch_deprecated_version) | High         |
| High availability | Autoscaling feature | [Disk space autoscaling is not configured](#opensearch_disk_autoscaling) | Low          |
| High availability | Autoscaling feature (restrictions) | [Disk space autoscaling is restricted](#opensearch-disk-autoscaling-limit) | Moderate       |
| High availability | Allocating disk space | [Risk of cluster unavailability](#opensearch_disk_free_space) | High         |
| High availability | Memory allocation | [Lack of RAM](#opensearch_oom) | High         |
| High availability | High cluster availability during zone failure | [Risk of data loss and cluster unavailability in the event of a zone failure](#opensearch_high_availability) | High         |

{% include [opensearch-cpu-idle](../_advisor/managed-opensearch/opensearch-cpu-idle.md) %}

{% include [opensearch-deprecated-version](../_advisor/managed-opensearch/opensearch-deprecated-version.md) %}

{% include [opensearch-disk-autoscaling](../_advisor/managed-opensearch/opensearch-disk-autoscaling.md) %} 

{% include [opensearch-disk-autoscaling-limit](../_advisor/managed-opensearch/opensearch-disk-autoscaling-limit.md) %}

{% include [opensearch-disk-free-space](../_advisor/managed-opensearch/opensearch-disk-free-space.md) %}

{% include [opensearch-oom](../_advisor/managed-opensearch/opensearch-oom.md) %}

{% include [opensearch-ha-zone](../_advisor/managed-opensearch/opensearch-ha-zone.md) %}



