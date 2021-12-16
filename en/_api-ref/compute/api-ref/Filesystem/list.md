---
editable: false
---

# Method list
Lists filesystems in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/filesystems
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list filesystems in.  To get the folder ID, make a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/compute/api-ref/Filesystem/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set `page_token` to the [nextPageToken](/docs/compute/api-ref/Filesystem/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters filesystems listed in the response.  The expression must specify: 1. The field name. Currently you can use filtering only on the [Filesystem.name](/docs/compute/api-ref/Filesystem#representation) field. 2. An `=` operator. 3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z]([-a-z0-9]{,61}[a-z0-9])?`. Example of a filter: `name=my-filesystem`.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "filesystems": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "typeId": "string",
      "zoneId": "string",
      "size": "string",
      "blockSize": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
filesystems[] | **object**<br><p>A filesystem resource. For details about the concept, see <a href="/docs/compute/concepts/filesystem">documentation</a>.</p> 
filesystems[].<br>id | **string**<br><p>ID of the filesystem. Generated at creation time.</p> 
filesystems[].<br>folderId | **string**<br><p>ID of the folder that the filesystem belongs to.</p> 
filesystems[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
filesystems[].<br>name | **string**<br><p>Name of the filesystem. The name is unique within the folder.</p> 
filesystems[].<br>description | **string**<br><p>Description of the filesystem.</p> 
filesystems[].<br>labels | **object**<br><p>Filesystem labels as ``key:value`` pairs. For details about the concept, see <a href="/docs/overview/concepts/services#labels">documentation</a>.</p> 
filesystems[].<br>typeId | **string**<br><p>ID of the filesystem type.</p> <p>To get a list of available filesystem types, make a <a href="/docs/compute/api-ref/DiskType/list">list</a> request.</p> 
filesystems[].<br>zoneId | **string**<br><p>ID of the availability zone where the filesystem resides.</p> <p>A filesystem can be attached only to instances residing in the same availability zone.</p> 
filesystems[].<br>size | **string** (int64)<br><p>Size of the filesystem, specified in bytes.</p> 
filesystems[].<br>blockSize | **string** (int64)<br><p>Block size used for the filesystem, specified in bytes.</p> 
filesystems[].<br>status | **string**<br><p>Current status of the filesystem.</p> <ul> <li>CREATING: The filesystem is being created.</li> <li>READY: The filesystem is ready to use.</li> <li>ERROR: The filesystem encountered a problem and cannot operate.</li> <li>DELETING: The filesystem is being deleted.</li> </ul> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/compute/api-ref/Filesystem/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/compute/api-ref/Filesystem/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 