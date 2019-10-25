# Getting a list of metrics

To get a list of metrics that belong to a specific cloud and folder, use the [listMetrics](../../api-ref/MetricsMeta/listMetrics.md) method.

{% include [before-beginning](../../../_includes/monitoring/before-beginning.md) %}

### Sample request {#sample-request}

Send the request and save the response to a file, for example, `output.json`:

```bash
$ export IAM_TOKEN=CggaATEVAgA...
$ curl -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    'https://monitoring.api.cloud.yandex.net/monitoring/v2/metrics/?folderId=aoeng2krmasimogorn5m&service=compute&selectors={resource_id="d9hvsd8eh12n8nzcof4ou"}' > output.json
```

Sample response. The list of metrics is given in the `metrics` property:

**output.json:**
```json
{
    "metrics": [
        {
            "name": "memory_usage",
            "labels": {
                "cluster": "aoeng2krmasimogorn5m",
                "service": "compute",
                "resource_type": "vm",
                "project": "b1gbkpesobgv2i2266vg",
                "resource_id": "d9hvsd8eh12n8nzcof4ou"
            },
            "type": "DGAUGE"
        },
        {
            "name": "cpu_usage",
            "labels": {
                "cluster": "aoeng2krmasimogorn5m",
                "service": "compute",
                "resource_type": "vm",
                "project": "b1gbkpesobgv2i2266vg",
                "resource_id": "d9hvsd8eh12n8nzcof4ou"
            },
            "type": "DGAUGE"
        },
        {
            "type": "DGAUGE",
            "name": "disk_write_ops",
            "labels": {
                "cluster": "aoeng2krmasimogorn5m",
                "service": "compute",
                "resource_type": "vm",
                "project": "b1gbkpesobgv2i2266vg",
                "resource_id": "d9hvsd8eh12n8nzcof4ou",
                "device": "d9hjde6k6168k7k4kgti",
            }
        },
    ...
    ]
}
```

