- **Connecting to replicas**:

    - `OFF`: Secondary replicas are unreadable and connections to them are prohibited.
    - `READ_ONLY`: Secondary replicas are readable but connections to them are read-only.

        {% note alert %}

        An additional fee is charged for using readable replicas. For more information, see [{#T}](../../../managed-sqlserver/pricing.md#license).

        {% endnote %}

    This setting is only available for multi-host **Enterprise Edition** cluster [versions](../../../managed-sqlserver/concepts/index.md).

- **Backup start time (UTC)**: UTC time in 24-hour format when you want to begin creating a [backup](../../../managed-sqlserver/operations/cluster-backups.md) of a cluster. If the time is not set, the backup will start at 22:00 UTC.

- **{{ datalens-name }} access**: Allows you to analyze cluster data in [{{ datalens-full-name }}](../../../datalens/concepts/index.md).

- **Deletion protection**: Enable this option to protect a cluster from accidental deletion by your cloud's users.

    {% include [Deletion protection limits](../deletion-protection-limits-db.md) %}

