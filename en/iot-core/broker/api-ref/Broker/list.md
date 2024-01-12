---
editable: false
sourcePath: en/_api-ref/iot/broker/v1/broker/api-ref/Broker/list.md
---

# IoT Core Broker Service, REST: Broker.list
Retrieves the list of brokers in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-iot-broker }}/iot-broker/v1/brokers
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list brokers in.</p> <p>To get a folder ID make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page that should be returned. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/iot-core/broker/api-ref/Broker/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/iot-core/broker/api-ref/Broker/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "brokers": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "status": "string",
      "logOptions": {
        "disabled": true,
        "minLevel": "string",

        // `brokers[].logOptions` includes only one of the fields `logGroupId`, `folderId`
        "logGroupId": "string",
        "folderId": "string",
        // end of the list of possible fields`brokers[].logOptions`

      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
brokers[] | **object**<br><p>List of brokers.</p> 
brokers[].<br>id | **string**<br><p>ID of the broker.</p> 
brokers[].<br>folderId | **string**<br><p>ID of the folder that the broker belongs to.</p> 
brokers[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
brokers[].<br>name | **string**<br><p>Name of the broker. The name is unique within the folder.</p> 
brokers[].<br>description | **string**<br><p>Description of the broker. 0-256 characters long.</p> 
brokers[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
brokers[].<br>status | **string**<br><p>Status of the broker.</p> <ul> <li>CREATING: Broker is being created.</li> <li>ACTIVE: Broker is ready to use.</li> <li>DELETING: Broker is being deleted.</li> </ul> 
brokers[].<br>logOptions | **object**<br><p>Options for logging broker events</p> 
brokers[].<br>logOptions.<br>disabled | **boolean** (boolean)<br><p>Is logging from broker disabled.</p> 
brokers[].<br>logOptions.<br>minLevel | **string**<br>Minimum log entry level.  See [LogLevel.Level] for details.<br><ul> <li> <p>TRACE: Trace log level.</p> <p>Possible use case: verbose logging of some business logic.</p> </li> <li> <p>DEBUG: Debug log level.</p> <p>Possible use case: debugging special cases in application logic.</p> </li> <li> <p>INFO: Info log level.</p> <p>Mostly used for information messages.</p> </li> <li> <p>WARN: Warn log level.</p> <p>May be used to alert about significant events.</p> </li> <li> <p>ERROR: Error log level.</p> <p>May be used to alert about errors in infrastructure, logic, etc.</p> </li> <li> <p>FATAL: Fatal log level.</p> <p>May be used to alert about unrecoverable failures and events.</p> </li> </ul> 
brokers[].<br>logOptions.<br>logGroupId | **string** <br>`brokers[].logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>Entry should be written to log group resolved by ID.</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{0,63})?``.</p> 
brokers[].<br>logOptions.<br>folderId | **string** <br>`brokers[].logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>Entry should be written to default log group for specified folder.</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{0,63})?``.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/iot-core/broker/api-ref/Broker/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/iot-core/broker/api-ref/Broker/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 