---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Method listScalingPolicies
Lists existing scaling policies for specified function
 

 
## HTTP request {#https-request}
```
GET https://serverless-functions.api.cloud.yandex.net/functions/v1/functions/{functionId}/scalingPolicies
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
functionId | Required. ID of the function to retrieve scaling policies for.  To get a function ID, make a [list](/docs/functions/functions/api-ref/Function/list) request.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page that should be returned. If the number of available results is larger than `pageSize`, the service returns a [nextPageToken](/docs/functions/functions/api-ref/Function/listScalingPolicies#responses) that can be used to get the next page of results in subsequent list requests.  Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set `pageToken` to the [nextPageToken](/docs/functions/functions/api-ref/Function/listScalingPolicies#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
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
scalingPolicies[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp for the scaling policy</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
scalingPolicies[].<br>modifiedAt | **string** (date-time)<br><p>Modification timestamp for the scaling policy</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
scalingPolicies[].<br>zoneInstancesLimit | **string** (int64)<br><p>Upper limit for instance count in each zone. 0 means no limit.</p> 
scalingPolicies[].<br>zoneRequestsLimit | **string** (int64)<br><p>Upper limit of requests count in each zone. 0 means no limit.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/functions/functions/api-ref/Function/listScalingPolicies#query_params">pageSize</a>, use ``nextPageToken`` as the value for the <a href="/docs/functions/functions/api-ref/Function/listScalingPolicies#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``nextPageToken`` to continue paging through the results.</p> 