---
editable: false
---

# Method list
Retrieves the list of Registry resources in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://container-registry.api.cloud.yandex.net/container-registry/v1/registries
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list registries in.  To get the folder ID use a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/container-registry/api-ref/Registry/list#query_params), the service returns a [nextPageToken](/docs/container-registry/api-ref/Registry/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/container-registry/api-ref/Registry/list#query_params) to the [nextPageToken](/docs/container-registry/api-ref/Registry/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on [Registry.name](/docs/container-registry/api-ref/Registry#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. Value or a list of values to compare against the values of the field.  The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "registries": [
    {
      "id": "string",
      "folderId": "string",
      "name": "string",
      "status": "string",
      "createdAt": "string",
      "labels": "object"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
registries[] | **object**<br><p>A Registry resource. For more information, see <a href="/docs/cloud/containerregistry/registry">Registry</a>.</p> 
registries[].<br>id | **string**<br><p>Output only. ID of the registry.</p> 
registries[].<br>folderId | **string**<br><p>ID of the folder that the registry belongs to.</p> 
registries[].<br>name | **string**<br><p>Name of the registry.</p> 
registries[].<br>status | **string**<br><p>Output only. Status of the registry.</p> <ul> <li>CREATING: Registry is being created.</li> <li>ACTIVE: Registry is ready to use.</li> <li>DELETING: Registry is being deleted.</li> </ul> 
registries[].<br>createdAt | **string** (date-time)<br><p>Output only. Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
registries[].<br>labels | **object**<br><p>Resource labels as `key:value` pairs. Maximum of 64 per resource.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/container-registry/api-ref/Registry/list#query_params">pageSize</a>, use the <a href="/docs/container-registry/api-ref/Registry/list#responses">nextPageToken</a> as the value for the <a href="/docs/container-registry/api-ref/Registry/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/container-registry/api-ref/Registry/list#responses">nextPageToken</a> to continue paging through the results.</p> 