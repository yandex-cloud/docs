# Service users in {{ mch-name }}

Creating a new {{ CH }} cluster automatically creates service users to administer and monitor the service.

### _admin {#admin}

User to administer and manage the {{ CH }} cluster: create databases, users, and housekeeping tables.

### _backup_admin {#backup_admin}

User to create backups and restore data from them.

### _monitor, _sli {#monitor_sli}

Users to health check the {{ CH }} cluster and its subsystems.

### _metrics {#metrics}

User to calculate the outbound metrics to {{ monitoring-full-name }}.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
