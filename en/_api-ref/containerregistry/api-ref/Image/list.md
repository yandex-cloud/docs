---
editable: false
---

# Method list
Retrieves the list of Image resources in the specified registry or repository.
 

 
## HTTP request {#https-request}
```
GET https://container-registry.api.cloud.yandex.net/container-registry/v1/images
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
registryId | ID of the registry to list Docker images in.  [registryId](/docs/container-registry/api-ref/Image/list#query_params) is ignored if a [repositoryName](/docs/container-registry/api-ref/Image/list#query_params) is specified in the request.  To get the registry ID use a [list](/docs/container-registry/api-ref/Registry/list) request.  The maximum string length in characters is 50.
repositoryName | Name of the repository to list Docker images in.  To get the repository name use a [list](/docs/container-registry/api-ref/Repository/list) request.  Value must match the regular expression `` |[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))* ``.
folderId | ID of the folder to list Docker images in.  [folderId](/docs/container-registry/api-ref/Image/list#query_params) is ignored if a [repositoryName](/docs/container-registry/api-ref/Image/list#query_params) or a [registryId](/docs/container-registry/api-ref/Image/list#query_params) are specified in the request.  To get the folder ID use a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/container-registry/api-ref/Image/list#query_params), the service returns a [nextPageToken](/docs/container-registry/api-ref/Image/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/container-registry/api-ref/Image/list#query_params) to the [nextPageToken](/docs/container-registry/api-ref/Image/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on [Image.name](/docs/container-registry/api-ref/Image#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be a maximum of 256 characters and match the regular expression `[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))`.  The maximum string length in characters is 1000.
orderBy | The maximum string length in characters is 100.
 
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
images[] | **object**<br><p>An Image resource. For more information, see <a href="/docs/cloud/container-registry/docker-image">Docker image</a>.</p> 
images[].<br>id | **string**<br><p>Output only. ID of the Docker image.</p> 
images[].<br>name | **string**<br><p>Name of the Docker image. The name is unique within the registry.</p> 
images[].<br>digest | **string**<br><p>Content-addressable identifier of the Docker image.</p> 
images[].<br>compressedSize | **string** (int64)<br><p>Compressed size of the Docker image, specified in bytes.</p> 
images[].<br>config | **object**<br><p>Configuration of the Docker image.</p> <p>A Blob resource.</p> 
images[].<br>config.<br>id | **string**<br><p>Output only. ID of the blob.</p> 
images[].<br>config.<br>digest | **string**<br><p>Content-addressable identifier of the blob.</p> 
images[].<br>config.<br>size | **string** (int64)<br><p>Size of the blob, specified in bytes.</p> 
images[].<br>config.<br>urls[] | **string**<br><p>List of blob urls.</p> 
images[].<br>layers[] | **object**<br><p>A Blob resource.</p> 
images[].<br>layers[].<br>id | **string**<br><p>Output only. ID of the blob.</p> 
images[].<br>layers[].<br>digest | **string**<br><p>Content-addressable identifier of the blob.</p> 
images[].<br>layers[].<br>size | **string** (int64)<br><p>Size of the blob, specified in bytes.</p> 
images[].<br>layers[].<br>urls[] | **string**<br><p>List of blob urls.</p> 
images[].<br>tags[] | **string**<br><p>Tags of the Docker image.</p> <p>Each tag is unique within the repository.</p> 
images[].<br>createdAt | **string** (date-time)<br><p>Output only. Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/container-registry/api-ref/Image/list#query_params">pageSize</a>, use the <a href="/docs/container-registry/api-ref/Image/list#responses">nextPageToken</a> as the value for the <a href="/docs/container-registry/api-ref/Image/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/container-registry/api-ref/Image/list#responses">nextPageToken</a> to continue paging through the results.</p> 