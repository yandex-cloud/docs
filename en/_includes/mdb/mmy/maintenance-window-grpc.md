* `maintenance_window`: [Maintenance window](../../../managed-mysql/concepts/maintenance.md) settings (including for disabled clusters). Provide one of these parameters:

  * `anytime`: Maintenance takes place at any time. This is the default value.
  * `weeklyMaintenanceWindow`: Scheduled maintenance:

    * `day`: Day of week (`MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`).
    * `hour`: UTC hour interval, from `1` to `24`.

      > For example, `1` stands for the interval from `00:00` to `01:00`, and `5`, from `04:00` to `05:00`.