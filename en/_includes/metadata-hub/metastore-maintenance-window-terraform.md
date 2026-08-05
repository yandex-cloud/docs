`maintenance_window`: [Maintenance window](../../metadata-hub/concepts/metastore-maintenance.md) settings, applying to both running and stopped clusters. 

* `type`: Maintenance type. The possible values include:
    * `ANYTIME`: Any time.
    * `WEEKLY`: On a schedule.
* `day`: Day of week for the `WEEKLY` type, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
* `hour`: UTC hour interval for the `WEEKLY` type, from `1` to `24`.

  > For example, `1` stands for the interval from `00:00` to `01:00`, and `5`, from `04:00` to `05:00`.
