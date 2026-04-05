# Resource relationships in {{ mos-name }}

[{{ OS }}](https://opensearch.org/) is a distributed system for data search and analysis. It uses the document data model, in which a document is a logical counterpart of a row in relational databases. Each document stores key-value pairs, e.g., in [JSON](https://www.json.org/json-en.html) format.

Document example:

>{
>  "name": "John Doe",
>  "gpa": 3.89,
>  "grad_year": 2022
>}

Each document added to {{ OS }} goes into an [_index_](indexing.md). After indexing, document data will be available for [search and analysis](searching.md).

{{ OS }} features [_{{ OS }} Dashboards_](https://opensearch.org/docs/latest/dashboards/), a data visualization UI.

The main entity {{ mos-name }} operates is an cluster.

Each cluster consists of one or more [_hosts_](host-roles.md), which are virtual machines with deployed {{ OS }}. Cluster hosts may reside in different [availability zones](../../overview/concepts/geo-scope.md). The minimum number of hosts in a cluster depends on the selected cluster configuration and [high availability](high-availability.md) requirements.

When [creating a cluster](../operations/cluster-create.md), specify:

- [_Host classes_](instance-types.md): VM templates for deploying the cluster hosts.

- _Host groups_: Groups of multiple linked hosts with specific configuration and [roles](host-roles.md):

    - _DATA_: Enable index storage and request processing.
    - _MANAGER_: Ensure fault tolerance of all {{ OS }} components.
    - _DASHBOARDS_: Provide access to {{ OS }} Dashboards.

- _Environment_ where the cluster will be deployed:

    - `PRODUCTION`: For stable versions of your applications.
    - `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by an SLA, but it is the first to get new features, improvements, and bug fixes. In the prestable environment, you can test new versions for compatibility with your application.


An {{ OS }} cluster created in a folder can be accessed by all VMs connected to the same [cloud network](../../vpc/concepts/network.md) as the cluster.


{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}

{% include [responsibilities-link](../../_includes/mdb/responsibilities-link.md) %}

## High availability of a cluster {#high-availability}

{% include [high-availability.md](../../_includes/mdb/mos/high-availability.md) %}