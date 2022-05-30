* **Backup start time (UTC)**: UTC time in 24-hour format when you would like to start creating a cluster backup. If the time is not set, the backup will start at 22:00 UTC.

* **Maintenance window**: Maintenance time settings:

   * To enable maintenance at any time, select **arbitrary** (default).
   * To specify the preferred maintenance start time, select **by schedule** and specify the desired day of the week and UTC hour. For example, you can choose a time when cluster load is lightest.

   Maintenance includes updating DBMS versions, applying patches, and so on.

* **Hybrid storage**: Enable this option to create a cluster that will use [hybrid storage](../../managed-clickhouse/concepts/storage.md#hybrid-storage-features). Specify the storage type and size under **Storage size**.

   {% note alert %}

   You can't disable this option after you create a cluster.

   {% endnote %}

* **Access from {{ datalens-name }}** : Enable this option to be able to analyze data from the cluster in [{{ datalens-full-name }}](../../datalens/concepts/index.md). For more information about setting up a connection, see [Connecting to {{ datalens-name }}](../../managed-clickhouse/operations/datalens-connect.md).

* **Access from the management console**: Enable this option to be able to [run SQL queries](../../managed-clickhouse/operations/web-sql-query.md) against a cluster's databases from the {{ yandex-cloud }} management console.

* **Access from Yandex.Metrica and AppMetrica**: This option helps [import data from AppMetrica](https://appmetrica.yandex.ru/docs/cloud/index.html) to a cluster.
   {% if audience != "internal" %}

* **Access from Serverless**: Enable this option to allow cluster access from [{{ sf-full-name }}](../../functions/concepts/index.md). For more detail on setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md).

{% else %}

* **Access from Serverless**: Enable this option to allow cluster access from {{ sf-full-name }}.

{% endif %}

* **Deletion protection**: Enable this option to protect a cluster from accidental deletion by your cloud's users.

   {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}
