# Managed Service for MySQL cluster switches to Read Only due to free space getting quickly consumed by temporary files

## Issue description {#issue-description}

In your Managed Service for MySQL cluster, you see the error:

```
The MySQL server is running with the --read-only option
so it cannot execute statement
```

When you expand the storage, your free space continues to quickly fill up, and the cluster switches to Read Only again.

## Solution {#issue-resolution}

The InnoDB engine used in the Managed Service for MySQL cluster, stores third-party connection data in [temporary tables](https://dev.mysql.com/doc/refman/8.0/en/innodb-temporary-tablespace.html). Temporary table data is stored in the cluster's disk storage.

Check the logs of your application connecting to the database for anomalies. To delete temporary files from the cluster storage, you can disconnect and then reconnect your application to the cluster, terminating all connections, or restart the cluster.
