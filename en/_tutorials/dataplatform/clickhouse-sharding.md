# Table sharding in {{ CH }}


In a [sharded {{ CH }} cluster](../../managed-clickhouse/concepts/sharding.md#uses), you can distribute table data across all cluster shards or only some of them, i.e., a [shard group](../../managed-clickhouse/operations/shard-groups.md).

You can select one of the following three topologies to implement distributed storage of table data on cluster shards:
* [All shards](#shard-example): the local and distributed tables are created across all shards within a cluster.
* [Single shard group](#shard-groups-example): the local and distributed tables are created on all shards within a group.
* [Two shard groups](#shard-groups-advanced-example): the local table is created on the shards of one group, while the distributed table is deployed on shards of the second group.

To split table data into shards:

1. [Create tables with data](#create-tables).
1. [Test the tables](#sharding-test).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ mch-name }} cluster: use of computing resources allocated to hosts (including {{ ZK }} hosts) and disk space (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Getting started {#before-you-begin}

### Set up your infrastructure {#deploy-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) with publicly available hosts and configure it as follows:

        * **{{ ui-key.yacloud.mdb.forms.base_field_name }}**: `chcluster`.
        * **{{ ui-key.yacloud.mdb.forms.label_diskTypeId }}**: Select the required disk type.

            It will determine the minimum number of hosts per shard:

            * Two hosts, if you select local SSDs (`local-ssd`).
            * Three hosts, if you select network non-replicated SSDs (`network-ssd-nonreplicated`).

            To ensure fault tolerance using these disk types, you must add redundant hosts.

            For more information, see [{#T}](../../managed-clickhouse/concepts/storage.md).

        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `tutorial`.

        {% include [public-access](../../_includes/mdb/note-public-access.md) %}

    1. [Create two additional shards](../../managed-clickhouse/operations/shards.md#add-shard) named `shard2` and `shard3`.
    1. [Add three {{ ZK }} hosts to the cluster](../../managed-clickhouse/operations/zk-hosts.md#add-zk).
    1. [Create shard groups](../../managed-clickhouse/operations/shard-groups.md#create-shard-group). The number of shard groups depends on the sharding type:

        * [Group-based sharding](#shard-groups-example) requires one group named `sgroup` that will include `shard1` and `shard2`.
        * [Advanced group-based sharding](#shard-groups-advanced-example) requires two groups:
            * `sgroup` including `shard1` and `shard2`.
            * `sgroup_data` including `shard3`.

         No shard groups are needed for [classic sharding](#shard-example).

    
    1. If using security groups, [configure them](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) to allow internet access to your cluster.


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download one of the following sharding example configuration files to your current working directory:

        * [simple-sharding.tf](https://github.com/yandex-cloud-examples/yc-clickhouse-sharding/blob/main/simple-sharding.tf): Classic sharding.
        * [sharding-with-groups.tf](https://github.com/yandex-cloud-examples/yc-clickhouse-sharding/blob/main/advanced-sharding-with-groups.tf): Group-based sharding.
        * [advanced-sharding-with-groups.tf](https://github.com/yandex-cloud-examples/yc-clickhouse-sharding/blob/main/advanced-sharding-with-groups.tf): Advanced group-based sharding.

        Each file describes the following:

        * Network.
        * Subnet.
        * Default security group and rules for connecting to the cluster from the internet.
        * {{ mch-name }} cluster with the required hosts and shards.

    1. In the configuration file, specify the username and password that will be used to access the {{ mch-name }} cluster.
    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.
    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Set up the clickhouse-client {#deploy-clickhouse-client}

[Install and configure the clickhouse-client](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) for database access.

## Create tables with data {#create-tables}

Let's assume we need to distribute the `hits_v1` [table]({{ ch.docs }}{{ lang }}/getting-started/example-datasets/metrica) data across shards.

Replace the `<table_structure>` placeholder with column descriptions from [this {{ CH }} guide]({{ ch.docs }}{{ lang }}/getting-started/example-datasets/metrica#create-the-database-and-table).

In the following examples, we use the `rand()` expression as a sharding key to randomly distribute data across shards.

### All shards {#shard-example}

In this example, the distributed and local tables are created on all cluster shards: `shard1`, `shard2`, and `shard3`.

Before creating a distributed table:

1. [Connect](../../managed-clickhouse/operations/connect/clients.md) to the `tutorial` database.
1. Create the `hits_v1` [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree) table on all cluster hosts:

   ```sql
   CREATE TABLE tutorial.hits_v1 ON CLUSTER '{cluster}' ( <table_structure> )
   ENGINE = MergeTree()
   PARTITION BY toYYYYMM(EventDate)
   ORDER BY (CounterID, EventDate, intHash32(UserID))
   SAMPLE BY intHash32(UserID)
   SETTINGS index_granularity = 8192
   ```

To create a distributed table named `hits_v1_distributed` in the cluster:

1. [Connect](../../managed-clickhouse/operations/connect/clients.md) to the `tutorial` database.
1. Create a [Distributed]({{ ch.docs }}{{ lang }}/engines/table-engines/special/distributed) table:

   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER '{cluster}' AS tutorial.hits_v1
   ENGINE = Distributed('{cluster}', tutorial, hits_v1, rand())
   ```

   Here, you can use the `AS tutorial.hits_v1` expression instead of explicitly stating the table structure since both tables, `hits_v1_distributed` and `hits_v1`, reside on the same cluster hosts.

   When creating a [Distributed]({{ ch.docs }}{{ lang }}/engines/table-engines/special/distributed) table, use `chcluster` as the cluster ID. You can get it with the [list of clusters in the folder](../../managed-clickhouse/operations/cluster-list.md#list-clusters).

   {% note tip %}

   You can use the `{cluster}` macro instead of the cluster ID. When running the query, ClickHouse will automatically substitute it with the ID of the cluster where the `CREATE TABLE` statement is running.

   {% endnote %}

### Single shard group {#shard-groups-example}

In this example, the distributed and local tables are created within a single shard group, `sgroup`.

Before creating a distributed table:

1. [Connect](../../managed-clickhouse/operations/connect/clients.md) to the `tutorial` database.
1. Create the `hits_v1` [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree) table on all hosts within the `sgroup` shard group:

   ```sql
   CREATE TABLE tutorial.hits_v1 ON CLUSTER sgroup ( <table_structure> )
   ENGINE = MergeTree()
   PARTITION BY toYYYYMM(EventDate)
   ORDER BY (CounterID, EventDate, intHash32(UserID))
   SAMPLE BY intHash32(UserID)
   SETTINGS index_granularity = 8192
   ```

To create a distributed table named `tutorial.hits_v1_distributed` in the cluster:

1. [Connect](../../managed-clickhouse/operations/connect/clients.md) to the `tutorial` database.
1. Create a [Distributed]({{ ch.docs }}{{ lang }}/engines/table-engines/special/distributed) table:

   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER sgroup AS tutorial.hits_v1
   ENGINE = Distributed(sgroup, tutorial, hits_v1, rand())
   ```

   Here, you can use the `AS tutorial.hits_v1` expression instead of explicitly stating the table structure since both tables, `hits_v1_distributed` and `hits_v1`, reside on the same cluster hosts within a single shard.

### Two shard groups {#shard-groups-advanced-example}

In this example:
* The distributed table is created within the `sgroup` shard group.
* The local table is created within the `sgroup_data` shard group.

Before creating a distributed table:

1. [Connect](../../managed-clickhouse/operations/connect/clients.md) to the `tutorial` database.
1. Create the `hits_v1` [ReplicatedMergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/replication) local table on all hosts within the `sgroup_data` shard group:

   ```sql
   CREATE TABLE tutorial.hits_v1 ON CLUSTER sgroup_data ( <table_structure> )
   ENGINE = ReplicatedMergeTree('/tables/{shard}/hits_v1', '{replica}')
   PARTITION BY toYYYYMM(EventDate)
   ORDER BY (CounterID, EventDate, intHash32(UserID))
   SAMPLE BY intHash32(UserID)
   SETTINGS index_granularity = 8192
   ```

   The **ReplicatedMergeTree** engine will provide fault tolerance to this solution.

To create a distributed table named `tutorial.hits_v1_distributed` in the cluster:

1. [Connect](../../managed-clickhouse/operations/connect/clients.md) to the `tutorial` database.
1. Create the [Distributed]({{ ch.docs }}{{ lang }}/engines/table-engines/special/distributed) table on all hosts within the `sgroup` shard group:

   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER sgroup ( <table_structure> )
   ENGINE = Distributed(sgroup_data, tutorial, hits_v1, rand())
   ```

   Here you must explicitly specify the table structure because the `hits_v1_distributed` and `hits_v1` tables reside on different hosts in separate shards.

## Test the tables {#sharding-test}

To test your new distributed table named `tutorial.hits_v1_distributed`:

1. Load the `hits_v1` test dataset:

   
   ```bash
   curl https://{{ s3-storage-host }}/doc-files/managed-clickhouse/hits_v1.tsv.xz | unxz --threads=`nproc` > hits_v1.tsv
   ```


1. Populate the table with test data:

   ```bash
   clickhouse-client \
      --host "<FQDN_of_any_host_with_distributed_table>" \
      --secure \
      --port 9440 \
      --user "<username>" \
      --password "<user_password>" \
      --database "tutorial" \
      --query "INSERT INTO tutorial.hits_v1_distributed FORMAT TSV" \
      --max_insert_block_size=100000 < hits_v1.tsv
   ```

    You can get the host names with the [list of {{ CH }} hosts in the cluster](../../managed-clickhouse/operations/hosts.md#list-hosts).

1. Run one or multiple test queries against this table. For example, you can get the table row count:

   ```sql
   SELECT count() FROM tutorial.hits_v1_distributed
   ```

    Result:

    ```text
    8873898
    ```

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Delete the {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).
    1. If you used static public IP addresses for cluster access, release and [delete them](../../vpc/operations/address-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
