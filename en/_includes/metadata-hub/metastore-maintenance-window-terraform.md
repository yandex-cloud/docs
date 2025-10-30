`maintenance_window`: Maintenance window settings, including those for disabled clusters. 

* `type`: Maintenance type. The possible values include:
    * `ANYTIME`: Any time.
    * `WEEKLY`: On a schedule.
* `day`: Day of week for the `WEEKLY` type, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
* `hour`: UTC hour for the `WEEKLY` type, from `1` to `24`.
