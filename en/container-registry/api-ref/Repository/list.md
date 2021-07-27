---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Method list
Retrieves the list of Repository resources in the specified registry.
 

 
## HTTP request {#https-request}
```
GET https://container-registry.api.cloud.yandex.net/container-registry/v1/repositories
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
registryId | ID of the registry to list repositories in.  To get the registry ID use a [list](/docs/container-registry/api-ref/Registry/list) request.  The maximum string length in characters is 50.
folderId | ID of the folder to list registries in.  [folderId](/docs/container-registry/api-ref/Repository/list#query_params) is ignored if a [registryId](/docs/container-registry/api-ref/Image/list#query_params) is specified in the request.  To get the folder ID use a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/container-registry/api-ref/Repository/list#query_params), the service returns a [nextPageToken](/docs/container-registry/api-ref/Repository/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/container-registry/api-ref/Repository/list#query_params) to the [nextPageToken](/docs/container-registry/api-ref/Repository/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on [Repository.name](/docs/container-registry/api-ref/Repository#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. Value or a list of values to compare against the values of the field.  The maximum string length in characters is 1000.
orderBy | The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "repositories": [
    {
      "name": "string",
      "id": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
repositories[] | **object**<br><p>A Repository resource. For more information, see <a href="/docs/cloud/container-registry/repository">Repository</a>.</p> 
repositories[].<br>name | **string**<br><p>Name of the repository. The name is unique within the registry.</p> 
repositories[].<br>id | **string**<br><p>Output only. ID of the repository.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/container-registry/api-ref/Repository/list#query_params">pageSize</a>, use the <a href="/docs/container-registry/api-ref/Repository/list#responses">nextPageToken</a> as the value for the <a href="/docs/container-registry/api-ref/Repository/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/container-registry/api-ref/Repository/list#responses">nextPageToken</a> to continue paging through the results.</p> 