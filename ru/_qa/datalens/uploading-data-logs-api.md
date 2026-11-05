### Раньше в {{ datalens-short-name }} была возможность подключения к Яндекс Метрике и AppMetrica с предварительной выгрузкой данных в {{ CH }} через LogsAPI. Сейчас есть такая возможность? {#uploading-data-logs-api}

Нет. Сейчас доступно только прямое подключение к Метрике и AppMetrica.

Чтобы работать с сырыми данными Метрики и AppMetrica, вы можете:

* для AppMetrica:

  * настроить выгрузку через [Data Stream API](https://appmetrica.yandex.ru/docs/{{ lang }}/mobile-api/datastream/quick-start);
  * настроить выгрузку через [Logs API](https://appmetrica.yandex.ru/docs/{{ lang }}/mobile-api/logs/about);
  * [выгрузить данные в файл](https://appmetrica.yandex.ru/docs/{{ lang }}/common/export).

* для Метрики:

  * воспользоваться [примером кода](https://github.com/zhdanchik/yandex_metrika_cloud_case/) из [документации](../../datalens/tutorials/data-from-metrica-yc-visualization.md#get-download-data-in-ch) для экспорта сырых данных в {{ CH }} через LogsAPI;
  * подключить пакет **{{ metrika-pro }}** и [настроить передачу данных](https://yandex.ru/support/metrica/ru/uploading-data/cloud) в кластер {{ mch-short-name }}.
