### Раньше в {{ datalens-short-name }} была возможность подключения к Яндекс.Метрике и AppMetrica с предварительной выгрузкой данных в {{ CH }} через LogsAPI. Сейчас есть такая возможность? {#uploading-data-logs-api}

Нет. Сейчас доступно только прямое подключение к Метрике и AppMetrica.

Чтобы работать с сырыми данными Метрики и AppMetrica вы можете:

* для AppMetrica настроить автоматическую выгрузку сырых данных в {{ mch-name }} прямо в [интерфейсе AppMetrica](https://appmetrica.yandex.ru/docs/cloud/index.html);
* для Метрики воспользоваться примером кода для экспорта сырых данных в {{ CH }} через LogsAPI из [документации](../../../datalens/solutions/data-from-metrica-yc-visualization.md#get-download-data-in-ch).
