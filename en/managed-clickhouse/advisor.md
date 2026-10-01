---
title: Recommendations for improving {{ mch-name }} cluster reliability, cost optimization, and performance
description: In this section, you will learn how to work with the results of {{ mch-name }} cluster checks and diagnostics.
---

# Inspections and recommendations in {{ mch-name }} 

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

Managing recommendations in {{ mch-name }} requires the [{{ roles.mch.editor }} role or higher](../managed-clickhouse/security.md).

## Available inspections in {{ mch-name }} {#mch-recommendations}

| **Category** | **Check** | **Risk** | **Severity** |
|---------------------|----------------------------------------------------|-----------------------------------------------------------------------------------------------------|-----------------|
| Performance  | CPU usage                                       | [High CPU usage on the host](#clickhouse_cpu_idle)                                               | High         |
| High availability | Allocating disk space | [Insufficient disk space](#clickhouse_disk_free_space) | High       |
| High availability | Hosting the coordination service on separate hosts | [Risk of unavailability due to hosting the coordination service on hosts](#clickhouse_ha_embedded_keeper) | High         |
| High availability | High shard availability | [Risk of data loss and cluster unavailability if an availability zone fails](#clickhouse_ha_shard) | High         |
| High availability | Coordination service quorum in case of a zone failure | [Risk of losing the coordination service quorum in the event of a zone failure](#clickhouse_ha_keeper) | High          |


{% include [clickhouse-cpu-idle](../_advisor/managed-clickhouse/clickhouse-cpu-idle.md) %}

{% include [disk-free-space](../_advisor/managed-clickhouse/clickhouse-disk-free-space.md) %}

{% include [disk-free-space](../_advisor/managed-clickhouse/clickhouse-ha-embedded-keeper.md) %} 

{% include [disk-free-space](../_advisor/managed-clickhouse/clickhouse-ha-shards.md) %}

{% include [disk-free-space](../_advisor/managed-clickhouse/clickhouse-ha-keeper.md) %}
