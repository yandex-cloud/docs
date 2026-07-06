---
title: Resource groups in {{ mgp-full-name }}
description: In this tutorial, you will learn what resource groups are, what parameters they have, and how memory is allocated between them.
---

# Resource groups

By using resource groups, users with the `mdb_admin` [role](cluster-users.md#mdb_admin) can set quotas for the following resources allocated for query processing:

* CPU computing resources
* Amount of RAM
* Number of concurrent transactions

A resource group may include several [roles](cluster-users.md) that will share their quotas.


{{ mgp-name }} gets a transaction query from the user and matches its resource requirements with the unused quotas in the resource group. If the quotas are sufficient, the query execution begins immediately. If not, the query waits for other queries to be completed and to free up the resources. Queries are queued based on the _first in, first out_ (FIFO) principle.

Clusters with {{ CB }} and {{ GP }} DBMS’s have different [resource group parameters](#parameters), [default](#default) resource groups, and [RAM allocation](#ram).

Learn how to manage resource groups in [this section](../operations/resource-groups.md).


## Resource group parameters {#parameters}

{% list tabs group=instructions %}

- {{ CB }} {#cb}

  #|
  || **Name** | **Description** ||
  || `CONCURRENCY` | Maximum number of concurrent transactions a resource group can process. Both active and pending transactions are counted. The minimum value is `0` (no transactions processed); the maximum value is taken from the [max_connections](settings-list.md#setting-max-connections) setting, `20` by default. ||
  || `CPU_MAX_PERCENT` | Maximum CPU percentage a resource group can use on a segment. The minimum value is `1`; the maximum value is `100`. The default value is `-1` (not set). If you set `CPU_MAX_PERCENT`, the `CPUSET` parameter is ignored.
  
  For more information, see [Specifics of CPU resource allocation](#cpu). ||
  || `CPU_WEIGHT` | Resource group priority for CPU allocation. The minimum value is `1`; the maximum value is `500`. The default value is `100`. ||
  || `CPUSET` | Numbers of logical CPU cores allocated to a resource group. It is set for the [master and segments](index.md) as separate values or ranges. The default value is `-1` (not set). If you set `CPU_MAX_PERCENT`, the `CPUSET` parameter is ignored.
  
  > For example, to allocate core `1` for the master, and cores `1`, `3`, `4` for segments, specify `CPUSET='1;1,3-4'`.
  
  {% note warning %}

  For stable cluster operation, do not allocate core `0`.

  {% endnote %}
  ||
  || `IO_LIMIT` | Maximum read and write throughput, as well as the maximum number of IOPS for a resource group. Set separately for each table space:
  
  * `wbps`: Maximum write throughput, in MBps.
  * `rbps`: Maximum read throughput, in MBps.
  * `wiops`: Maximum writes per second.
  * `riops`: Maximum reads per second.

  For each `IO_LIMIT` parameter, the valid values range from `2` to `4294967295`. The default value is `-1` (not limited). You may skip some of the parameters. The parameters you skip take their defaults.
  
  > Here is an example: `IO_LIMIT='pg_default:wbps=1000,rbps=1000,wiops=100,riops=100'` ||
  || `MEMORY_QUOTA` | Amount of RAM, in MB, a resource group can use on a segment. The default value is `-1` (not limited); the [statement_mem](settings-list.md#setting-statement-mem) setting will be used.
  
  For more information, see [Specifics of RAM allocation](#ram). ||
  || `MIN_COST` | Minimum cost of query plan sufficient to assign a query to a resource group. The default value is `0`. ||
  |#

- {{ GP }} {#gp}

  #|
  || **Name** | **Description** ||
  || `MEMORY_AUDITOR` | Memory auditor used by a resource group. {{ mgp-name }} uses `vmtracker` as the default value. ||
  || `CONCURRENCY` | Maximum number of concurrent transactions a resource group can process. Both active and pending transactions are counted. The default value is `20` ||
  || `CPU_RATE_LIMIT` | CPU percentage a resource group can use on a segment. The minimum value is `1`; the maximum value is `100`. The value is automatically reset to `-1` if you specify `CPUSET`. ||
  || `CPUSET` | Numbers of allocated CPU cores. The numbers or intervals are enclosed in quotes, e.g., `'1,3-4'`. Use the numbers that exist in the system and are not allocated to other resource groups. The value is automatically reset to `-1` if you specify `CPU_RATE_LIMIT`.
  
  {% note warning %}

  For stable cluster operation, do not allocate core `0`.

  {% endnote %}
  ||
  || `MEMORY_LIMIT` | RAM percentage a resource group can use on a segment. The minimum value is `0` (default); the maximum value is `100`. When the value is `0`, the resource group can only use [non-allocated RAM](#ram) to run queries. The total of `MEMORY_LIMIT` values for all resource groups may not exceed `100`. ||
  || `MEMORY_SHARED_QUOTA` | Percentage of `MEMORY_LIMIT` available to all resource group transactions whenever needed.
  
  For more information, see [Specifics of RAM allocation](#ram). ||
  || `MEMORY_SPILL_RATIO` | RAM usage threshold for transactions as a percentage of `MEMORY_LIMIT`. If exceeded, temporary files are created on the disk to process transactions. The minimum value is `0` (default); the maximum value is `100`. If `MEMORY_LIMIT` equals `0`, this parameter must also equal `0`. ||
  |#

{% endlist %}


## Default resource groups {#default}

{% list tabs group=instructions %}

- {{ CB }} {#cb}

  When you create a cluster with an {{ CB }} DBMS, the following resource groups are created:

  * `admin_group`: Assigned to the roles with the [SUPERUSER attribute](cluster-users.md#attributes).
  * `system_group`: Used by {{ CB }} system processes. You cannot assign this group manually.
  * `mdb_admin_group`: Group for administrators. By default, it is assigned to the administrator whose username and password were specified when creating the cluster.
    
    If you reach the resource limit for this group, the admin will not be able to connect to the cluster and terminate resource-hungry processes. This is why we recommend assigning `mdb_admin_group` only to users with the `mdb_admin` role.

  * `default_group`: Assigned to other roles if no resource group was set when creating them.

  Resource group parameter values:

  | Parameter          | `admin_group` | `system_group` | `mdb_admin_group` | `default_group` |
  | ------------------| ------------- | -------------- | ----------------- | --------------- |
  | `CONCURRENCY`     |     `20`      |      `0`       |       `20`        |      `20`       |
  | `CPU_MAX_PERCENT` |     `-1`      |      `10`      |       `1`         |      `20`       |
  | `CPU_WEIGHT`      |     `100`     |      `100`     |       `100`       |      `100`      |
  | `CPUSET`          |     `-1`      |      `-1`      |       `-1`        |      `-1`       |
  | `IO_LIMIT`        |     `-1`      |      `-1`      |       `-1`        |      `-1`       |
  | `MEMORY_QUOTA`    |     `-1`      |      `-1`      |       `-1`        |      `-1`       |
  | `MIN_COST`        |     `0`       |      `500`     |       `0`         |      `500`      |

  You cannot change parameter values for `admin_group`.

  For more information about managing roles, see [Users and roles](cluster-users.md) and [this {{ CB }} guide]({{ gp.docs.cloudberry }}/security/manage-roles-and-privileges/).

- {{ GP }} {#gp}

  When you create a cluster with a {{ GP }} DBMS DBMS, the following resource groups are created:

  * `admin_group`: Service group assigned to the `monitor` and `gpadmin` service roles.
  * `mdb_admin_group`: Group for administrators. By default, it is assigned to the administrator whose username and password were specified when creating the cluster.

    If the administrator and other users belong to the same resource group, and all its resources are used up, the administrator will not be able to connect to the database and interrupt resource-intensive processes manually. This is why we recommend assigning this resource group only to the users with the `mdb_admin` role.

  * `default_group`: Shared group. It is assigned to a newly created role unless it is assigned another explicit resource group.

  Resource group parameter values:

  | Parameter              | `admin_group` | `mdb_admin_group` | `default_group` |
  | --------------------- | -----------   | ----------- | ----------- |
  | `MEMORY_AUDITOR`      | `vmtracker`   | `vmtracker` | `vmtracker` |
  | `CONCURRENCY`         | `10`          | `20`        | `20`        |
  | `CPU_RATE_LIMIT`      | `10`          | `1`         | `30`        |
  | `CPUSET`              | `-1`          | `-1`        | `-1`        |
  | `MEMORY_LIMIT`        | `10`          | `0`         | `0`         |
  | `MEMORY_SHARED_QUOTA` | `80`          | `80`        | `80`        |
  | `MEMORY_SPILL_RATIO`  | `0`           | `0`         | `0`         |

  You cannot change parameter values for `admin_group`.

  For more information about managing roles, see [Users and roles](cluster-users.md) and [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/admin_guide-roles_privs.html).

{% endlist %}


## Specifics of RAM allocation {#ram}

{% list tabs group=instructions %}

- {{ CB }} {#cb}

  * If there is a limit on RAM per resource group (the `MEMORY_QUOTA` parameter), RAM management takes place at the segment level.
      
    RAM per query is decided by the `gp_resgroup_memory_query_fixed_mem` setting. If it is not set, RAM per query is calculated using this formula: `MEMORY_QUOTA ÷ CONCURRENCY`.
    
    Read more about the `gp_resgroup_memory_query_fixed_mem` setting in [this {{ GP }} guide]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-config_params-guc-list.html#gp_resgroup_memory_query_fixed_mem).

    For more information on additional criteria affecting RAM per query, see [this {{ CB }} guide.]({{ gp.docs.cloudberry }}/performance/manage-resources-using-resource-groups/#memory-limits)
  
  * If there is no limit on RAM per resource group, RAM management takes place at the query level. RAM per query is decided by the [statement_mem](settings-list.md#setting-statement-mem) setting.

- {{ GP }} {#gp}

  * You can allocate a segment's RAM share for each resource group using the `MEMORY_LIMIT` parameter. This percentage is split into the _shared quota_ and _guaranteed quota_:

    * The shared quota is set in the `MEMORY_SHARED_QUOTA` parameter and can be used by all the resource group transactions. {{ mgp-name }} distributes the shared quota to transactions based on the _first in, first out_ principle.
    * The guaranteed quota is allocated to each transaction and calculated by the following formula:

        `(MEMORY_LIMIT − MEMORY_SHARED_QUOTA) ÷ CONCURRENCY`

  * If the total of `MEMORY_LIMIT` values of all resource groups is below `100`, {{ mgp-name }} distributes unallocated RAM to any transactions from any resource groups based on the _first in, first out_ principle.

    The transaction uses non-allocated memory when both conditions are met:

    * The guaranteed memory share for the transaction is used up.
    * The shared quota for the resource group is used up.


    For your cluster to run in a stable and efficient manner, leave 10% to 20% of memory unallocated.

{% endlist %}


## Specifics of CPU resource allocation {#cpu}

You can allocate CPU resources using one of the following methods:

* By setting a CPU percentage per resource group on a segment. In {{ CB }}, the parameter used to set CPU percentage is `CPU_MAX_PERCENT`, while in {{ GP }}, it is `CPU_RATE_LIMIT`.
 
  If a resource group is idle, its resources get re-allocated towards highly loaded groups. In {{ CB }}, resource group priority (the `CPU_WEIGHT` parameter) is another factor affecting CPU resource allocation. As soon as the resource group stops idling, it gets its re-allocated CPU resources back.

* By specifying the numbers of logical CPU cores you are allocating to the resource group (in the `CPUSET` parameter). These cores will be unavailable to other resource groups even if the resource group they are allocated to is idle. Therefore, we recommend minimizing the number of resource groups with allocated cores.

  {% note warning %}

  For stable cluster operation, do not allocate core `0`.

  {% endnote %}

CPU allocation methods may vary from one resource group to another.

For more on resource groups, see:

* [This {{ CB }} guide]({{ gp.docs.cloudberry }}/performance/manage-resources-using-resource-groups/).
* [This {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/admin_guide-workload_mgmt_resgroups.html).

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

{% include [cloudberry-trademark](../../_includes/mdb/mgp/trademark-cloudberry.md) %}