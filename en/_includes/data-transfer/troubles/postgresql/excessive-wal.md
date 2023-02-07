### Excessive WAL size increase {#excessive-wal}

In the {{ PG }} source database, the size of the Write-Ahead Log (WAL) may reach up to dozens of GB due to the queries running for over five minutes. These queries block the WAL and do not allow it to move forward and reset.

You can see the WAL size has gone up when:

* The space used by the source database has increased.
* The **Read buffer size** chart in {{ data-transfer-name }} [monitoring](../../../../data-transfer/operations/monitoring.md) is rising.

**Solution:**

1. Find the query sessions running for more than five minutes:

   ```sql
   SELECT now()-xact_start, query, pid FROM pg_stat_activity
   WHERE (now()-xact_start)>'5minute'::interval AND STATE != 'idle'
   ORDER BY 1 DESC;
   ```

1. Terminate the sessions found. Make sure to avoid such queries moving forward.
