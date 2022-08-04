- **Connecting to replicas**:

   - `OFF`: Secondary replicas aren't readable and can't be connected to.
   - `READ_ONLY`: Secondary replicas are readable, but connections are only allowed for read operations.

      {% note alert %}

      An additional fee is charged for using readable replicas. For more information, see [Pricing for {{ mms-name }}](../../../managed-sqlserver/pricing/index.md#license).

      {% endnote %}

   This setting is only available for multi-host clusters of the [](../../../managed-sqlserver/concepts/index.md) **Enterprise Edition**

- **Backup start time (UTC)**: UTC time when you want to start creating a cluster [backup](../../../managed-sqlserver/operations/cluster-backups.md) (in 24-hour format). If the time is not set, the backup will start at 22:00 UTC.

- **{{ datalens-name }} access:** Allows you to analyze cluster data in [{{ datalens-full-name }}](../../../datalens/concepts/index.md).

- {% include [Deletion protection](../console/deletion-protection.md) %}

   {% include [deletion-protection-limits-db](../deletion-protection-limits-db.md) %}
