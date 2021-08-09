---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Method listDryRunResultAffectedImages
Retrieves the list of the affected images.
 

 
## HTTP request {#https-request}
```
GET https://container-registry.api.cloud.yandex.net/container-registry/v1/dryRunLifecyclePolicyResults/{dryRunLifecyclePolicyResultId}:affectedImages
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
dryRunLifecyclePolicyResultId | Required. ID of the dry run result of the lifecycle policy  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/container-registry/api-ref/LifecyclePolicy/listDryRunResultAffectedImages#responses) that can be used to get the next page of results in subsequent list requests.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set `page_token` to the [nextPageToken](/docs/container-registry/api-ref/LifecyclePolicy/listDryRunResultAffectedImages#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters affected images listed in the response.  The expression must specify: 1. The field name. Currently you can use filtering only on [LifecyclePolicy.name](/docs/container-registry/api-ref/LifecyclePolicy#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`.  The maximum string length in characters is 1000.
orderBy | Sorting the list by [LifecyclePolicy.name](/docs/container-registry/api-ref/LifecyclePolicy#representation) and [LifecyclePolicy.createdAt](/docs/container-registry/api-ref/LifecyclePolicy#representation) fields. The default sorting order is ascending.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "affectedImages": [
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
affectedImages[] | **object**<br><p>An Image resource. For more information, see <a href="/docs/cloud/container-registry/docker-image">Docker image</a>.</p> 
affectedImages[].<br>id | **string**<br><p>Output only. ID of the Docker image.</p> 
affectedImages[].<br>name | **string**<br><p>Name of the Docker image. The name is unique within the registry.</p> 
affectedImages[].<br>digest | **string**<br><p>Content-addressable identifier of the Docker image.</p> 
affectedImages[].<br>compressedSize | **string** (int64)<br><p>Compressed size of the Docker image, specified in bytes.</p> 
affectedImages[].<br>config | **object**<br><p>Configuration of the Docker image.</p> <p>A Blob resource.</p> 
affectedImages[].<br>config.<br>id | **string**<br><p>Output only. ID of the blob.</p> 
affectedImages[].<br>config.<br>digest | **string**<br><p>Content-addressable identifier of the blob.</p> 
affectedImages[].<br>config.<br>size | **string** (int64)<br><p>Size of the blob, specified in bytes.</p> 
affectedImages[].<br>config.<br>urls[] | **string**<br><p>List of blob urls.</p> 
affectedImages[].<br>layers[] | **object**<br><p>A Blob resource.</p> 
affectedImages[].<br>layers[].<br>id | **string**<br><p>Output only. ID of the blob.</p> 
affectedImages[].<br>layers[].<br>digest | **string**<br><p>Content-addressable identifier of the blob.</p> 
affectedImages[].<br>layers[].<br>size | **string** (int64)<br><p>Size of the blob, specified in bytes.</p> 
affectedImages[].<br>layers[].<br>urls[] | **string**<br><p>List of blob urls.</p> 
affectedImages[].<br>tags[] | **string**<br><p>Tags of the Docker image.</p> <p>Each tag is unique within the repository.</p> 
affectedImages[].<br>createdAt | **string** (date-time)<br><p>Output only. Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/container-registry/api-ref/LifecyclePolicy/listDryRunResultAffectedImages#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/container-registry/api-ref/LifecyclePolicy/listDryRunResultAffectedImages#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 