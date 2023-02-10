# Запись пользовательских метрик через API

Чтобы начать записывать пользовательские метрики через API, воспользуйтесь методом [write](../../api-ref/MetricsData/write.md).

### Перед началом {#before-you-begin}

Чтобы воспользоваться примерами в этом разделе:

1. Убедитесь, что у вас установлена утилита [cURL](https://curl.haxx.se), используемая в примерах.
1. [Получите идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), на который у вас есть роль `{{ roles-monitoring-editor }}` или выше.
1. Получите IAM-токен:
   
   {% if product == "yandex-cloud" %}* [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.{% endif %}
   * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
   * [Инструкция](../../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.

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
    export IAM_TOKEN=CggaATEVAgA...
    curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d '@body.json' \
        'https://monitoring.{{ api-host }}/monitoring/v2/data/write?folderId=aoe6vrq0g3svvs3uf62u&service=custom' > output.json
    ```

    Пример ответа на запрос:

    **output.json:**
    ```json
    {
        "metrics_written":"1"
    }
    ```
