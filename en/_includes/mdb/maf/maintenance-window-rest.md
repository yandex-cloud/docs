`maintenanceWindow`: [Maintenance window](../../../managed-airflow/concepts/maintenance.md) settings (including for disabled clusters). In `maintenanceWindow`, provide one of the two parameters:

  * `anytime`: Maintenance can take place at any time.
  * `weeklyMaintenanceWindow`: Maintenance takes place once a week at the specified time:

    * `day`: Day of week in `DDD` format: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
    * `hour`: Time of day (UTC) in `HH` format, from `1` to `24`.