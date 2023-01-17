# Managing fault tolerance

{{ RD }} uses Redis Sentinel to provide fault tolerance in non-sharded clusters: Sentinel services monitor the state of master and replica hosts, notify of host performance issues, and manage the selection of a new master and the reconfiguration of replicas. In sharded {{ RD }} clusters, fault tolerance is provided by using a quorum of master hosts and detecting failures based on the [Gossip algorithm](https://web.stanford.edu/~boyd/papers/gossip_infocom.html).

These methods alone don't ensure full fault tolerance:

* If network connectivity is lost, two hosts may be available for writes in an isolated network or a single shard.
* To select a new master, at least three hosts in different availability zones are required.
* When selecting a master, a replica's priority is more important than its lag behind the master. Therefore, data loss is possible even if the [WAIT command](https://redis.io/commands/wait/) is used.

To increase fault tolerance, `rdsync`, a host status management agent from Yandex, was integrated into the {{ mrd-name }} architecture . The status of a host is stored in the distributed configuration management system. If the cache connection is lost, the agent switches the host to [protected mode]({{ rd.docs }}/manual/security/#protected-mode) and terminates client connections. When selecting a new master, the agent stops the replication process and chooses a host with the minimum lag behind the master if the highest-priority replica host requires full resynchronization of data.

Thanks to the `rdsync` agent running in a {{ mrd-name }} cluster:

* Configurations that consist of an even number of hosts (for non-sharded clusters) or one or two shards (for sharded clusters) are fault-tolerant.

* Handling of [client requests]({{ rd.docs }}/reference/sentinel-clients/) for the name of a host available for writes is consistent with the `rdsync` agent and up-to-date information is provided to clients, because the status of all hosts is known.

* There is no data loss when using the `WAIT` command with `N/2` available replicas, where `N` is the number of cluster hosts.
