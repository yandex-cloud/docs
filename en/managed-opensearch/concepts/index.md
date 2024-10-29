# Resource relationships in {{ mos-name }}

[{{ OS }}](https://opensearch.org/) is a specialized distributed system for storing, searching, visualizing, and analyzing data. When you add a document to {{ OS }}, it is placed into an [_index_](indexing.md). Data from an indexed document is available for [search and analysis](searching.md).

{{ OS }} features [_{{ OS }} Dashboards_](https://opensearch.org/docs/latest/dashboards/), a data visualization UI.

The main entity used in {{ mos-name }} is a database cluster.

Each cluster consists of one or more [_hosts_](host-roles.md), i.e., virtual machines with DBMS servers deployed on them. Cluster hosts may reside in different [availability zones](../../overview/concepts/geo-scope.md). The minimum number of hosts in a cluster depends on the selected [disk type](storage.md#storage-type-selection).

When [creating a cluster](../operations/cluster-create.md), specify the following:

- [_Host classes_](instance-types.md): VM templates for deploying the cluster hosts.

- _Host groups_: Groups of multiple linked hosts with specific configuration and [roles](host-roles.md):

   - _DATA_: Enable index storage and request processing.
   - _MANAGER_: Ensure fault tolerance of all {{ OS }} components.
   - _DASHBOARDS_: Provide access to {{ OS }} Dashboards.

   A single-host cluster is not fault tolerant. A cluster with multiple hosts automatically provides fault tolerance for the `MANAGER` role. To ensure data safety in such a cluster, you need to configure index [sharding and replication](scalability-and-resilience.md).

- _Environment_ where the cluster will be deployed:

   - `PRODUCTION`: For stable versions of your apps.
   - `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.


An {{ OS }} cluster created in a folder can be accessed by all VMs connected to the same [cloud network](../../vpc/concepts/network.md) as the cluster.


{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}
