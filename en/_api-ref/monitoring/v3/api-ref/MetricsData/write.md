---
editable: false
---

# Method write
Writes metric data to Monitoring.
 

 
## HTTP request {#https-request}
```
POST https://monitoring.{{ api-host }}/monitoring/v3/data/write
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "service": "string",
  "rawData": {
    "contentType": "string",
    "content": "string"
  }
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder that the metric belongs to.</p> <p>The maximum string length in characters is 50.</p> 
service | **string**<br><p>Required. ID of the service that the metric belongs to. Use ``service=custom`` for custom metrics.</p> <p>The maximum string length in characters is 50.</p> 
rawData | **object**<br>Raw metrics data.
rawData.<br>contentType | **string**<br><p>Required. Query content type. Use "application/json".</p> 
rawData.<br>content | **string** (byte)<br><p>Required. Query content.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "writtenMetricsCount": "string"
}
```

 
Field | Description
--- | ---
writtenMetricsCount | **string** (int64)<br><p>Number of successfully written metrics.</p> 