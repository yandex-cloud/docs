---
title: Recommendations for improving {{ mmy-name }} cluster reliability, cost optimization, and performance
description: In this section, you will learn how to work with the results of {{ mmy-name }} cluster checks and diagnostics.
---

# Inspections and recommendations in {{ mmy-name }} 

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

Managing recommendations in {{ mmy-name }} requires the [{{ roles.mmy.editor }} role or higher](../managed-mysql/security/index.md).

## Available inspections in {{ mmy-name }} {#mmy-recommendations}

| **Category** | **Check** | **Risk** | **Severity** |
|---------------------|-------------------------------------------------------|----------------------------------------------------------------------------------------------------|-----------------|
| Performance  | CPU usage                                          | [Risk of reduced performance](#mysql_cpu_idle)                                                 | High         |
| High availability | Availability of synchronous replicas in a cluster | [Risk of data loss and cluster unavailability in the event of a zone (replica) failure](#mysql_ha_replics) | High         |
| High availability | Memory allocation                                      | [Lack of RAM](#mysql_oom)                                                          | High         |
| High availability | Allocating disk space | [Risk of cluster unavailability](#mysql_disk_free_space) | High         |
| High availability | High cluster availability during zone failure | [Risk of data loss and cluster unavailability in the event of a zone failure](#mysql_ha_zone) | High         |
| High availability | High cluster availability in the event of a zone failure (quorum) | [Risk of data loss and cluster unavailability in the event of a zone failure (quorum)](#mysql_ha_quorum) | High         |
| High availability | Disk autoscaling feature | [Disk space autoscaling is limited](#mysql_disk_autoscaling_limit) | Moderate      |

{% include [mysql-cpu-idle](../_advisor/managed-mysql/mysql-cpu-idle.md) %}

{% include [mysql-ha-replics](../_advisor/managed-mysql/mysql-ha-replics.md) %} 

{% include [mysql-oom](../_advisor/managed-mysql/mysql-oom.md) %}

{% include [mysql-disk-free-space](../_advisor/managed-mysql/mysql-disk-free-space.md) %} 

{% include [mysql-ha-zone](../_advisor/managed-mysql/mysql-ha-zone.md) %}

{% include [mysql-ha-quorum](../_advisor/managed-mysql/mysql-ha-quorum.md) %}

{% include [mysql-disk-autoscaling-limit](../_advisor/managed-mysql/mysql-disk-autoscaling-limit.md) %} 







