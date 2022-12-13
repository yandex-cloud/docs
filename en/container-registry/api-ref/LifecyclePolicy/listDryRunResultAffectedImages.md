---
editable: false
sourcePath: en/_api-ref/containerregistry/api-ref/LifecyclePolicy/listDryRunResultAffectedImages.md
---

# Container Registry API, REST: LifecyclePolicy.listDryRunResultAffectedImages
Retrieves the list of the affected images.
 

 
## HTTP request {#https-request}
```
GET https://container-registry.{{ api-host }}/container-registry/v1/dryRunLifecyclePolicyResults/{dryRunLifecyclePolicyResultId}:affectedImages
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
dryRunLifecyclePolicyResultId | <p>Required. ID of the dry run result of the lifecycle policy</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/container-registry/api-ref/LifecyclePolicy/listDryRunResultAffectedImages#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/container-registry/api-ref/LifecyclePolicy/listDryRunResultAffectedImages#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters affected images listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on <a href="/docs/container-registry/api-ref/LifecyclePolicy#representation">LifecyclePolicy.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
orderBy | <p>Sorting the list by <a href="/docs/container-registry/api-ref/LifecyclePolicy#representation">LifecyclePolicy.name</a> and <a href="/docs/container-registry/api-ref/LifecyclePolicy#representation">LifecyclePolicy.createdAt</a> fields. The default sorting order is ascending.</p> <p>The maximum string length in characters is 100.</p> 
 
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
affectedImages[] | **object**<br><p>List of affected images.</p> 
affectedImages[].<br>id | **string**<br><p>Output only. ID of the Docker image.</p> 
affectedImages[].<br>name | **string**<br><p>Name of the Docker image. The name is unique within the registry.</p> 
affectedImages[].<br>digest | **string**<br><p>Content-addressable identifier of the Docker image.</p> 
affectedImages[].<br>compressedSize | **string** (int64)<br><p>Compressed size of the Docker image, specified in bytes.</p> 
affectedImages[].<br>config | **object**<br><p>Configuration of the Docker image.</p> <p>A Blob resource.</p> 
affectedImages[].<br>config.<br>id | **string**<br><p>Output only. ID of the blob.</p> 
affectedImages[].<br>config.<br>digest | **string**<br><p>Content-addressable identifier of the blob.</p> 
affectedImages[].<br>config.<br>size | **string** (int64)<br><p>Size of the blob, specified in bytes.</p> 
affectedImages[].<br>config.<br>urls[] | **string**<br><p>List of blob urls.</p> 
affectedImages[].<br>layers[] | **object**<br><p>Layers of the Docker image.</p> 
affectedImages[].<br>layers[].<br>id | **string**<br><p>Output only. ID of the blob.</p> 
affectedImages[].<br>layers[].<br>digest | **string**<br><p>Content-addressable identifier of the blob.</p> 
affectedImages[].<br>layers[].<br>size | **string** (int64)<br><p>Size of the blob, specified in bytes.</p> 
affectedImages[].<br>layers[].<br>urls[] | **string**<br><p>List of blob urls.</p> 
affectedImages[].<br>tags[] | **string**<br><p>Tags of the Docker image.</p> <p>Each tag is unique within the repository.</p> 
affectedImages[].<br>createdAt | **string** (date-time)<br><p>Output only. Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/container-registry/api-ref/LifecyclePolicy/listDryRunResultAffectedImages#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/container-registry/api-ref/LifecyclePolicy/listDryRunResultAffectedImages#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 