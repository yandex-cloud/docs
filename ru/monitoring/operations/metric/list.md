# Получение списка метрик

Чтобы получить список метрик, принадлежащих определенному облаку и каталогу, воспользуйтесь методом [listMetrics](../../api-ref/MetricsMeta/listMetrics.md).

[!INCLUDE [ai-before-beginning](../../../_includes/ai-before-beginning.md)]

### Пример запроса

Отправьте запрос и сохраните ответ в файл, например `output.json`:

```bash
$ export IAM_TOKEN=CggaATEVAgA...
$ curl -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    'https://monitoring.api.cloud.yandex.net/monitoring/v1/metrics/?cloud_id=b1ebkpesobgv2i2266vg&folder_id=b1ehmo15rmnlod3hrf8&service=compute' > output.json
```

Пример ответа на запрос. В свойстве `result` перечислен список метрик, а свойстве `page` – параметры пагинации:

**body.json:**
```json
{
  "result": [
    {
      "name": "memory_usage",
      "labels": {
        "cluster": "b1ghmo15rmnlod3hrf8p",
        "instance_id": "epdpmp80p408he72k3mf",
        "metric": "memory_usage",
        "service": "compute",
        "resource_type": "vm",
        "project": "b1gbkpesobgv2i2266vg",
        "resource_id": "epdpmp80p408he72k3mf"
      },
      "kind": "DGAUGE",
      "createdAt": "2019-04-02T07:47:37Z"
    },
    {
      "name": "cpu_usage",
      "labels": {
        "cluster": "b1ghmo15rmnlod3hrf8p",
        "instance_id": "epderigcmk645crlnlvt",
        "metric": "cpu_usage",
        "service": "compute",
        "resource_type": "vm",
        "project": "b1gbkpesobgv2i2266vg",
        "resource_id": "epderigcmk645crlnlvt"
      },
      "kind": "DGAUGE",
      "createdAt": "2019-04-02T03:38:01Z"
    },
    ...
  ],
  "page": {
    "pagesCount": 3,
    "totalCount": 72,
    "pageSize": 30,
    "current": 0
  }
}
```
