# Resource groups

By using resource groups, the users with the `mdb_admin` role can set resource quotas for query processing:

* CPU computing resources.
* Amount of RAM.
* Number of transactions run in parallel.

Every resource group can include multiple [roles](cluster-users.md) that share the group's quotas.

{% if audience == "draft" %}

{{ GP }} supports two types of resource groups:

* _Resource groups for roles_ set the quotas allocated for [users](cluster-users.md) with a specific role.

   Every resource group can include multiple roles that share the group's quotas.

   For more information about managing users and roles, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/GUID-admin_guide-roles_privs.html).

* _Resource groups for components_ determine the amount of resources allocated to an external component.

   A resource group can only include one external component, and the quotas will be shared by all its instances.

{% endif %}

{{ GP }} gets a transaction query from the user and matches its required resources with the unused quotas in the resource group. If the quotas are enough, it immediately runs the query. If the quotas aren't enough, the query waits until other queries complete and release resources. The query queue follows the FIFO principle: <q>first in — first out</q>.

## Resource group parameters {#parameters}

Every resource group has the following parameters:

| Name | Description |
| -----               | ----- |
| `MEMORY_AUDITOR` | The memory auditor used by the resource group.{% if audience == "draft" %} It defines the group's type. Use `cgroup` when creating a resource group for a component. For default roles in a resource group, the `vmtracker` value is used.{% endif %} {{ mgp-name }} uses `vmtracker` by default. |
| `CONCURRENCY` | The maximum number of transactions that a resource group can process in parallel. Both active and pending transactions are counted. Default value: `20`.{% if audience == "draft" %} When creating a resource group for a component, specify `0` explicitly.{% endif %} |
| `CPU_RATE_LIMIT` | The percentage of CPU resources allocated to the segment. The minimum value is `1` and the maximum value is `100`. The value is automatically reset to `-1` if the `CPUSET` parameter is specified. |
| `CPUSET` | The numbers of the CPU cores allocated. The numbers or their intervals are enclosed in single quotes: `'1,3-4'`. Use the numbers that exist in the system and aren't allocated to other resource groups. The value is automatically reset to `-1` if the `CPU_RATE_LIMIT` parameter is specified. |
| `MEMORY_LIMIT` | The percentage of RAM reserved for the segment. The minimum value is `0` (default) and the maximum value is `100`. When the value is `0`, the resource group can only use [non-allocated RAM](#ram) for query execution. The total `MEMORY_LIMIT` for all the resource groups shouldn't exceed `100`. |
| `MEMORY_SHARED_QUOTA` | The allocated memory percentage (`MEMORY_LIMIT`) that can be utilized by all the transactions in the resource group when needed. The minimum value is `1` and the maximum value is `100`. Defaults to `80`. For more information, see [{#T}](#ram). |
| `MEMORY_SPILL_RATIO` | The RAM usage threshold per transaction. When this threshold is reached, temporary files are created for the transaction on the hard disk. The minimum value is `0` (default) and the maximum value is `100`. If `MEMORY_LIMIT` is `0`, the value of this parameter must also be `0`. |

## Default resource groups {#default}

When a {{ mgp-name }} cluster is created, it includes three resource groups:

* `admin_group` is a default group assigned to the `monitor` and `gpadmin` default roles.
* `mdb_admin_group` is an administrative group. By default, it's assigned to the administrative user whose username and password were specified when creating the cluster.

   If the administrator and other users belong to the same resource group, and all its resources are used up, the administrator won't be able to connect to the database and interrupt resource-intensive processes manually. That's why we recommend assigning this resource group to the users with the `mdb_admin` role only.

* `default_group` is a shared group. It is assigned to a newly created role unless it's assigned another explicit resource group.

Default values of the resource group parameters:

| Parameter | `admin_group` | `mdb_admin_group` | `default_group` |
| --------------------- | ----------- | ----------- | ----------- |
| `MEMORY_AUDITOR` | `vmtracker` | `vmtracker` | `vmtracker` |
| `CONCURRENCY` | `10` | `20` | `20` |
| `CPU_RATE_LIMIT` | `10` | `1` | `30` |
| `CPUSET` | `-1` | `-1` | `-1` |
| `MEMORY_LIMIT` | `10` | `0` | `0` |
| `MEMORY_SHARED_QUOTA` | `80` | `80` | `80` |
| `MEMORY_SPILL_RATIO` | `0` | `0` | `0` |

You can't change the values of the `admin_group` resource group.

For more information about role management, see [{#T}](./cluster-users.md) and the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/GUID-admin_guide-roles_privs.html).

## Memory allocation {#ram}

* To each resource group, you can allocate the segment's RAM percentage (the `MEMORY_LIMIT` parameter). This percentage is split into the _shared quota_ and _guaranteed quota_:

   * The shared quota is specified by the `MEMORY_SHARED_QUOTA` parameter and can be used by all the transactions in the resource group. {{ GP }} allocates the shared quota to transactions based on the <q>first in, first out</q> paradigm.
   * The guaranteed quota is allocated to each transaction and calculated by the formula:

      `(MEMORY_LIMIT − MEMORY_SHARED_QUOTA)/CONCURRENCY`.

* If the total `MEMORY_LIMIT` of all the resource groups is less than `100`, then {{ GP }} allocates unallocated RAM to any transactions from any resource groups based on the <q>first in, first out</q> paradigm.

   The transaction uses non-allocated memory provided that:

   * The guaranteed memory share for the transaction is used up.
   * The shared quota for the resource group is used up.

   {% if audience == "draft" %}
   The non-allocated memory can only be used by the resource groups that were created for roles.
   {% endif %}

   For your cluster to run in a stable and efficient manner, leave 10%–20% of memory unallocated.

## CPU resource allocation {#cpu}

There are two ways to allocate CPU resources for a resource group:

* (Recommended) Specify the share of resources of the CPU segment to be available for the resource group (the `CPU_RATE_LIMIT` parameter).

   {{ mgp-name }} has the controls that re-allocate CPU resources from idle resource groups to highly loaded resource groups. When a resource group is not idle anymore, it regains its re-allocated CPU resources.

* Specify the CPU core numbers to be used by the resource group (the `CPUSET` parameter). These cores won't be available to other resource groups. When the resource group isn't processing transactions, the cores allocated to it become idle. We recommend you to minimize the number of such resource groups.

   For stable cluster operation, we don't recommend allocating the core `0`.

You can use these two methods in parallel, for different resource groups, or switch them over as you run your cluster.

To learn more about resource groups, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/GUID-admin_guide-workload_mgmt_resgroups.html).

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
