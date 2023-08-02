# Managing fault tolerance

To ensure the fault tolerance of {{ RD }}:

* In non-sharded clusters, fault tolerance is provided by {{ RD }} Sentinel: Sentinel services monitor the state of master and replica hosts, notify of host performance issues, and manage the selection of a new master and the reconfiguration of replicas.

   Sentinel is only applied for clusters with {{ RD }} version 6.2.

* In sharded clusters, a quorum of master hosts is used along with [Gossip](https://web.stanford.edu/~boyd/papers/gossip_infocom.html)-based fault detection.

These methods alone do not ensure full fault tolerance:

* If network connectivity is lost, two hosts may be available for writes in an isolated network or a single shard.
* To select a new master, at least three hosts in different availability zones are required.
* When selecting a master, a replica's priority takes precedence over its lag behind the master. Therefore, data loss is possible even when using the [WAIT command](https://redis.io/commands/wait/).

To increase fault tolerance, `rdsync`, a host status management agent from Yandex, was integrated into the {{ mrd-name }} architecture for {{ RD }} 7.0. Host status is stored in the distributed configuration management system. If the connection to the DCS (Distributed Configuration Store, e.g., {{ ZK }}, etcd, Consul) is lost, the agent switches the host to [protected mode]({{ rd.docs }}/manual/security/#protected-mode) and terminates client connections. When selecting a new master, if the replica host with the highest priority requires full data resynchronization, the agent stops the replication process and selects a host with the least lag behind the master.

Thanks to the `rdsync` agent running in a {{ RD }} 7.0 cluster:

* Configurations that consist of an even number of hosts (for non-sharded clusters) or one or two shards (for sharded clusters) are fault-tolerant.

* Handling of [client requests]({{ rd.docs }}/reference/sentinel-clients/) for the name of a host available for writes is consistent with the `rdsync` agent and up-to-date information is provided to clients, because the status of all hosts is known.

* There is no data loss when using the `WAIT` command with `N/2` available replicas, where `N` is the number of cluster hosts.
