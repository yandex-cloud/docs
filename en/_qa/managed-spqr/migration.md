#### Can I shard by a composite key? {#composite-sharding-key}

Yes. Do it by creating a composite key:

```sql
CREATE DISTRIBUTION <sharding_rule_name> COLUMN TYPES integer, varchar;
ALTER DISTRIBUTION <sharding_rule_name> ATTACH RELATION orders DISTRIBUTION KEY user_id, order_date;
```

Learn more about composite sharding keys in [this SPQR guide](https://docs.pg-sharding.tech/sharding/composite_keys).

#### Can I create a default shard for unbound keys? {#default-shard-for-unbound-keys}

Yes. Do it by running this command:

```sql
ALTER DISTRIBUTION <sharding_rule_name> ADD DEFAULT SHARD <shard_name>;
```

Learn more about default shards in [this SPQR guide](https://docs.pg-sharding.tech/sharding/default_shard).

#### How do I add a new shard and rebalance the data? {#how-to-add-new-shard}

1. [Create a new shard](../../managed-spqr/operations/shards.md#create-shard).
1. Use the `SYNC REFERENCE TABLES` command to copy reference tables.
1. Redistribute the key ranges. Use these commands:
    * `SPLIT KEY RANGE` to split the key range.
    * `REDISTRIBUTE KEY RANGE` to automatically migrate data.

#### How does data rebalancing work when adding a new shard? {#data-rebalancing-for-new-shard}

When adding a new shard, you need to start manual data migration using the `REDISTRIBUTE KEY RANGE` command. In which case {{ SPQR }} moves small data ranges to minimize the cluster being unavailable for writes.

#### How do I load big data volumes? {#how-to-upload-big-chunks-of-data}

There are two options for loading big data volumes:

* `COPY` with the `/* __spqr__allow_multishard: true */` virtual parameter.

    For example, for loading from a CSV file:

    ```sql
    COPY <table_name> FROM 'data.csv' WITH DELIMITER ',' /* __spqr__allow_multishard: true */;
    ```

    {% note warning %}

    The use of `COPY` can cause a high load on the router. If you are using `COPY` on a regular basis, we recommend allocating a separate router for the task.

    {% endnote %}

* Batch insert of several table rows using the `/* __spqr__engine_v2: true */` virtual parameter. In this scenario, the router analyzes each row, determines the target shard based on the sharding key, and converts the query into separate `INSERT` commands for each shard.

    For example, the following command:

    ```sql
    INSERT INTO users (id, name) VALUES
      (1, 'Alice'),      -- send to shard sh1
      (100, 'Bob'),      -- send to shard sh2
      (2, 'Charlie')     -- send to shard sh1
    /* __spqr__engine_v2: true */;
    -- NOTICE: send query to shard(s) : sh1,sh2
    ```

    will be converted to:

    * `INSERT INTO users (id, name) VALUES (1, 'Alice'), (2, 'Charlie');` for shard `sh1`.
    * `INSERT INTO users (id, name) VALUES (100, 'Bob');` for shard `sh2`.

You can set virtual parameters with comments in SQL or via `SET`.

Learn more about inserting big data volumes in [this SPQR guide](https://docs.pg-sharding.tech/sharding/bulk).

#### How can I speed up migration of big data volumes? {#how-to-improve-migration-of-big-chunks-of-data}

* Increase chunk size.
* Make sure each shard has an index based on the sharding key.
* Avoid running parallel writes during migration.

#### What happens if there is a failure during data migration? {#data-migration-failure}
{{ SPQR }} ensures range-level atomicity. If there is a failure, data can temporarily exist on both shards. The operation will be either canceled or resumed following recovery.

#### How do I rename a table while keeping it available? {#how-to-rename-table-and-keep-it-available}

Run the `ALTER TABLE` sequence within a single transaction. To enable this feature, use the `/* __spqr__multishard_ddl: true */` virtual parameter.

```sql
ALTER TABLE ... /* __spqr__multishard_ddl: true */;
```

{% note warning}

The operation is non-transactional. Be careful when renaming tables.

{% endnote %}

You can set virtual parameters with comments in SQL or via `SET`.
