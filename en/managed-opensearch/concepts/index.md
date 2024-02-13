# Resource relationships in {{ mos-name }}

{{ mos-full-name }} helps you deploy and maintain clusters of {{ OS }} servers in the {{ yandex-cloud }} infrastructure.

{{ OS }} is a set of search and analytical resources for real-time application monitoring, log analysis, and search across websites. {{ OS }} clusters consist of one or more host groups with various resources that handle a variety of tasks.

When [creating a cluster](../operations/cluster-create.md), specify the following:

- [_Host classes_](instance-types.md): VM templates for deploying the cluster hosts.

- [_Host groups_](host-groups.md): Sets of multiple linked hosts with specific configuration and [roles](host-roles.md):

   - [_DATA_](host-roles.md#data)
   - [_MANAGER_](host-roles.md#manager)
   - [_DASHBOARDS_](host-roles.md#dashboards)

- _Environment_ where the cluster will be deployed:

   - `PRODUCTION`: For stable versions of your apps.
   - `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.

- `admin` _user password_.

   {% include [mos-superuser](../../_includes/mdb/mos/superuser.md)%}

- {{ OS }} _version_.


An {{ OS }} cluster created in a folder can be accessed by all VMs connected to the same [cloud network](../../vpc/concepts/network.md) as the cluster.


A cluster with a single-host group does not guarantee fault tolerance. A cluster with multiple hosts automatically provides fault tolerance for the `MANAGER` role. To ensure data safety in such a cluster, you need to configure index [sharding and replication](scalability-and-resilience.md).

Cluster hosts may reside in different availability zones and subnets. For more information about {{ yandex-cloud }} availability zones, see [{#T}](../../overview/concepts/geo-scope.md).

{% include [monitoring-access](../../_includes/mdb/monitoring-access.md) %}
