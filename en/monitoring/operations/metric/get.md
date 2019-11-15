# Reading metrics

To read metric data, use the [read](../../api-ref/MetricsData/read.md) method.

{% include [before-beginning](../../../_includes/monitoring/before-beginning.md) %}

### Sample request {#sample-request}

1. Create a file with the request body (for example, `body.json`). In the `query` property, specify the query text. For example, the request below gets metric data on CPU usage from 00:00 UTC on July 24 to 00:00 UTC on July 31 for the virtual machine with ID `epdpfhoh1r83vdmdnjuf`.

    **body.json:**

    ```json
    {
        "query": "cpu_usage{service=\"compute\", resource_id=\"epdpfhoh1r83vdmdnjuf\"}",
        "fromTime": "1563926400000",
        "toTime": "1564531200000",
        "downsampling": {
            "maxPoints": 10
        }
    }
    ```

1. Send the request and save the response to a file, for example, `output.json`:

    ```bash
    $ export IAM_TOKEN=CggaATEVAgA...
    $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d '@body.json' \
        'https://monitoring.api.cloud.yandex.net/monitoring/v2/data/read?folderId=b2ghmo15rmnlod3hrf8p' > output.json
    ```

    Sample response:

    **body.json:**

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

