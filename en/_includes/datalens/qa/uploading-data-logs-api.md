### Previously, {{ datalens-short-name }} supported connection to Yandex.Metrica/AppMetrica with prior data exporting to {{ CH }} via LogsAPI. Is this still possible? {#uploading-data-logs-api}

No. Currently, only direct connections to Yandex.Metrica and AppMetrica are available.

To work with raw Yandex.Metrica and AppMetrica data, you can:

* For AppMetrica, set up automatic uploading of raw data to {{ mch-name }} directly in the [AppMetrica interface](https://appmetrica.yandex.com/docs/cloud/index.html).
* For Yandex.Metrica, use the sample code to export raw data to {{ CH }} via LogsAPI given in the [documentation](../../../datalens/solutions/data-from-metrica-visualization.md#get-download-data-in-ch).

