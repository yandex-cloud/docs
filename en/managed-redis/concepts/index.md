# Relationship between service resources

{{ RD }} is a high-performance key-value store that runs in RAM. {{ mrd-name }} allows you to easily create {{ RD }} host clusters with a high level of fault tolerance.

The main entity used in {{ mrd-name }} is a _database cluster_.

Each cluster consists of one or more _database hosts_, which are virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different availability zones and even different availability regions. [Learn more about the Cloud geography](../../overview/concepts/geo-scope.md).

* A cluster consisting of 3 and more hosts has automatic failover, because the hosts can take over each other's functions as the cluster's primary replica.

* A cluster of one or two hosts is cheaper, but it doesn't guarantee fault tolerance.

When creating a cluster, you need to specify the _host class_, which is a VM template for deploying the cluster hosts. For a list of available host classes and their characteristics, see [#T](instance-types.md).

{% note info %}

The amount of memory allocated to a host is also determined by the `maxmemory` configuration parameter for Redis hosts: the max amount of data is 75% of the available memory. For example, for a host class with 8 GB RAM, the `maxmemory` value will be 6 GB.

{% endnote %}

A DB cluster connected to a cloud network can be accessed by all VMs connected to the same cloud network. [Learn more about networking](../../vpc/).

