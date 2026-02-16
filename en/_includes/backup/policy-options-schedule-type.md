* `{{ ui-key.yacloud.backup.policy-form.value_schedule-type-fixed }}`: Specify the backup frequency:

    * `{{ ui-key.yacloud.backup.policy-form.value_periodicity-daily }}`. Either once a day at a specified time or several times a day at a particular interval within the specified time period.
    * `{{ ui-key.yacloud.backup.policy-form.value_periodicity-weekly }}`. Select days of the week and time for backups on those days.
    * `{{ ui-key.yacloud.backup.policy-form.value_periodicity-monthly }}`. Specify months, day of the month, and time for backups.

    For incremental backups, you can enable **{{ ui-key.yacloud.backup.policy-form.value_weekly-full-copy }}** and select the day of the week for a full backup. On the selected day, a full backup will be created instead of an incremental one.

* `{{ ui-key.yacloud.backup.policy-form.value_schedule-type-interval }}`: Specify the interval, in hours or days, between the end of the previous backup and the start of the new one.

Backups are created based on the VM's or {{ baremetal-name }} server's local time. There may be a slight delay in the schedule depending on the current service load.