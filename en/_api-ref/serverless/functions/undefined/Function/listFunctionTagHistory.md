---
editable: false
---

# Method listFunctionTagHistory
Deprecated. Use ListTagHistory.
 

 
## HTTP request {#https-request}
```
GET undefined/functions/v1/functions/{functionId}:tagHistory
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
functionId | Required.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
tag | Value must match the regular expression `` [a-z][-_0-9a-z]*|[$]latest ``.
pageSize | Acceptable values are 0 to 1000, inclusive.
pageToken | The maximum string length in characters is 100.
filter | The maximum string length in characters is 1000.
 
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
functionTagHistoryRecord[] | **object**<br>
functionTagHistoryRecord[].<br>functionId | **string**<br>
functionTagHistoryRecord[].<br>functionVersionId | **string**<br>
functionTagHistoryRecord[].<br>tag | **string**<br>
functionTagHistoryRecord[].<br>effectiveFrom | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
functionTagHistoryRecord[].<br>effectiveTo | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
nextPageToken | **string**<br>