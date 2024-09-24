---
editable: false
sourcePath: en/_api-ref/serverless/eventrouter/v1/eventrouter/api-ref/Connector/get.md
---

# EventRouter Service, REST: Connector.get
Returns the specified bus.
To get the list of all available connectors, make a [list](/docs/functions/eventrouter/api-ref/Connector/list) request.
 

 
## HTTP request {#https-request}
```
GET https://serverless-eventrouter.{{ api-host }}/eventrouter/v1/connectors/{connectorId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
connectorId | <p>Required. ID of the connector to return.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "busId": "string",
  "folderId": "string",
  "cloudId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "source": {

    // `source` includes only one of the fields `dataStream`, `messageQueue`
    "dataStream": {
      "database": "string",
      "streamName": "string",
      "consumer": "string",
      "serviceAccountId": "string"
    },
    "messageQueue": {
      "queueArn": "string",
      "serviceAccountId": "string",
      "visibilityTimeout": "string",
      "batchSize": "string",
      "pollingTimeout": "string"
    },
    // end of the list of possible fields`source`

  },
  "deletionProtection": true,
  "status": "string"
}
```

 
Field | Description
--- | ---
id | **string**<br><p>ID of the connector.</p> 
busId | **string**<br><p>ID of the bus that the connector belongs to.</p> 
folderId | **string**<br><p>ID of the folder that the connector resides in.</p> 
cloudId | **string**<br><p>ID of the cloud that the connector resides in.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the connector.</p> 
description | **string**<br><p>Description of the connector.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
source | **object**<br><p>Source of the connector.</p> 
source.<br>dataStream | **object** <br>`source` includes only one of the fields `dataStream`, `messageQueue`<br>
source.<br>dataStream.<br>database | **string**<br><p>Required. Stream database. example: /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********</p> 
source.<br>dataStream.<br>streamName | **string**<br><p>Required. Stream name, absolute or relative.</p> 
source.<br>dataStream.<br>consumer | **string**<br><p>Required. Consumer name.</p> 
source.<br>dataStream.<br>serviceAccountId | **string**<br><p>Required. Service account which has read permission on the stream.</p> 
source.<br>messageQueue | **object** <br>`source` includes only one of the fields `dataStream`, `messageQueue`<br>
source.<br>messageQueue.<br>queueArn | **string**<br><p>Required. Queue ARN. Example: yrn:yc:ymq:ru-central1:aoe***:test</p> 
source.<br>messageQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has read access to the queue.</p> <p>The maximum string length in characters is 50.</p> 
source.<br>messageQueue.<br>visibilityTimeout | **string**<br><p>Queue visibility timeout override.</p> <p>The maximum value is 43200 seconds.</p> 
source.<br>messageQueue.<br>batchSize | **string** (int64)<br><p>Batch size for polling.</p> <p>The maximum value is 10.</p> 
source.<br>messageQueue.<br>pollingTimeout | **string**<br><p>Queue polling timeout.</p> <p>The maximum value is 20 seconds.</p> 
deletionProtection | **boolean** (boolean)<br><p>Deletion protection.</p> 
status | **string**<br><p>Status of the connector.</p> <p>Status of the connector.</p> <ul> <li>STOPPED: disabled by user</li> <li>RESOURCE_NOT_FOUND: source does not exist</li> <li>PERMISSION_DENIED: service account does not have read permission on source</li> <li>SUBJECT_NOT_FOUND: service account not found</li> </ul> 