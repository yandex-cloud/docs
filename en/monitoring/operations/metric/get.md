# Downloading metrics

To download metric data, use the [read](../../api-ref/MetricsData/read.md) method.

{% include [before-beginning](../../../_includes/monitoring/before-beginning.md) %}

### Request example {#sample-request}

1. Create a file with the request body, e.g., `body.json`:
    
    For example, the request below gets metric data on the CPU usage from 00:00 UTC on July 24 to 00:00 UTC on July 31 for the VM with the `epdpfhoh1r83********` ID.

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

    Where:

    * `query`: Request text:
      * `cpu_usage`: CPU utilization
      * `resource_id`: VM ID
    * `fromTime`: Start of the period
    * `toTime`: End of the period


1. Send the request and save the response to a file, e.g., `output.json`:

    ```bash
    export IAM_TOKEN=CggaATEVAgA...
    curl \
      --request POST \
      --header "Content-Type: application/json" \
      --header "Authorization: Bearer ${IAM_TOKEN}" \
      --data '@body.json' \
      'https://monitoring.{{ api-host }}/monitoring/v2/data/read?folderId=b2ghmo15rmnl********' > output.json
    ```

    Response example:

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
