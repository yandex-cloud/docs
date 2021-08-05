---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Method read
Read log entries from the specified log group.
 

 
## HTTP request {#https-request}
```
GET https://logging.api.cloud.yandex.net/logging/v1/read
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageToken | Page token. To get the next page of results, set `page_token` to the [nextPageToken](/docs/logging/api-ref/LogReading/read#responses) or [previousPageToken](/docs/logging/api-ref/LogReading/read#responses) returned by a previous read request.
criteria.logGroupId | Required. ID of the log group to return.  To get a log group ID make a [list](/docs/logging/api-ref/LogGroup/list) request.  The maximum string length in characters is 64.
criteria.resourceTypes | List of resource types to limit log entries to.  Empty list disables filter.  The maximum number of elements is 100. Each value must match the regular expression `` [a-zA-Z][-a-zA-Z0-9_.]{1,62} ``.
criteria.resourceIds | List of resource IDs to limit log entries to.  Empty list disables filter.  The maximum number of elements is 100. Each value must match the regular expression `` [a-zA-Z][-a-zA-Z0-9_.]{1,62} ``.
criteria.since | Lower bound of log entries timestamps.  String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
criteria.until | Upper bound of log entries timestamps.  String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
criteria.levels | List of log levels to limit log entries to.  Empty list disables filter.  The maximum number of elements is 10.
criteria.filter | Filter expression. For details about filtering, see [documentation](/docs/logging/concepts/filter).  The maximum string length in characters is 1000.
criteria.pageSize | The maximum number of results per page to return.  Acceptable values are 1 to 1000, inclusive.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "logGroupId": "string",
  "entries": [
    {
      "uid": "string",
      "resource": {
        "type": "string",
        "id": "string"
      },
      "timestamp": "string",
      "ingestedAt": "string",
      "savedAt": "string",
      "level": "string",
      "message": "string",
      "jsonPayload": "object"
    }
  ],
  "nextPageToken": "string",
  "previousPageToken": "string"
}
```

 
Field | Description
--- | ---
logGroupId | **string**<br><p>Log group ID the read was performed from.</p> 
entries[] | **object**<br><p>List of matching log entries.</p> 
entries[].<br>uid | **string**<br><p>Unique entry ID.</p> <p>Useful for logs deduplication.</p> 
entries[].<br>resource | **object**<br><p>Entry resource specification.</p> <p>May contain information about source service and resource ID. Also may be provided by the user.</p> <p>Log entry resource specification.</p> <p>May be used either by services and by user.</p> 
entries[].<br>resource.<br>type | **string**<br><p>Resource type, i.e., ``serverless.function``</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{1,62})?``.</p> 
entries[].<br>resource.<br>id | **string**<br><p>Resource ID, i.e., ID of the function producing logs.</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{1,62})?``.</p> 
entries[].<br>timestamp | **string** (date-time)<br><p>Timestamp of the entry.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
entries[].<br>ingestedAt | **string** (date-time)<br><p>Entry ingestion time observed by ``LogIngestion``.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
entries[].<br>savedAt | **string** (date-time)<br><p>Entry save time.</p> <p>Entry is ready to be read since this moment.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
entries[].<br>level | **string**<br><p>Entry severity.</p> <p>See ``LogLevelLevel`` for details.</p> <p>Possible log levels for entries.</p> <ul> <li>LEVEL_UNSPECIFIED: Default log level.</li> </ul> <p>Equivalent to not specifying log level at all.</p> <ul> <li>TRACE: Trace log level.</li> </ul> <p>Possible use case: verbose logging of some business logic.</p> <ul> <li>DEBUG: Debug log level.</li> </ul> <p>Possible use case: debugging special cases in application logic.</p> <ul> <li>INFO: Info log level.</li> </ul> <p>Mostly used for information messages.</p> <ul> <li>WARN: Warn log level.</li> </ul> <p>May be used to alert about significant events.</p> <ul> <li>ERROR: Error log level.</li> </ul> <p>May be used to alert about errors in infrastructure, logic, etc.</p> <ul> <li>FATAL: Fatal log level.</li> </ul> <p>May be used to alert about unrecoverable failures and events.</p> 
entries[].<br>message | **string**<br><p>Entry text message.</p> 
entries[].<br>jsonPayload | **object**<br><p>Entry annotation.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the log entries.</p> <p>After getting log entries initially with ``Criteria``, you can use ``next_page_token`` as the value for the <a href="/docs/logging/api-ref/LogReading/read#query_params">pageToken</a> parameter in the next read request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 
previousPageToken | **string**<br><p>Token for getting the previous page of the log entries.</p> <p>After getting log entries initially with ``Criteria``, you can use ``previous_page_token`` as the value for the <a href="/docs/logging/api-ref/LogReading/read#query_params">pageToken</a> parameter in the next read request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 