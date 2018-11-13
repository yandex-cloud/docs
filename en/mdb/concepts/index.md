# Relationship between service resources

The main entity used in Yandex [!KEYREF full-service-name] is a _database cluster_. A cluster can be created for any supported database management system.

Each cluster consists of one or more _database hosts_, i.e., virtual machines with a database deployed. Cluster hosts can reside in different availability zones and even different availability regions. [Learn more about the Cloud geography](../../overview/concepts/geo-scope.md).

- A cluster consisting of multiple hosts has automatic failover, because the hosts can take over each other's functions as the cluster's primary replica.
- A single-host cluster is cheaper, but obviously less reliable.

When creating a cluster, you should specify a _DB class_, i.e.,  a virtual machine template based on which the cluster hosts will be deployed. For a list of available database classes and their characteristics, see [[!TITLE]](instance-types.md).

A database cluster created in the folder is available over the network to all VMs connected to the same cloud network. [Learn more about networking](../../vpc/).

