# Writing custom metrics via the API

To start writing custom metrics via the API, use the [write](../../api-ref/MetricsData/write.md) method.

### Getting started {#before-you-begin}

To try the examples in this section:

1. Make sure you have installed the [cURL](https://curl.haxx.se) utility that is used in the examples.
1. [Get the ID of the folder](../../../resource-manager/operations/folder/get-id.md) for which you have the `{{ roles-monitoring-editor }}` role or higher.
1. Get an IAM token:

   * [Guide](../../../iam/operations/iam-token/create.md) for users with a Yandex account.
   * [How to get a token](../../../iam/operations/iam-token/create-for-sa.md) for a service account.
   * [How to get a token](../../../iam/operations/iam-token/create-for-federation.md) for a federated account.

### Sample request {#sample-request}

1. Create a file with the request body, e.g., `body.json`. In the `metrics` property, specify the list of metrics to write. Send the required labels in the query parameters and additional labels in the request body.

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

1. Send the request and save the response to a file, e.g., `output.json`:

    ```bash
    export IAM_TOKEN=CggaATEVAgA...
    curl \
      --request POST \
      --header "Content-Type: application/json" \
      --header "Authorization: Bearer ${IAM_TOKEN}" \
      --data '@body.json' \
      'https://monitoring.{{ api-host }}/monitoring/v2/data/write?folderId=aoe6vrq0g3sv********&service=custom' > output.json
    ```

    Response example:

    **output.json:**
    ```json
    {
        "metrics_written":"1"
    }
    ```
