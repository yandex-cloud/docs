# Viewing metrics in {{ monitoring-full-name }}

To download metric data, use the [read](../../monitoring/api-ref/MetricsData/read.md) method.

{% include [before-beginning](../../_includes/monitoring/before-beginning.md) %}

## Getting CPU metrics {#cpu}

{% include [metrics-sample](../../_includes/monitoring/metrics-ref/cpu-metrics-sample.md) %}

## Getting disk metrics {#disk}

1. Create a file with the request body, e.g., `body.json`:

    For example, the request below gets metric data on the disk load from August 9 to August 10 (00:00 UTC).

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

    Where:

    * `query`: Query text:
      * `disk.read_bytes`: Number of bytes read from the disk.
      * `service="compute"`: Name of the service associated with the metric.
      * `disk="fhmhpdpidgen********"`: ID of a given disk.
    * `fromTime`: Start of the period.
    * `toTime`: End of the period.

1. Send the request and save the response to a file, e.g., `output.json`:

    ```bash
    export IAM_TOKEN=...
    curl \
      --request POST \
      --header "Content-Type: application/json" \
      --header "Authorization: Bearer ${IAM_TOKEN}" \
      --data '@body.json' \
      'https://monitoring.api.cloud.yandex.net/monitoring/v2/data/read?folderId=b1gsm0k26v1l********' > output.json
    ```

    Response example:

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

You can also view metrics in the [management console]({{ link-console-main }}). To do this, click ![image](../../_assets/console-icons/dots-9.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}** on the left-hand panel and select ![image](../../_assets/console-icons/monitoring-icon.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}** or find it using the search bar on the dashboard.