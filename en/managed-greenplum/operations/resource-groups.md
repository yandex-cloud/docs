# Managing resource groups

You can manage cluster resource usage quotas using [resource groups](../concepts/resource-groups.md).

To perform operations using SQL queries, [connect to the cluster](connect.md) as a user with the `mdb_admin` [role](../concepts/cluster-users.md#mdb_admin).

## View information about resource groups {#info}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To view a list of resource groups and their [parameter](../concepts/resource-groups.md#rg-params) values, run the command:

    ```bash
    {{ yc-mdb-gp }} resource-groups list --cluster-id=<cluster_ID> 
    ```

    To view the parameter values of a specific resource group, run this command:

    ```bash
    {{ yc-mdb-gp }} resource-groups get <resource_group_name> \
       --cluster-id=<cluster_ID> 
    ```

    {% include [cluster-name-as-id](../../_includes/mdb/mgp/cluster-name-as-id.md) %}

- SQL {#sql}

    To view a list of resource groups and their [parameter](../concepts/resource-groups.md#rg-params) values, run the command:

    ```sql
    SELECT * FROM gp_toolkit.gp_resgroup_config;
    ```

    To view a list of roles and the resource groups they belong to, run the command:

    ```sql
    SELECT rolname, rsgname FROM pg_roles, pg_resgroup
    WHERE pg_roles.rolresgroup=pg_resgroup.oid;
    ```

{% endlist %}

## Create a resource group {#create}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Provide the name of the resource group and the values of its [parameters](../concepts/resource-groups.md#rg-params) in the command:

    ```bash
    {{ yc-mdb-gp }} resource-groups create <resource_group_name> \
       --cluster-id=<cluster_ID> \
       --concurrency=<CONCURRENCY_parameter_value> \
       --cpu-rate-limit=<CPU_RATE_LIMIT_parameter_value> \
       --memory-limit=<MEMORY_LIMIT_parameter_value> \
       --memory-shared-quota=<MEMORY_SHARED_QUOTA_parameter_value> \
       --memory-spill-ratio=<MEMORY_SPILL_RATIO_parameter_value>
    ```

    When creating a resource group, just specify the value of the `CPU_RATE_LIMIT` parameter. For the other parameters, the default settings will be applied.

    {% include [cluster-name-as-id](../../_includes/mdb/mgp/cluster-name-as-id.md) %}

- SQL {#sql}

    Provide the name of the resource group and its [parameters](../concepts/resource-groups.md#rg-params) in the command:

    ```sql
    CREATE RESOURCE GROUP <resource_group_name> WITH (<parameter_1>, <parameter_2>, ...);
    ```

    When creating a resource group, just specify the value of the `CPU_RATE_LIMIT` or `CPUSET` parameter. For the other parameters, the default settings will be applied.


{% endlist %}

## Assign a resource group to a role {#assign}

{% list tabs group=instructions %}

- SQL {#sql}

    To create a role and immediately assign it to a resource group, run the command:

    ```sql
    CREATE ROLE <role_name> RESOURCE GROUP <resource_group_name>;
    ```

    {% note info %}

    By default, new roles are assigned to `default_group`.

    {% endnote %}

    To assign a different resource group to the role, run the command:

    ```sql
    ALTER ROLE <role_name> RESOURCE GROUP <resource_group_name>;
    ```

{% endlist %}

## View the current load of resource groups {#load}

{% list tabs group=instructions %}

- SQL {#sql}

    To view the current load on resource groups across the whole cluster, run this command:

    ```sql
    SELECT * FROM gp_toolkit.gp_resgroup_status;
    ```

    To view the same data by hosts, use this command:

    ```sql
    SELECT * FROM gp_toolkit.gp_resgroup_status_per_host;
    ```

    To view the same data by segments, use this command:

    ```sql
    SELECT * FROM gp_toolkit.gp_resgroup_status_per_segment;
    ```

{% endlist %}

## View a list of queries in resource groups {#queries}

{% list tabs group=instructions %}

- SQL {#sql}

    To see a list of queries in progress and in the queue, run the command:

    ```sql
    SELECT query, waiting, rsgname, rsgqueueduration
    FROM pg_stat_activity;
    ```

{% endlist %}

## Change resource group parameters {#params}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Provide the name of the resource group and the new values for its [parameters](../concepts/resource-groups.md#rg-params) you want to change in the command:

    ```bash
    {{ yc-mdb-gp }} resource-groups update <resource_group_name> \
       --cluster-id=<cluster_ID> \
       --concurrency=<new_CONCURRENCY_parameter_value> \
       --cpu-rate-limit=<new_CPU_RATE_LIMIT_parameter_value> \
       --memory-limit=<new_MEMORY_LIMIT_parameter_value> \
       --memory-shared-quota=<new_MEMORY_SHARED_QUOTA_parameter_value> \
       --memory-spill-ratio=<new_MEMORY_SPILL_RATIO_parameter_value>
    ```

    {% include [cluster-name-as-id](../../_includes/mdb/mgp/cluster-name-as-id.md) %}

- SQL {#sql}

    Provide the name of the resource group and the new values of its [parameters](../concepts/resource-groups.md#rg-params) you want to change in the command:

    ```sql
    ALTER RESOURCE GROUP <resource_group_name> SET <parameter_name> <new_parameter_value>;
    ```

{% endlist %}

If you do not provide new values for certain resource group parameters, they will not change.

## Delete a resource group {#delete}

You can delete a resource group only if it isn't assigned to any roles and contains no transactions in progress or in the queue.

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To delete a resource group, run the command:

    ```bash
    {{ yc-mdb-gp }} resource-groups delete <resource_group_name> \
       --cluster-id=<cluster_ID> 
    ```

    {% include [cluster-name-as-id](../../_includes/mdb/mgp/cluster-name-as-id.md) %}

- SQL {#sql}

    To delete a resource group, run the command:

    ```sql
    DROP RESOURCE GROUP <resource_group_name>;
    ```

{% endlist %}


## Example of creating a resource group {#example}

Create a resource group with test characteristics:

* Name: `testgroup`.
* Maximum number of processed transactions: 15.
* Share of CPU resources used in the segment: 10%.
* RAM share in the segment: 20%.
* Share allocated as an overall quota: 50%.
* RAM share in the resource group that a single transaction operator can occupy: 30%.

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Run this command:

    ```bash
    {{ yc-mdb-gp }} resource-groups create testgroup \
       --cluster-id=<cluster_ID> \
       --concurrency=15 \
       --cpu-rate-limit=10 \
       --memory-limit=20 \
       --memory-shared-quota=50\
       --memory-spill-ratio=30
    ```

    Check that the new resource group appeared in the list:

    ```bash
    {{ yc-mdb-gp }} resource-groups list --cluster-id=<cluster_ID> 
    ```

- SQL {#sql}

    Run this command:

    ```sql
    CREATE RESOURCE GROUP testgroup
    WITH (CONCURRENCY=15, CPU_RATE_LIMIT=10, MEMORY_LIMIT=20, MEMORY_SHARED_QUOTA=50, MEMORY_SPILL_RATIO=30);
    ```

    Check that the new resource group appeared in the list:

    ```sql
    SELECT * FROM gp_toolkit.gp_resgroup_config;
    ```

{% endlist %}


{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
