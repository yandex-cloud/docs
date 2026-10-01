### Low transfer speed {#low-speed}

​May affect _{{ dt-type-copy }}_ or _{{ dt-type-copy-repl }}_ transfers from {{ PG }} to {{ PG }}.

The possible causes may include the following:

* Write protocol.

    Under normal conditions, the transfer uses the fast `copy` protocol but switches to slow line-by-line writes if there are batch write conflicts. The more write conflicts, the lower the transfer speed.

    **Solution**: Set the target endpoint's cleanup policy type to `Drop` and exclude other writing processes.

* Parallel table reading.

    Parallel reading is only available for tables containing a primary key. When using a key of the [`serial` type](https://www.postgresql.org/docs/current/datatype-numeric.html#DATATYPE-SERIAL), parts of tables are read in ranges. Other types of keys allow you to distribute tables evenly matching a special algorithm.

    **Solution**: Set up [parallel copy](../../../../data-transfer/concepts/sharded.md) and [reactivate the transfer](../../../../data-transfer/operations/transfer.md#activate).
