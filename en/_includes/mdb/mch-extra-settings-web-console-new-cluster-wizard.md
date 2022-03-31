* **Backup start time (UTC)**: UTC time in 24-hour format when you would like to start creating a cluster backup. If the time is not set, the backup will start at 22:00 UTC.

* **Maintenance window**: Maintenance time settings:
    * To enable maintenance at any time, select **arbitrary** (default).
    * To specify the preferred maintenance start time, select **by schedule** and specify the desired day of the week and UTC hour. For example, you can choose a time when cluster load is lightest.

    Maintenance includes updating DBMS versions, applying patches, and so on.

* **Hybrid storage**: Enable this option and select a network storage type under **Storage size** to create a cluster that will use [hybrid storage](../../managed-clickhouse/concepts/storage.md#hybrid-storage-features).

   {% note warning %}

   You can't disable this option after you create a cluster.

   {% endnote %}

* **{{ datalens-name }} access**: Allows you to analyze cluster data in [{{ datalens-full-name }}](../../datalens/concepts/index.md).

* **Access from management console**: Enables you to run SQL queries against cluster databases from the {{ yandex-cloud }} management console.

* **Access from Yandex.Metrica and AppMetrica**: Enables you to [import AppMetrica data](https://appmetrica.yandex.com/docs/cloud/index.html) into the cluster.

* **Access from Serverless**: Enable this option to allow cluster access from [{{ sf-full-name }}](../../functions/concepts/index.md). For more information about setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md) documentation.

* **Deletion protection**: Enable this option to protect a cluster from accidental deletion by your cloud's users.

    {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

