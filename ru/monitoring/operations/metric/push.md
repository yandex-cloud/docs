# Запись метрик через API

Чтобы записать метрику в Solomon через API, воспользуйтесь методом [/api/v2/push](https://solomon.yandex-team.ru/swagger-ui/index.html#/push/pushUsingPOST).

### Перед началом {#before-you-begin}

Чтобы воспользоваться примерами в этом разделе, сохраните [OAuth-токен](../../api-ref/authentication.md#oauth) к Solomon API в переменную окружения `SOLOMON_TOKEN`.

### Пример запроса {#sample-request}

1. Создайте файл с телом запроса, например `body.json`. В поле `metrics` перечислите список метрик для записи в формате [JSON](../../concepts/data-collection/dataformat/json.md). Обязательные метки передаются в query-параметрах запроса, а дополнительные — в теле запроса в поле `labels`.

    **body.json:**
    ```json
    {
        "metrics": [
            {
                "labels": {
                    "sensor": "temperature",
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
        curl -s "https://solomon.yandex-team.ru/api/v2/push?project=junk&cluster=foo&service=bar" \
        -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: OAuth "$SOLOMON_TOKEN \
        -d @body.json > output.json
    ```

    Пример ответа на запрос:

    **output.json:**
    ```bash
    {"status":"OK","sensorsProcessed":1}
    ```

1. Чтобы увидеть записанные значения, перейдите в [Monitoring UI](https://monitoring.yandex-team.ru/projects/junk/explorer?normz=off&colors=auto&type=auto&interpolation=linear&dsp_method=auto&dsp_aggr=default&dsp_fill=default&q%5B0%5D%5Bs%5D=%7Bproject%3D%22junk%22%2C%20cluster%3D%22foo%22%2C%20service%3D%22bar%22%2C%20sensor%3D%22%2A%22%2C%20building%3D%22office%22%2C%20room%3D%22openspace%22%7D&range=1h).
