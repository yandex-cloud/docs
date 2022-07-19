# Получение списка метрик

Чтобы получить список метрик, принадлежащих определенному облаку и каталогу, воспользуйтесь методом [listMetrics](../../api-ref/MetricsMeta/listMetrics.md).

{% include [before-beginning](../../../_includes/monitoring/before-beginning.md) %}

### Пример запроса {#sample-request}

Отправьте запрос и сохраните ответ в файл, например `output.json`:

```bash
export IAM_TOKEN=CggaATEVAgA...
curl -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -G 'https://monitoring.{{ api-host }}/monitoring/v2/metrics/?folderId=b1gucmd4tma1r85c7rhk&pageSize=200' --data-urlencode 'selectors={service="managed-clickhouse", resource_id="c9q5e2a9i24p7s0o9sh6"}' >  output.json
```

Пример ответа на запрос, который получает список метрик сервиса {{ mch-name }} для ресурса:

**output.json:**
```json
{
   "metrics" : [
      {
         "labels" : {
            "dc" : "rc1c",
            "host" : "rc1c-dqd0h0i0vax2bxk7.{{ dns-zone }}",
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
            "host" : "rc1c-dqd0h0i0vax2bxk7.{{ dns-zone }}",
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

Где:

* `resource_id` – идентификатор ресурса.
* `metrics` – список метрик.
