### Couldn't create a replication slot at the activation step {#lock-replication}

In the beginning of the transfer, one or more [replication slots]({{ pg-docs }}/logicaldecoding-explanation.html#LOGICALDECODING-REPLICATION-SLOTS) are created in the source database. The database objects are locked at this point. If some object is locked by another transaction, this results in a competing lock, which will terminate the transfer with an error.

**Solution:**

1. Get the `PID` of the process that competes for locks with the transfer:

   ```sql
   /* Get PID of the transfer */
   SELECT active_pid
     FROM pg_replication_slots
     WHERE slot_name = '<transfer ID>';

   /* search the PID of the locking process */
   SELECT pid, pg_blocking_pids(pid) as blocked_by
     FROM pg_stat_activity
     WHERE cardinality(pg_blocking_pids(pid)) > 0;
   ```

   ```text
           pid      | blocked_by
   -----------------+-------------------
    <transfer PID> | {<locking transaction PID>}
   (1 row)
   ```

1. Look up the locking query:

   ```sql
   SELECT query, usename
     FROM pg_stat_activity
     WHERE pid = <locking transaction PID>;
   ```

1. (Optional) Stop the transaction by the command:

   ```sql
   SELECT pg_terminate_backend(<locking transaction PID>);
   ```

1. [Reactivate the transfer](../../../../data-transfer/operations/transfer.md#activate).
