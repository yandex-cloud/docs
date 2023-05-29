---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/GpuCluster/list.md
---

# Compute Cloud API, REST: GpuCluster.list
Retrieves the list of GPU clusters in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/gpuClusters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>ID of the folder to list GPU clusters in.</p> <p>To get the folder ID, make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/compute/api-ref/GpuCluster/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/compute/api-ref/GpuCluster/list#responses">nextPageToken</a> returned by a previous list request.</p> 
filter | <p>A filter expression that filters GPU clusters listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on <a href="/docs/compute/api-ref/GpuCluster#representation">GpuCluster.name</a> field.</li> <li>An operator. Can be either ``=`` or ``!=`` for single values, ``IN`` or ``NOT IN`` for lists of values.</li> <li>The value. Must be 3-63 characters long and match the regular expression ``^[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``name=my-schedule``.</li> </ol> 
orderBy | <p>A sorting expression that sorts GPU clusters listed in the response.</p> <p>The expression must specify the field name from <a href="/docs/compute/api-ref/GpuCluster#representation">GpuCluster</a> and ``asc``ending or ``desc``ending order, e.g. ``createdAt desc``.</p> <p>Default value: ``id asc``.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "gpuClusters": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "status": "string",
      "zoneId": "string",
      "interconnectType": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
gpuClusters[] | **object**<br><p>List of GPU clusters in the specified folder.</p> 
gpuClusters[].<br>id | **string**<br><p>ID of GPU cluster.</p> 
gpuClusters[].<br>folderId | **string**<br><p>ID of the folder that the GPU cluster belongs to.</p> 
gpuClusters[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
gpuClusters[].<br>name | **string**<br><p>Name of the GPU cluster.</p> <p>The name is unique within the folder.</p> 
gpuClusters[].<br>description | **string**<br><p>Description of the GPU cluster.</p> 
gpuClusters[].<br>labels | **object**<br><p>GPU cluster labels as ``key:value`` pairs.</p> 
gpuClusters[].<br>status | **string**<br><p>Status of the GPU cluster.</p> <ul> <li>CREATING: GPU cluster is being created.</li> <li>READY: GPU cluster is ready to use.</li> <li>ERROR: GPU cluster encountered a problem and cannot operate.</li> <li>DELETING: GPU cluster is being deleted.</li> </ul> 
gpuClusters[].<br>zoneId | **string**<br><p>ID of the availability zone where the GPU cluster resides.</p> 
gpuClusters[].<br>interconnectType | **string**<br><p>Type of interconnect used for this GPU cluster.</p> <ul> <li>INFINIBAND: InfiniBand interconnect.</li> </ul> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/compute/api-ref/GpuCluster/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/compute/api-ref/GpuCluster/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 