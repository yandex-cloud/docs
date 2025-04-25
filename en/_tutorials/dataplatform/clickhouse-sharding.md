# Sharding tables in {{ CH }}


Sharding provides [a number of benefits](../../managed-clickhouse/concepts/sharding.md#advantages) when dealing with high query rates and massive datasets. It works by creating a distributed table that routes queries to underlying tables. You can access data in sharded tables both directly or through the distributed table.

There are three approaches to sharding:

* The classic approach, where the distributed table uses all shards in the cluster.
* The group-based approach, where some shards are grouped together.
* The advanced group-based approach, where shards are divided into two groups: one for the distributed table and the other for the underlying tables.

Below are examples of sharding setup for all three approaches.

For more information, see [{#T}](../../managed-clickhouse/concepts/sharding.md).

To set up sharding:

1. [Create tables with data](#create-tables).
1. [Test the tables](#sharding-test).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* {{ mch-name }} cluster fee: Using computing resources allocated to hosts (including {{ ZK }} hosts) and disk space (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).
* Fee for using public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Getting started {#before-you-begin}

### Prepare the infrastructure {#deploy-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md):

        * **{{ ui-key.yacloud.mdb.forms.base_field_name }}**: `chcluster`.
        * **{{ ui-key.yacloud.mdb.forms.label_diskTypeId }}**: Select the required disk type.

            The disk type determines the minimum number of hosts per shard:

            * Two hosts, if you select local SSDs (`local-ssd`).
            * Three hosts, if you select network non-replicated SSDs (`network-ssd-nonreplicated`).

            Additional hosts for these disk types are required for fault tolerance.

            To learn more, see [{#T}](../../managed-clickhouse/concepts/storage.md).

        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `tutorial`.

        Cluster hosts must be available online.

    1. [Create two additional shards](../../managed-clickhouse/operations/shards.md#add-shard) named `shard2` and `shard3`.
    1. [Add three {{ ZK }} hosts to the cluster](../../managed-clickhouse/operations/zk-hosts.md#add-zk).
    1. [Create shard groups](../../managed-clickhouse/operations/shard-groups.md#create-shard-group). Their number depends on the sharding type:

        * [Group-based sharding](#shard-groups-example) requires one shard group named `sgroup`, which includes `shard1` and `shard2`.
        * [Advanced group-based sharding](#shard-groups-advanced-example) requires two groups:
            * `sgroup` includes `shard1` and `shard2`.
            * `sgroup_data` includes `shard3`.

         No shard groups are needed for [classic sharding](#shard-example).

    
    1. If using security groups, [configure them](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) so that you can connect to the cluster from the internet.


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. In the same working directory, download the configuration file for one of the sharding examples described below:

        * [simple-sharding.tf](https://github.com/yandex-cloud-examples/yc-clickhouse-sharding/blob/main/simple-sharding.tf): Classic sharding.
        * [sharding-with-groups.tf](https://github.com/yandex-cloud-examples/yc-clickhouse-sharding/blob/main/advanced-sharding-with-groups.tf): Group-based sharding.
        * [advanced-sharding-with-groups.tf](https://github.com/yandex-cloud-examples/yc-clickhouse-sharding/blob/main/advanced-sharding-with-groups.tf): Advanced group-based sharding.

        Each file describes the following:

        * Network.
        * Subnet.
        * Default security group and rules required to connect to the cluster from the internet.
        * {{ mch-name }} cluster with relevant hosts and shards.

    1. In the configuration file, specify the username and password to access the {{ mch-name }} cluster.
    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.
    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Set up clickhouse-client {#deploy-clickhouse-client}

[Install and configure clickhouse-client](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) to connect to your database.

## Create tables with data {#create-tables}

Let's assume you need to enable sharding for the `hits_v1` [table]({{ ch.docs }}/getting-started/example-datasets/metrica/). The text of the table creation query depends on the sharding approach you selected.

For the table structure to substitute instead of `<table_structure>`, see the [{{ CH }} documentation]({{ ch.docs }}/getting-started/tutorial/#create-tables).

Once you engage any of the sharding methods, you can send the `SELECT` and `INSERT` queries to the distributed table you created, and they will be processed according to the specified configuration.

The sharding key in the examples is a random number `rand()`.

### Classic sharding {#shard-example}

In this example, the distributed table that will be created based on `hits_v1` uses all the shards of the `chcluster` cluster: `shard1`, `shard2`, `shard3`.

Before operating the distributed table:

1. [Connect](../../managed-clickhouse/operations/connect/clients.md) to the `tutorial` database.
1. Create a [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table named `hits_v1` that will reside on all the cluster's hosts:

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

   Here, instead of explicitly specifying the table structure, you can use the `AS tutorial.hits_v1` expression because the `hits_v1_distributed` and `hits_v1` tables are on the same cluster hosts.

   When creating a [Distributed]({{ ch.docs }}/engines/table-engines/special/distributed) table, use `chcluster` as the cluster ID. You can get it with the [list of clusters in the folder](../../managed-clickhouse/operations/cluster-list.md#list-clusters).

   {% note tip %}

   Instead of the cluster ID, you can use the `{cluster}` macro: when executing the query, the ID of the cluster the `CREATE TABLE` operation is being executed in will be substituted automatically.

   {% endnote %}

### Group-based sharding {#shard-groups-example}

In this example:

- One shard group is used named `sgroup`.
- A distributed table and the underlying table named `hits_v1` are in the same cluster shard group named `sgroup`.

Before operating the distributed table:

1. [Connect](../../managed-clickhouse/operations/connect/clients.md) to the `tutorial` database.
1. Create a [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table named `hits_v1` that uses all the cluster's `sgroup` shard group hosts:

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

   Here, instead of explicitly specifying the table structure, you can use the `AS tutorial.hits_v1` expression because the `hits_v1_distributed` and `hits_v1` tables use the same shard and run on the same hosts.

### Advanced group-based sharding {#shard-groups-advanced-example}

In this example:

1. Two shard groups are used: `sgroup` and `sgroup_data`.
1. The distributed table is in the shard group named `sgroup`.
1. The `hits_v1` underlying table is in the shard group named `sgroup_data`.

Before operating the distributed table:

1. [Connect](../../managed-clickhouse/operations/connect/clients.md) to the `tutorial` database.
1. Create a [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) table named `hits_v1` that uses all the cluster's `sgroup_data` shard group hosts:

   ```sql
   CREATE TABLE tutorial.hits_v1 ON CLUSTER sgroup_data ( <table_structure> )
   ENGINE = ReplicatedMergeTree('/tables/{shard}/hits_v1', '{replica}')
   PARTITION BY toYYYYMM(EventDate)
   ORDER BY (CounterID, EventDate, intHash32(UserID))
   SAMPLE BY intHash32(UserID)
   SETTINGS index_granularity = 8192
   ```

   The ReplicatedMergeTree engine is used for fault tolerance.

To create a distributed table named `tutorial.hits_v1_distributed` in the cluster:

1. [Connect](../../managed-clickhouse/operations/connect/clients.md) to the `tutorial` database.
1. Create a [Distributed]({{ ch.docs }}/engines/table-engines/special/distributed) table:

   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER sgroup ( <table_structure> )
   ENGINE = Distributed(sgroup_data, tutorial, hits_v1, rand())
   ```

   Here you must explicitly specify the table structure because `hits_v1_distributed` and `hits_v1` use different shards and are on different hosts.

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

    To find out the host names, request a [list of {{ CH }} hosts in the cluster](../../managed-clickhouse/operations/hosts.md#list-hosts).

1. Run one or more test queries to this table. For example, you can find out the number of rows in it:

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
    1. If static public IP addresses were used for cluster access, release and [delete them](../../vpc/operations/address-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
