---
editable: false
---

# Cloud Functions Service, REST: Function.listScalingPolicies
Lists existing scaling policies for specified function
 

 
## HTTP request {#https-request}
```
GET https://serverless-functions.{{ api-host }}/functions/v1/functions/{functionId}/scalingPolicies
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
functionId | <p>Required. ID of the function to retrieve scaling policies for.</p> <p>To get a function ID, make a <a href="/docs/functions/functions/api-ref/Function/list">list</a> request.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page that should be returned. If the number of available results is larger than ``pageSize``, the service returns a <a href="/docs/functions/functions/api-ref/Function/listScalingPolicies#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set ``pageToken`` to the <a href="/docs/functions/functions/api-ref/Function/listScalingPolicies#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "scalingPolicies": [
    {
      "functionId": "string",
      "tag": "string",
      "createdAt": "string",
      "modifiedAt": "string",
      "provisionedInstancesCount": "string",
      "zoneInstancesLimit": "string",
      "zoneRequestsLimit": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
scalingPolicies[] | **object**<br><p>Set of relevant scaling policies.</p> 
scalingPolicies[].<br>functionId | **string**<br><p>ID of the function that the scaling policy belongs to.</p> 
scalingPolicies[].<br>tag | **string**<br><p>Tag of the version that the scaling policy belongs to. For details, see <a href="/docs/functions/concepts/function#tag">Version tag</a>.</p> 
scalingPolicies[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp for the scaling policy</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
scalingPolicies[].<br>modifiedAt | **string** (date-time)<br><p>Modification timestamp for the scaling policy</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
scalingPolicies[].<br>provisionedInstancesCount | **string** (int64)<br><p>Minimum guaranteed provisioned instances count for all zones in total. Billed separately.</p> 
scalingPolicies[].<br>zoneInstancesLimit | **string** (int64)<br><p>Upper limit for instance count in each zone. 0 means no limit.</p> 
scalingPolicies[].<br>zoneRequestsLimit | **string** (int64)<br><p>Upper limit of requests count in each zone. 0 means no limit.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/functions/functions/api-ref/Function/listScalingPolicies#query_params">pageSize</a>, use ``nextPageToken`` as the value for the <a href="/docs/functions/functions/api-ref/Function/listScalingPolicies#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``nextPageToken`` to continue paging through the results.</p> 