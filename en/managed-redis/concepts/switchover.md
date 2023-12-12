---
title: "Fault tolerance management in {{ mrd-full-name }}"
description: "We use {{ RD }} Sentinel to ensure fault tolerance in a non-sharded cluster. In sharded clusters, we use a quorum of master hosts along with Gossip-based fault detection."
---

# Managing fault tolerance

To ensure {{ RD }} fault tolerance:

* In non-sharded clusters, fault tolerance is provided by {{ RD }} Sentinel. Sentinel services monitor the state of master and replica hosts, notify you on host performance issues, and manage the selection of a new master and the reconfiguration of replicas.

   Sentinel is only applied for clusters with {{ RD }} version 6.2.

* In sharded clusters, a quorum of master hosts is used along with [Gossip](https://web.stanford.edu/~boyd/papers/gossip_infocom.html)-based fault detection.

These methods alone do not ensure full fault tolerance:

* If the network connectivity is lost, two hosts may be available for writes in an isolated network or a single shard.
* To select a new master, at least three hosts in different availability zones are required.
* When selecting a master, a replica's priority is more important than whether it is most up-to-date with the master. Therefore, you may lose data even when using the [`WAIT` command](https://redis.io/commands/wait/).

To increase fault tolerance, `rdsync`, a host status management agent by Yandex, was integrated into the {{ mrd-name }} architecture for {{ RD }} 7.0. Host status is stored in the distributed configuration management system. If the connection to the DCS (distributed configuration store, e.g., {{ ZK }}, etcd, or Consul) is lost, the agent switches the host to [protected mode]({{ rd.docs }}/manual/security/#protected-mode) and terminates client connections. When selecting a new master, if the replica host with the highest priority requires full data resync, the agent stops the replication process and selects a host that is most up-to-date with the master.

Thanks to the `rdsync` agent running in a {{ RD }} 7.0 cluster:

* Configurations that consist of an even number of hosts (for non-sharded clusters) or one or two shards (for sharded clusters) are fault-tolerant.

* Handling [client requests]({{ rd.docs }}/reference/sentinel-clients/) for the name of a host available for writes is consistent with the `rdsync` agent and provides up-to-date information to clients, since the statuses of all hosts are known.

* You do not lose data when using the `WAIT` command with `N/2` available replicas, where `N` is the number of cluster hosts.
