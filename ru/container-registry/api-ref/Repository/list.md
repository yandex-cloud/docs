---
editable: false
sourcePath: en/_api-ref/containerregistry/api-ref/Repository/list.md
---

# Container Registry API, REST: Repository.list
Retrieves the list of Repository resources in the specified registry.
 

 
## HTTP request {#https-request}
```
GET https://container-registry.{{ api-host }}/container-registry/v1/repositories
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
registryId | <p>ID of the registry to list repositories in.</p> <p>To get the registry ID use a <a href="/docs/container-registry/api-ref/Registry/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
folderId | <p>ID of the folder to list registries in.</p> <p><a href="/docs/container-registry/api-ref/Repository/list#query_params">folderId</a> is ignored if a <a href="/docs/container-registry/api-ref/Image/list#query_params">registryId</a> is specified in the request.</p> <p>To get the folder ID use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/container-registry/api-ref/Repository/list#query_params">pageSize</a>, the service returns a <a href="/docs/container-registry/api-ref/Repository/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/container-registry/api-ref/Repository/list#query_params">pageToken</a> to the <a href="/docs/container-registry/api-ref/Repository/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on <a href="/docs/container-registry/api-ref/Repository#representation">Repository.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
orderBy | <p>The maximum string length in characters is 100.</p> 
 
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
repositories[] | **object**<br><p>List of Repository resources.</p> 
repositories[].<br>name | **string**<br><p>Name of the repository. The name is unique within the registry.</p> 
repositories[].<br>id | **string**<br><p>Output only. ID of the repository.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/container-registry/api-ref/Repository/list#query_params">pageSize</a>, use the <a href="/docs/container-registry/api-ref/Repository/list#responses">nextPageToken</a> as the value for the <a href="/docs/container-registry/api-ref/Repository/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/container-registry/api-ref/Repository/list#responses">nextPageToken</a> to continue paging through the results.</p> 