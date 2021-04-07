# Relationship between service resources

With {{ mes-full-name }}, you can deploy and maintain {{ ES }} server clusters in the {{ yandex-cloud }} infrastructure.

{{ ES }} is a specialized distributed document storage system, which allows users to search and analyze information in documents.

When a document is added to {{ ES }}, it gets added to the [index](indexing.md). Data from the indexed document becomes available for [search and analysis](searching.md).

Each {{ mes-name }} cluster consists of one or more {{ ES }} hosts with different roles:

- Dedicated hosts with the _Data node_ role.

  Hosts with this role store one or more indexes containing indexed documents and handle search and analysis queries. To ensure index scalability and fault tolerance, configure [sharding and replication](scalability-and-resilience.md) for this index.

  For better handling indexes and search queries, [Kibana](https://www.elastic.co/kibana/features) is installed and configured on these hosts. It can be accessed from the web interface. To learn more, see [{#T}](../operations/cluster-connect.md).

  There should be at least one host with the _Data node_ role in the cluster.

- Dedicated hosts with the _Master node_ role.

  Hosts with this role monitor the state of the cluster and manage its configuration, ensuring the performance of all {{ ES }} components.

  When using dedicated hosts with the _Master node_ role, 3 such hosts are added to the cluster and you can't change their number.

  You don't have to use these hosts, in which case the corresponding role will be supported by hosts with the _Data node_ role. However, this approach isn't recommended because the presence of dedicated hosts with the _Master node_ role reduces the load on hosts with the _Data node_ role and improves the overall reliability of the cluster.

A single-host cluster doesn't guarantee fault tolerance. A cluster of multiple hosts automatically provides fault tolerance for the _Master node_ role. To ensure data safety in such a cluster, you need to configure index [sharding and replication](scalability-and-resilience.md).

Cluster hosts may reside in different availability zones. [Learn more about the geo scope of {{ yandex-cloud }}](../../overview/concepts/geo-scope.md).

When creating a cluster, specify:

- _Host class_: A VM template for deploying the cluster hosts. For a list of available host classes and their characteristics, see [{#T}](instance-types.md).
- _Host roles_: _Data node_ or _Master node_.
- _Environment_: The environment where the cluster will be deployed:
  - `PRODUCTION`: For stable versions of your apps.
  - `PRESTABLE`: For testing, including the {{ mes-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

An {{ ES }} cluster created in a folder can be accessed by all VMs connected to the same cloud network. [Learn more about networking](../../vpc/).

{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}

