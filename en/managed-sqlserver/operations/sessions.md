# Managing user sessions

You can [request](#get) a list of active user [sessions](https://docs.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-sessions-transact-sql) in a {{ MS }} cluster and forcibly [terminate](#kill) any of them.

## Getting a list of sessions {#get}

To get a list of active user sessions:

1. [Connect](connect.md) to the database with an account with the `DB_OWNER` or `DB_SECURITYADMIN` role.

1. Run the query:

    ```sql
    USE msdb;
    EXECUTE dbo.mdb_sessions_get;
    ```

   The `dbo.mdb_sessions_get` procedure accepts the following parameters:

   | Parameter | Default<br>value | Description |
   | :-------: | :---------: | :--------------------- |
   | `session_id` | `Null` | Filter by session ID. If `NULL`, all active sessions are returned. |
   | `detail_level` | `3` | The level of detail. Each next level includes all data from the previous ones.<br/><ul><li>`1`: Session data from the `sys.dm_exec_sessions` system view.</li><li>`2`: Information about active requests from the `sys.dm_exec_requests` view.</li><li>`3`: Information about text and query plans from the `sys.dm_exec_sql_text` and `sys.dm_exec_query_plan` views.</li><li>`4`: Information about query memory grants from the `sys.dm_exec_query_memory_grants` view.</li> |
   | `order_by` | `1` | Sorts the rows to be returned by column number. |
   | `order_by_desc` | `0` | When the value is `1`, sorts the rows to be returned in descending order. Can be used together with `order_by`. |
   | `show_session_wait_stats` | `0` | When the value is `1`, session wait statistics from the `sys.dm_exec_session_wait_stats` view is returned in a separate table. |
   | `show_version` | `0` | When the value is `1`, the procedure version is returned. Other parameters are ignored in this case. |

1. You'll get a table with a list of active sessions and their parameters:
   1. Session data from the `sys.dm_exec_sessions` view:
      1. `database_name`: The name of the database that the session queries.
      1. `session_id`: Session ID.
      1. `login_time`: Session login time.
      1. `host_name`: The host name specified in the session.
      1. `program_name`: The name of the client program that initiated the session.
      1. `login_name`: The name of the account that the session is running under.
      1. `status`: Session status:
         * `Running`: One or more queries are being executed.
         * `Sleeping`: Queries are not running.
         * `Dormant`: The session was reset for connection pooling and is in the pre-login status.
         * `Preconnect`: The session is in the Resource Governor classifier.
      1. `session_cpu_time`: CPU time used by the session (in milliseconds).
      1. `last_request_start_time`: The time when the last request was received.
      1. `session_database_id`: The ID of the database that the session queries.
      1. `open_transaction_count`: The number of open transactions per session.
   1. Information about active requests from the `sys.dm_exec_requests` view:
      1. `request_start_time`: The time when the request was received.
      1. `request_status`: Request status:
         * `Background`: Running in the background.
         * `Running`: In progress.
         * `Runnable`: Ready to run.
         * `Sleeping`: Waiting for a command.
         * `Suspended`: On hold.
      1. `request_command`: The type of the currently running command.
      1. `blocking_session_id`: The ID of the session blocking the request.
      1. `wait_type`: The [type of wait](https://docs.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql?#types-of-waits) for the blocked request.
      1. `wait_time`: The waiting time when blocking the request (in milliseconds).
      1. `last_wait_type`: The [type of the last wait](https://docs.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql?#types-of-waits) if the request has previously been blocked.
      1. `wait_resource`: The resource that the request is waiting for when blocked.
   1. Information about text and query plans from the `sys.dm_exec_sql_text` and `sys.dm_exec_query_plan` views:
      1. `object_id`: The ID of an object (such as a stored procedure or function) for this query plan.
      1. `query_text`: SQL query text (`NULL` for encrypted objects).
      1. `query_plan`: The compile-time `Showplan` representation of the query execution plan.

{% note info %}

The `dbo.mdb_sessions_get` procedure doesn't return sessions that:

* Are run by privileged system users.
* Query databases where the user calling the procedure has no `DB_OWNER` or `DB_SECURITYADMIN` role.

{% endnote %}

## Killing a session {#kill}

To abort an active user session:

1. [Connect](connect.md) to the database with an account with the `DB_OWNER` or `DB_SECURITYADMIN` role.

1. Run the query:

    ```sql
    USE msdb;
    EXECUTE dbo.mdb_sessions_kill <session ID>;
    ```

   To find out the ID of the session, execute the [procedure](#get) `dbo.mdb_sessions_get`.

{% note info %}

The `dbo.mdb_sessions_kill` procedure doesn't abort sessions that:

* Are run by privileged system users.
* Query databases where the user calling the procedure has no `DB_OWNER` or `DB_SECURITYADMIN` role.

{% endnote %}

