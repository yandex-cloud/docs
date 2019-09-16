# Получение списка метрик

Чтобы получить список метрик, принадлежащих определенному облаку и каталогу, воспользуйтесь методом [listMetrics](../../api-ref/MetricsMeta/listMetrics.md).

{% include [before-beginning](../../../_includes/monitoring/before-beginning.md) %}

### Пример запроса {#sample-request}

Отправьте запрос и сохраните ответ в файл, например `output.json`:

```bash
$ export IAM_TOKEN=CggaATEVAgA...
$ curl -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    'https://monitoring.api.cloud.yandex.net/monitoring/v2/metrics/?folderId=aoeng2krmasimogorn5m&service=compute&selectors={resource_id="d9hvsd8eh12n8nzcof4ou"}' > output.json
```

Пример ответа на запрос, который получает список метрик сервиса Compute для ресурса (виртуальной машины) с идентификатором `d9hvsd8eh12n8nzcof4ou`. В свойстве `metrics` перечислен список метрик:

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
