---
editable: false
---

# Method listMetrics
Retrieves the list of metrics.
 

 
## HTTP request {#https-request}
```
GET https://monitoring.api.cloud.yandex.net/monitoring/v1/metrics
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
cloudId | Required. ID of the cloud that the metric belongs to.  The maximum string length in characters is 50.
folderId | Required. ID of the folder that the metric belongs to.  The maximum string length in characters is 50.
page | Number of page to return.
pageSize | Number of metrics per page.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "result": [
    {
      "name": "string",
      "labels": "object",
      "kind": "string",
      "createdAt": "string"
    }
  ],
  "page": {
    "pagesCount": "string",
    "totalCount": "string",
    "pageSize": "string",
    "current": "string"
  }
}
```

 
Field | Description
--- | ---
result[] | **object**<br><p>List of metrics.</p> 
result[].<br>name | **string**<br><p>Name of the metric.</p> 
result[].<br>labels | **object**<br><p>Metric labels as <code>key:value</code> pairs.</p> 
result[].<br>kind | **string**<br><p>Type of the metric.</p> <ul> <li>DGAUGE: Gauge with fractional values.</li> <li>IGAUGE: Gauge with integer values.</li> <li>COUNTER: Counter.</li> <li>RATE: Rate.</li> </ul> 
result[].<br>createdAt | **string** (int64)<br><p>Metric creation time. String in <a href="https://ru.wikipedia.org/wiki/ISO_8601">ISO8601</a> format.</p> 
page | **object**<br><p>Pagination parameters.</p> 
page.<br>pagesCount | **string** (int64)<br><p>Number of pages in the response.</p> 
page.<br>totalCount | **string** (int64)<br><p>Total number of metrics in the response.</p> 
page.<br>pageSize | **string** (int64)<br><p>Number of metrics per page.</p> 
page.<br>current | **string** (int64)<br><p>Number of the current page.</p> 