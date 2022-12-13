---
editable: false
sourcePath: en/_api-ref/serverless/functions/functions/api-ref/Function/listTagHistory.md
---

# Cloud Functions Service, REST: Function.listTagHistory
Returns the log of tags assigned to versions of the specified function.
 

 
## HTTP request {#https-request}
```
GET https://serverless-functions.{{ api-host }}/functions/v1/functions/{functionId}:tagHistory
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
functionId | <p>Required. ID of the function to retrieve tag history for.</p> <p>To get a function ID, make a <a href="/docs/functions/functions/api-ref/Function/list">list</a> request.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
tag | <p>Specific tag that history should be limited to.</p> <p>Value must match the regular expression ``[a-z][-_0-9a-z]*\|[$]latest``.</p> 
pageSize | <p>The maximum number of results per page that should be returned. If the number of available results is larger than ``pageSize``, the service returns a <a href="/docs/functions/functions/api-ref/Function/listOperations#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set ``pageToken`` to the <a href="/docs/functions/functions/api-ref/Function/listOperations#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently filtering can only be applied to the [FunctionTagHistoryRecord.effective_from] and [FunctionTagHistoryRecord.effective_to] fields.</li> <li>An ``=`` or ``&gt;`` or ``&lt;`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``. For example, ``effective_to&gt;2021-01-01T12:00:00Z``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "functionTagHistoryRecord": [
    {
      "functionId": "string",
      "functionVersionId": "string",
      "tag": "string",
      "effectiveFrom": "string",
      "effectiveTo": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
functionTagHistoryRecord[] | **object**<br><p>Set of relevant tag history records.</p> 
functionTagHistoryRecord[].<br>functionId | **string**<br><p>ID of the function that the record is about.</p> 
functionTagHistoryRecord[].<br>functionVersionId | **string**<br><p>ID of the function version that the record is about.</p> 
functionTagHistoryRecord[].<br>tag | **string**<br><p>Tag that was set for the version at some point.</p> 
functionTagHistoryRecord[].<br>effectiveFrom | **string** (date-time)<br><p>Timestamp when the tag started being active for the function.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
functionTagHistoryRecord[].<br>effectiveTo | **string** (date-time)<br><p>Timestamp when the tag stopped being active for the function.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/functions/functions/api-ref/Function/listTagHistory#query_params">pageSize</a>, use ``nextPageToken`` as the value for the <a href="/docs/functions/functions/api-ref/Function/listTagHistory#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``nextPageToken`` to continue paging through the results.</p> 