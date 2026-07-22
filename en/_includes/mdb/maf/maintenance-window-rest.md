`maintenanceWindow`: [Maintenance window](../../../managed-airflow/concepts/maintenance.md) settings, applying to both running and stopped clusters. Provide one of these two properties:

  * `anytime`: Maintenance can take place at any time.
  * `weeklyMaintenanceWindow`: Maintenance takes place once a week at the specified time:

    * `day`: Day of week, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
    * `hour`: UTC hour interval, from `1` to `24`.

      > For example, `1` stands for the interval from `00:00` to `01:00`, and `5`, from `04:00` to `05:00`.