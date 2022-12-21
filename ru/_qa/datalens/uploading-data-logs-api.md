### Раньше в {{ datalens-short-name }} была возможность подключения к Яндекс Метрике и AppMetrica с предварительной выгрузкой данных в {{ CH }} через LogsAPI. Сейчас есть такая возможность? {#uploading-data-logs-api}

Нет. Сейчас доступно только прямое подключение к Метрике и AppMetrica.

Чтобы работать с сырыми данными Метрики и AppMetrica вы можете:

* для AppMetrica настроить автоматическую выгрузку сырых данных в {{ mch-name }} прямо в [интерфейсе AppMetrica](https://appmetrica.yandex.ru/docs/common/cloud/about.html);
* для Метрики воспользоваться [примером кода](../../datalens/tutorials/data-from-metrica-yc-visualization.md#get-download-data-in-ch) из документации или [скриптом](https://yandex.ru/dev/metrika/doc/api2/logs/clickhouse-integration.html) для экспорта сырых данных в {{ CH }} через LogsAPI.
