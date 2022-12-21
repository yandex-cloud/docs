### Previously, {{ datalens-short-name }} supported connections to Yandex Metrica/AppMetrica with prior data export to {{ CH }} via LogsAPI. Is this still possible? {#uploading-data-logs-api}

No. Currently, only direct connections to Yandex Metrica and AppMetrica are available.

To work with raw Yandex Metrica and AppMetrica data, you can:

* For AppMetrica, set up automatic raw data export to {{ mch-name }} directly in the [AppMetrica interface](https://appmetrica.yandex.com/docs/cloud/index.html).
* For Yandex Metrica, use the [code snippet](../../datalens/tutorials/data-from-metrica-yc-visualization.md#get-download-data-in-ch) from the documentation or the following [script](https://yandex.com/dev/metrika/doc/api2/logs/clickhouse-integration.html) to export raw data to {{ CH }} via LogsAPI.

