---
editable: false
sourcePath: en/_api-ref/logging/v1/api-ref/Sink/list.md
---

# Cloud Logging Service, REST: Sink.list
Retrieves the list of sinks in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://logging.{{ api-host }}/logging/v1/sinks
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. Folder ID of the sinks to return.</p> <p>To get a folder ID make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 64.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a [ListSinkssResponse.next_page_token] that can be used to get the next page of results in subsequent list requests.</p> <p>Default value: 100.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/logging/api-ref/Sink/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters sinks listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently filtering can only be applied to the <a href="/docs/logging/api-ref/Sink#representation">Sink.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``name="my-sink"``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "sinks": [
    {
      "id": "string",
      "folderId": "string",
      "cloudId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "serviceAccountId": "string",

      // `sinks[]` includes only one of the fields `yds`, `s3`
      "yds": {
        "streamName": "string"
      },
      "s3": {
        "bucket": "string",
        "prefix": "string"
      },
      // end of the list of possible fields`sinks[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
sinks[] | **object**<br><p>List of sinks in the specified folder.</p> 
sinks[].<br>id | **string**<br><p>Sink ID.</p> 
sinks[].<br>folderId | **string**<br><p>Sink folder ID.</p> 
sinks[].<br>cloudId | **string**<br><p>Sink cloud ID.</p> 
sinks[].<br>createdAt | **string** (date-time)<br><p>Sink creation time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
sinks[].<br>name | **string**<br><p>Sink name.</p> 
sinks[].<br>description | **string**<br><p>Sink description.</p> 
sinks[].<br>labels | **object**<br><p>Sink labels.</p> 
sinks[].<br>serviceAccountId | **string**<br><p>Logs will be written to the sink on behalf of this service account</p> 
sinks[].<br>yds | **object**<br>Yandex data stream <br>`sinks[]` includes only one of the fields `yds`, `s3`<br>
sinks[].<br>yds.<br>streamName | **string**<br><p>Fully qualified name of data stream</p> <p>The maximum string length in characters is 512.</p> 
sinks[].<br>s3 | **object**<br>Object storage <br>`sinks[]` includes only one of the fields `yds`, `s3`<br>
sinks[].<br>s3.<br>bucket | **string**<br><p>Object storage bucket</p> <p>Value must match the regular expression ``[a-zA-Z0-9][-a-zA-Z0-9.]{2,62}``.</p> 
sinks[].<br>s3.<br>prefix | **string**<br><p>Prefix to use for saved log object names</p> <p>The maximum string length in characters is 1024.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/logging/api-ref/Sink/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/logging/api-ref/Sink/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 