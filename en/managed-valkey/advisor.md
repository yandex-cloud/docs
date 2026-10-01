---
title: Recommendations for improving {{ mrd-name }} cluster reliability, cost optimization, and performance
description: In this section, you will learn how to work with the results of {{ mrd-name }} cluster checks and diagnostics.
---

# Inspections and recommendations in {{ mrd-name }} 

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

Managing recommendations in {{ mrd-name }} requires the [{{ roles.mrd.editor }} role or higher](../managed-valkey/security/index.md).

## Available inspections in {{ mrd-name }} {#mrd-recommendations}

| **Category** | **Check** | **Risk** | **Severity** |
|---------------------|----------------------------------------------|-------------------------------------------------------------------------------------------------------|-----------------|
| Performance | CPU usage (main thread) | [Risk of reduced performance](#valkey_main_thread) | Moderate |
| Performance | Cache hit rate | [Low cache hit rate](#valkey_cachehit) | Moderate |
| High availability | Availability of replicas in a shard | [Risk of data loss and cluster unavailability in the event of a zone failure (lack of replicas)](#valkey_ha_replics) | Low |
| High availability | High cluster availability during zone failure | [Risk of data loss and cluster unavailability in the event of a zone failure](#valkey_ha_geos) | High |
| High availability | Memory allocation | [Lack of RAM](#valkey_oom) | Moderate |
| High availability | Database version updates | [Database version is out of date](#valkey_deprecated_version) | High |
| High availability | {{ VLK }} memory usage policy | [The memory usage limit has been reached on the host](#valkey_maxmemory_policy) | Moderate |
| High availability | Disk autoscaling feature | [Disk space autoscaling is limited](#valkey_disk_autoscaling_limit) | Moderate |

{% include [valkey-main_thread](../_advisor/managed-valkey/valkey-main-thread.md) %}

{% include [valkey-valkey_cachehit](../_advisor/managed-valkey/valkey-cachehit.md) %}

{% include [valkey-ha-replics](../_advisor/managed-valkey/valkey-ha-replics.md) %}

{% include [valkey-ha-geos](../_advisor/managed-valkey/valkey-ha-geos.md) %}

{% include [valkey-oom](../_advisor/managed-valkey/valkey-oom.md) %}

{% include [valkey-deprecated-verion](../_advisor/managed-valkey/valkey-deprecated-version.md) %}

{% include [valkey-maxmemory-policy](../_advisor/managed-valkey/valkey-maxmemory-policy.md) %}

{% include [valkey-disk-autoscaling-limit](../_advisor/managed-valkey/valkey-disk-autoscaling-limit.md) %}






