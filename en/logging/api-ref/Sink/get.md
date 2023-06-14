---
editable: false
sourcePath: en/_api-ref/logging/v1/api-ref/Sink/get.md
---

# Cloud Logging Service, REST: Sink.get
Returns the specified sink.
 
To get the list of all available sinks, make a [list](/docs/logging/api-ref/Sink/list) request.
 
## HTTP request {#https-request}
```
GET https://logging.{{ api-host }}/logging/v1/sinks/{sinkId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
sinkId | <p>Required. ID of the sink to return.</p> <p>To get a sink ID make a <a href="/docs/logging/api-ref/Sink/list">list</a> request.</p> <p>The maximum string length in characters is 64.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "cloudId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "serviceAccountId": "string",

  //  includes only one of the fields `yds`, `s3`
  "yds": {
    "streamName": "string"
  },
  "s3": {
    "bucket": "string",
    "prefix": "string"
  },
  // end of the list of possible fields

}
```

 
Field | Description
--- | ---
id | **string**<br><p>Sink ID.</p> 
folderId | **string**<br><p>Sink folder ID.</p> 
cloudId | **string**<br><p>Sink cloud ID.</p> 
createdAt | **string** (date-time)<br><p>Sink creation time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Sink name.</p> 
description | **string**<br><p>Sink description.</p> 
labels | **object**<br><p>Sink labels.</p> 
serviceAccountId | **string**<br><p>Logs will be written to the sink on behalf of this service account</p> 
yds | **object**<br>Yandex data stream <br> includes only one of the fields `yds`, `s3`<br>
yds.<br>streamName | **string**<br><p>Fully qualified name of data stream</p> <p>The maximum string length in characters is 512.</p> 
s3 | **object**<br>Object storage <br> includes only one of the fields `yds`, `s3`<br>
s3.<br>bucket | **string**<br><p>Object storage bucket</p> <p>Value must match the regular expression ``[a-zA-Z0-9][-a-zA-Z0-9.]{2,62}``.</p> 
s3.<br>prefix | **string**<br><p>Prefix to use for saved log object names</p> <p>The maximum string length in characters is 1024.</p> 