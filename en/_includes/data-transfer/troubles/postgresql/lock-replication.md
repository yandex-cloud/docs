### Unable to create replication slot during activation phase {#lock-replication}

At the beginning of the transfer, one or more [replication slots]({{ pg-docs }}/logicaldecoding-explanation.html#LOGICALDECODING-REPLICATION-SLOTS) are created in the source database. The database objects are locked at this point. If some object is locked by another transaction, this results in a competing lock, which will terminate the transfer with an error.

**Solution:**

1. Find the process competing for locks with the transfer:

   ```sql
   SELECT
     activity.pid,
     activity.usename,
     activity.query,
     blocking.pid AS blocking_id,
     blocking.query AS blocking_query
   FROM
     pg_stat_activity AS activity
     JOIN pg_stat_activity AS blocking ON blocking.pid = ANY(
       pg_blocking_pids(activity.pid)
     )
   WHERE
     activity.query like '%<transfer_ID>%';
   ```

   You can get the transfer ID with the [list of transfers in the folder](../../../../data-transfer/operations/transfer.md#list).

   Response:

   ```text
          pid      |      usename       |      query      |         blocking_id          |    blocking_query
   ----------------+--------------------+-----------------+------------------------------+----------------------
   <transfer_PID> | <username> | <request_text> | <blocking_transaction_PID> | <blocking_request>
   (1 row)
   ```

1. Stop the transaction using this command:

   ```sql
   SELECT pg_terminate_backend(<blocking_transaction_PID>);
   ```

1. [Reactivate the transfer](../../../../data-transfer/operations/transfer.md#activate).
