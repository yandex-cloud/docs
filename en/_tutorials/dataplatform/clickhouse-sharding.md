# Table sharding in {{ CH }}


Sharding provides [a number of benefits](../../managed-clickhouse/concepts/sharding.md#advantages) when dealing with high query rates and massive datasets. It works by creating a distributed table that routes queries to underlying tables. You can access data in sharded tables both directly or through the distributed table.

There are three primary sharding strategies:

* Classic approach, where the distributed table uses all shards in the cluster.
* Group-based approach, where some shards are grouped together.
* Advanced group-based approach, where shards are divided into two groups: one for the distributed table and the other for the underlying tables.

Below are configuration examples for all three sharding methods.

For more information, see [{#T}](../../managed-clickhouse/concepts/sharding.md).

To set up sharding:

1. [Create tables with data](#create-tables).
1. [Test the tables](#sharding-test).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* {{ mch-name }} cluster fee, which covers the use of computing resources allocated to hosts (including {{ ZK }} hosts) and disk space (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).
* Fee for using public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Getting started {#before-you-begin}

### Set up the infrastructure {#deploy-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md):

        * **{{ ui-key.yacloud.mdb.forms.base_field_name }}**: `chcluster`.
        * **{{ ui-key.yacloud.mdb.forms.label_diskTypeId }}**: Select the required disk type.

            It will determine the minimum number of hosts per shard:

            * Two hosts, if you select local SSDs (`local-ssd`).
            * Three hosts, if you select network non-replicated SSDs (`network-ssd-nonreplicated`).

            To ensure fault tolerance using these disk types, you must add redundant hosts.

            For more information, see [{#T}](../../managed-clickhouse/concepts/storage.md).

        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `tutorial`.

        Cluster hosts must be accessible from the internet.

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
    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will show any errors found in your configuration files.
    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Set up the clickhouse-client {#deploy-clickhouse-client}

[Install and configure the clickhouse-client](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) for database access.

## Create tables with data {#create-tables}

Let’s assume you need to enable sharding for the `hits_v1` [table]({{ ch.docs }}/getting-started/example-datasets/metrica/). The create table statement text will depend on your chosen sharding strategy.

Replace the `<table_structure>` placeholder with column descriptions from [this {{ CH }} guide]({{ ch.docs }}/getting-started/tutorial/#create-tables).

Once you enable sharding (by any method), you will be able to send `SELECT` and `INSERT` queries to the distributed table. These queries will be processed according to the specified configuration.

In the following examples, we use a random number, `rand()`, as a sharding key.

### Classic sharding {#shard-example}

In this example, the distributed table built from `hits_v1` uses every shard in the `chcluster` cluster: `shard1`, `shard2`, and `shard3`.

Before operating the distributed table:

1. [Connect](../../managed-clickhouse/operations/connect/clients.md) to the `tutorial` database.
1. Create the `hits_v1` table on every host in the cluster using the [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) engine:

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
1. Create a [Distributed]({{ ch.docs }}/engines/table-engines/special/distributed) table:

   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER '{cluster}' AS tutorial.hits_v1
   ENGINE = Distributed('{cluster}', tutorial, hits_v1, rand())
   ```

   Here, you can use the `AS tutorial.hits_v1` expression instead of explicitly stating the table structure since both tables, `hits_v1_distributed` and `hits_v1`, reside on the same cluster hosts.

   When creating a [Distributed]({{ ch.docs }}/engines/table-engines/special/distributed) table, use `chcluster` as the cluster ID. You can get it with the [list of clusters in the folder](../../managed-clickhouse/operations/cluster-list.md#list-clusters).

   {% note tip %}

   You can use the `{cluster}` macro instead of the cluster ID. When running the query, ClickHouse will automatically substitute it with the ID of the cluster where the `CREATE TABLE` statement is running.

   {% endnote %}

### Group-based sharding {#shard-groups-example}

In this example:

- We use a single shard group named `sgroup`.
- The distributed table and its underlying table, `hits_v1`, are in the same `sgroup` shard group within the cluster.

Before operating the distributed table:

1. [Connect](../../managed-clickhouse/operations/connect/clients.md) to the `tutorial` database.
1. Create the `hits_v1` table on every host in the `sgroup` shard group, using the [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) engine:

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
1. Create a [Distributed]({{ ch.docs }}/engines/table-engines/special/distributed) table:

   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER sgroup AS tutorial.hits_v1
   ENGINE = Distributed(sgroup, tutorial, hits_v1, rand())
   ```

   Here, you can use the `AS tutorial.hits_v1` expression instead of explicitly stating the table structure since both tables, `hits_v1_distributed` and `hits_v1`, reside on the same cluster hosts within a single shard.

### Advanced group-based sharding {#shard-groups-advanced-example}

In this example:

1. We use the `sgroup` and `sgroup_data` shard groups.
1. The distributed table resides in the `sgroup` shard group.
1. The `hits_v1` underlying table resides in the `sgroup_data` shard group.

Before operating the distributed table:

1. [Connect](../../managed-clickhouse/operations/connect/clients.md) to the `tutorial` database.
1. Create the `hits_v1` table on every host of the `sgroup_data` shard group, using the [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) engine:

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
1. Create a [Distributed]({{ ch.docs }}/engines/table-engines/special/distributed) table:

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
