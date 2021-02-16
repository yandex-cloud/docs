# Запись пользовательских метрик через API

Чтобы записать метрику, воспользуйтесь методом [write](../../api-ref/MetricsData/write.md).

{% include [before-beginning](../../../_includes/monitoring/before-beginning.md) %}

### Пример запроса {#sample-request}

1. Создайте файл с телом запроса, например `body.json`. В свойстве `metrics` перечислите список метрик для записи. Обязательные метки передаются в query-параметрах запроса, а дополнительные — в теле запроса.

    **body.json:**
    ```json
    {
        "metrics": [
            {
                "name": "temperature",
                "labels": {
                    "building": "office",
                    "room": "openspace"
                },
                "value": 18.6
            }
        ]
    }
    ```

1. Отправьте запрос и сохраните ответ в файл, например `output.json`:

    ```bash
    $ export IAM_TOKEN=CggaATEVAgA...
    $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d '@body.json' \
        'https://monitoring.api.cloud.yandex.net/monitoring/v2/data/write?folderId=aoe6vrq0g3svvs3uf62u&service=custom' > output.json
    ```

    Пример ответа на запрос:

    **output.json:**
    ```json
    {
        "metrics_written":"1"
    }
    ```
