# Sharding tables {{ CH }}

{{ mch-name }} automatically creates a cluster with a single shard. This shard includes all the hosts in the cluster.

To start using sharding, [add](../operations/shards.md#add-shard) the desired number of shards and create a table on the [Distributed]({{ ch.docs }}/operations/table_engines/distributed/) engine. The article under the link describes sharding strategies and guidelines for creating tables in the applicable format, as well as distributed table limits.

Each sharded table in {{ CH }} consists of:
- A distributed table on the Distributed engine that routes queries.
- Underlying tables with data located on several shards in the cluster.

With a sharded table, you can operate data:
- By accessing them via a distributed table, which represents all sharded tables in the form of a single table.
- By directly accessing the underlying tables to insert data in the required shards or read the data contained in the table on a specific shard.

For more information about the sharding concept, see [{#T}](../concepts/sharding.md).

## Examples of sharding {#example}

Let's assume that a {{ mch-name }} cluster named `chcluster` is [created](../operations/cluster-create.md), containing:
- Five shards: `shard1, ..., shard5`.
- The `tutorial` database.

For example, you need to enable sharding for a [table]({{ ch.docs }}/getting-started/example-datasets/metrica/) named `hits_v1`. The table will be created for each example separately. You can find the structure of the table that you need to put in place of the `<table structure>` text in the [documentation for {{ CH }}]({{ ch.docs }}/getting-started/tutorial/#create-tables).

After enabling sharding using any of the methods below, you can send the `SELECT` and `INSERT` queries to the created distributed table, and they will be processed according to the specified configuration.

The sharding key in the examples is a random number `rand()`.

### Traditional sharding { #shard-example }

In this example, a distributed table that will be created based on `hits_v1` uses all `shards shard1, ..., shard5` in the `chcluster` cluster.

Before operating a distributed table:
1. [Connect](../operations/connect.md) to the `tutorial` database.
1. Create a table named `hits_v1` on the [MergeTree engine]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/), which will be located on all cluster hosts:

   ```sql
   CREATE TABLE tutorial.hits_v1 ON CLUSTER '{cluster}' ( <table structure> )
   ENGINE = MergeTree()
   PARTITION BY toYYYYMM(EventDate)
   ORDER BY (CounterID, EventDate, intHash32(UserID))
   SAMPLE BY intHash32(UserID)
   SETTINGS index_granularity = 8192 
   ```

To create the `hits_v1_distributed` distributed table in the cluster:
1. [Connect](../operations/connect.md) to the `tutorial` database.
1. Create a table on the [Distributed engine]({{ ch.docs }}/engines/table-engines/special/distributed/):

   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER '{cluster}' AS tutorial.hits_v1
   ENGINE = Distributed('{cluster}', tutorial, hits_v1, rand())
   ```

   Here, instead of explicitly specifying the table structure, you can use the `AS tutorial.hits_v1` expression because the `hits_v1_distributed` and `hits_v1` tables are on the same hosts in the cluster.

   When creating a distributed table, in `Distributed`, specify the cluster ID `chcluster` as the first parameter or use the `{cluster}` macro, which automatically substitutes the ID of the cluster where the `CREATE TABLE` operation is executed.

   To find out the cluster ID, [get a list of clusters in the folder](../operations/cluster-list.md#list-clusters).

### Sharding using shard groups { #shard-groups-example }

In this example:
- One `sgroup` shard group is used.
- A distributed table and the `hits_v1` underlying table are in the same `sgroup` shard group in the cluster.

Before operating a distributed table:
1. [Create](../operations/shard-groups.md#create-shard-group) the `sgroup` shard group consisting of the `shard1` and `shard2` shards in the cluster.
1. [Connect](../operations/connect.md) to the `tutorial` database.
1. Create a table named `hits_v1` on the [MergeTree engine]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/), which will use all hosts of the `sgroup` shard group in the cluster:

   ```sql
   CREATE TABLE tutorial.hits_v1 ON CLUSTER sgroup ( <table structure> )
   ENGINE = MergeTree()
   PARTITION BY toYYYYMM(EventDate)
   ORDER BY (CounterID, EventDate, intHash32(UserID))
   SAMPLE BY intHash32(UserID)
   SETTINGS index_granularity = 8192 
   ```

To create the `tutorial.hits_v1_distributed` distributed table in the cluster:
1. [Connect](../operations/connect.md) to the `tutorial` database.
1. Create a table on the [Distributed engine]({{ ch.docs }}/engines/table-engines/special/distributed/):

   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER sgroup AS tutorial.hits_v1
   ENGINE = Distributed(sgroup, tutorial, hits_v1, rand())
   ```

   Here, instead of explicitly specifying the table structure, you can use the `AS tutorial.hits_v1` expression because the `hits_v1_distributed` and `hits_v1` tables share the shard and are on the same hosts in the cluster.

### Advanced sharding using shard groups { #shard-groups-example }

In this example:
1. Two shard groups are used: `sgroup` and `sgroup_data`.
1. The distributed table is located in the `sgroup` shard group.
1. The `hits_v1` underlying table is in the `sgroup_data` shard group.

Before operating a distributed table:
1. [Create](../operations/shard-groups.md#create-shard-group) shard groups:
   - `sgroup`: Contains the `shard1` and `shard2` shards.
   - `sgroup_data`: Contains the `shard3`, `shard4` and `shard5` shards.
1. [Connect](../operations/connect.md) to the `tutorial` database.
1. Create a table named `hits_v1` on the [ReplicatedMergeTree engine]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/), which will use all hosts of the `sgroup_data` shard group in the cluster:

   ```sql
   CREATE TABLE tutorial.hits_v1 ON CLUSTER sgroup_data ( <table structure> )
   ENGINE = ReplicatedMergeTree('/tables/{shard}/hits_v1', '{replica}')
   PARTITION BY toYYYYMM(EventDate)
   ORDER BY (CounterID, EventDate, intHash32(UserID))
   SAMPLE BY intHash32(UserID)
   SETTINGS index_granularity = 8192 
   ```

   The `ReplicatedMergeTree` engine ensures fault tolerance.

To create the `tutorial.hits_v1_distributed` distributed table in the cluster:
1. [Connect](../operations/connect.md) to the `tutorial` database.
1. Create a table on the [Distributed engine]({{ ch.docs }}/engines/table-engines/special/distributed/):

   ```sql
   CREATE TABLE tutorial.hits_v1_distributed ON CLUSTER sgroup ( <table structure> )
   ENGINE = Distributed(sgroup_data, tutorial, hits_v1, rand())
   ```

   Here you need to explicitly specify the structure of the distributed table, because the `hits_v1_distributed` and `hits_v1` tables use different shards and are on different hosts.

### Health check { #sharding-test }

To check the health of the created distributed table named `tutorial.hits_v1_distributed`:
1. Load the `hits_v1` test dataset:

   ```bash
   curl https://clickhouse-datasets.{{ s3-objstorage-host }}/hits/tsv/hits_v1.tsv.xz | unxz --threads=`nproc` > hits_v1.tsv
   ```
1. Complete the table with the test data:

   ```bash
   clickhouse-client \ 
       --host <any host with a distributed table> \
       --secure \
       --port 9440 \ 
       --user <username> \
       --password <user password> \
       --database tutorial \                      
       --query "INSERT INTO tutorial.hits_v1_distributed FORMAT TSV" --max_insert_block_size=100000 < hits_v1.tsv
   ```
1. Run one or more test queries to this table. For example, you can find out the number of rows in the table:

   ```sql
   SELECT count() FROM tutorial.hits_v1_distributed
   ```

   You should receive the following response to the query:

   `8873898`.