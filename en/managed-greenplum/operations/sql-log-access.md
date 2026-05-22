---
title: Reading {{ mgp-full-name }} cluster logs via SQL
description: How to access Greenplum logs via SQL using the mdb_toolkit.gp_log view.
keywords:
  - greenplum logs sql
  - Greenplum external table logs
  - mdb_toolkit gp_log
  - Viewing Greenplum SQL logs
---

# Reading cluster logs via SQL

{{ mgp-name }} provides direct access to cluster logs via SQL queries. This allows you to analyze logs using standard SQL tools: filter, aggregate, and join data with other tables.

{% note info %}

This feature is available for clusters based on {{ GP }} version 6.29 or higher, as well as Apache Cloudberry™.

{% endnote %}

## How it works {#how-it-works}

The system automatically creates a view named `gp_log` is in the `mdb_toolkit` schema of the `postgres` database. This view aggregates logs from the master node and all primary segments of the cluster. The view automatically updates during cluster topology changes, such as expansion, recovery from a backup, or master failover.

## Getting started {#before-you-begin}

To read logs via SQL, the user must have the `mdb_log_reader` role. This role can be granted by the cluster administrator (`gpadmin` or a user with `SUPERUSER` privileges).

```sql
GRANT mdb_log_reader TO <username>;
```

## Reading logs {#read-logs}

Connect to the `postgres` database and query the `mdb_toolkit.gp_log` view:

```sql
SELECT * FROM mdb_toolkit.gp_log
ORDER BY logtime DESC
LIMIT 100;
```

### Filtering by time {#filter-by-time}

```sql
SELECT logtime, logseverity, logmessage, logdatabase, loguser
FROM mdb_toolkit.gp_log
WHERE logtime >= NOW() - INTERVAL '1 hour'
ORDER BY logtime DESC;
```

### Searching for errors {#filter-errors}

```sql
SELECT logtime, logseverity, logmessage, logdatabase, loguser, loghost
FROM mdb_toolkit.gp_log
WHERE logseverity IN ('ERROR', 'FATAL', 'PANIC')
  AND logtime >= NOW() - INTERVAL '24 hours'
ORDER BY logtime DESC;
```

### Searching for slow queries {#slow-queries}

```sql
SELECT logtime, logdatabase, loguser, logmessage
FROM mdb_toolkit.gp_log
WHERE logmessage LIKE '%duration:%'
  AND logtime >= NOW() - INTERVAL '1 hour'
ORDER BY logtime DESC;
```

### Filtering by database {#filter-by-database}

```sql
SELECT logtime, logseverity, logmessage
FROM mdb_toolkit.gp_log
WHERE logdatabase = '<DB_name>'
  AND logtime >= NOW() - INTERVAL '6 hours'
ORDER BY logtime DESC;
```

## View structure {#schema}

The `mdb_toolkit.gp_log` view contains the following columns:

| Column | Type | Description |
|---|---|---|
| `logtime` | `timestamp with time zone` | Event time |
| `loguser` | `text` | User name |
| `logdatabase` | `text` | Database name |
| `logpid` | `text` | Process ID |
| `logthread` | `text` | Thread ID |
| `loghost` | `text` | Host name (master or segment) |
| `logport` | `text` | Port |
| `logsessiontime` | `timestamp with time zone` | Session start time |
| `logtransaction` | `int` | Transaction ID |
| `logsession` | `text` | Session ID |
| `logcmdcount` | `text` | Session command counter |
| `logsegment` | `text` | Segment ID |
| `logslice` | `text` | Slice ID |
| `logdistxact` | `text` | Distributed transaction ID |
| `loglocalxact` | `text` | Local transaction ID |
| `logsubxact` | `text` | Nested transaction ID |
| `logseverity` | `text` | Severity level (`DEBUG`, `INFO`, `WARNING`, `ERROR`, `FATAL`, `PANIC`) |
| `logstate` | `text` | SQLSTATE status code |
| `logmessage` | `text` | Message text |
| `logdetail` | `text` | Detailed error description |
| `loghint` | `text` | Error troubleshooting tip |
| `logquery` | `text` | SQL query text |
| `logquerypos` | `int` | Position in the query |
| `logcontext` | `text` | Execution context |
| `logdebug` | `text` | Debug info |
| `logcursorpos` | `int` | Cursor position |
| `logfunction` | `text` | Function name |
| `logfile` | `text` | Source file name |
| `logline` | `int` | Row number in the source file |
| `logstack` | `text` | Stack tracing |

## Specifics and limitations {#limitations}

- **Log storage depth**: CSV logs on cluster nodes are rotated daily. By default, the system retains the 10 most recent rotations, i.e., at most the last 10 days. Queries to older data will return an empty result.

- **Sensitive data masking**:  In the `logmessage`, `logdetail`, `logquery`, and `logdebug` columns, passwords from `CREATE/ALTER ROLE ... PASSWORD` commands and external table URLs (PXF, S3, gpfdist) are automatically masked. This is done to protect credentials.

- **`postgres` database only**: The `mdb_toolkit.gp_log` view is available only in the `postgres`database. To access it, connect to that database.

- **Cluster load**: Queries without filtering by `logtime` read all available logs from all cluster nodes, which may lead to high cluster load. We recommend always specifying a time range in the `WHERE` clause.

- **Parallel reading**: Data is read in parallel from all primary segments and the master, so the rows may be unordered unless you use `ORDER BY`.

- **Topology relevance**: When changes are made to the cluster topology (expansion, recovery from a backup), the view updates automatically within a few minutes.

## Examples of analytical queries {#analytics}

### Number of errors for each database over the last 24 hours {#errors-by-database}

```sql
SELECT logdatabase, logseverity, COUNT(*) AS cnt
FROM mdb_toolkit.gp_log
WHERE logseverity IN ('ERROR', 'FATAL', 'PANIC')
  AND logtime >= NOW() - INTERVAL '24 hours'
GROUP BY logdatabase, logseverity
ORDER BY cnt DESC;
```

### User activity by hour {#user-activity}

```sql
SELECT DATE_TRUNC('hour', logtime) AS hour,
       loguser,
       COUNT(*) AS events
FROM mdb_toolkit.gp_log
WHERE logtime >= NOW() - INTERVAL '7 days'
  AND logdatabase = '<DB_name>'
GROUP BY 1, 2
ORDER BY 1 DESC, 3 DESC;
```

### Top ten most frequent error messages {#top-errors}

```sql
SELECT logmessage, COUNT(*) AS cnt
FROM mdb_toolkit.gp_log
WHERE logseverity = 'ERROR'
  AND logtime >= NOW() - INTERVAL '7 days'
GROUP BY logmessage
ORDER BY cnt DESC
LIMIT 10;
```

## See also {#see-also}

- [{#T}](cluster-logs.md)
- [{#T}](mgp-to-cloud-logging.md)

