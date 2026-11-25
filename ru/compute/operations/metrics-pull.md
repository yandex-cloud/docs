# Посмотреть метрики в {{ metrics-name }}

Метрики сервиса {{ compute-name }} поставляются в [{{ metrics-name }}](../../monium/metrics/quickstart.md). Посмотреть их можно в интерфейсе {{ monium-name }} или выгрузить через API.

{% include [before-beginning](../../_includes/monitoring/before-beginning.md) %}

Полный список метрик {{ compute-name }} приведен в [справочнике метрик](../metrics.md).

## Получение метрик CPU {#cpu}

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите ![image](../../_assets/console-icons/compass.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.all-panel.menu.category.explore }}** → ![image](../../_assets/console-icons/rectangle-pulse.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
  1. Вверху на шкале времени задайте промежуток поиска данных.
  1. В строке запроса укажите метки метрик ресурсов {{ yandex-cloud }}:

      * `project` = `folder__<идентификатор_каталога>` — каталог, в котором находятся виртуальные машины;
      * `cluster` = `default`;
      * `service` = `__compute__`;
      * `name` = `cpu_usage` — загрузка CPU;
      * (опционально) `resource_id` = `<идентификатор_ВМ>` — чтобы посмотреть метрики конкретной виртуальной машины.

  1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.button.apply-and-parse }}**.

  Подробнее о поиске и анализе метрик читайте в разделе [{#T}](../../monium/metrics/metric-explorer.md).

- API {#api}

    {% include [metrics-sample](../../_includes/monitoring/metrics-ref/cpu-metrics-sample.md) %}

{% endlist %}

## Получение метрик диска {#disk}

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите ![image](../../_assets/console-icons/compass.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.all-panel.menu.category.explore }}** → ![image](../../_assets/console-icons/rectangle-pulse.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
  1. Вверху на шкале времени задайте промежуток поиска данных.
  1. В строке запроса укажите метки метрик ресурсов {{ yandex-cloud }}:

      * `project` = `folder__<идентификатор_каталога>` — каталог, в котором находятся диски;
      * `cluster` = `default`;
      * `service` = `__compute__`;
      * `name` = `disk.read_bytes` — количество байт, прочитанных с диска или имя другой метрики диска из [справочника](../metrics.md);
      * (опционально) `disk` = `<идентификатор_диска>` — чтобы посмотреть метрики конкретного диска.

  1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.button.apply-and-parse }}**.

  Подробнее о поиске и анализе метрик читайте в разделе [{#T}](../../monium/metrics/metric-explorer.md).

- API {#api}

    1. Создайте файл с телом запроса, например `body.json`:

        Например, запрос ниже получает данные метрики с загрузкой диска в период с 00:00 UTC 9 августа до 00:00 UTC 10 августа.

        **body.json:**
        ```json
        {
            "query": "disk.read_bytes{service=\"compute\", disk=\"fhmhpdpidgen********\"}",
            "fromTime": "2025-08-09T00:00:00Z",
            "toTime": "2025-08-10T00:00:00Z",
            "downsampling": {
                "maxPoints": 10
            }
        }
        ```

        Где:

        * `query` — текст запроса:
          * `disk.read_bytes` — количество байт, прочитанных с диска.
          * `service="compute"` — сервис, к которому относится метрика.
          * `disk="fhmhpdpidgen********"` — идентификатор конкретного диска.
        * `fromTime` — начало периода.
        * `toTime` — конец периода.

    1. Отправьте запрос и сохраните ответ в файл, например `output.json`:

        ```bash
        export IAM_TOKEN=...
        curl \
          --request POST \
          --header "Content-Type: application/json" \
          --header "Authorization: Bearer ${IAM_TOKEN}" \
          --data '@body.json' \
          'https://monitoring.api.cloud.yandex.net/monitoring/v2/data/read?folderId=b1gsm0k26v1l********' > output.json
        ```

        Пример ответа на запрос:

        **output.json:**
        ```json
        {
            "metrics": [
                {
                    "name": "disk.read_bytes",
                    "labels": {
                        "disk": "fhmhpdpidgen********",
                        "instance": "for-backup",
                        "service": "compute"
                    },
                    "type": "RATE",
                    "timeseries": {
                        "timestamps": [
                            1754697600000,
                            1754707200000,
                            1754716800000,
                            1754726400000,
                            1754736000000,
                            1754745600000,
                            1754755200000,
                            1754764800000,
                            1754774400000
                        ],
                        "doubleValues": [
                            457.38666666666666,
                            525.6533333333333,
                            122.45333333333333,
                            442.88,
                            419.4133333333333,
                            360.1066666666667,
                            387.41333333333336,
                            381.8666666666667,
                            561.4933333333333
                        ]
                    }
                }
            ]
        }
        ```

{% endlist %}
