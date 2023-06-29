# Creating scheduled disk snapshots

You can configure automatic [disk snapshot](snapshot.md) creation based on a _schedule_.

In the schedule, you specify:

* Disks for which the snapshots will be created. One schedule can include multiple disks, and one disk can be added to multiple schedules.
* Frequency of snapshot creation by hour, day, week, or [cron expression](#cron). The time is provided for the [UTC](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00) time zone.
* [Snapshot retention](#retention) settings.
* Scheduled snapshot description and [labels](../../resource-manager/concepts/labels.md) (you can only use the API to add them to the schedule settings).

{% note info %}

{% include [snapshot-schedule-delay](../../_includes/compute/snapshot-schedule-delay.md) %}

{% endnote %}

Snapshots are created in the same folder as the schedule, even if the schedule has disks from other folders.

A single snapshot can only be created for one disk at a time. All other schedules for the disk in question are ignored until a snapshot for this disk is created.

{% include [snapshot-disk-types](../../_includes/compute/snapshot-disk-types.md) %}

A [quota](limits.md#compute-quotas), which can be increased, applies to the number of schedules per cloud. Fixed [limits](limits.md#compute-limits-snapshot-schedule) apply to the number of disks in a schedule and the number of schedules for a disk.

Schedules can be used free of charge. You only pay for storing the snapshots. For more information, see [{#T}](../pricing.md).


## Cron expressions {#cron}

You can specify a snapshot schedule using [cron expressions](https://{{ lang }}.wikipedia.org/wiki/Cron), which include five [fields](#cron-fields): `Minutes Hours Day-of-month Month Day-of-week`. You can also use [special expressions](#cron-predefined), e.g., to create snapshots every hour or every day.


### Possible field values {#cron-fields}

| Field <br>name | Acceptable <br>values | Supported<br>[special <br>characters](#cron-special-characters) |
|----|----|----|
| `Minutes` | `0`-`59` | `,`, `-`, `*`, `/` |
| `Hours` | `0`-`23` (UTC) | `,`, `-`, `*`, `/` |
| `Day of month` | `1`-`31` | `,`, `-`, `*`, `?`, `/` |
| `Month` | `1`-`12`, <br>`JAN`-`DEC` | `,`, `-`, `*`, `/` |
| `Day of week` | `1`-`7`, <br>`MON`-`SUN` | `,`, `-`, `*`, `?`, `/` |

{% note info %}

The names of months and days are case-insensitive, i.e., `MON` is the same as `mon`.

{% endnote %}


### Special characters {#cron-special-characters}

You can use the following special characters in cron expressions:

* `*`: Select all values in the field.

  > `*` character in the `Hours` field: Snapshots are created every hour.

* `?`: Select any field value. You cannot specify `Day of month` and `Day of week` at the same time. If you entered a value or `*` in one of these fields, enter `?`. in the other.

  > `10` in `Day of month` and `?` in `Day of week`: Snapshots are created every tenth day of the month.

* `-`: Select a range of values.

  > The `10-12` range in `Hours`: Snapshots are created at 10 a.m., 11 a.m., and 12 p.m.

* `,`: Select multiple values.

  > `MON, WED, FRI` in the `Day of week` field: Snapshots are created on Monday, Wednesday, and Friday.

* `/`: Increment the value.

  > `2/6` in `Hours`: Snapshots are created at 2 a.m., 8 a.m., 2 p.m., and 8 p.m.


### Examples of cron expressions {#cron-examples}

| Cron expression | Description |
|----|----|
| `0 * ? * *` | Snapshots are created at the start of every hour. |
| `15 10 ? * *` | Snapshots are created every day at 10:15 a.m. |
| `0 9,18 ? * 1-5` | Snapshots are created every weekday at 9 a.m. and 9 p.m. |


### Special expressions {#cron-predefined}

| Cron expression | Description | The same as |
| --- | --- | --- |
| `@hourly` | Snapshots are created at the start of every hour. | `0 * ? * *` |
| `@daily`<br>`@midnight` | Snapshots are created every day at midnight. | `0 0 ? * *` |
| `@weekly` | Snapshots are created every Sunday at midnight. | `0 0 * * SUN` |
| `@monthly` | Snapshots are created every first day of the month at midnight. | `0 0 1 * *` |
| `@yearly`<br>`@annually` | Snapshots are created every year on January 1 at midnight. | `0 0 1 1 *` |


## Storing snapshots {#retention}

With schedules, you can set and configure a _snapshot retention policy_. For each disk included in a schedule, you can store:

* All created scheduled snapshots.
* Only the last few snapshots. The oldest snapshots created on schedule are automatically deleted once the specified number is exceeded. For example, if you want to keep only the last five snapshots, the first snapshot is deleted after the sixth one is created, the second is deleted after the seventh one is created, etc.
* Only the snapshots younger than a certain age, e.g., those created for the last few days. The oldest snapshots created on schedule are automatically deleted once the specified age is reached.

The retention policy applies to all disks in a schedule.

Snapshots are deleted only while the schedule is at the `ACTIVE` [status](#statuses).


## Snapshot names {#names}

For a scheduled snapshot, a name up to 63 characters long is generated. The name consists of the following items separated with underscores:

* Name of a virtual machine the disk is attached to (up to 24 characters), or the `unattached` line, if the disk is not attached to any VM.
* Disk name (up 20 characters).
* Snapshot creation date and time (UTC) in `YYYYMMDDhhmm` format (year, month, day, hour, and minute).
* Line consisting of four random alphanumeric characters.

> For example, if the `test-disk-with-a-long-name` disk is attached to the `test-vm` VM, its scheduled snapshot created on September 1, 2022 at 03:30 p.m. UTC will have the following name:
>
> ```
> test-vm_test-disk-with-a-lon_202209011530_pd2k
> ```

## Schedule statuses {#statuses}

* `CREATING`: Schedule is being created.
* `ACTIVE`: Schedule is on: based on it, new disk snapshots are created and old ones are deleted (if the respective parameter has been specified in [snapshot retention](#retention)).
* `UPDATING`: Changes are being made to the schedule settings or the list of attached disks.
* `INACTIVE`: Schedule has been paused, snapshots are not created or deleted.
* `DELETING`: Schedule is being deleted.

All snapshot creation or deletion operations that started prior to changing, pausing, or deleting the schedule will be completed.

#### See also {#see-also}

* [Guides on disk snapshots and schedules](../operations/#snapshots)