# Relationship between service resources

The main entity used in {{ mch-name }} is a _database cluster_.

Each cluster consists of one or more _database hosts_, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones and even different availability regions. [Learn more about Yandex.Cloud geography](../../overview/concepts/geo-scope.md).

* A cluster consisting of multiple hosts has automatic failover, because the hosts can take over each other's functions as the cluster's primary replica.

* A single-host cluster doesn't guarantee fault tolerance. To add replicas, first [add the {{ ZK }} hosts](../operations/zk-hosts.md) that manage replication and query distribution across the cluster hosts.

When creating a cluster, specify:

* _Host class_: A VM template for deploying the cluster hosts. For a list of available host classes and their characteristics, see [{#T}](instance-types.md).

* _Environment_: The environment where the cluster will be deployed:
   * `PRODUCTION`: For stable versions of your apps.
   * `PRESTABLE`: For testing, including the {{ mch-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

You should also specify the host class when creating a [shard](sharding.md).

{% if audience != "internal" %}

A database cluster created in a folder can be accessed by all VMs connected to the same cloud network. [Learn more about networking](../../vpc/).

{% endif %}

{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}

