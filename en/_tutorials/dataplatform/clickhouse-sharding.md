# Sharding tables in {{ CH }}

Sharding provides a [range of benefits](../../managed-clickhouse/concepts/sharding.md#advantages) for coping with a high query rate and big data amounts. It works by creating a distributed table that routes queries to underlying tables. You can access data in sharded tables both directly and through the distributed table.

There are three approaches to sharding:

* Classic approach, when the distributed table uses all shards in the cluster.
* Regular group-based approach, when some shards are combined into a group.
* Advanced group-based approach, when shards are split into two groups: one group is created for the distributed table and another group is created for underlying tables.

Below are examples of sharding setup for each of the three approaches.

For more information, see [{#T}](../../managed-clickhouse/concepts/sharding.md).

To set up sharding:

1. [Create tables with data](#create-tables).
1. [Test the tables](#sharding-test).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

### Prepare the infrastructure {#deploy-infrastructure}

{% list tabs %}

- Manually

   1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md):

      * **{{ ui-key.yacloud.mdb.forms.base_field_name }}**: `cluster`
      * **{{ ui-key.yacloud.mdb.forms.label_diskTypeId }}**: Select the required disk type.

         The disk type determines the minimum number of hosts per shard:

         * Two hosts, if you select local SSD disks (`local-ssd`).
         * Three hosts, if you select non-replicated SSD disks (`network-ssd-nonreplicated`).

         Additional hosts for these disk types are required for fault tolerance.

         For more information, see [{#T}](../../managed-clickhouse/concepts/storage.md).

      * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `tutorial`

      Cluster hosts must be available online.

   1. [Create two additional shards](../../managed-clickhouse/operations/shards.md#add-shard) with the names `shard2` and `shard3`.
   1. [Add three {{ ZK }} hosts to the cluster](../../managed-clickhouse/operations/zk-hosts.md#add-zk-host).
   1. [Create shard groups](../../managed-clickhouse/operations/shard-groups.md#create-shard-group). Their number depends on the sharding type:

      * [Regular group-based sharding](#shard-groups-example) requires one shard group named `sgroup`, which includes the `shard1` and `shard2` shards.
      * [Advanced group-based sharding](#shard-groups-advanced-example) requires two groups:
         * `sgroup` includes `shard1` and `shard2`.
         * `sgroup_data` includes `shard3`.

      No shard groups are needed for [classic sharding](#shard-example).

   
  1. If you are using security groups, [configure them](../../managed-clickhouse/operations/connect.md#configuring-security-groups) so that you can connect to the cluster from the internet.


- Using {{ TF }}

  
  1. If you don't have {{ TF }} yet, set up and configure it according to the [instructions](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).


   1. In the same working directory, download the configuration file for one of the sharding examples described below:

      * [simple-sharding.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/clickhouse-sharding/simple-sharding.tf): Classic sharding
      * [sharding-with-group.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/clickhouse-sharding/sharding-with-group.tf): Group-based sharding
      * [advanced-sharding-with-groups.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/clickhouse-sharding/advanced-sharding-with-groups.tf): Advanced group-based sharding

      Each file describes:

      * Network.
      * Subnet.
      * Default security group and rules required to connect to the cluster from the internet.
      * {{ mch-name }} cluster with relevant hosts and shards.

   1. In the configuration file, specify the username and password to access the {{ mch-name }} cluster.
   1. Run the `terraform init` command in the directory with the configuration file. This command initializes the providers specified in the configuration files and allows you to work with the provider resources and data sources.
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

[Install and configure clickhouse-client](../../managed-clickhouse/operations/connect.md) to connect to your database.

## Create tables with data {#create-tables}

For example, you need to enable sharding for the [table]({{ ch.docs }}/getting-started/example-datasets/metrica/) named `hits_v1`. The text of the table creation query depends on the sharding approach that you selected.

For the table structure to use for `<table structure>`, see the [{{ CH }} documentation]({{ ch.docs }}/getting-started/tutorial/#create-tables).

When you enable sharding by any of the methods, you can send the `SELECT` and `INSERT` queries to the created distributed table, and they will be processed according to the specified configuration.

The sharding key in the examples is a random number `rand()`.

### Traditional sharding {#shard-example}

In this example, a distributed table that we create based on `hits_v1` uses all the shards (`shard1`, `shard2`, and `shard3`) in the `chcluster` cluster.

Before operating a distributed table:

1. [Connect](../../managed-clickhouse/operations/connect.md) to the `tutorial` database.
1. Create a [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table named `hits_v1`, which will run on all cluster hosts:

   ```sql
   CREATE TABLE tutorial.hits_v1 ON CLUSTER '{cluster}' ( <table structure> )
   ENGINE = MergeTree()
   PARTITION BY toYYYYMM(EventDate)
   ORDER BY (CounterID, EventDate, intHash32(UserID))
   SAMPLE BY intHash32(UserID)
   SETTINGS index_granularity = 8192
   ```

To create the `hits_v1_distributed` distributed table in the cluster:

1. [Connect](../../managed-clickhouse/operations/connect.md) to the `tutorial` database.
1. Create a table on the [Distributed]({{ ch.docs }}/engines/table-engines/special/distributed) engine:

   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER '{cluster}' AS tutorial.hits_v1
   ENGINE = Distributed('{cluster}', tutorial, hits_v1, rand())
   ```

   In this case, instead of explicitly specifying the table structure, you can use the `AS tutorial.hits_v1` expression because the `hits_v1_distributed` and `hits_v1` tables run on the same hosts in the cluster.

   When creating a table on the [Distributed]({{ ch.docs }}/engines/table-engines/special/distributed) engine, use `chcluster` as the cluster ID. You can get it with a [list of clusters in the folder](../../managed-clickhouse/operations/cluster-list.md#list-clusters).

   {% note tip %}

   Instead of the cluster ID, you can use the `{cluster}` macro: when executing the query, the ID of the cluster where the `CREATE TABLE` operation is running will be picked up automatically.

   {% endnote %}

### Sharding using shard groups {#shard-groups-example}

In this example:

- One `sgroup` shard group is used.
- A distributed table and the `hits_v1` underlying table are in the same `sgroup` shard group in the cluster.

Before operating a distributed table:

1. [Connect](../../managed-clickhouse/operations/connect.md) to the `tutorial` database.
1. Create a [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table named `hits_v1`, which will use all of the hosts of the `sgroup` shard group in the cluster:

   ```sql
   CREATE TABLE tutorial.hits_v1 ON CLUSTER sgroup ( <table structure> )
   ENGINE = MergeTree()
   PARTITION BY toYYYYMM(EventDate)
   ORDER BY (CounterID, EventDate, intHash32(UserID))
   SAMPLE BY intHash32(UserID)
   SETTINGS index_granularity = 8192
   ```

To create the `tutorial.hits_v1_distributed` distributed table in the cluster:

1. [Connect](../../managed-clickhouse/operations/connect.md) to the `tutorial` database.
1. Create a table on the [Distributed]({{ ch.docs }}/engines/table-engines/special/distributed) engine:

   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER sgroup AS tutorial.hits_v1
   ENGINE = Distributed(sgroup, tutorial, hits_v1, rand())
   ```

   In this case, instead of explicitly specifying the table structure, you can use the `AS tutorial.hits_v1` expression because the `hits_v1_distributed` and `hits_v1` tables use the same shard and run on the same hosts in the cluster.

### Advanced sharding using shard groups {#shard-groups-advanced-example}

In this example:

1. Two shard groups are used: `sgroup` and `sgroup_data`.
1. The distributed table is located in the `sgroup` shard group.
1. The `hits_v1` underlying table is in the `sgroup_data` shard group.

Before operating a distributed table:

1. [Connect](../../managed-clickhouse/operations/connect.md) to the `tutorial` database.
1. Create a [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) table named `hits_v1`, which will use all of the hosts of the `sgroup_data` shard group in the cluster:

   ```sql
   CREATE TABLE tutorial.hits_v1 ON CLUSTER sgroup_data ( <table structure> )
   ENGINE = ReplicatedMergeTree('/tables/{shard}/hits_v1', '{replica}')
   PARTITION BY toYYYYMM(EventDate)
   ORDER BY (CounterID, EventDate, intHash32(UserID))
   SAMPLE BY intHash32(UserID)
   SETTINGS index_granularity = 8192
   ```

   The ReplicatedMergeTree engine ensures fault tolerance.

To create the `tutorial.hits_v1_distributed` distributed table in the cluster:

1. [Connect](../../managed-clickhouse/operations/connect.md) to the `tutorial` database.
1. Create a table on the [Distributed]({{ ch.docs }}/engines/table-engines/special/distributed) engine:

   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER sgroup ( <table structure> )
   ENGINE = Distributed(sgroup_data, tutorial, hits_v1, rand())
   ```

   For example, you can find out the number of rows in the table because the `hits_v1_distributed` and `hits_v1` tables use different shards and run on different hosts.

## Test the tables {#sharding-test}

To check the health of the created distributed table named `tutorial.hits_v1_distributed`:

1. Load the `hits_v1` test dataset:

   
   ```bash
   curl https://{{ s3-storage-host }}/doc-files/managed-clickhouse/hits_v1.tsv.xz | unxz --threads=`nproc` > hits_v1.tsv
   ```


1. Complete the table with the test data:

   ```bash
   clickhouse-client \
     --host "<FQDN of any host with a distributed table>" \
     --secure \
     --port 9440 \
     --user "<username>" \
     --password "<user password>" \
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

{% list tabs %}

- Manually

  1. [Delete the {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).
  1. If static public IP addresses were used for cluster access, release and [delete them](../../vpc/operations/address-delete.md).

- Using {{ TF }}

   To delete the infrastructure [created with {{ TF }}](#deploy-infrastructure):

   1. In the terminal window, switch to the directory containing the infrastructure plan.
   1. Delete the configuration file (`simple-sharding.tf`, `sharding-with-group.tf`, or `advanced-sharding-with-groups.tf`).
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     All the resources described in the configuration file will be deleted.

{% endlist %}
