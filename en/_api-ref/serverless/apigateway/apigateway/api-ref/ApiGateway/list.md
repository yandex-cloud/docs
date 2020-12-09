---
editable: false
---

# Method list
Retrieves the list of API gateways in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://serverless-apigateway.api.cloud.yandex.net/apigateways/v1/apigateways
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list API gateways in.  To get a folder ID make a [list](/docs/resource-manager/api-ref/Folder/list) request.
pageSize | The maximum number of results per page to return. If the number of available results is larger than `pageSize`, the service returns a [nextPageToken](/docs/functions/api-gateway/api-ref/ApiGateway/list#responses) that can be used to get the next page of results in subsequent list requests.  Default value: 100.
pageToken | Page token. To get the next page of results, set `pageToken` to the [nextPageToken](/docs/functions/api-gateway/api-ref/ApiGateway/list#responses) returned by a previous list request.
filter | A filter expression that filters functions listed in the response.  The expression must specify: 1. The field name. Currently filtering can only be applied to the [ApiGateway.name](/docs/functions/api-gateway/api-ref/ApiGateway#representation) field. 2. A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 1-63 characters long and match the regular expression `^[a-z]([-a-z0-9]{0,61}[a-z0-9])?$`. Example of a filter: `name=my-apigw`.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "apiGateways": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "status": "string",
      "domain": "string",
      "logGroupId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
apiGateways[] | **object**<br><p>List of API gateways in the specified folder.</p> 
apiGateways[].<br>id | **string**<br><p>ID of the API gateway. Generated at creation time.</p> 
apiGateways[].<br>folderId | **string**<br><p>ID of the folder that the API gateway belongs to.</p> 
apiGateways[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp for the API-gateway.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
apiGateways[].<br>name | **string**<br><p>Name of the API gateway. The name is unique within the folder.</p> 
apiGateways[].<br>description | **string**<br><p>Description of the API gateway.</p> 
apiGateways[].<br>labels | **object**<br><p>API gateway labels as `key:value` pairs.</p> 
apiGateways[].<br>status | **string**<br><p>Status of the API gateway.</p> <ul> <li>CREATING: API gateway is being created.</li> <li>ACTIVE: API gateway is ready for use.</li> <li>DELETING: API gateway is being deleted.</li> <li>ERROR: API gateway failed. The only allowed action is delete.</li> <li>UPDATING: API gateway is being updated.</li> </ul> 
apiGateways[].<br>domain | **string**<br><p>Default domain for the API gateway. Generated at creation time.</p> 
apiGateways[].<br>logGroupId | **string**<br><p>ID of the log group for the API gateway.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/functions/api-gateway/api-ref/ApiGateway/list#query_params">pageSize</a>, use `nextPageToken` as the value for the <a href="/docs/functions/api-gateway/api-ref/ApiGateway/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own `nextPageToken` to continue paging through the results.</p> 