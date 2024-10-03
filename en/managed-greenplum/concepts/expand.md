---
title: Expanding a {{ GP }} cluster
description: How does a cluster expand procedure work in {{ mgp-full-name }}.
---

# Expanding a {{ GP }} cluster

You can [expand](../operations/hosts/cluster-expand.md) a cluster to add additional segment hosts to it.

The expansion procedure consists of a [preparation stage](#preparation) and a [data redistribution](#redistribution) stage. The data redistribution stage can be completed either right after the preparation stage or later on in the [background](#setting-delay-redistribution).

Each of these stages [may take a long time](#duration). You cannot influence the duration of the preparation stage, but you can influence that of the data redistribution stage, thus controlling the overall duration of the cluster expansion procedure.

## Preparation stage {#preparation}

At this stage, the following processes take place:

1. New segment hosts are added to the cluster.
1. The [gpexpand]({{ gp.docs.vmware }}/6/greenplum-database/utility_guide-ref-gpexpand.html) utility gears up for for table redistribution:

    1. Creates the `gpexpand` service data schema in the `postgres` database.

    1. Generates a table redistribution queue.

        All tables from all the cluster databases will be redistributed but they all will get different priorities affecting their positions in the queue.

        [You can manage their priorities](../operations/hosts/cluster-expand.md#table-priority) provided that data redistribution for a particular table [has not started yet](../operations/hosts/cluster-expand.md#redistribute-monitoring) and the cluster is not [closed from load](#setting-close-cluster).

    1. Prepares [partitioned tables]({{ gp.docs.vmware }}/6/greenplum-database/admin_guide-ddl-ddl-partition.html#about-table-partitioning) for data redistribution.

The approximate duration of this stage is several hours; there is no way to influence it. For more information on how long the stages take, see [below](#duration).

{% note warning %}

Technically, new segment hosts will be added to the cluster already at this stage, but the expansion will be considered complete only after the data redistribution stage is over.

{% endnote %}

## Data redistribution stage {#redistribution}

At this stage, the following processes take place:

1. The cluster's table data is redistributed using the [gpexpand]({{ gp.docs.vmware }}/6/greenplum-database/utility_guide-ref-gpexpand.html) utility for even distribution across all segment hosts.

1. The `gpexpand` service data schema is deleted.

The approximate duration of this stage is several days. You can influence it using [settings](#settings). For more information on how long the stages take, see [below](#duration).

## Stage duration and duration control {#duration}

The approximate durations of the stages:

* Several hours for the [preparation stage](#preparation).
* Several days for the [data redistribution stage](#redistribution).

The actual duration of each stage depends not only on the size of the cluster databases and the total number of tables but also on the level and nature of the cluster load.

This is because the [gpexpand]({{ gp.docs.vmware }}/6/greenplum-database/utility_guide-ref-gpexpand.html) utility, which operates at every stage of cluster expansion, captures exclusive [locks]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-sql_commands-LOCK.html) at the individual table level. User requests may also capture locks when they are executed. This may considerably slow down both `gpexpand` and user request processing: it depends on which process captures the lock first and which one has to wait for the lock to be released. Both of these processes can generate increased load on the cluster.

You cannot shorten the preparation stage, but you can influence the duration of the data redistribution stage. To do this, before you run the procedure, [configure](../operations/hosts/cluster-expand.md) the [settings](#settings) that control the cluster's behavior at this stage. By combining the settings, you can strike the right balance between data redistribution speed and user request processing speed.

As the data redistribution stage can potentially take a long time, there are tools for {{ mgp-name }} clusters to [monitor](../operations/hosts/cluster-expand.md#redistribute-monitoring) the data redistribution process. Use these tools while cluster expansion is ongoing to get more accurate information about its progress and be able to estimate its completion time.

## Settings affecting data redistribution process {#redistribution}

You can use the following settings:

* **{{ ui-key.yacloud.greenplum.field_expand-close-cluster }}**{#setting-close-cluster} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    If this setting is enabled (`true`), you cannot connect to the cluster and it does not receive new user requests. As a result, cluster expansion will run faster because you do not have to wait for releasing of locks that would otherwise be captured by incoming user requests.

    {% include [close-and-delay-warning](../../_includes/mdb/mgp/expand/close-and-delay-warning.md) %}

* **{{ ui-key.yacloud.greenplum.field_expand-delay-redistribution }}**{#setting-delay-redistribution} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    This setting affects the data redistribution strategy:

    * If the setting is disabled (`false`), data redistribution will start as soon as the cluster expansion preparation stage is over.

        {% include [updating-long](../../_includes/mdb/mgp/expand/updating-long.md) %}

        The data redistribution process will be run once and will continue either until all the cluster's tables are redistributed or [until the timeout expires](#setting-duration).

        {% include [manual-redistribution](../../_includes/mdb/mgp/expand/manual-redistribution.md) %}

    * If the setting is enabled (`true`), data redistribution will be delayed.

        {% include [updating-short](../../_includes/mdb/mgp/expand/updating-short.md) %}

        The data redistribution process will be run on a schedule during [routine maintenance operations](./maintenance.md#regular-ops) until all tables are processed.

        When background data redistribution is enabled, routine maintenance operations are performed according to the following algorithm:

        1. [Custom table vacuuming](./maintenance.md#custom-table-vacuum) (`VACUUM`).

        1. Data redistribution (`REDISTRIBUTE`):

            1. If all tables were processed before the [timeout expired](#setting-duration), the data redistribution process will be removed from the routine maintenance schedule and will not be started again.
            1. If only some of the tables were processed before the timeout expired, the process will be restarted during the next routine maintenance, and table processing will continue.

        1. [Collecting statistics](./maintenance.md#get-statistics) (`ANALYZE`).

* **{{ ui-key.yacloud.greenplum.field_expand-duration }}**{#setting-duration} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Timeout (in seconds) after which the data redistribution process will be interrupted.

    {% include [setting-expand-duration](../../_includes/mdb/mgp/expand/setting-expand-duration.md) %}

* **{{ ui-key.yacloud.greenplum.field_expand-parallel }}**{#setting-parallel} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Number of threads that will be started during the data redistribution process.

    {% include [setting-expand-parallel](../../_includes/mdb/mgp/expand/setting-expand-parallel.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
