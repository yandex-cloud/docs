# Выгрузка метрик

Чтобы выгрузить данные метрики, воспользуйтесь методом [read](../../api-ref/MetricsData/read.md).

[!INCLUDE [before-beginning](../../../_includes/monitoring/before-beginning.md)]

### Пример запроса

1. Создайте файл с телом запроса, например `body.json`. В свойстве `program` укажите текст запроса. Например, запрос ниже получает данные метрики с загрузкой CPU виртуальной машины с идентификатором `epdpfhoh1r83vdmdnjuf` в период с 00:00 UTC 5 апреля до 00:00 UTC 6 апреля.

    **body.json:**
    ```json
    {
        "program": "cpu_usage{service=\"compute\", resource_id=\"epdpfhoh1r83vdmdnjuf\"}",
        "from": "2019-04-05T00:00:00.000Z",
        "to": "2019-04-06T00:00:00.000Z",
        "downsampling": {
            "maxPoints": 10
        }
    }
    ```

1. Отправьте запрос и сохраните ответ в файл, например `output.json`:

    ```bash
    $ export IAM_TOKEN=CggaATEVAgA...
    $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d @body.json \
        'https://monitoring.api.cloud.yandex.net/monitoring/v1/data/read?cloud_id=b2gbkpesobgv2i2266vg&folder_id=b2ghmo15rmnlod3hrf8p' > output.json
    ```

    Пример ответа на запрос:

    **body.json:**
    ```json
    {
        "vector": [
            {
            "timeseries": {
                "kind": "DGAUGE",
                "name": "cpu_usage",
                "labels": {
                    "resource_type": "vm",
                    "cluster": "b1ghmo15rmnlod3hrf8p",
                    "project": "b1gbkpesobgv2i2266vg",
                    "resource_id": "epdpfhoh1r83vdmdnjuf",
                    "service": "compute"
                },
                "timestamps": [
                    1554422400000,
                    1554432000000,
                    1554441600000,
                    1554451200000,
                    ...
                ],
                "values": [
                    8.435615891402113,
                    7.351297033321152,
                    22.13237045892276,
                    6.805491444898502,
                    ...
                ]
            }
            }
        ]
    }
    ```
