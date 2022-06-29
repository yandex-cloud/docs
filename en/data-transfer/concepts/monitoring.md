# Monitoring transfers

{{ data-transfer-name }} supports transfer monitoring. To track data creating a snapshot and increment processes, go to the **Monitoring** tab and use metrics.

## Increment {#increment}

* **Maximum lag on delivery, [s]** is the maximum delay time for applying changes to the target.

   *sinker.pusher.time.row_max_lag_sec* is the difference in seconds between the time when a change is detected on the source and the time when it's applied on the target. Calculated for each row. For a snapshot, the point when a change is detected on the source is the snapshot start time.

   The chart shows the maximum value for all rows in the transaction.

* **Tables sync progress, [rows]** is the progress of applying changes to the target.

   *sinker.table.rows* is the number of rows found on the target.

   The chart shows the number of rows found for each table within 15 seconds. The table name is set in the `table` tag.

## Snapshot {#snapshot}

* **Snapshot task progress (top-50 tables)** is the number of remaining rows when copying a snapshot.

   *task.snapshot.remainder.table* is counted for each table. After the snapshot is complete, all values are reset to zero. The table name is set in the `table` tag.

