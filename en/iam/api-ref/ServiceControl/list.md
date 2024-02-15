---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/ServiceControl/list.md
---

# Identity and Access Management API, REST: ServiceControl.list
Retrieves the list of Service in the specified resource container.
 

 
## HTTP request {#https-request}
```
GET https://iam.{{ api-host }}/iam/v1/services
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
resource.id | <p>Required. ID of the resource.</p> <p>The maximum string length in characters is 50.</p> 
resource.type | <p>Required. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc.</p> <p>The maximum string length in characters is 64.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/iam/api-ref/ServiceControl/list#query_params">pageSize</a>, the service returns a <a href="/docs/iam/api-ref/ServiceControl/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/iam/api-ref/ServiceControl/list#query_params">pageToken</a> to the <a href="/docs/iam/api-ref/ServiceControl/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 2000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "services": [
    {
      "serviceId": "string",
      "resource": {
        "id": "string",
        "type": "string"
      },
      "updatedAt": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
services[] | **object**<br><p>List of Services.</p> 
services[].<br>serviceId | **string**<br><p>ID of the service.</p> 
services[].<br>resource | **object**<br><p>Resource that the service belongs to.</p> <p>A Resource. For more information, see <a href="/docs/iam/concepts/access-control/resources-with-access-control">Resource</a>.</p> 
services[].<br>resource.<br>id | **string**<br><p>Required. ID of the resource.</p> <p>The maximum string length in characters is 50.</p> 
services[].<br>resource.<br>type | **string**<br><p>Required. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc.</p> <p>The maximum string length in characters is 64.</p> 
services[].<br>updatedAt | **string** (date-time)<br><p>Time of the last status update of the service.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
services[].<br>status | **string**<br><p>Current status of the service.</p> <ul> <li>ENABLED: The service is enabled.</li> <li>PAUSED: The service is paused.</li> <li>DISABLED: The service is disabled.</li> <li>ENABLING: The service is being enabled.</li> <li>RESUMING: The service is being resumed.</li> <li>PAUSING: The service is being paused.</li> <li>DISABLING: The service is being disabled.</li> <li>ERROR: The service is in error state.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/iam/api-ref/ServiceControl/list#query_params">pageSize</a>, use the <a href="/docs/iam/api-ref/ServiceControl/list#responses">nextPageToken</a> as the value for the <a href="/docs/iam/api-ref/ServiceControl/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/iam/api-ref/ServiceControl/list#responses">nextPageToken</a> to continue paging through the results.</p> 