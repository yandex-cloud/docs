`maintenance_window`: Maintenance window settings, applying to both running and stopped clusters. In `maintenance_window`, provide one of these two values:

* `anytime`: Maintenance takes place at any time.
* `weekly_maintenance_window`: Maintenance takes place once a week at the specified time:

    * `day`: Day of week in `DDD` format, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
    * `hour`: Hour of the day, in `HH` format. Allowed values range from `1` to `24` hours.