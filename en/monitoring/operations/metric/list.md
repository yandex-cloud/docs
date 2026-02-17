# Getting a list of metrics

To get a list of metrics that belong to a specific cloud and folder, use the [listMetrics](../../api-ref/MetricsMeta/listMetrics.md) method.

{% include [before-beginning](../../../_includes/monitoring/before-beginning.md) %}

### Request example {#sample-request}

Send the request and save the response to a file, e.g., `output.json`:

```bash
export IAM_TOKEN=CggaATEVAgA...
curl \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --get 'https://monitoring.{{ api-host }}/monitoring/v2/metrics/?folderId=b1gucmd4tma1********&pageSize=200' \
  --data-urlencode 'selectors={service="managed-clickhouse", resource_id="c9q5e2a9i24p********"}' > output.json
```

Here is an example of a response to a request that retrieves a list of {{ mch-name }} metrics for a resource:

**output.json:**
```json
{
   "metrics" : [
      {
         "labels" : {
            "dc" : "rc1c",
            "host" : "rc1c-dqd0h0i0********.{{ dns-zone }}",
            "node" : "replica",
            "resource_id" : "c9q5e2a9i24p********",
            "resource_type" : "cluster",
            "service" : "managed-clickhouse",
            "shard" : "c9qdstaf9lfg********"
         },
         "name" : "net.packets_sent",
         "type" : "DGAUGE"
      },
      {
         "labels" : {
            "dc" : "rc1c",
            "host" : "rc1c-dqd0h0i0********.{{ dns-zone }}",
            "node" : "replica",
            "resource_id" : "c9q5e2a9i24p********",
            "resource_type" : "cluster",
            "service" : "managed-clickhouse",
            "shard" : "c9qdstaf9lfg********"
         },
         "name" : "disk.free_inodes",
         "type" : "DGAUGE"
      }
    ]
}
```

Where:

* `resource_id`: Resource ID.
* `metrics`: List of metrics.

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
