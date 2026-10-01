---
title: Recommendations for improving {{ mpg-name }} cluster reliability, cost optimization, and performance
description: In this section, you will learn how to work with the results of {{ mpg-name }} cluster checks and diagnostics.
---

# Inspections and recommendations in {{ mpg-name }} 

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

Managing recommendations in {{ mpg-name }} requires the [{{ roles.mpg.editor }} role or higher](../managed-postgresql/security/index.md).

## Available {{ mpg-name }} inspections {#mpg-recommendations}

| **Category** | **Check** | **Risk** | **Severity** |
|---------------------|-------------------------------------------------------|---------------------------------------------------------------------------------------------------------|-----------------|
| Performance | CPU usage | [Risk of reduced performance](#postgresql_cpu_idle) | High         |
| High availability | Availability of synchronous replicas in a cluster                  | [Risk of data loss and cluster unavailability in the event of a zone (replica) failure](#postgresql_ha_replics) | High         |
| High availability | Memory allocation | [Lack of RAM](#postgresql_oom) | High         |
| High availability | Allocating disk space | [Risk of cluster unavailability](#postgresql_disk_free_space) | High         |
| High availability | High cluster availability during zone failure | [Risk of data loss and cluster unavailability in the event of a zone failure](#postgresql_ha_zone) | High         |
| High availability | High cluster availability in the event of a zone failure (quorum) | [Risk of data loss and cluster unavailability in the event of a zone failure (quorum)](#postgresql_ha_quorum) | High         |
| High availability | Disk autoscaling feature | [Disk space autoscaling is limited](#postgresql_disk_autoscaling_limit) | Moderate       |

{% include [postgresql-cpu-idle](../_advisor/managed-postgresql/postgresql-cpu-idle.md) %}

{% include [postgresql-ha-replics](../_advisor/managed-postgresql/postgresql-ha-replics.md) %}

{% include [postgresql-oom](../_advisor/managed-postgresql/postgresql-oom.md) %}

{% include [postgresql-disk-free-space](../_advisor/managed-postgresql/postgresql-disk-free-space.md) %}

{% include [postgresql-ha-zone](../_advisor/managed-postgresql/postgresql-ha-zone.md) %}

{% include [postgresql-ha-quorum](../_advisor/managed-postgresql/postgresql-ha-quorum.md) %}

{% include [postgresql-disk-autoscaling-limit](../_advisor/managed-postgresql/postgresql-disk-autoscaling-limit.md) %}
