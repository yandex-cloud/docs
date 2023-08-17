### Low transfer speed {#low-speed}

_{{ dt-type-copy }}_ or _{{ dt-type-copy-repl }}_ transfers from {{ PG }} to {{ PG }} may slow down.

Possible cause:

* Write protocol.

   Under normal operation, a transfer is performed via the fast `copy` protocol. However, if there's a batch write conflict, it switches to slow line-by-line writes. The more write conflicts, the lower the transfer speed.

   **Solution:** set the target endpoint's cleanup policy type to `Drop` and exclude other writing processes.

* Parallel table reading.

   Parallel reading is only available for tables that contain a primary key in [serial mode](https://www.postgresql.org/docs/current/datatype-numeric.html#DATATYPE-SERIAL).

   **Solution:** Set up [parallel copy](../../../../data-transfer/concepts/sharded.md) and [reactivate the transfer](../../../../data-transfer/operations/transfer.md#activate).
