### Previously, {{ datalens-short-name }} supported connection to Yandex Metrica and AppMetrica with prior data export to {{ CH }} via LogsAPI. Is this still possible? {#uploading-data-logs-api}

No. Currently, only direct connections to Yandex Metrica and AppMetrica are available.

To work with raw Yandex.Metrica and AppMetrica data, you can:

* For AppMetrica, set up automatic raw data export to {{ mch-name }} directly in the [AppMetrica interface](https://appmetrica.yandex.ru/docs/common/cloud/about.html).
* For Metrica:

   * Use the [sample code](https://github.com/zhdanchik/yandex_metrika_cloud_case/) from the [documentation](../../datalens/tutorials/data-from-metrica-yc-visualization.md#get-download-data-in-ch) to export raw data to {{ CH }} via LogsAPI.
   * Add the **{{ metrika-pro }}** package and [set up data transfer](https://yandex.ru/support/metrica/pro/cloud.html?lang=en) to a {{ mch-short-name }} cluster.
