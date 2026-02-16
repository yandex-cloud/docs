# How to enable SQL query logging



## Case description {#case-description}

You need to enable SQL query logging.

## Solution {#case-resolution}

To enable query logging, make sure `pg_stat_statements` is installed. This extension adds an option to track execution plans and collect the statistics of all SQL queries run in the cluster. You must have the [`mdb_monitor` role](../../../managed-postgresql/operations/extensions/cluster-extensions.md) to use it.

You also need to check the `Auto explain sample rate=1` and `Auto explain log analyze` settings following [this guide](../../../managed-postgresql/concepts/settings-list.md#dbms-cluster-settings) and enable `Log min duration statement`. We do not recommend setting the `1 ms` value as this will keep the cluster busy with logging only.

You can enable this setting from the [management console]({{ link-console-main }}) by selecting **{{ ui-key.yacloud.mdb.cluster.overview.label_advanced-settings }}**, or by using this YC CLI command: 

```
yc managed-postgresql cluster update-config <cluster name> --set log_min_duration_statement=100
```

After that, you can view the log records, e.g., via the YC CLI: 

```
yc managed-postgresql cluster list-logs --service-type postgresql --since '2h' --until '1s' --id=YOUR-CLUSTER-ID
```