# Backup policies

Backups of {{ yandex-cloud }} resources are created in {{ backup-name }} automatically according to _backup policies_.

The backup policy specifies:

* Backup frequency: By hour, day, week, or month. The time is written in the [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00) time zone.
* Backup type: Full or incremental. For more information, see [{#T}](backup.md#types).
* [Snapshot retention](#retention) settings.

{% note info %}

Backups can be created with a little delay from the schedule, depending on the current load on the service.

{% endnote %}


## Storing backups {#retention}

You can set up backup storage for the policy. The following can be stored for each VM included in the policy:

* All backups created under this policy.
* Only the last several backups.
* Only snapshots that are younger than a certain age, for example, created for the last few days.

The settings apply to all VMs in the policy.