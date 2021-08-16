# Getting a list of metrics

To get a list of metrics that belong to a specific cloud and folder, use the [listMetrics](../../api-ref/MetricsMeta/listMetrics.md) method.

{% include [before-beginning](../../../_includes/monitoring/before-beginning.md) %}

### Sample request {#sample-request}

Send the request and save the response to a file, for example, `output.json`:

```bash
$ export IAM_TOKEN=CggaATEVAgA...
$ curl -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -G 'https://monitoring.api.cloud.yandex.net/monitoring/v2/metrics/?folderId=b1gucmd4tma1r85c7rhk&pageSize=200' --data-urlencode 'selectors={service="managed-clickhouse", resource_id="c9q5e2a9i24p7s0o9sh6"}' >  output.json
```

Sample response. The list of metrics is given in the `metrics` property:

**output.json:**
```json
{
   "metrics" : [
      {
         "labels" : {
            "dc" : "rc1c",
            "host" : "rc1c-dqd0h0i0vax2bxk7.mdb.yandexcloud.net",
            "node" : "replica",
            "resource_id" : "c9q5e2a9i24p7s0o9sh6",
            "resource_type" : "cluster",
            "service" : "managed-clickhouse",
            "shard" : "c9qdstaf9lfgtogd213s"
         },
         "name" : "net.packets_sent",
         "type" : "DGAUGE"
      },
      {
         "labels" : {
            "dc" : "rc1c",
            "host" : "rc1c-dqd0h0i0vax2bxk7.mdb.yandexcloud.net",
            "node" : "replica",
            "resource_id" : "c9q5e2a9i24p7s0o9sh6",
            "resource_type" : "cluster",
            "service" : "managed-clickhouse",
            "shard" : "c9qdstaf9lfgtogd213s"
         },
         "name" : "disk.free_inodes",
         "type" : "DGAUGE"
      }
    ]
}
```

