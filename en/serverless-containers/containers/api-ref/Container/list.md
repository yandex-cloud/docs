---
editable: false
sourcePath: en/_api-ref/serverless/containers/v1/containers/api-ref/Container/list.md
---

# Serverless Containers Service, REST: Container.list
Retrieves the list of containers in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://serverless-containers.{{ api-host }}/containers/v1/containers
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list containers in.</p> <p>To get a folder ID make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``pageSize``, the service returns a <a href="/docs/serverless/containers/api-ref/Container/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>Default value: 100.</p> 
pageToken | <p>Page token. To get the next page of results, set ``pageToken`` to the <a href="/docs/serverless/containers/api-ref/Container/list#responses">nextPageToken</a> returned by a previous list request.</p> 
filter | <p>A filter expression that filters containers listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently filtering can only be applied to the <a href="/docs/serverless/containers/api-ref/Container#representation">Container.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``name="my-container"``.</li> </ol> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "containers": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "url": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
containers[] | **object**<br><p>List of containers in the specified folder.</p> 
containers[].<br>id | **string**<br><p>ID of the container. Generated at creation time.</p> 
containers[].<br>folderId | **string**<br><p>ID of the folder that the container belongs to.</p> 
containers[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp for the container.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
containers[].<br>name | **string**<br><p>Name of the container. The name is unique within the folder.</p> 
containers[].<br>description | **string**<br><p>Description of the container.</p> 
containers[].<br>labels | **object**<br><p>Container labels as ``key:value`` pairs.</p> 
containers[].<br>url | **string**<br><p>URL that needs to be requested to call the container.</p> 
containers[].<br>status | **string**<br><p>Status of the container.</p> <ul> <li>CREATING: Container is being created.</li> <li>ACTIVE: Container is ready for use.</li> <li>DELETING: Container is being deleted.</li> <li>ERROR: Container failed. The only allowed action is delete.</li> </ul> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/serverless/containers/api-ref/Container/list#query_params">pageSize</a>, use ``nextPageToken`` as the value for the <a href="/docs/serverless/containers/api-ref/Container/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``nextPageToken`` to continue paging through the results.</p> 