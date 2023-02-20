---
editable: false
---

# Метод prometheusMetrics
Экспортирует метрики сервиса в [формате Prometheus](https://prometheus.io/docs/instrumenting/exposition_formats/). Из каталога выгружаются все метрики сервиса.

## HTTP-запрос {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v2/prometheusMetrics
Authorization: Bearer <API key>
```

## Заголовки {#headers}
Заголовок | Описание
--- | ---
Authorization | API-ключ сервисного аккаунта. В качестве префикса необходимо использовать `Bearer`, а не `Api-Key`.

## Query-параметры {#query_params}

Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога, из которого необходимо выгружать метрики. Максимальная длина строки в символах — 50.
service | Идентификатор сервиса, из которого необходимо выгружать метрики.

## Ответ {#responses}
**HTTP Code: 200 - OK**

Метрики сервиса в формате Prometheus.

```bash
# TYPE disk_flush_ops_failed gauge
disk_flush_ops_failed{device="fhm4madvd612357ao6vf", resource_id="fhmpnl2v1rsj4qqp3k0m", resource_type="vm"} 0.0
# TYPE disk_read_ops_in_flight gauge
disk_read_ops_in_flight{device="fhm4madvd612357ao6vf", resource_id="fhmpnl2v1rsj4qqp3k0m", resource_type="vm"} 0.0
# TYPE target_instances_count gauge
target_instances_count{resource_id="cl11231oqcpuqlqvqh83", resource_type="instance_group"} 1.0
...
```

