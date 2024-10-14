# Replication and fault tolerance {{ MG }}

{{ mmg-name }} supports replication by default: if a cluster has multiple active hosts, they automatically select a primary replica to process write queries.

When [changing the primary replica](../operations/stepdown.md) manually, {{ MG }} will automatically select a new primary replica from the available hosts.

For more information about how replication works in {{ MG }}, read the [relevant documentation](https://docs.mongodb.com/manual/replication/).

## Fault tolerance {#Fault-tolerance}

For cluster hosts to be able to automatically select the primary replica when needed, the absolute majority of hosts need to be healthy. This makes clusters with an odd number of hosts more cost-efficient to deploy. For example, a cluster with three hosts can lose one host and keep working. At the same time, a cluster with four hosts can also lose only one host: if a second host is lost, the remaining hosts will not be enough to select a new primary replica.

A cluster with two hosts does not ensure full fault tolerance for the same reason: a single remaining host cannot select itself as primary replica. In this situation, the cluster can only handle read queries.
