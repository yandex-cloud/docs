# Writing custom metrics via the API

To start writing custom metrics via the API, use the [write](../../api-ref/MetricsData/write.md) method.

{% include [before-beginning](../../../_includes/monitoring/before-beginning.md) %}

### Sample request {#sample-request}

1. Create a file with the request body (for example, `body.json`). In the `metrics` property, specify the list of metrics to write. Send the required labels in the request parameters and additional labels in the request body.

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

1. Send the request and save the response to a file, for example, `output.json`:

    ```bash
    $ export IAM_TOKEN=CggaATEVAgA...
    $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d '@body.json' \
        'https://monitoring.api.cloud.yandex.net/monitoring/v2/data/write?folderId=aoe6vrq0g3svvs3uf62u&service=custom' > output.json
    ```

    Sample response:

    **output.json:**

    ```json
    {
        "metrics_written":"1"
    }
    ```

