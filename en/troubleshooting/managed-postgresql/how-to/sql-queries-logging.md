# How to enable SQL query logging



## Scenario description {#case-description}

You need to enable SQL query logging.

## Solution {#case-resolution}

To enable query logging, make sure that the `pg_stat_statements` extension is installed. This extension adds the option to track execution plans and collect the statistics of all SQL queries run in the cluster. [The `mdb_monitor` role](../../../managed-postgresql/operations/extensions/cluster-extensions) is required to use the extension.

Additionally, check the `Auto explain sample rate=1` and `Auto explain log analyze` settings as shown in the [guide](../../../managed-postgresql/concepts/settings-list#dbms-cluster-settings).

Next, enable the `Log min duration statement` parameter. We do not recommend setting the value to `1 ms` as this would keep the cluster busy with log recording only.

You can enable this parameter via the UI, on the cluster settings page, using **DBMS settings** or this YC CLI command:
```yc managed-postgresql cluster update-config <имя кластера> --set log_min_duration_statement=100
```

After that, you can view the log records, for example, via the YC CLI:
```yc managed-postgresql cluster list-logs --service-type postgresql --since '2h' --until '1s' --id=YOUR-CLUSTER-ID
```

