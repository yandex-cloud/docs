---
editable: false
---

# Method write
Write log entries to specified destination.
 

 
## HTTP request {#https-request}
```
POST https://logging.api.cloud.yandex.net/logging/v1/write
```
 
## Body parameters {#body_params}
 
```json 
{
  "destination": {

    // `destination` includes only one of the fields `logGroupId`, `folderId`
    "logGroupId": "string",
    "folderId": "string",
    // end of the list of possible fields`destination`

  },
  "resource": {
    "type": "string",
    "id": "string"
  },
  "entries": [
    {
      "timestamp": "string",
      "level": "string",
      "message": "string",
      "jsonPayload": "object"
    }
  ]
}
```

 
Field | Description
--- | ---
destination | **object**<br><p>Required. Log entries destination.</p> <p>See ``Destination`` for details.</p> 
destination.<br>logGroupId | **string** <br>`destination` includes only one of the fields `logGroupId`, `folderId`<br><br><p>Entry should be written to log group resolved by ID.</p> <p>The maximum string length in characters is 64.</p> 
destination.<br>folderId | **string** <br>`destination` includes only one of the fields `logGroupId`, `folderId`<br><br><p>Entry should be written to default log group for the folder.</p> <p>The maximum string length in characters is 64.</p> 
resource | **object**<br><p>Common resource (type, ID) specification for log entries.</p> <p>Log entry resource specification.</p> <p>May be used either by services and by user.</p> 
resource.<br>type | **string**<br><p>Resource type, i.e., ``serverless.function``</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{1,62})?``.</p> 
resource.<br>id | **string**<br><p>Resource ID, i.e., ID of the function producing logs.</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{1,62})?``.</p> 
entries[] | **object**<br><p>List of log entries.</p> <p>The maximum number of elements is 100.</p> 
entries[].<br>timestamp | **string** (date-time)<br><p>Required. Timestamp of the entry.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
entries[].<br>level | **string**<br><p>Entry severity.</p> <p>See ``LogLevelLevel`` for details.</p> <p>Possible log levels for entries.</p> <ul> <li>LEVEL_UNSPECIFIED: Default log level.</li> </ul> <p>Equivalent to not specifying log level at all.</p> <ul> <li>TRACE: Trace log level.</li> </ul> <p>Possible use case: verbose logging of some business logic.</p> <ul> <li>DEBUG: Debug log level.</li> </ul> <p>Possible use case: debugging special cases in application logic.</p> <ul> <li>INFO: Info log level.</li> </ul> <p>Mostly used for information messages.</p> <ul> <li>WARN: Warn log level.</li> </ul> <p>May be used to alert about significant events.</p> <ul> <li>ERROR: Error log level.</li> </ul> <p>May be used to alert about errors in infrastructure, logic, etc.</p> <ul> <li>FATAL: Fatal log level.</li> </ul> <p>May be used to alert about unrecoverable failures and events.</p> 
entries[].<br>message | **string**<br><p>Entry text message.</p> <p>The maximum string length in characters is 65536.</p> 
entries[].<br>jsonPayload | **object**<br><p>Entry annotation.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "errors": "object"
}
```

 
Field | Description
--- | ---
errors | **object**<br><p>Map&lt;idx, status&gt; of ingest failures.</p> <p>If entry with idx N is absent, it was ingested successfully.</p> 