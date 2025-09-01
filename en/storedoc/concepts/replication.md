# Replication and fault tolerance in {{ SD }}

{{ mmg-name }} supports replication by default: if a cluster has multiple active hosts, they automatically select a primary replica to process write queries.

When [changing the primary replica](../operations/stepdown.md) manually, {{ SD }} will automatically select a new primary replica from the available hosts.

For more information about how replication works in {{ SD }}, read the [relevant documentation](https://docs.mongodb.com/manual/replication/).

## Fault tolerance {#Fault-tolerance}

For cluster hosts to be able to automatically select the primary replica when needed, the absolute majority of hosts need to be healthy. This makes clusters with an odd number of hosts more cost-efficient to deploy. For example, a cluster with three hosts can lose one host and keep working. At the same time, a cluster with four hosts can also lose only one host: if a second host is lost, the remaining hosts will not be enough to select a new primary replica.

A cluster with two hosts does not ensure full fault tolerance for the same reason: a single remaining host cannot select itself as primary replica. In this situation, the cluster can only handle read queries.

### Assigning a different host as a master if the primary master fails {#master-failover}

If the master host fails, {{ SD }} will automatically select a new master from among the available hosts.

You can influence master selection in a {{ SD }} cluster by [configuring priorities](../operations/hosts.md#update) for cluster hosts. The host with the highest priority will become a new master.

You can set the host priority using the YC CLI, API, or {{ TF }}:

* When [creating a cluster](../operations/cluster-create.md) or [a host in a cluster](../operations/hosts.md#add).
* When [changing the host settings](../operations/hosts.md#update).

Minimum value (lowest priority): `0`. A host with such priority value can become a master only if there are no other hosts suitable for the role. Default priority value: `1`. You can specify a value higher than `100`.

## Use cases {#examples}

* [{#T}](../tutorials/storedoc-versions)
