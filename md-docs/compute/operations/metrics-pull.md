[Документация Yandex Cloud](../../index.md) > [Yandex Compute Cloud](../index.md) > [Пошаговые инструкции](index.md) > Просмотр метрик в Monium Metrics

# Посмотреть метрики в Monium Metrics

Метрики сервиса Compute Cloud поставляются в [Monium Metrics](../../monium/metrics/quickstart.md). Посмотреть их можно в интерфейсе Monium или выгрузить через API.

### Перед началом работы {#before-you-begin}

Чтобы воспользоваться примерами в этом разделе:

1. Убедитесь, что у вас установлена утилита [cURL](https://curl.haxx.se), используемая в примерах.
1. [Получите идентификатор каталога](../../resource-manager/operations/folder/get-id.md), на который у вас есть роль `monitoring.viewer` или выше.
1. Получите IAM-токен:
   * [Инструкция](../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.
   * [Инструкция](../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
   * [Инструкция](../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
   * [Инструкция](../../iam/operations/iam-token/create-for-local.md) для локального аккаунта.

Полный список метрик Compute Cloud приведен в [справочнике метрик](../metrics.md).

## Получение метрик CPU {#cpu}

{% list tabs group=instructions %}

- Интерфейс Monium {#console}

  1. На главной странице [Monium](https://monium.yandex.cloud) слева выберите ![image](../../_assets/console-icons/compass.svg) **Обзор** → ![image](../../_assets/console-icons/rectangle-pulse.svg) **Метрики**.
  1. Вверху на шкале времени задайте промежуток поиска данных.
  1. В строке запроса укажите метки метрик ресурсов Yandex Cloud:

      * `project` = `folder__<идентификатор_каталога>` — каталог, в котором находятся виртуальные машины;
      * `cluster` = `default`;
      * `service` = `__compute__`;
      * `name` = `cpu_usage` — загрузка CPU;
      * (опционально) `resource_id` = `<идентификатор_ВМ>` — чтобы посмотреть метрики конкретной виртуальной машины.

  1. Нажмите **Выполнить**.

  Подробнее о поиске и анализе метрик читайте в разделе [Посмотреть метрики в Monium Metrics](../../monium/metrics/metric-explorer.md).

- API {#api}

    1. Создайте файл с телом запроса, например `body.json`:
        
        Например, запрос ниже получает данные метрики с загрузкой CPU виртуальной машины с идентификатором `epdpfhoh1r83********` в период с 00:00 UTC 24 июля до 00:00 UTC 31 июля.
    
        **body.json:**
        ```json
        {
            "query": "cpu_usage{service=\"compute\", resource_id=\"epdpfhoh1r83********\"}",
            "fromTime": "2021-07-24T00:00:00Z",
            "toTime": "2021-07-31T00:00:00Z",
            "downsampling": {
                "maxPoints": 10
            }
        }
        ```
    
        Где:
    
        * `query` — текст запроса:
          * `cpu_usage` — загрузка CPU.
          * `resource_id` — идентификатор виртуальной машины.
        * `fromTime` — начало периода.
        * `toTime` — конец периода.
    
    1. Отправьте запрос и сохраните ответ в файл, например `output.json`:
    
        ```bash
        export IAM_TOKEN=CggaATEVAgA...
        curl \
          --request POST \
          --header "Content-Type: application/json" \
          --header "Authorization: Bearer ${IAM_TOKEN}" \
          --data '@body.json' \
          'https://monitoring.api.cloud.yandex.net/monitoring/v2/data/read?folderId=b2ghmo15rmnl********' > output.json
        ```
    
        Пример ответа на запрос:
    
        **output.json:**
        ```json
        {
            "metrics": [
                {
                    "type": "DGAUGE",
                    "name": "cpu_usage",
                    "labels": {
                        "resource_type": "vm",
                        "cluster": "b2ghmo15rmnl********",
                        "project": "b1gbkpesobgv********",
                        "resource_id": "epdpfhoh1r83********",
                        "service": "compute"
                    },
                    "timeseries": {
                        "timestamps": [
                            1562069440800,
                            1562405369712,
                            1562741298624,
                            1563077227536,
                            1563413156448,
                            1563749085360,
                            1564085014272,
                            1564420943184
                        ],
                        "doubleValues": [
                            53.6475600118669,
                            65.5547751323391,
                            70.7148916473759,
                            49.4514634827568,
                            54.3817816479781,
                            81.9327383032693,
                            99.3035341016667,
                            99.982002860023
                        ]
                    }
                }
            ]
        }
        ```

{% endlist %}

## Получение метрик диска {#disk}

{% list tabs group=instructions %}

- Интерфейс Monium {#console}

  1. На главной странице [Monium](https://monium.yandex.cloud) слева выберите ![image](../../_assets/console-icons/compass.svg) **Обзор** → ![image](../../_assets/console-icons/rectangle-pulse.svg) **Метрики**.
  1. Вверху на шкале времени задайте промежуток поиска данных.
  1. В строке запроса укажите метки метрик ресурсов Yandex Cloud:

      * `project` = `folder__<идентификатор_каталога>` — каталог, в котором находятся диски;
      * `cluster` = `default`;
      * `service` = `__compute__`;
      * `name` = `disk.read_bytes` — количество байт, прочитанных с диска или имя другой метрики диска из [справочника](../metrics.md);
      * (опционально) `disk` = `<идентификатор_диска>` — чтобы посмотреть метрики конкретного диска.

  1. Нажмите **Выполнить**.

  Подробнее о поиске и анализе метрик читайте в разделе [Посмотреть метрики в Monium Metrics](../../monium/metrics/metric-explorer.md).

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