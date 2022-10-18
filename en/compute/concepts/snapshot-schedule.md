# Creating scheduled disk snapshots

You can configure automatic _scheduled_ creation of [disk snapshots](snapshot.md).

The schedule describes:

* Disks for which the snapshots will be created. One schedule can include several disks and one disk can be added to several schedules.
* Frequency of snapshot creation by hour, day, week, or [cron expression](#cron). The time is written in the [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00) time zone.
* [Snapshot retention](#retention) settings.

{% note info %}

{% include [snapshot-schedule-delay](../../_includes/compute/snapshot-schedule-delay.md) %}

{% endnote %}

Snapshots are created in the same folder as the schedule, even if disks from other folders are added to the schedule.

A single snapshot can be created for one disk at a time. All other schedules for a given disk are ignored until a snapshot for this disk is created.

A [quota](limits.md#compute-quotas), which can be increased, applies to the number of schedules in one cloud. Fixed [limits](limits.md#compute-limits-snapshot-schedule) apply to the number of disks in a schedule and number of schedules for a disk.

Schedules can be used free of charge. You only pay for retaining the snapshots. For more information, see [{#T}](../pricing.md).


## Cron expressions {#cron}

You can set the frequency of creating scheduled snapshots using [cron expressions](https://{{ lang }}.wikipedia.org/wiki/Cron), which include five [fields](#cron-fields): `Minutes Hours Day-of-month Month Day-of-week`. [Special expressions](#cron-predefined) are also supported - for example, to create snapshots every hour or every day.


### Possible field values {#cron-fields}

| Field <br>name. | Acceptable <br>values | [Special <br>characters](#cron-special-characters) <br>supported |
|----|----|----|
| `Minutes` | `0`–`59` | `,`, `-`, `*`, `/` |
| `Hours` | `0`–`23` (UTC+0) | `,`, `-`, `*`, `/` |
| `Day of month` | `1`–`31` | `,`, `-`, `*`, `?`, `/` |
| `Month` | `1`–`12`, <br>`JAN`–`DEC` | `,`, `-`, `*`, `/` |
| `Day of week` | `1`–`7`, <br>`MON`–`SUN` | `,`, `-`, `*`, `?`, `/` |

{% note info %}

The names of months and days of the week are not case-insensitive: `MON` is the same as `mon`.

{% endnote %}


### Special characters {#cron-special-characters}

You can use the following special characters in cron expressions:

* `*` — Select all values in the field.

   > `*` character in the `Hours` field: Snapshots are created every hour.

* `?` — Select any field value. You can't fill `Day of month` and `Day of week` at the same time. If you entered a value or `*` in one of these fields, enter `?`. in the other field.

   > `10` in `Day of month` and `?` in `Day of week`: Snapshots are created every 10th day of the month.

* `-` — Select a range of values.

   > The `10-12` range in `Hours`: Snapshots are created at 10 AM, 11 AM, and noon.

* `,` — Select multiple values.

   > `MON, WED, FRI` in the `Day of week` field: Snapshots are created on Monday, Wednesday, and Friday.

* `/` — Increment the value.

   > `2/6` in `Hours`: Snapshots are created at 2 AM, 8 AM, 2 PM, and 8 PM.


### Examples of cron expressions {#cron-examples}

| Cron expression | Description |
|----|----|
| `0 * ? * *` | Snapshots are created at the start of every hour. |
| `15 10 ? * *` | Snapshots are created every day at 10:15 AM. |
| `0 9,18 ? * 1-5` | Snapshots are created every weekday at 09:00 AM and 09:00 PM. |


### Special expressions {#cron-predefined}

| Cron expression | Description | The same as |
| --- | --- | --- |
| `@hourly` | Snapshots are created at the start of every hour. | `0 * ? * *` |
| `@daily`<br>`@midnight` | Snapshots are created every day at midnight. | `0 0 ? * *` |
| `@weekly` | Snapshots are created every Sunday at midnight. | `0 0 * * SUN` |
| `@monthly` | Snapshots are created every 1st day of the month at midnight. | `0 0 1 * *` |
| `@yearly`<br>`@annually` | Snapshots are created every year on January 1 at midnight. | `0 0 1 1 *` |


## Retaining snapshots {#retention}

In schedules, you can set and configure a _snapshot retention policy_. For each disk included in a schedule, you can keep the following:

* All created scheduled snapshots.
* Only the last several snapshots. The oldest snapshots are automatically deleted once the defined number is exceeded. For example, if you want to keep only the last five snapshots, the first snapshot is deleted after the sixth one is created, the second is deleted after the seventh one is created, and so on.
* Only the snapshots created for the last several days. The oldest snapshots are automatically deleted once the defined age is reached.

The policy applies to all disks in a schedule.

Snapshots are deleted only while the schedule is on (`ACTIVE` [status](#statuses)).


## Snapshot names {#names}

For a created scheduled snapshot, a name up to 63 characters long is generated. It shows the following, separated by underscores:

* Name of a virtual machine to which the disk is connected (up to 24 characters) or the `unattached` line if the disk is attached to no VM.
* Disk name (up 20 characters).
* Snapshot creation date and time (UTC+0) in `YYYYMMDDhhmm` format (year, month, day, hour, and minute).
* Line consisting of four random Latin letters and digits.

> For example, if the `test-disk-with-a-long-name` disk is connected to the `test-vm` VM, its snapshot, created as scheduled on September 1, 2022 at 03:30 PM UTC+0, can have the following name:
>
> ```
> test-vm_test-disk-with-a-lon_202209011530_pd2k
> ```

## Schedule statuses {#statuses}

* `CREATING`: The schedule is being created.
* `ACTIVE`: The schedule is on: new disk snapshots will be created, old ones deleted (if the corresponding parameter of [snapshot retention](#retention) is selected).
* `UPDATING`: Changes are being made to schedule settings or a list of attached disks.
* `INACTIVE`: The schedule is interrupted, snapshots won't be created or deleted.
* `DELETING`: The schedule is being deleted.

All snapshot creation or deletion operations that started prior to changing, interrupting or deleting the schedule will be completed.

#### See also {#see-also}

* [Instructions for disk snapshots and schedules](../operations/#snapshots)
