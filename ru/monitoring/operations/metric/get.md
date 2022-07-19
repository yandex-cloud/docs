# Выгрузка метрик

Чтобы выгрузить данные метрики, воспользуйтесь методом [read](../../api-ref/MetricsData/read.md).

{% include [before-beginning](../../../_includes/monitoring/before-beginning.md) %}

### Пример запроса {#sample-request}

1. Создайте файл с телом запроса, например `body.json`:
    
    Например, запрос ниже получает данные метрики с загрузкой CPU виртуальной машины с идентификатором `epdpfhoh1r83vdmdnjuf` в период с 00:00 UTC 24 июля до 00:00 UTC 31 июля.

    **body.json:**
    ```json
    {
        "query": "cpu_usage{service=\"compute\", resource_id=\"epdpfhoh1r83vdmdnjuf\"}",
        "fromTime": "2021-07-24T00:00:00Z",
        "toTime": "2021-07-31T00:00:00Z",
        "downsampling": {
            "maxPoints": 10
        }
    }
    ```

    Где:

    * `query` – текст запроса:
      * `cpu_usage` – загрузка CPU.
      * `resource_id` – идентификатор виртуальной машины.
    * `fromTime` – начало периода.
    * `toTime` – конец периода.


1. Отправьте запрос и сохраните ответ в файл, например `output.json`:

    ```bash
    export IAM_TOKEN=CggaATEVAgA...
    curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d '@body.json' \
        'https://monitoring.{{ api-host }}/monitoring/v2/data/read?folderId=b2ghmo15rmnlod3hrf8p' > output.json
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
                    "cluster": "b2ghmo15rmnlod3hrf8p",
                    "project": "b1gbkpesobgv2i2266vg",
                    "resource_id": "epdpfhoh1r83vdmdnjuf",
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
