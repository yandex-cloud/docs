### Excessive WAL size increase {#excessive-wal}

The WAL may grow in size during the {{ dt-type-copy-repl }} and {{ dt-type-repl }} transfers. You can be alerted to a WAL size increase by the following:

* Increased used space on the source cluster disk (**Disk usage on primary** chart).
* Increased size of the source cluster WAL files (**Total size of WAL files** chart).
* Growth on the **[Source buffer size](../../../../data-transfer/operations/monitoring.md#publisher.consumer.log_usage_bytes)** or **[Maximum data transfer delay](../../../../data-transfer/operations/monitoring.md#sinker.pusher.time.row_max_lag_sec)** diagrams in {{ data-transfer-name }} monitoring.

**Solution:**

You actions should depend on the current transfer stage:

   Transfer stage | Cause of WAL increase | Recommended action                                                                            
   --------|-----|---------------------------------------------------------
   Copying | WAL increase is expected.  |  Wait for the transfer to enter the replication stage.                          
   Replication | The source database has long transactions (over 5 minutes). Such requests cause the WAL to grow and interfere with its archiving. | Wait until the transaction ends or terminate the sessions manually. You can locate long transaction using the following query:<br>```SELECT pid, now() - pg_stat_activity.query_start```<br>```AS duration, query, state```<br>```FROM pg_stat_activity```<br>```WHERE (now() - pg_stat_activity.query_start) > interval '5 minutes'```<br>```AND state != 'idle';```
   Replication | There is a large changefeed on the source that the transfer fails to process. | Check the transfer resource utilization. If all the resources are utilized fully, increase them, reduce the number of threads, or split one transfer into multiple transfers. [Check](../../../../data-transfer/metrics.md) the source and target resource utilization. If all resources are utilized fully, increase them.
   Replication | There were changes in the transferred objects schema on the source (table fields added or removed, types changed, etc.). Data stopped being written to the target due to schema mismatch. | Change the schema in the same way on the target manually.                                                                                                                                               

