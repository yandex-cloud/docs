`sharding`: Settings for data [sharding](../../../../../managed-clickhouse/concepts/sharding.md). You can only specify one of the sharding options:

* `columnValueHash.columnName`: Name of the table column to shard the data by. Uniform distribution between shards will depend on the hash of this column value.

* `customMapping`: Sharding by column value:

   * `columnName`: Name of the table column to shard the data by.

   * `mapping`: Mapping of column values and shards:

      * `columnValue.stringValue`: Column value.
      * `shardName`: Shard name.

* `transferId`: Data will be distributed between shards based on the transfer ID value. The parameter contains no value.

* `roundRobin`: Data will be randomly distributed between shards. Each shard will contain approximately the same amount of data. The parameter contains no value.

If no sharding option is specified, all data will be transferred to a single shard.
