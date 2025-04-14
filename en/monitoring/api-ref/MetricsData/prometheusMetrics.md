---
editable: false
---

# prometheusMetrics method
Exports all service metrics from a folder in [Prometheus format](https://prometheus.io/docs/instrumenting/exposition_formats/).

## HTTP request {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v2/prometheusMetrics
Authorization: Bearer <API_key>
```

## Headers {#headers}
Header | Description
--- | ---
Authorization | Service account API key. Use `Bearer` rather than `Api-Key` as the prefix.

## Query parameters {#query_params}

Parameter | Description
--- | ---
folderId | This is a required field. ID of the folder containing metrics you want to export. The maximum string length is 50 characters.
service | This is a required field. [ID](../../operations/metric/prometheusExport.md) of the service you want to monitor by exporting its metrics.

## Response {#responses}
**HTTP Code: 200 - OK**

Service metrics in Prometheus format.

```bash
# TYPE disk_flush_ops_failed gauge
disk_flush_ops_failed{device="fhm4madvd612********", resource_id="fhmpnl2v1rsj********", resource_type="vm"} 0.0
# TYPE disk_read_ops_in_flight gauge
disk_read_ops_in_flight{device="fhm4madvd612********", resource_id="fhmpnl2v1rsj********", resource_type="vm"} 0.0
# TYPE target_instances_count gauge
target_instances_count{resource_id="cl11231oqcpu********", resource_type="instance_group"} 1.0
...
```

