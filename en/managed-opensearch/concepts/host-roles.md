# Host roles in {{ mos-name }}

Each [host group](host-groups.md) contains hosts with a certain role: `DATA`, `MANAGER`, or `DASHBOARDS`.

## Hosts with the DATA role {#data}

Hosts with this role store one or more indexes and handle search, write, and analysis queries. To ensure index scalability and fault tolerance, configure [sharding and replication](scalability-and-resilience.md) for this index.

{% note info %}

There should be at least one host with the `DATA` role in the cluster. A single-host cluster does not guarantee fault tolerance.

{% endnote %}

To ensure fault tolerance, you cannot create a cluster that only has two hosts with the `DATA` role. To make your cluster fault-tolerant, add an `{{ OS }}` host group with the `MANAGER` role.

## Hosts with the MANAGER role {#manager}

Hosts with this role monitor the state of the cluster and manage its configuration, ensuring the performance of all {{ OS }} components.

When using hosts with the `MANAGER` role, the cluster will be added a host group containing three hosts like this.

If no hosts with the `MANAGER` role are used, this role will be supported by hosts with the `DATA` role. However, the presence of dedicated hosts with the `MANAGER` role increases the overall cluster reliability and reduces the load on hosts with the `DATA` role.

## Hosts with the DASHBOARDS role {#dashboards}

Hosts with this role are used as a data visualization tool, for example, for real-time application monitoring, threat detection, incident management, or personalized search.
