---
editable: false
sourcePath: en/_api-ref/containerregistry/api-ref/Image/list.md
---

# Method list
Retrieves the list of Image resources in the specified registry or repository.
 

 
## HTTP request {#https-request}
```
GET https://container-registry.{{ api-host }}/container-registry/v1/images
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
registryId | <p>ID of the registry to list Docker images in.</p> <p><a href="/docs/container-registry/api-ref/Image/list#query_params">registryId</a> is ignored if a <a href="/docs/container-registry/api-ref/Image/list#query_params">repositoryName</a> is specified in the request.</p> <p>To get the registry ID use a <a href="/docs/container-registry/api-ref/Registry/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
repositoryName | <p>Name of the repository to list Docker images in.</p> <p>To get the repository name use a <a href="/docs/container-registry/api-ref/Repository/list">list</a> request.</p> <p>Value must match the regular expression ``\|[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))*``.</p> 
folderId | <p>ID of the folder to list Docker images in.</p> <p><a href="/docs/container-registry/api-ref/Image/list#query_params">folderId</a> is ignored if a <a href="/docs/container-registry/api-ref/Image/list#query_params">repositoryName</a> or a <a href="/docs/container-registry/api-ref/Image/list#query_params">registryId</a> are specified in the request.</p> <p>To get the folder ID use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/container-registry/api-ref/Image/list#query_params">pageSize</a>, the service returns a <a href="/docs/container-registry/api-ref/Image/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/container-registry/api-ref/Image/list#query_params">pageToken</a> to the <a href="/docs/container-registry/api-ref/Image/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on <a href="/docs/container-registry/api-ref/Image#representation">Image.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be a maximum of 256 characters long and match the regular expression ``[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
orderBy | <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "images": [
    {
      "id": "string",
      "name": "string",
      "digest": "string",
      "compressedSize": "string",
      "config": {
        "id": "string",
        "digest": "string",
        "size": "string",
        "urls": [
          "string"
        ]
      },
      "layers": [
        {
          "id": "string",
          "digest": "string",
          "size": "string",
          "urls": [
            "string"
          ]
        }
      ],
      "tags": [
        "string"
      ],
      "createdAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
images[] | **object**<br><p>List of Image resources.</p> 
images[].<br>id | **string**<br><p>Output only. ID of the Docker image.</p> 
images[].<br>name | **string**<br><p>Name of the Docker image. The name is unique within the registry.</p> 
images[].<br>digest | **string**<br><p>Content-addressable identifier of the Docker image.</p> 
images[].<br>compressedSize | **string** (int64)<br><p>Compressed size of the Docker image, specified in bytes.</p> 
images[].<br>config | **object**<br><p>Configuration of the Docker image.</p> <p>A Blob resource.</p> 
images[].<br>config.<br>id | **string**<br><p>Output only. ID of the blob.</p> 
images[].<br>config.<br>digest | **string**<br><p>Content-addressable identifier of the blob.</p> 
images[].<br>config.<br>size | **string** (int64)<br><p>Size of the blob, specified in bytes.</p> 
images[].<br>config.<br>urls[] | **string**<br><p>List of blob urls.</p> 
images[].<br>layers[] | **object**<br><p>Layers of the Docker image.</p> 
images[].<br>layers[].<br>id | **string**<br><p>Output only. ID of the blob.</p> 
images[].<br>layers[].<br>digest | **string**<br><p>Content-addressable identifier of the blob.</p> 
images[].<br>layers[].<br>size | **string** (int64)<br><p>Size of the blob, specified in bytes.</p> 
images[].<br>layers[].<br>urls[] | **string**<br><p>List of blob urls.</p> 
images[].<br>tags[] | **string**<br><p>Tags of the Docker image.</p> <p>Each tag is unique within the repository.</p> 
images[].<br>createdAt | **string** (date-time)<br><p>Output only. Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/container-registry/api-ref/Image/list#query_params">pageSize</a>, use the <a href="/docs/container-registry/api-ref/Image/list#responses">nextPageToken</a> as the value for the <a href="/docs/container-registry/api-ref/Image/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/container-registry/api-ref/Image/list#responses">nextPageToken</a> to continue paging through the results.</p> 