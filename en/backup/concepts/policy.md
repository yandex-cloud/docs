# Backup policies

Backups of {{ yandex-cloud }} resources are created in {{ backup-name }} automatically according to _backup policies_.

The backup policy specifies:

* Backup frequency: By hour, day, week, or month. The time is provided for the [UTC](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00) time zone.
* Backup type: Full or incremental. For more information, see [{#T}](backup.md#types).
* [Snapshot retention](#retention) settings.

{% include [policy-execute-time](../../_includes/backup/policy-execute-time.md) %}

## Storing backups {#retention}

You can set up backup storage for the policy. The following can be stored for each VM included in the policy:

* All backups created under this policy.
* Only the last several backups.
* Only the snapshots younger than a certain age, e.g., those created during the last few days.

The settings apply to all VMs in the policy.

If you make changes to the backup retention rules, by default they will take effect as soon as you create another backup. For more information on the setup parameters of the backup retention rules, see the next section.

## Backup policy specification {#specification}

In {{ backup-name }}, you can [create](../operations/policy-vm/create.md) or [update](../operations/policy-vm/update.md) backup policies based on the specification in [JSON](https://en.wikipedia.org/wiki/JSON) format by using the {{ yandex-cloud }} [command line](../../cli/quickstart.md) or making an API request.

Full backup policy specification in {{ backup-name }}:

{% include [full-config](../../_includes/backup/operations/full-config.md) %}
