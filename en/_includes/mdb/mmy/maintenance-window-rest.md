* `maintenanceWindow`: [Maintenance window](../../../managed-mysql/concepts/maintenance.md) settings (including for disabled clusters). Provide one of these parameters:

  * `anytime` (default): Maintenance can take place at any time.
  * `weeklyMaintenanceWindow`: Scheduled maintenance:

    * `day`: Day of week, in `DDD` format. Valid values: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.
    * `hour`: Time of day (UTC) in `HH` format. The valid values range from `1` to `24`.