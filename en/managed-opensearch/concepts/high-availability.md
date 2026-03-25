---
title: High availability of a {{ mos-full-name }} cluster
description: High availability is the ability of a system to continue to operate when one or more of its components fail. High availability of a {{ mos-name }} cluster depends on the host configuration and other cluster parameters.
---

# High availability of a {{ mos-name }} cluster


[High availability](../../architecture/fault-tolerance.md#mdb-ha) of a {{ mos-name }} cluster depends on the number of `DATA` and `MANAGER` [hosts](#host-configuration).


## Cluster host configuration {#host-configuration}

A {{ mos-name }} cluster consists of one or more host groups where each host assumes a [specific role](host-roles.md).

Each `{{ OS }}` host group can include hosts with the [DATA](host-roles.md#data) or [MANAGER](host-roles.md#manager) roles. If a cluster has a single `{{ OS }}` group, its hosts will have both roles.

For a cluster to be highly available and covered by a [service level agreement (SLA)](https://yandex.com/legal/cloud_sla_mdb/), it must include:


1. Two or more hosts with the `DATA` role.
1. Three or more hosts with the `MANAGER` role.


{% note tip %}

To reduce load on hosts with the `DATA` role, we recommend you put hosts with the `MANAGER` role into a separate group.

{% endnote %}


## Storage settings {#storage-settings}

When the storage is 95% full, cluster hosts automatically enter read-only mode. In this mode, data write requests fail. To prevent situations where the disk runs out of free space and the cluster becomes unavailable for writes:

* [Set up alerts in {{ monitoring-full-name }}](../operations/monitoring.md#monitoring-integration) to monitor storage utilization.
* [Configure automatic storage expansion](storage.md#auto-rescale).

[Learn more about managing disk space in {{ mos-name }}](storage.md#manage-storage-space).

## Maintenance settings {#maintenance-settings}

In multi-host clusters, hosts undergo [maintenance](maintenance.md) one by one. Any host that requires a restart during maintenance will be unavailable until maintenance is complete.

[Learn more about maintenance in {{ mos-name }}](maintenance.md).

## Other parameters and limitations {#other-settings}

Cluster availability may also be affected by:

* [Backup settings](backup.md).
* [Storage disk type](storage.md).
* [Host class](instance-types.md).
* [Quotas and limits](limits.md).


* [Security group settings](../operations/connect/index.md#security-groups).
