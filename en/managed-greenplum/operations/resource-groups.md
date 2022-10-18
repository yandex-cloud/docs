# Managing resource groups

You can manage cluster resource usage quotas using [resource groups](../concepts/resource-groups.md). To do this, [connect to the cluster](connect.md) as the user with the `mdb_admin` [role](../concepts/cluster-users.md).

## View information about resource groups {#info}

To view a list of resource groups and their [parameter](../concepts/resource-groups.md#rg-params) values, run the command:

```sql
SELECT * FROM gp_toolkit.gp_resgroup_config;
```

To view a list of roles and the resource groups they belong to, run the command:

```sql
SELECT rolname, rsgname FROM pg_roles, pg_resgroup
WHERE pg_roles.rolresgroup=pg_resgroup.oid;
```

## Create a resource group {#create}

Pass the name of the resource group and its [parameters](../concepts/resource-groups.md#rg-params) in the command:

```sql
CREATE RESOURCE GROUP <resource group name> WITH (<parameter 1>, <parameter 2>, ...);
```

When creating a resource group, just specify the value of the `CPU_RATE_LIMIT` or `CPUSET` parameter. For the other parameters, the default settings will be applied.

{% if audience == "draft" %}

To create a resource group for a component, just specify the values of the parameters:

* `MEMORY_AUDITOR=cgroup`
* `CONCURRENCY=0`
* `CPU_RATE_LIMIT` or `CPUSET`
* `MEMORY_LIMIT`

{% endif %}

## Assign a resource group to a role {#assign}

To create a role and immediately assign it to a resource group, run the command:

```sql
CREATE ROLE <role name> RESOURCE GROUP <resource group name>;
```

{% note info %}

By default, new roles are assigned to the `default_group` resource group.

{% endnote %}

To assign a different resource group to the role, run the command:

```sql
ALTER ROLE <role name> RESOURCE GROUP <resource group name>;
```

## View the current load of resource groups {#load}

{% list tabs %}

* In the entire cluster

   ```sql
   SELECT * FROM gp_toolkit.gp_resgroup_status;
   ```

* On each host

   ```sql
   SELECT * FROM gp_toolkit.gp_resgroup_status_per_host;
   ```

* In each segment

   ```sql
   SELECT * FROM gp_toolkit.gp_resgroup_status_per_segment;
   ```

{% endlist %}

## View a list of queries in resource groups {#queries}

To see a list of queries in progress and in the queue, run the command:

```sql
SELECT query, waiting, rsgname, rsgqueueduration
FROM pg_stat_activity;
```

## Change resource group parameters {#params}

Run the command:

```sql
ALTER RESOURCE GROUP <resource group name> SET <parameter name> <new parameter value>;
```

## Delete a resource group {#delete}

You can delete a resource group only if it isn't assigned to any roles and contains no transactions in progress or in the queue.

To delete a resource group, run the command:

```sql
DROP RESOURCE GROUP <resource group name>;
```

{% if audience == "draft" %}
{% note warning %}

When a resource group that contains running instances of an external component is deleted, {{ GP }} terminates those instances.

{% endnote %}
{% endif %}

## Example of creating a resource group {#example}

Create a resource group with test characteristics:

* Name: `testgroup`.
* Maximum number of processed transactions: 15.
* Share of CPU resources used in the segment: 10%.
* RAM share in the segment: 20%.
* Share allocated as an overall quota: 50%.
* RAM share in the resource group that a single transaction operator can occupy: 30%.

Run the command:

```sql
CREATE RESOURCE GROUP testgroup
WITH (CONCURRENCY=15, CPU_RATE_LIMIT=10, MEMORY_LIMIT=20, MEMORY_SHARED_QUOTA=50, MEMORY_SPILL_RATIO=30);
```

Check that the new resource group appeared in the list:

```sql
SELECT * FROM gp_toolkit.gp_resgroup_config;
```

{% if audience == "draft" %}

* A resource group for a component

   Create a resource group with test characteristics:

   * Name: `testcomgroup`.
   * Reserved CPU core number 2.
   * RAM share in the segment: 10%.
   * Share allocated as an overall quota: 70%.
   * RAM share in the resource group that a single transaction operator can occupy: 25%.

   Run the following command:

   ```sql
   CREATE RESOURCE GROUP testcomgroup WITH (MEMORY_AUDITOR=cgroup, CONCURRENCY=0, CPUSET='2', MEMORY_LIMIT=10, MEMORY_SHARED_QUOTA=70, MEMORY_SPILL_RATIO=25);
   ```

   Check that the new resource group appeared in the list:

   ```sql
   SELECT * FROM gp_toolkit.gp_resgroup_config;
   ```

{% endif %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
