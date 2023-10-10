---
editable: false
sourcePath: en/_api-ref/logging/v1/api-ref/Export/list.md
---

# Cloud Logging Service, REST: Export.list
Retrieves the list of exports in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://logging.{{ api-host }}/logging/v1/exports
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. Folder ID of the exports to return.</p> <p>To get a folder ID make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 64.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a [ListExportssResponse.next_page_token] that can be used to get the next page of results in subsequent list requests.</p> <p>Default value: 100.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/logging/api-ref/Export/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters exports listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently filtering can only be applied to the <a href="/docs/logging/api-ref/Export#representation">Export.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``name="my-export"``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "exports": [
    {
      "id": "string",
      "folderId": "string",
      "cloudId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "groupId": "string",
      "sinkId": "string",
      "params": {
        "resourceTypes": [
          "string"
        ],
        "resourceIds": [
          "string"
        ],
        "streamNames": [
          "string"
        ],
        "levels": [
          "string"
        ],
        "filter": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
exports[] | **object**<br><p>List of exports in the specified folder.</p> 
exports[].<br>id | **string**<br><p>Export ID.</p> 
exports[].<br>folderId | **string**<br><p>Export folder ID.</p> 
exports[].<br>cloudId | **string**<br><p>Export cloud ID.</p> 
exports[].<br>createdAt | **string** (date-time)<br><p>Export creation time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
exports[].<br>name | **string**<br><p>Export name.</p> 
exports[].<br>description | **string**<br><p>Export description.</p> 
exports[].<br>labels | **object**<br><p>Export lables.</p> 
exports[].<br>groupId | **string**<br><p>Group logs are exported from.</p> 
exports[].<br>sinkId | **string**<br><p>Sink logs are exported to.</p> 
exports[].<br>params | **object**<br><p>Parameters of logs filtration.</p> 
exports[].<br>params.<br>resourceTypes[] | **string**<br><p>The maximum number of elements is 100. The maximum string length in characters for each value is 63.</p> 
exports[].<br>params.<br>resourceIds[] | **string**<br><p>The maximum number of elements is 100. The maximum string length in characters for each value is 63.</p> 
exports[].<br>params.<br>streamNames[] | **string**<br><p>The maximum number of elements is 100. The maximum string length in characters for each value is 63.</p> 
exports[].<br>params.<br>levels[] | **string**<br><p>The maximum number of elements is 10.</p> <ul> <li> <p>TRACE: Trace log level.</p> <p>Possible use case: verbose logging of some business logic.</p> </li> <li> <p>DEBUG: Debug log level.</p> <p>Possible use case: debugging special cases in application logic.</p> </li> <li> <p>INFO: Info log level.</p> <p>Mostly used for information messages.</p> </li> <li> <p>WARN: Warn log level.</p> <p>May be used to alert about significant events.</p> </li> <li> <p>ERROR: Error log level.</p> <p>May be used to alert about errors in infrastructure, logic, etc.</p> </li> <li> <p>FATAL: Fatal log level.</p> <p>May be used to alert about unrecoverable failures and events.</p> </li> </ul> 
exports[].<br>params.<br>filter | **string**<br><p>The maximum string length in characters is 1000.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/logging/api-ref/Export/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/logging/api-ref/Export/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 