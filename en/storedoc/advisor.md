---
title: Recommendations for improving {{ mmg-name }} cluster reliability, cost optimization, and performance
description: In this section, you will learn how to work with the results of {{ mmg-name }} cluster checks and diagnostics.
---

# Inspections and recommendations in {{ mmg-name }} 

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

Managing recommendations in {{ mmg-name }} requires the [{{ roles.mmg.editor }} role or higher](../storedoc/security/index.md).

## Available inspections in {{ mmg-name }} {#mmg-recommendations}

| **Category** | **Check** | **Risk** | **Severity** |
|---------------------|----------------------------------------------|-------------------------------------------------------------------------------------------------------|-----------------|
| Performance | CPU usage | [Risk of reduced performance](#storedoc_cpu_idle) | High         |
| High availability | Availability of replicas in a shard                       | [Risk of data loss and cluster unavailability in the event of a zone failure (lack of replicas)](#storedoc_ha_replics) | Low          |
| High availability | High cluster availability during zone failure | [Risk of data loss and cluster unavailability in the event of a zone failure](#storedoc_ha_geos) | High         |
| High availability | Allocating disk space | [Risk of cluster unavailability](#storedoc_disk_free_space) | High         |
| High availability | Memory allocation | [Lack of RAM](#storedoc_oom) | High         |
| High availability | Database version updates | [Database version is out of date](#storedoc_deprecated_version) | High         |
| High availability | Replication lag | [Risk of data loss](#storedoc_replication_lag) | Moderate       |
| High availability | Disk autoscaling feature | [Disk space autoscaling is limited](#storedoc_disk_autoscaling_limit) | Moderate       |

{% include [storedoc-cpu-idle](../_advisor/storedoc/storedoc-cpu-idle.md) %}

{% include [storedoc-ha-replics](../_advisor/storedoc/storedoc-ha-replics.md) %}

{% include [storedoc-ha-geos](../_advisor/storedoc/storedoc-ha-geos.md) %}

{% include [storedoc-disk-free-space](../_advisor/storedoc/storedoc-disk-free-space.md) %} 

{% include [storedoc-oom](../_advisor/storedoc/storedoc-oom.md) %}

{% include [storedoc-deprecated-version](../_advisor/storedoc/storedoc-deprecated-version.md) %}

{% include [storedoc-replication-lag](../_advisor/storedoc/storedoc-replication-lag.md) %}

{% include [storedoc-disk-autoscaling-limit](../_advisor/storedoc/storedoc-disk-autoscaling-limit.md) %}
