---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Method listTagHistory
Returns the log of tags assigned to versions of the specified function.
 

 
## HTTP request {#https-request}
```
GET https://serverless-functions.api.cloud.yandex.net/functions/v1/functions/{functionId}:tagHistory
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
functionId | Required. ID of the function to retrieve tag history for.  To get a function ID, make a [list](/docs/functions/functions/api-ref/Function/list) request.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
tag | Specific tag that history should be limited to.  Value must match the regular expression `` [a-z][-_0-9a-z]*|[$]latest ``.
pageSize | The maximum number of results per page that should be returned. If the number of available results is larger than `pageSize`, the service returns a [nextPageToken](/docs/functions/functions/api-ref/Function/listOperations#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set `pageToken` to the [nextPageToken](/docs/functions/functions/api-ref/Function/listOperations#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response.  The expression must specify: 1. The field name. Currently filtering can only be applied to the [Function.name](/docs/functions/functions/api-ref/Function#representation) field. 2. A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. For example, `name=my-function`.  The maximum string length in characters is 1000.
 
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
functionTagHistoryRecord[] | **object**<br><p>A record in the tag history.</p> 
functionTagHistoryRecord[].<br>functionId | **string**<br><p>ID of the function that the record is about.</p> 
functionTagHistoryRecord[].<br>functionVersionId | **string**<br><p>ID of the function version that the record is about.</p> 
functionTagHistoryRecord[].<br>tag | **string**<br><p>Tag that was set for the version at some point.</p> 
functionTagHistoryRecord[].<br>effectiveFrom | **string** (date-time)<br><p>Timestamp when the tag started being active for the function.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
functionTagHistoryRecord[].<br>effectiveTo | **string** (date-time)<br><p>Timestamp when the tag stopped being active for the function.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/functions/functions/api-ref/Function/listTagHistory#query_params">pageSize</a>, use ``nextPageToken`` as the value for the <a href="/docs/functions/functions/api-ref/Function/listTagHistory#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``nextPageToken`` to continue paging through the results.</p> 