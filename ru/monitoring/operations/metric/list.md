# Получение списка метрик

Чтобы получить список метрик, принадлежащих определенному облаку и каталогу, воспользуйтесь методом [listMetrics](../../api-ref/MetricsMeta/listMetrics.md).

{% include [before-beginning](../../../_includes/monitoring/before-beginning.md) %}

### Пример запроса {#sample-request}

Отправьте запрос и сохраните ответ в файл, например `output.json`:

```bash
export IAM_TOKEN=CggaATEVAgA...
curl -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -G 'https://monitoring.{{ api-host }}/monitoring/v2/metrics/?folderId=b1gucmd4tma1********&pageSize=200' --data-urlencode 'selectors={service="managed-clickhouse", resource_id="c9q5e2a9i24p********"}' >  output.json
```

Пример ответа на запрос, который получает список метрик сервиса {{ mch-name }} для ресурса:

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

Где:

* `resource_id` – идентификатор ресурса.
* `metrics` – список метрик.

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
