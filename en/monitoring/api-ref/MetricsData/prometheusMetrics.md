---
editable: false
---

# prometheusMetrics method
Exports service metrics in [Prometheus format](https://prometheus.io/docs/instrumenting/exposition_formats/). All the metrics from the folder are exported.

## HTTP request {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v2/prometheusMetrics
Authorization: Bearer <API key>
```

## Headers {#headers}
| Header | Description |
--- | ---
| Authorization | Service account API key. Use `Bearer` rather than `Api-Key` as the prefix. |

## Query parameters {#query_params}

| Parameter | Description |
--- | ---
| folderId | Required field. ID of the folder you want to export metrics from. Maximum string length: 50 characters. |
| service | ID of the service you want to export metrics from. |

## Response {#responses}
**HTTP Code: 200 - OK**

Metrics from the service in Prometheus format.

```bash
# TYPE disk_flush_ops_failed gauge
disk_flush_ops_failed{device="fhm4madvd612357ao6vf", resource_id="fhmpnl2v1rsj4qqp3k0m", resource_type="vm"} 0.0
# TYPE disk_read_ops_in_flight gauge
disk_read_ops_in_flight{device="fhm4madvd612357ao6vf", resource_id="fhmpnl2v1rsj4qqp3k0m", resource_type="vm"} 0.0
# TYPE target_instances_count gauge
target_instances_count{resource_id="cl11231oqcpuqlqvqh83", resource_type="instance_group"} 1.0
...
```

